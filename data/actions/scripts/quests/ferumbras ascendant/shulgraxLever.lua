local config = {
	centerRoom = Position(33485, 32786, 13),
	BossPosition = Position(33485, 32786, 13),
	playerPositions = {
		Position(33434, 32785, 13),
		Position(33434, 32786, 13),
		Position(33434, 32787, 13),
		Position(33434, 32788, 13),
		Position(33434, 32789, 13)
	},
	newPosition = Position(33485, 32790, 13)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(33434, 32785, 13) then
			item:transform(9826)
			return true
		end
	end
	if item.itemid == 9825 then
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Shulgrax.")
				return true
			end
		end
	local spectators = Game.getSpectators(config.BossPosition, false, false, 20, 20, 20, 20)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isMonster() then
			spectator:remove()
							return true
			end
			end
		Game.createMonster("Shulgrax", config.BossPosition, true, true)
		for y = 32785, 32789 do
			local playerTile = Tile(Position(33434, y, 13)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
		Player.setStorageValue(GlobalStorage.FerumbrasAscendantQuest.ShulgraxTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(33473, 32776, 13), Position(33496, 32798, 13), Position(33319, 32318, 13), GlobalStorage.FerumbrasAscendantQuest.ShulgraxTimer)
		item:transform(9826)
	elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end
