local w = require('wezterm')
local spawn = require('utils').spawnWindow
local OS = require('utils').OS
w.on('gui-startup', function()
    if OS:find('windows') then
    spawn('default', '')
    spawn('explorer', '', { 'wsl' }, 'xplr')
    else
        spawn('default', '')
    end
    w.mux.set_active_workspace('default')
end)
w.on('format-tab-title', function(tab)
    local title = tab.active_pane.title
    return {
        { Text = ' ' .. title .. ' ' },
    }
end)
w.on('update-right-status', function(window, pane)
    local reset = 'ResetAttributes'
    local leader = ''
    local dir = pane:get_current_working_dir()
    local pixel_width = window:get_dimensions().pixel_width or 0
    if dir then
        dir = dir.path
    else
        dir = "nil"
    end
    if window:leader_is_active() then
        leader = '     '
    end
    if OS:find('windows') then
        dir = string.gsub(dir, '/C:/Users/Vicen', '~')
    else
        dir =string.gsub(dir, '/home/vicenzo', '~')
    end

 local time_and_branch = {
        { Attribute = { Italic = true } },
        { Foreground = { Color = '#f38ba8' } },
        { Text = ' ' .. window:active_workspace() },
        { Foreground = { Color = '#cba6f7' } },
        { Text = w.strftime(' %H:%M ') },
    }
    local right_status_elements = {
        { Attribute = { Intensity = 'Bold' } },
        { Attribute = { Italic = true } },
        { Background = { Color = '#91d7e3' } },
        { Foreground = { Color = '#181926' } },
        { Text = ' ' .. dir .. ' ' },
        { Background = { Color = '#643fff' } },
        { Foreground = { Color = '#b4befe' } },
        { Text = leader },
        { Background = { Color = '#f38ba8' } },
        { Text = '  ' },
    }
    local merged_elements = {}
    if pixel_width > 910 then
        for _, element in ipairs(time_and_branch) do
            table.insert(merged_elements, element)
        end
    end
    for _, element in ipairs(right_status_elements) do
        table.insert(merged_elements, element)
    end

    window:set_right_status(w.format(merged_elements))
    window:set_left_status(w.format({
        { Background = { Color = '#f38ba8' } },
        { Text = '  ' },
        reset,
        { Background = { Color = '#11111b' } },
        { Foreground = { Color = '#643fff' } },
        { Text = '    ' },
    }))
end)
