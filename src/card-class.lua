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

function Card:GetCodeAsync(callback, onerror)
	coroutine.wrap(function(callback)
		local response = game:HttpGet(self.downloadUrl:gsub(" ", "%%20"))
		local absoluteUrl = response:match(SELECTOR.BUTTON_DOWNLOADURL):gsub(" ", "%%20")
		if type(absoluteUrl) ~= "string" then
			onerror("absoluteUrl not a string", absoluteUrl)
		else
			callback(game:HttpGet(absoluteUrl))
		end
	end)(callback)
end

return Card
