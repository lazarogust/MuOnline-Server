OpenFolder("Definitions")


CUSTOM_EFFECT_INFOS = {}


CUSTOM_EFFECT_INFOS[GET_ITEM_MODEL(12, 144)] = { 

{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 47, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 24, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 40, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 46, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 23, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 35, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 39, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 44, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 45, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 12, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 16, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 21, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 22, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 61, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 60, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 59, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 62, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 55, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 52, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 53, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 54, Size = 1.60, ColorR = 0.97, ColorG = 0.4137, ColorB = 0.0679, Black = 0, RandTime = 100 },


}

function CharacterItensEffect(ObjectStruct, BMDStruct, ItemIndex)
	--Effects in tuple
	effectInfo = CUSTOM_EFFECT_INFOS[ItemIndex]
	
	if effectInfo ~= nil
	then
		math.randomseed(os.time())
		for i = 1, #effectInfo do
			local effect = effectInfo[i]
			local randValue = 100
			
			if effect.RandTime ~= 100
			then
				randValue = math.random(1, 100)
			end
			
			if effect.RandTime >= randValue
			then
				if effect.Type == 0
				then
					CreateSprite(BMDStruct, effect.EffectID, effect.Bone, effect.Size, effect.ColorR, effect.ColorG, effect.ColorB, ObjectStruct)
				else
					CreateParticle(BMDStruct, effect.EffectID, effect.EffectLv, effect.Bone, effect.Size, effect.ColorR, effect.ColorG, effect.ColorB, ObjectStruct)
				end
			end
		end
		return
	end
end
