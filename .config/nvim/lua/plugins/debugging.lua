return {
	-- { "folke/neodev.nvim", opts = {} },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		}
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"NicholasMata/nvim-dap-cs"
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local dap_utils = require("dap.utils")
			dapui.setup()

			require("dap-go").setup()

			local attach_godot = function()
				local filter = function(proc)
					return string.find(proc.name, "godot") ~= nil and
						string.find(proc.name, "%-%-remote%-debug") ~= nil
				end

				local processes = dap_utils.get_processes()
				processes = vim.tbl_filter(filter, processes)
				-- print(vim.inspect(processes))


				if #processes == 0 then
					print("No godot projects could be found automatically. Try 'Attach' instead")
					return
				end

				if #processes > 1 then
					return dap_utils.pick_process({
						filter = filter
					})
				end

				return processes[1].pid
			end

			require('dap-cs').setup({
				dap_configurations = {
					{
						type = "coreclr",
						name = "Attach Godot",
						request = "attach",
						processId = attach_godot,
					},
				},
				netcoredbg = {
					-- the path to the executable netcoredbg which will be used for debugging.
					-- by default, this is the "netcoredbg" executable on your PATH.
					path = "netcoredbg"
				}
			})

			-- GODOT Debugger setup
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006
			}

			dap.configurations.gdscript = {
				type = "godot",
				request = "launch",
				name = "Launch Scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			}

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			--     dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			--     dapui.close()
			-- end

			vim.keymap.set('n', '<F4>', dapui.toggle, { desc = 'Debug ui toggle' })
			vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug continue' })
			vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug step over' })
			vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug step into' })
			vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug step out' })
			vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = 'Debug toggle breakpoint' })
			vim.keymap.set('n', '<Leader>dB', dap.set_breakpoint, { desc = 'Debug breakpoint' })
			vim.keymap.set('n', '<Leader>dlp',
				function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				{ desc = 'Debug log point message' })
			vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = 'Debug repl open' })
			vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = 'Debug reun last' })
			-- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
			--     require('dap.ui.widgets').hover()
			-- end)
			-- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
			--     require('dap.ui.widgets').preview()
			-- end)
			-- vim.keymap.set('n', '<Leader>df', function()
			--     local widgets = require('dap.ui.widgets')
			--     widgets.centered_float(widgets.frames)
			-- end)
			-- vim.keymap.set('n', '<Leader>ds', function()
			--     local widgets = require('dap.ui.widgets')
			--     widgets.centered_float(widgets.scopes)
			-- end)





			local number_indices = function(array)
				local result = {}
				for i, value in ipairs(array) do
					result[i] = i .. ": " .. value
				end
				return result
			end

			local display_options = function(prompt_title, options)
				options = number_indices(options)
				table.insert(options, 1, prompt_title)

				local choice = vim.fn.inputlist(options)

				if choice > 0 then
					return options[choice + 1]
				else
					return nil
				end
			end


			local file_selection = function(cmd, opts)
				local results = vim.fn.systemlist(cmd)

				if #results == 0 then
					print(opts.empty_message)
					return
				end

				if opts.allow_multiple then
					return results
				end

				local result = results[1]
				if #results > 1 then
					result = display_options(opts.multiple_title_message, results)
				end

				return result
			end

			local project_selection = function(project_path, allow_multiple)
				local check_csproj_cmd = string.format('find %s -type f -name "*.csproj"', project_path)
				local project_file = file_selection(check_csproj_cmd, {
					empty_message = 'No csproj files found in ' .. project_path,
					multiple_title_message = 'Select project:',
					allow_multiple = allow_multiple
				})
				return project_file
			end

			Select_dll = function(project_path)
				local bin_path = project_path .. '/.godot/mono/temp/bin/Debug'

				local check_net_folders_cmd = string.format('find %s -type d -name "net*"', bin_path)

				local project_file = project_selection(project_path)
				if project_file == nil then
					return
				end
				local project_name = vim.fn.fnamemodify(project_file, ":t:r")

				local dll_path = bin_path .. '/' .. project_name .. '.dll'
				return dll_path
			end
		end
	}
}
