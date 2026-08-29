# agent-cli.nvim

## Installation

```lua
  {
    "Kurama622/agent-cli.nvim",
    opts = {
      cmd = "qodercli",
    },
    keys = {
      { "<leader>qd", "<cmd>AgentCliToggle<CR>", mode = { "n", "t" }, desc = "Open Qoder" },
      { "<leader>af", "<cmd>AgentCliAddFile<CR>", mode = "n", desc = "Add File to Qoder" },
      { "<leader>as", "<cmd>AgentCliAddSnippet<CR>", mode = "v", desc = "Add Snippet to Qoder" },
    },
  }
```
