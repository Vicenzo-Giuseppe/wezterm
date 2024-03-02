local w = require('wezterm')
local action = require('utils').action_callback
local act = w.action
local m = w.mux
local keys = {
    -- Move to WorkSpaces
    { key = 'LeftArrow', mods = 'ALT', action = act.SwitchWorkspaceRelative(1) },
    { key = 'RightArrow', mods = 'ALT', action = act.SwitchWorkspaceRelative(-1) },
    { key = 'Delete', mods = 'LEADER', action = act.ShowLauncherArgs({ flags = 'WORKSPACES' }) },

    -- Move to Tabs
    { key = 'j', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = 'k', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'LEADER', action = act.ShowLauncherArgs({ flags = 'TABS|FUZZY' }) },
    { key = 'UpArrow', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'LeftArrow', mods = 'CTRL', action = act.ActivateTabRelative(-1) },

    -- Move Right And Left CurrentTab
    { key = '-', mods = 'ALT', action = act.MoveTabRelative(-1) },
    { key = '=', mods = 'ALT', action = act.MoveTabRelative(1) },

    -- SpawnTab
    { key = 'z', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },
    -- CloseTab
    { key = 'c', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = false }) },

    -- Open Launcher
    { key = 'Tab', mods = 'LEADER', action = act.ShowLauncher },

    -- Rename WorkSpace
    {
        key = 'r',
        mods = 'LEADER',
        action = act.PromptInputLine({
            description = w.format({
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = ':Workspace:' },
            }),
            action = action(function(window, line)
                if line then
                    window:active_tab():set_title(line)
                    m.rename_workspace(m.get_active_workspace(), line)
                end
            end),
        }),
    },

    -- Rename Tab
    {
        key = 'e',
        mods = 'LEADER',
        action = act.PromptInputLine({
            description = 'new name for tab',
            action = action(function(window, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },

    -- Copy and Paste
    { key = 'V', mods = 'CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'L', mods = 'CTRL', action = act.CopyTo('Clipboard') },

    -- Spawn Split Terminal
    { key = '=', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = '-', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { key = 'DownArrow', mods = 'CTRL', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { key = 'RightArrow', mods = 'CTRL', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

    -- Spawn new terminal
    {
        key = 'Enter',
        mods = 'CTRL',
        action = act.SpawnCommandInNewWindow({
            cwd = w.home_dir,
        }),
    },
    
    -- Fullscreen
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    
    -- Run programs in new tab
    {
        key = 'x',
        mods = 'LEADER',
        action = act.SpawnCommandInNewTab({ domain = 'CurrentPaneDomain', args = { 'xplr' } }),
    },

    -- Open Console Debugger
    { key = 'p', mods = 'LEADER', action = act.ShowDebugOverlay },

    -- Move to Panels
    { key = 'LeftArrow', mods = 'SHIFT', action = act.ActivatePaneDirection('Left') },
    { key = 'RightArrow', mods = 'SHIFT', action = act.ActivatePaneDirection('Right') },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ActivatePaneDirection('Down') },
    { key = 'UpArrow', mods = 'SHIFT', action = act.ActivatePaneDirection('Up') },

    -- ...
    {
        key = 'F1',
        mods = 'NONE',
        action = act.ActivateCommandPalette,
    },
    {
        key = 'U',
        mods = 'CTRL',
        action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    {
        key = 'U',
        mods = 'SHIFT|CTRL',
        action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    {
        key = 'u',
        mods = 'SHIFT|CTRL',
        action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
}

for i = 1, 9 do
    -- Go to tab by number
    table.insert(keys, {
        key = tostring(i),
        mods = 'CTRL',
        action = w.action.ActivateTab(i - 1),
    })
    -- Move tab by number
    table.insert(keys, {
        key = tostring(i),
        mods = 'ALT',
        action = w.action.MoveTab(i - 1),
    })
end

return keys
