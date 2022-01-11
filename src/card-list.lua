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
