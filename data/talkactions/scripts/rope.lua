local price_aol = 100

function onSay(player, words, param)
	
	if player:removeMoneyNpc(price_aol) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:addItem(2120, 1)	
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You dont have enought money.")
	end
	
end