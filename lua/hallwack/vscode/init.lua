if vim.g.vscode then
  local vscode_neovim = require("vscode-neovim")

  local comment = {
    selected = function()
      vscode_neovim.call("editor.action.commentLine")
    end
  }

  local file = {
    save = function()
      vscode_neovim.call("workbench.action.files.save")
    end,

    saveAll = function()
      vscode_neovim.call("workbench.action.files.saveAll")
    end,

    close = function()
      vscode_neovim.call("workbench.action.closeActiveEditor")
    end,

    format = function()
      vscode_neovim.action("editor.action.formatDocument")
    end,

    showInExplorer = function()
      vscode_neovim.call("workbench.files.action.showActiveFileInExplorer")
    end,

    rename = function()
      vscode_neovim.call("workbench.files.action.showActiveFileInExplorer")
      vscode_neovim.call("renameFile")
    end
  }

  local action = {
    quickOpen = function()
      vscode_neovim.call("workbench.action.quickOpen")
    end,

    showCommands = function()
      vscode_neovim.call("workbench.action.showCommands")
    end,

    toggleSidebarVisibility = function()
      vscode_neovim.call("workbench.action.toggleSidebarVisibility")
      vscode_neovim.call("workbench.action.focusSidebar")
    end,

    toggleCenteredLayout = function()
      vscode_neovim.call("workbench.action.toggleCenteredLayout")
    end,

    focusLeftGroup = function()
      vscode_neovim.call("workbench.action.focusLeftGroup")
    end,

    focusRightGroup = function()
      vscode_neovim.call("workbench.action.focusRightGroup")
    end,

    focusAboveGoup = function()
      vscode_neovim.call("workbench.action.focusAboveGroup")
    end,

    focusBelowGroup = function()
      vscode_neovim.call("workbench.action.focusBelowGroup")
    end,

    navigateLeft = function()
      vscode_neovim.call("workbench.action.navigateLeft")
    end,

    navigateRight = function()
      vscode_neovim.call("workbench.action.navigateRight")
    end,

    navigateAbove = function()
      vscode_neovim.call("workbench.action.navigateUp")
    end,

    navigateBelow = function()
      vscode_neovim.call("workbench.action.navigateDown")
    end,

    moveEditorLeftInGroup = function()
      vscode_neovim.call("workbench.action.moveEditorLeftInGroup")
    end,

    moveEditorRightInGroup = function()
      vscode_neovim.call("workbench.action.moveEditorRightInGroup")
    end,

    navigateForwardInEditLocations = function()
      vscode_neovim.call("workbench.action.navigateForwardInEditLocations")
    end,

    navigatePreviousInEditLocations = function()
      vscode_neovim.call("workbench.action.navigatePreviousInEditLocations")
    end,
  }

  local view = {
    explorer = function()
      vscode_neovim.call("workbench.view.explorer")
    end
  }

  local editor = {
    hover = function()
      vscode_neovim.action("editor.action.showHover")
    end,

    rename = function()
      vscode_neovim.call("editor.action.rename")
    end,
  }

  vim.keymap.set({ 'n', 'v' }, "<C-b>", "<NOP>")
  vim.keymap.set({ 'n', 'v' }, "<C-b>", action.toggleSidebarVisibility)
  vim.keymap.set({ 'n', 'v' }, "<leader>/", comment.selected)

  vim.keymap.set({ 'n', 'v' }, "<leader>ea", file.showInExplorer)

  vim.keymap.set({ 'n', 'v' }, "<leader>wa", file.saveAll)
  vim.keymap.set({ 'n', 'v' }, "<leader>ff", action.quickOpen)
  vim.keymap.set({ 'n', 'v' }, "<leader>fc", action.showCommands)
  vim.keymap.set({ 'n', 'v' }, "<leader>zz", action.toggleCenteredLayout)
  vim.keymap.set({ 'n', 'v', 'x' }, "<C-h>", action.navigateLeft)
  vim.keymap.set({ 'n', 'v', 'x' }, "<C-j>", action.navigateBelow)
  vim.keymap.set({ 'n', 'v', 'x' }, "<C-k>", action.navigateAbove)
  vim.keymap.set({ 'n', 'v', 'x' }, "<C-l>", action.navigateRight)

  vim.keymap.set({ 'n', 'v' }, "<leader>ee", view.explorer)

  vim.keymap.set({ 'n' }, "K", editor.hover)
  vim.keymap.set({ 'n' }, "<leader>rn", editor.rename)
  vim.keymap.set({ 'n' }, "<leader>fr", file.format)

  vim.keymap.set({ 'n', 'v' }, "<leader>t", action.moveEditorRightInGroup)
  vim.keymap.set({ 'n', 'v' }, "<leader>T", action.moveEditorLeftInGroup)

  vim.keymap.set({ 'n', 'v' }, "<leader>o", action.navigatePreviousInEditLocations)
  vim.keymap.set({ 'n', 'v' }, "<leader>i", action.navigateForwardInEditLocations)
  vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<;-r><C-w>]])
end
