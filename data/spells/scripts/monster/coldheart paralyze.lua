	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)

	local condition = Condition(CONDITION_PARALYZE)
	condition:setParameter(CONDITION_PARAM_TICKS, 20000)
	condition:setFormula(-0.5, 0, -0.75, 0)
	combat:setCondition(condition)

	local area = createCombatArea(AREA_SQUARE1X1)
	combat:setArea(area)
	combat:setCondition(condition)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
