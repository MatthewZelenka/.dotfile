-- Get the current tab character (either spaces or a tab character)
local function get_tab_character()

    local tabstop = vim.api.nvim_buf_get_option(0, 'tabstop')
    local expandtab = vim.api.nvim_buf_get_option(0, 'expandtab')
    if expandtab then
        return string.rep(' ', tabstop)
    else
        return '\t'
    end
end

-- Function to remove the first occurrence of the tab character at the start of the line
function smart_untab()
    local tab_char = get_tab_character()
    local line = vim.api.nvim_get_current_line()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor_pos[1], cursor_pos[2]

    -- Remove only one leading tab character if present
    if line:sub(1, #tab_char) == tab_char then
        local new_line = line:sub(#tab_char + 1)
        vim.api.nvim_set_current_line(new_line)

        -- Adjust cursor column if it was within the removed tab area
        local tab_length = #tab_char
        -- Get the current window
        col = math.max(0, col - tab_length)

        -- Set the updated cursor position
        local win_id = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_cursor(win_id, { row, col })
    end
end

vim.api.nvim_set_keymap('i', '<S-Tab>', [[<Esc>:lua smart_untab()<CR>a]], { noremap = true, silent = true })
