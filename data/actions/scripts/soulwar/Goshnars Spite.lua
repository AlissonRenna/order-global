local config = {
	bossName = "Goshnar's Spite",
	bossName2 = "Spiteful Spitter",
	bossName3 = "Spiteful Spitter",
	bossName4 = "Spiteful Spitter",
	bossName5 = "Spiteful Spitter",
	bossName6 = "Weeping Soul",
	bossName7 = "Weeping Soul",
	bossName8 = "Weeping Soul",
	summonName = "Rift Invader",
	bossPos = Position{x = 33742, y = 31630, z = 14},
	horror = Position{x = 33737, y = 31632, z = 14},
	phobia = Position{x = 33747, y = 31631, z = 14},
	fear = Position{x = 33747, y = 31636, z = 14},
	fear2 = Position{x = 33737, y = 31636, z = 14},
	fear3 = Position{x = 33740, y = 31639, z = 14},
	fear4 = Position{x = 33744, y = 31627, z = 14},
	fear5 = Position{x = 33739, y = 31626, z = 14},
	centerRoom = Position{x = 33742, y = 31632, z = 14}, -- Center Room
	exitPosition = Position{x = 33743, y = 31640, z = 14}, -- Exit Position
	newPos = Position{x = 33742, y = 31637, z = 14}, -- Player Position on room
	playerPositions = {
		Position{x = 33774, y = 31634, z = 14},
		Position{x = 33775, y = 31634, z = 14},
		Position{x = 33776, y = 31634, z = 14},
		Position{x = 33777, y = 31634, z = 14},
		Position{x = 33778, y = 31634, z = 14}
	},
	range = 20,
	time = 20, -- time in minutes to remove the player
}
local function clearSpiteRoom()
	local spectators = Game.getSpectators(config.bossPos, false, false, 20, 20, 20, 20)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			spectator:teleportTo(config.exitPosition)
			spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
		elseif spectator:isMonster() then
			spectator:remove()
		end
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 and item.actionid == 30045 then -- ID da alavanca OU QUALQUER ITEM, e em seguida ACTION ID que está na alavanca.
		if player:getPosition() ~= Position{x = 33774, y = 31634, z = 14} then
			return true
		end

		for x = 33774, 33778 do
			for y = 31634, 31634 do
				local playerTile = Tile(Position(x, y, 14)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					if playerTile:getStorageValue(58885555) > os.time() then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You or a member in your team have to wait 20 hours to face Boss again!")
						item:transform(9826)
						return true
					end
				end
			end
		end

		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with Boss.")
				return true
			end
		end

		local spectators = Game.getSpectators(config.bossPos, false, false, 15, 15, 15, 15)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if spectator:isMonster() then
				spectator:remove()
			end
		end

		for x = 33774, 33778 do
			for y = 31634, 31634 do
				local playerTile = Tile(Position(x, y, 14)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPos)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setStorageValue(58885555, os.time() + 20 * 60 * 60) -- 14 days
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 30 minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
					addEvent(clearAlptraRoom, 60 * config.time * 1000, player:getId(), config.centerRoom, config.range, config.range, config.exitPosition)

					

					
					
					item:transform(9826)
				end
			end
		end
		            Game.createMonster(config.bossName, config.bossPos, true, true)
					Game.createMonster(config.bossName2, config.horror, true, true)
					Game.createMonster(config.bossName3, config.phobia, true, true)
					Game.createMonster(config.bossName4, config.fear, true, true)
					Game.createMonster(config.bossName5, config.fear2, true, true)
					Game.createMonster(config.bossName6, config.fear3, true, true)
					Game.createMonster(config.bossName7, config.fear4, true, true)
					Game.createMonster(config.bossName8, config.fear5, true, true)
	elseif item.itemid == 9826 then
		item:transform(9825)
		return true
	end
end