# Usage

(i recommend downloading the [script](https://raw.githubusercontent.com/sound-infinity/script-query/master/dist/bundle.min.lua) and inserting it into the "autoexec" folder instead)

```lua
--#region load remotely
local MODULE_URL = "https://raw.githubusercontent.com/sound-infinity/script-query/master/dist/bundle.min.lua"
loadstring(game:HttpGet(MODULE_URL))()
---#endregion
_G.ScriptSearchAPI:search('WRD ESP'):GetCodeAsync(function(code)
    loadstring(code)()
end)
```

# Examples

## List Script Cards

```lua
_G.ScriptSearchAPI:fetch()
for _, card in next, _G.ScriptSearchAPI.collection do
    rconsolewarn('title: '..card.title)
    rconsolewarn('description: '..card.description..'\r\n')
end
```

## Searching And Loading A Script Card

`API:search()` - Automatically fetches script cards & runs a quick name lookup.

```lua
_G.ScriptSearchAPI:search('WRD ESP'):GetCodeAsync(function(code)
    loadstring(code)()
end)
```
