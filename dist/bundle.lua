-- Bundled by luabundle {"version":"1.6.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(require)
__bundle_register("__root", function(require, _LOADED, __bundle_register, __bundle_modules)
local CardList = require("card-list") ---@type CardList
_G.WeAreDevs = CardList

end)
__bundle_register("card-list", function(require, _LOADED, __bundle_register, __bundle_modules)
local SELECTOR = require("selectors")
local Card = require("card-class")

local TARGET_URL = "https://wearedevs.net/scripts"
local insert = table.insert
---@class CardList
---@field public collection table<number, Card>
local CardList = { collection = {}, _initialized = false }

-- local htmlCardList = game:HttpGet("https://wearedevs.net/scripts"):match(SELECTOR.CARDLIST)

-- for htmlCard in htmlCardList:gmatch(SELECTOR.CARD) do
-- 	local _card = Card:new(htmlCard)
-- 	print(_card.title)
-- end

function CardList:fetch()
	self._initialized = true
	self.collection = {}
	--
	local htmlContainer = game:HttpGet(TARGET_URL):match(SELECTOR.CARDLIST)
	for htmlCard in htmlContainer:gmatch(SELECTOR.CARD) do
		insert(self.collection, Card:new(htmlCard))
	end
end

---@return Card | nil
function CardList:search(title)
	if not self._initialized then
		self:fetch()
	end
	for _, card in next, self.collection do
		if card.title:match(title) then
			return card
		end
	end
end

return CardList

end)
__bundle_register("card-class", function(require, _LOADED, __bundle_register, __bundle_modules)
local SELECTOR = require("selectors")

---@class BaseCard
local Card = {}

---@return Card
function Card:new(html)
	assert(type(html) == "string", "expected a html string for new card.")
	---@class Card
	local this = {}
	setmetatable(this, Card)
	Card.__index = Card

	this.title = html:match(SELECTOR.CARD_TITLE)
	this.description = html:match(SELECTOR.CARD_DESCRIPTION)
	this.downloadUrl = ("https://wearedevs.net%s"):format(html:match(SELECTOR.CARD_DOWNLOADURL))
	return this
end

-- game:HttpGet("https://wearedevs.net" .. CardList:search("Dex").downloadUrl)
-- <a class="btnDownload round" href="https://cdn.wearedevs.net/scripts/Dex Explorer V2.txt" rel="nofollow" target="_blank" onclick="ViewRaw()">View Raw Text</a>
function Card:GetCodeAsync(callback, onerror)
	coroutine.wrap(function(callback)
		local response = game:HttpGet(self.downloadUrl:gsub(" ", "%%20"))
		local absoluteUrl = response:match('.-btnDownload.-href.-"(.-)"'):gsub(" ", "%%20")
		if type(absoluteUrl) ~= "string" then
			onerror("absoluteUrl not a string", absoluteUrl)
			return
		end
		local contents = game:HttpGet(absoluteUrl)
		callback(contents)
	end)(callback)
end

return Card

end)
__bundle_register("selectors", function(require, _LOADED, __bundle_register, __bundle_modules)
return {
	CARDLIST = '<main>.-<div.-class="releases".->(.+)</div>.-</main>',
	CARD = '<div.-class="release%-card.-".->.-</a>.-</div>',
	CARD_TITLE = ".-release%-title.->(.-)</",
	CARD_DESCRIPTION = ".-release%-description.->.-<p>(.-)</",
	CARD_DOWNLOADURL = '.-download%-button.-href.-"(.-)"',
}

end)
return __bundle_require("__root")