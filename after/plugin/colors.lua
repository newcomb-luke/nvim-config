function InitColorScheme(color)
	color = color or "rose-pine"

	vim.cmd.colorscheme(color)
end

InitColorScheme()
