vim.api.nvim_create_user_command("AgentCliToggle", function()
	require("agent-cli"):toggle()
end, {})

vim.api.nvim_create_user_command("AgentCliAddFile", function()
	require("agent-cli"):add_file()
end, {})

vim.api.nvim_create_user_command("AgentCliAddSnippet", function()
	require("agent-cli"):add_snippet()
end, {})
