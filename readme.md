# Usage

List Script Cards

```lua
_G.ScriptSearchAPI:fetch()
for _, card in next, _G.ScriptSearchAPI.collection do
    rconsolewarn('title: '..card.title)
    rconsolewarn('description: '..card.description..'\r\n')
end
```

Searching And Loading A Script Card

`API:search()` - Automatically fetches script cards & runs a quick name lookup.

```lua
_G.ScriptSearchAPI:search('WRD ESP'):GetCodeAsync(function(code)
    loadstring(code)()
end)
```
