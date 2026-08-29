local api, cmd, opt, wo, fn = vim.api, vim.cmd, vim.opt, vim.wo, vim.fn
local M = { bufnr = -1, winid = -1, job_id = nil }

function M.setup(opts)
	M.cmd = opts.cmd
end

function M:check_agent_cli_is_opened() end

function M:create_agent_win()
	local save_splitright = opt.splitright:get()
	opt.splitright = true

	cmd("vsplit")
	cmd("vertical resize 50")

	opt.splitright = save_splitright

	self.winid = api.nvim_get_current_win()
	api.nvim_win_set_buf(self.winid, self.bufnr)

	wo.number = false
	wo.relativenumber = false
	wo.signcolumn = "no"
	cmd("startinsert")
end

function M:toggle()
	if api.nvim_buf_is_valid(self.bufnr) then
		if api.nvim_win_is_valid(self.winid) then
			return api.nvim_win_close(self.winid, true)
		else
			return self:create_agent_win()
		end
	end

	self.bufnr = api.nvim_create_buf(false, true)
	self:create_agent_win()
	self.job_id = fn.jobstart(M.cmd, {
		term = true,
		on_exit = function()
			api.nvim_win_close(self.winid, true)
			self.job_id = nil
		end,
	})
end

function M:add_file()
	if self.job_id == nil then
		return vim.notify("Please Open Agent Cli!", vim.log.levels.WARN, { title = "agent-cli.nvim" })
	end
	fn.chansend(self.job_id, "@" .. api.nvim_buf_get_name(0))
	api.nvim_set_current_win(self.winid)
	cmd("startinsert!")
end

function M:add_snippet()
	if self.job_id == nil then
		return vim.notify("Please Open Agent Cli!", vim.log.levels.WARN, { title = "agent-cli.nvim" })
	end

	cmd("normal! \27")
	local start_pos = fn.getpos("'<")
	local end_pos = fn.getpos("'>")
	local start_line = start_pos[2] - 1
	local end_line = end_pos[2] - 1
	local msg = ("Please read %s#L%d-L%d\n"):format(api.nvim_buf_get_name(0), start_line, end_line)
	fn.chansend(self.job_id, msg)
	api.nvim_set_current_win(self.winid)
	cmd("startinsert!")
end

return M
