-- Define function first
local function open_html_in_browser()
  if vim.bo.filetype ~= "html" then
    print("Not an HTML file.")
    return
  end

  local filepath = vim.fn.expand("%:p")
  if vim.fn.filereadable(filepath) == 0 then
    print("File is not saved.")
    return
  end

  local os_name = vim.loop.os_uname().sysname
  local open_cmd

  if os_name == "Linux" then
    open_cmd = "xdg-open"
  elseif os_name == "Darwin" then
    open_cmd = "open"
  elseif os_name:match("Windows") or os_name == "Windows_NT" then
    open_cmd = "start"
  else
    print("Unsupported OS: " .. os_name)
    return
  end

  vim.fn.jobstart({ open_cmd, filepath }, { detach = true })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.keymap.set("n", "<leader>ob", open_html_in_browser, { buffer = true, desc = "Open HTML in browser" })
  end
})
