-- Returns the current buffer directory
function GetCurBufferDir()
	local buffer_name = vim.fn.expand("%:p:h")
	return vim.fn.fnameescape(buffer_name)
end

-- Runs a make command with a specified argument (project specific - bad)
function RunMake(target, release)
	local current_dir = vim.fn.getcwd()
	local target_dir = "~/Dev/pine-engine"

	-- Change to the desired directory
	vim.cmd("cd " .. target_dir)

	-- Run the make command with the specified target
	if release == "true" then
		vim.fn.execute("terminal make " .. target .. " BUILD_TYPE=Release")
	else
		vim.fn.execute("terminal make " .. target)
	end

	-- Return to the original directory
	vim.cmd("cd " .. current_dir)
end
