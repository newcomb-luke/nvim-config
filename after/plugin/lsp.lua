local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.nvim_workspace()

lsp.ensure_installed({
	'lua_ls',
	'rust_analyzer',
})

require('lspconfig').rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                allFeatures = true,
                overrideCommand = {
                    'cargo', 'clippy', '--workspace', '--message-format=json',
                    '--all-targets', '--all-features'
                }
            },
        }
    },
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
}

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.g.rustfmt_autosave = 1

lsp.setup()
