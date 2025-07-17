return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"j-hui/fidget.nvim",
		},
		opts = {
			strategies = {
				chat = {
					adapter = "mistral",
				},
				inline = {
					adapter = "mistral",
				}
			},
			adapters = {
        mistral = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'mistral',
              schema = {
                model = {
                  default = 'mistral:7b',
                }
              }
            })
        end,
        mcphub_ollama = {
          -- This adapter uses MCPHub as its provider
          provider = "mcphub",
          -- The callback function is how CodeCompanion integrates with MCPHub's extension
          callback = function() return require("mcphub.extensions.codecompanion") end,
          -- The 'model' here tells MCPHub which LLM to use via its own configured LLM providers (if any)
          -- or it can be passed to your custom Ollama MCP server.
          model = "mistral",
          opts = {
            requires_approval = true, -- Set to false if you want auto-approval for tool calls
            -- Any other options specific to the MCPHub extension for CodeCompanion can go here
            -- E.g., if you want to pass a specific Ollama model to your custom MCP server
            -- ollama_model_override = "mistral:7b-instruct-v0.2",
          }
        },
			},
			display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "telescope", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          }
        }
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true,      -- Show tool results directly in chat buffer
            format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true,                -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true,      -- Add MCP prompts as /slash commands
          }
        }
      }
		},
		config = function(_, opts)
			require("codecompanion").setup(opts)

			local progress = require("fidget.progress")
			local handles = {}
			local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestStarted",
				group = group,
				callback = function(e)
					handles[e.data.id] = progress.handle.create({
						title = "CodeCompanion",
						message = "Thinking...",
						lsp_client = { name = e.data.adapter.formatted_name },
					})
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestFinished",
				group = group,
				callback = function(e)
					local h = handles[e.data.id]
					if h then
						h.message = e.data.status == "success" and "Done" or "Failed"
						h:finish()
						handles[e.data.id] = nil
					end
				end,
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},
	{
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua",  -- Bundles `mcp-hub` binary along with the neovim plugin
    config = function()
        require("mcphub").setup({
            --- `mcp-hub` binary related options-------------------
            config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
            port = 37373, -- The port `mcp-hub` server listens to
            shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
            use_bundled_binary = true, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
            mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks

            ---Chat-plugin related options-----------------
            auto_approve = false, -- Auto approve mcp tool calls
            auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
            extensions = {
                avante = {
                    make_slash_commands = true, -- make /slash commands from MCP server prompts
                }
            },

            --- Plugin specific options-------------------
            native_servers = {}, -- add your custom lua native servers here
            builtin_tools = {
                edit_file = {
                    parser = {
                        track_issues = true,
                        extract_inline_content = true,
                    },
                    locator = {
                        fuzzy_threshold = 0.8,
                        enable_fuzzy_matching = true,
                    },
                    ui = {
                        go_to_origin_on_complete = true,
                        keybindings = {
                            accept = ".",
                            reject = ",",
                            next = "n",
                            prev = "p",
                            accept_all = "ga",
                            reject_all = "gr",
                        },
                    },
                },
            },
            ui = {
                window = {
                    width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
                    relative = "editor",
                    zindex = 50,
                    border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
                },
                wo = { -- window-scoped options (vim.wo)
                    winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
                },
            },
            on_ready = function(hub)
                -- Called when hub is ready
            end,
            on_error = function(err)
                -- Called on errors
            end,
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub",
            },
        })
    end
  }
}
