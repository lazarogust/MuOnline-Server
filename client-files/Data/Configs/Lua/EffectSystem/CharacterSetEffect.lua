OpenFolder("Definitions")

CUSTOM_EFFECT_SETS_SWITCH = 1

CUSTOM_SET_EFFECTS = {}

--[[
this config only detect boots so you need put boots of the set you want put effect

EffectType, 0 = sprite, 1 = particle, 2 = skill
]]--
CUSTOM_SET_EFFECTS[GET_ITEM_MODEL(11, 0)] = 
{
--	{ BonePlayer = 25, ItemMinLevel = 0, ItemMaxLevel = 15, EffectType = 2, EffectID = 387, EffectLv = 1, Size = 1.3, R = 0.0, G = 0.0, B = 0.8, PosX = 0.0, PosY = 10.0, PosZ = 0.0, RandTime = 200 },
}

function CreateEffectSetPlayer(BMDStruct, ObjectStruct, ItemIndex, SetLevel)
	if CUSTOM_EFFECT_SETS_SWITCH == 0
	then
		return
	end
	
	local setInfo = CUSTOM_SET_EFFECTS[ItemIndex]
	
	if setInfo ~= nil
	then
		math.randomseed(os.time())
		
		for key in pairs(setInfo) do
			local effectInfo = setInfo[key]
			
			if (SetLevel >= effectInfo.ItemMinLevel and SetLevel <= effectInfo.ItemMaxLevel)
			then
				local RandValue = 100
				
				if effectInfo.RandTime ~= 100
				then
					randValue = math.random(1, 100)
				end
				
				if effectInfo.RandTime >= randValue
				then
					if effectInfo.EffectType == 0
					then
						CreateSprite(BMDStruct, ObjectStruct, effectInfo.BonePlayer, effectInfo.EffectID, effectInfo.Size, effectInfo.R, effectInfo.G, effectInfo.B, effectInfo.PosX, effectInfo.PosY, effectInfo.PosZ)
					elseif effectInfo.EffectType == 1
					then
						CreateParticle(BMDStruct, ObjectStruct, effectInfo.BonePlayer, effectInfo.EffectID, effectInfo.EffectLv, effectInfo.Size, effectInfo.R, effectInfo.G, effectInfo.B, effectInfo.PosX, effectInfo.PosY, effectInfo.PosZ)
					elseif effectInfo.EffectType == 2
					then
						CreateSkill(BMDStruct, ObjectStruct, effectInfo.BonePlayer, effectInfo.EffectID, effectInfo.EffectLv, effectInfo.Size, effectInfo.R, effectInfo.G, effectInfo.B, effectInfo.PosX, effectInfo.PosY, effectInfo.PosZ)
					end
				end
			end
		end
	end
end