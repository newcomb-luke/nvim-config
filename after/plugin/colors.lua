function InitColorScheme(color)
    color = color or "gruvbox"

    vim.o.background = "dark"

	vim.cmd.colorscheme(color)
end

InitColorScheme()
