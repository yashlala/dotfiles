-- TODO: We don't understand how this works. 
-- Might be a highlighting problem.

-- OK we get it now. 

-- Nevermind, we don't. Looks like we can't disable the repeat, and worse the
-- highlighting doesn't stop after we just finish jumping. Switch back to
-- hop.nvim...except THAT doesn't work right yet, either!!! We need a PR to go
-- through. Damn all this. 

require('lightspeed').setup {
  exit_after_idle_msecs = {
    labeled = nil, 
    unlabeled = nil,
  },

  -- s/x
  grey_out_search_area = false,
  -- When we start to search, highlight the chars we can immediately jump to.
  -- Helps our brain realize we don't need a second character. 
  highlight_unique_chars = true,
  -- Suppose we only needed to type 1 character, but we typed 2 out of muscle
  -- memory. This safety buffer absorbs that second character if typed quickly
  -- enough, so we don't trip. 
  jump_on_partial_input_safety_timeout = 5,

  -- Doesn't allow us to jump to second "l" in "ll". 
  -- This is to prevent "======" style lines from becoming overwhelming. 
  match_only_the_start_of_same_char_seqs = false,

  -- Replace whitespace characters when highlighting to make them visible.
  substitute_chars = { [' '] = '_', ['\r'] = '↵' },


  -- No clue what the documentation is trying to tell me here. 
  -- This plugin is made for people with smarter fingers than I...
  safe_labels = nil, 

  -- Suppose there are multiple instances of the pattern we're trying to jump
  -- to. We'll append one of these glyphs to the pattern to disambiguate it. 
  labels = { 
    's', 'f', 'n', 'j', 'k', 'l', 'o', 'i', 'w', 'e', 'h', 'g',
    'u', 't', 'm', 'v', 'c', 'a', '.', ';', 'z',
    '/', 'F', 'L', 'N', 'H', 'G', 'M', 'U', 'T', '?', 'Z',
  },

   -- Suppose that we don't have enough labels. Use these keys to move the
   -- labels to the next "block" of locations.
  cycle_group_fwd_key = '<c-n>',
  cycle_group_bwd_key = '<c-p>',

  -- Highlight `n` matches when searching with `f`. 
  -- Looks like this plugin doesn't actually let you jump to it, though LOL.
  limit_ft_matches = 0,
  -- Allows you to do `faaa` instead of `fa;;;`.
  repeat_ft_with_target_char = false,
}

-- Lightspeed maps many things by default. This is annoying, so disable it now. 
