-- Completion
-- if true then
--   return {}
-- end
return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "mtoohey31/cmp-fish",
    "andersevenrud/cmp-tmux",
    -- 'hrsh7th/cmp-copilot',
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip/loaders/from_snipmate").lazy_load()

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match("%s")
          == nil
    end

    local source_map = {
      buffer = "Buffer",
      nvim_lsp = "LSP",
      nvim_lsp_signature_help = "Signature",
      luasnip = "LuaSnip",
      nvim_lua = "Lua",
      path = "Path",
      copilot = "Copilot",
    }

    local function ltrim(s)
      return s:match("^%s*(.*)")
    end

    cmp.setup({
      preselect = false,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      view = {
        entries = { name = "custom", selection_order = "near_cursor" },
      },
      window = {
        completion = {
          col_offset = -2, -- align the abbr and word on cursor (due to fields order below)
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol",
          symbol_map = { Supermaven = "" },
          -- See: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
          before = function(entry, vim_item)
            -- Replace the 'menu' field with the kind and source
            vim_item.menu = "  "
              .. vim_item.kind
              .. " ("
              .. (source_map[entry.source.name] or entry.source.name)
              .. ")"
            vim_item.menu_hl_group = "SpecialComment"

            vim_item.abbr = ltrim(vim_item.abbr)

            if
              vim_item.kind == "Color" and entry.completion_item.documentation
            then
              local _, _, r, g, b = string.find(
                entry.completion_item.documentation,
                "^rgb%((%d+), (%d+), (%d+)"
              )
              if r then
                local color = string.format("%02x", r)
                  .. string.format("%02x", g)
                  .. string.format("%02x", b)
                local group = "Tw_" .. color
                if vim.fn.hlID(group) < 1 then
                  vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
                end
                vim_item.kind_hl_group = group
                return vim_item
              end
            end

            return vim_item
          end,
        }),
      },

      mapping = {
        ["<C-n>"] = cmp.mapping(
          cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          { "i", "c" }
        ),
        ["<C-p>"] = cmp.mapping(
          cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          { "i", "c" }
        ),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
          -- behavior = cmp.ConfirmBehavior.Insert,

          -- behavior = cmp.ConfirmBehavior.Insert,
        }),
        -- ["<C-e>"] = cmp.mapping.confirm {
        -- 	select = true,
        -- 	behavior = cmp.ConfirmBehavior.Replace,
        -- 	-- behavior = cmp.ConfirmBehavior.Insert,
        -- },
      },
      -- mapping = {
      --   ["<Tab>"] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_next_item()
      --     elseif luasnip.locally_jumpable(1) then
      --       luasnip.jump(1)
      --     elseif has_words_before() then
      --       cmp.complete()
      --       print('complete...')
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }),
      --   ["<S-Tab>"] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_prev_item()
      --     elseif luasnip.locally_jumpable(-1) then
      --       luasnip.jump(-1)
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }),
      --   -- ['<CR>'] = cmp.mapping(function (fallback)
      --   --   if cmp.visible() then
      --   --     if luasnip.expandable() then
      --   --       luasnip.expand()
      --   --     else
      --   --       cmp.confirm({
      --   --         select = true,
      --   --       })
      --   --     end
      --   --   else
      --   --     fallback()
      --   --   end
      --   -- end),
      --   ['<CR>'] = cmp.mapping.confirm({ select = false }),
      -- },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "supermaven" },
        { name = "copilot" },
        { name = "buffer" },
        { name = "path" },
        { name = "vim-dadbod-completion" },
      },
      experimental = {
        -- ghost_text = true,
      },
    })

    -- cmp.setup.filetype("sql", {
    --   sources = cmp.config.sources({
    --     { name = "vim-dadbod-completion" },
    --   }, {
    --     { name = "buffer" },
    --   }),
    -- })
  end,
}
