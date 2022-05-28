require('bqf').setup({
  func_map = {
    open = '<cr>', -- Open the item under the cursor, keeping the list open.
    openc = 'o', -- Open the item under the cursor, closing the qf list.

    tabb = 't', -- Open the item in a new tab, but stay here
    tab = 'T', -- Open the new item in a tab, and follow it to the tab.

    split = '<c-s>', -- Open in horizontal split.
    vsplit = '<c-v>', -- Open in vertical split.

    stoggledown = 'v', -- Toggle the current item as "selected".
    stogglevm = 'v', -- In visual mode, too.

    ptoggleauto = 'p', -- Toggle previews
    ptoggleitem = 'P', -- Toggle preview for a particular node
    
    pscrollorig = '=', -- Center the preview window.
    -- We can use <c-f> <c-b> to move around in the preview window too
    -- TODO: Switch this to c-u and c-d. 

    prevhist = '[[', -- Go to the previous qf list
    nexthist = ']]',  -- Go to the next qf list

    -- Use fzf to trim down the current list. We can then use <c-e> to create
    -- a new, more "trimmed down", list. This is nothing short of incredible.
    -- If we want to trim down the list further, we can do
    --    `g/pattern/norm v`
    -- to manually "press v" (select) the items of our choice.
    --
    -- Using <c-e>, we can create a NEW list (effectively filtering) with only
    -- those items.
    --
    -- What do we do when we eventually want to do something at every location?
    -- We can just use :cdo.
    --
    -- Eg :cdo s/YEE=/YEE =/
    -- or :cdo norm! ^wwwidt)<cr>
    --
    -- See? In effect, we can automate actions on all quickfix lines!!!
    --
    -- Godly EX commands:
    -- - :global
    -- - :normal
    -- - :cdo
    -- - :bufdo
    --
    -- So much trial and error gone with these EX commands!
    -- Anyways, here's FZF.
    fzffilter = '/',
    -- TODO: Not really true anymore is it? Find out...
    filter = '<c-e>' -- FILTER list based on current selected options

  },

  -- Bindings while in fzf mode
  filter = {
    fzf = {
      action_for = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'},
      -- Enter accepts the current entry, <c-s> accepts them all
      extra_opts = {'--bind', 'ctrl-e:select-all+accept,return:accept', '--prompt', '> '}
    }
  },

  preview = { 
    auto_preview = true, -- enable preview window by default
  }, 
})
