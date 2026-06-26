return {
{
  'saghen/blink.cmp',
  version = '1.8.0',
  -- optional: provides snippets for the snippet source
  dependencies = {
			{ 'rafamadriz/friendly-snippets', commit = '6cd7280adead7f586db6fccbd15d2cac7e2188b9' }
},

  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
	    preset = 'super-tab',
      	    -- disable a keymap from the preset
            ['<C-space>'] = false,
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- (Default) Only show the documentation popup when manually triggered
      documentation = { auto_show = true },

      -- Disable auto brackets
      -- some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = false }, },

      -- Display a preview of the selected item on the current line
      ghost_text = { enabled = true },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- Show function signature when typing arguments
    signature = { enabled = true },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    --
    --
    -- Disabled because it sauses bad performance
    -- fuzzy = { implementation = "prefer_rust" }
  },
  opts_extend = { "sources.default" }
}
}
