
local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(-1)


local conditions = {
	CONDITION_POISON,
	CONDITION_FIRE,
	CONDITION_ENERGY,
	CONDITION_BLEEDING,
	CONDITION_HASTE,
	CONDITION_PARALYZE,
	CONDITION_INVISIBLE,
	CONDITION_LIGHT,
	CONDITION_MANASHIELD,
	CONDITION_INFIGHT,
	CONDITION_DRUNK,
	CONDITION_SOUL,
	CONDITION_DROWN,
	CONDITION_YELLTICKS,
	CONDITION_ATTRIBUTES,
	CONDITION_FREEZING,
	CONDITION_DAZZLED,
	CONDITION_CURSED,
	CONDITION_EXHAUST_COMBAT,
	CONDITION_EXHAUST_HEAL,
	CONDITION_SPELLCOOLDOWN,
	CONDITION_SPELLGROUPCOOLDOWN
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if player:getStorageValue(Storage.CultsOfTibia.Barkless.ice) == 2 then
		player:setStorageValue(Storage.CultsOfTibia.Barkless.ice, 3)
		player:setStorageValue(Storage.CultsOfTibia.Barkless.Death, 1)
		for _, conditionType in pairs(conditions) do
			if player:getCondition(conditionType) then
				player:removeCondition(conditionType)
			end
		end
		condition:setOutfit(player:getSex() == PLAYERSEX_FEMALE and 3065 or 3058)
		player:addCondition(condition)
		local it = Game.createItem(player:getSex() == PLAYERSEX_FEMALE and 3065 or 3058, 1, player:getPosition())
		if it then
			it:decay()
		end
		player:addHealth((-player:getHealth() + 1))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You were killed by something evil and others.")
		-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are still blessed with Wisdom of Solitude, Spark of the Phoenix, Fire of the Suns, Spiritual Shielding, Embrace of Tibia, Heart of the Mountani, Blood of the Montain and Twist of Fate.")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You lost 0 experience and 0.00% of all of your skills.")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You did not lose any items.")
		player:setStorageValue(Storage.CultsOfTibia.Barkless.Mission, 3)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The cold has all but disappeared from your body and you're getting warmer. You need to renew all preparations for purification.")
							creature:remove()
	else
			player:teleportTo(fromPosition, true)
	end
	return true
end



