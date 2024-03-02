local utils = {}
local w = require('wezterm')
local act = w.action

utils.OS = w.target_triple

function utils.system()
 if utils.OS:find('windows') then
        return true
    else
        return false
    end
end

utils.launch_menu = {}
if utils.OS:find('windows') then
    table.insert(utils.launch_menu, {
        label = 'PowerShell',
        args = { 'pwsh', '-nol' },
    })
end

function utils.spawnWindow(workspace, cwd, args)
    local tab, build_pane, window = w.mux.spawn_window({
        workspace = workspace,
        cwd = w.home_dir .. '/' .. cwd,
        args = args,
    })
    return tab, build_pane, window
end

function utils.action_callback(callback)
    local event_id = '...'
    w.on(event_id, callback)
    return act.EmitEvent(event_id)
end

function utils.translate_toml_to_lua(table)
    local file = io.open(w.config_dir .. "/config.toml", 'r')
    if file then
    local toml_string = file:read('*all')
    file:close()
    local toml_table = w.serde.toml_decode(toml_string)
    local lua_table = {}
    for key, value in pairs(toml_table) do
        lua_table[key] = value
    end
    if table then
        for k, v in pairs(lua_table) do
            table[k] = v
        end
        return table
    else
        return lua_table
    end
  else
    w.log_error('no toml file')
  end
end

return utils
