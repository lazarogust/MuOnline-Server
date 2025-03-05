OpenFolder("Definitions")

local HELPER_CONFIG = {
--[[
SetHelper(
ItemIndex, -> GET_ITEM_MODEL(section, index)
Type, -> 0 (angel) - 1 Uniria - 2 Dinorant - 3 Fenrir - 4 Horse
Movement, -> 0 igual Angel, 1 igual demon season 4, 2 correr atr�s do player
Height, -> altura do pet do ch�o s� funciona em type 0
Size, -> tamanho do pet s� funciona em type 0
Model, -> nome do BMD para aparecer no invent�rio
ObjectModel -> nome do BMD para aparecer caso senha Uniria etc... (puxa da pasta Skills)
)
--]]
	{ ItemIndex = GET_ITEM_MODEL(13, 130), Type = 0, Movement = 1, Height = 180.0, Size = 0.70, SizeSelectChar = 1.0, Model = 'DragonKnight' , ObjectModel = 'DragonKnight' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	--{ ItemIndex = GET_ITEM_MODEL(13, 131), Type = 0, Movement = 2, Height = 5.0, Size = 0.50, SizeSelectChar = 1.0, Model = 'Fenrir_Ghost' , ObjectModel = 'Fenrir_Ghost' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	--{ ItemIndex = GET_ITEM_MODEL(13, 132), Type = 1, Movement = 0, Height = 5.0, Size = 1.00, SizeSelectChar = 1.0, Model = 'uniriav2' , ObjectModel = 'uniriav2' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	--{ ItemIndex = GET_ITEM_MODEL(13, 133), Type = 2, Movement = 0, Height = 5.0, Size = 1.00, SizeSelectChar = 1.0, Model = 'dinorantv2' , ObjectModel = 'dinorantv2' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	{ ItemIndex = GET_ITEM_MODEL(13, 134), Type = 3, Movement = 0, Height = 5.0, Size = 1.00, SizeSelectChar = 1.0, Model = 'fenrilv2' , ObjectModel = 'fenrilv2' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	{ ItemIndex = GET_ITEM_MODEL(13, 135), Type = 4, Movement = 0, Height = 5.0, Size = 1.00, SizeSelectChar = 1.2, Model = 'horsev2' , ObjectModel = 'Horse_ghost_skin3_skill' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	--{ ItemIndex = GET_ITEM_MODEL(13, 136), Type = 0, Movement = 1, Height = 150.0, Size = 0.70, SizeSelectChar = 1.0, Model = 'Pet213' , ObjectModel = 'Pet213' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	--{ ItemIndex = GET_ITEM_MODEL(13, 137), Type = 0, Movement = 2, Height = 5.0, Size = 0.50, SizeSelectChar = 1.0, Model = 'basecall' , ObjectModel = 'basecall' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
	{ ItemIndex = GET_ITEM_MODEL(13, 138), Type = 4, Movement = 0, Height = 5.0, Size = 1.00, SizeSelectChar = 1.0, Model = 'horsev2' , ObjectModel = 'Horse_ghost_skin3_skill' ,Miniature = 1, SizeMiniature = 0.40, VelocityMiniature = 0.50 },
}


----------------------------------
--- CONFIGURACAO DE SOMBRAS--
-- 0 = DESATIVA
-- 1 = ATIVA
-- SHADOW = SOMBRA
----------------------------------


local HELPER_CONFIG_SHADOW = { }  

-- HORN OF FENRIR POSEIDON
--local HELPER_CONFIG_SHADOW = {    
--	[GET_ITEM_MODEL(13, 218)] = 1,
--}

local HELPER_CONFIG_PEGADAS = { }

--local HELPER_CONFIG_PEGADAS = {   
--	[GET_ITEM_MODEL(13, 201)] = 1, 
--}

local HELPER_CONFIG_GLOW = {}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 130)] = {
--Voador body
{ RenderType = 1, Mesh = 2, ModelGlow = 65602, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
{ RenderType = 1, Mesh = 2, ModelGlow = 70, LightR = 1.0, LightG = 0.9, LightB = 0.0 },
{ RenderType = 0, Mesh = 0, ModelGlow = 70, LightR = 1.0, LightG = 0.9, LightB = 0.0 },
{ RenderType = 0, Mesh = 1, ModelGlow = 70, LightR = 1.0, LightG = 0.9, LightB = 0.0 },
{ RenderType = 0, Mesh = 2, ModelGlow = 70, LightR = 1.0, LightG = 0.9, LightB = 0.0 },
{ RenderType = 0, Mesh = 3, ModelGlow = 70, LightR = 1.0, LightG = 0.9, LightB = 0.0 },

}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 134)] = {
	--Fenrir render body and glow
	{ RenderType = 0, Mesh = 0, ModelGlow = 2, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
	{ RenderType = 0, Mesh = 1, ModelGlow = 2, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
	{ RenderType = 0, Mesh = 0, ModelGlow = 65602, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
	{ RenderType = 0, Mesh = 1, ModelGlow = 65602, LightR = 0.56, LightG = 0.38, LightB = 0.38 },
	}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 135)] = {
	--Voador body
	{ RenderType = 0, Mesh = 0, ModelGlow = 2,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 1, ModelGlow = 2, LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 2, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 3, ModelGlow = 2,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 4, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 5, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 6, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 7, ModelGlow = 2,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	-- EFFECT IN CAMADAS
	{ RenderType = 0, Mesh = 2, ModelGlow = 70,  LightR =  1.00, LightG = 0.4167,   LightB = 0.00, },
	{ RenderType = 0, Mesh = 4, ModelGlow = 70,  LightR =  1.00, LightG = 0.4167,   LightB = 0.00, },
	{ RenderType = 0, Mesh = 3, ModelGlow = 70,  LightR =  0.20, LightG = 0.20,   LightB = 0.20, },
}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 138)] = {
	--Voador body
	{ RenderType = 0, Mesh = 0, ModelGlow = 2,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 1, ModelGlow = 2, LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 2, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 3, ModelGlow = 2,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 4, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 5, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 6, ModelGlow = 66,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	{ RenderType = 0, Mesh = 7, ModelGlow = 2,  LightR =  1.00, LightG = 1.00, LightB = 1.00, },
	-- EFFECT IN CAMADAS
	{ RenderType = 0, Mesh = 2, ModelGlow = 70,  LightR =  1.00, LightG = 0.4167,   LightB = 0.00, },
	{ RenderType = 0, Mesh = 4, ModelGlow = 70,  LightR =  1.00, LightG = 0.4167,   LightB = 0.00, },
	{ RenderType = 0, Mesh = 3, ModelGlow = 70,  LightR =  0.20, LightG = 0.20,   LightB = 0.20, },
}

local HELPER_CONFIG_EFFECT = { }

HELPER_CONFIG_EFFECT[GET_ITEM_MODEL(13, 135)] = {
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 17  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 18  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 23  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 28  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 29  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 33  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 34  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 63  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 96  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 97  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 98  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 99  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 103 , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 31  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 64  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 65  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 66  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 90  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 42  , Size = 1.0, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 52  , Size = 1.0, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 74  , Size = 1.0, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 85  , Size = 1.0, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 43  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 44  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 45  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 53  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 54  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 58  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 75  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 76  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 77  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 86  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 87  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 88  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 78  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 0, EffectIndex = 32378, EffectLevel = 0,  Skeleton = 89  , Size = 0.8, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	
	{ EffectType = 1, EffectIndex = 32392, EffectLevel = 0,  Skeleton = 42  , Size = 0.62, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 1, EffectIndex = 32392, EffectLevel = 0,  Skeleton = 52  , Size = 0.62, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 1, EffectIndex = 32392, EffectLevel = 0,  Skeleton = 74  , Size = 0.62, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 1, EffectIndex = 32392, EffectLevel = 0,  Skeleton = 85  , Size = 0.62, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	
	{ EffectType = 1, EffectIndex = 32392, EffectLevel = 0,  Skeleton = 30  , Size = 0.30, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	{ EffectType = 1, EffectIndex = 32392, EffectLevel = 0,  Skeleton = 35  , Size = 0.30, LightR = 1.00, LightG = 0.3, LightB = 0.00, PosX = -1, PosY = -1, PosZ = -1, Black = 0.0 },
	
	
	}


--HELPER_CONFIG_EFFECT[GET_ITEM_MODEL(13, 218)] = {
--	{ EffectType = 0, EffectIndex = 32113, EffectLevel = 0,  Skeleton = 1, Size = 7.0, LightR = 1.49, LightG = 2.13, LightB = 1.98, PosX = 00.0, PosY = 0.0, PosZ = 0.0, Black = 0.0 },
--}

--[[
SetHelper(
ItemIndex, -> GET_ITEM_MODEL(section, index)
Type, -> 0 (angel) - 1 Uniria - 2 Dinorant - 3 Fenrir - 4 Horse
Movement, -> 0 igual Angel, 1 igual demon season 4, 2 correr atr�s do player
Height, -> altura do pet do ch�o s� funciona em type 0
Size, -> tamanho do pet s� funciona em type 0
Model, -> nome do BMD para aparecer no invent�rio
ObjectModel -> nome do BMD para aparecer caso senha Uniria etc... (puxa da pasta Skills)
)
--]]

--[[
CreateSprite(
BMDStruct
EffectIndex
Bone (Skeleton)
Size
R
G
B
ObjectStruct
)

CreateParticle(
BMDStruct
EffectIndex
EffectValue
Bone (Skeleton)
Size
R
G
B
ObjectStruct
)

CheckModelById(
GET_ITEM_MODEL(x, y)
} -> if you want render a mount need get with CheckModelById
]]

function LoadHelpers()
	for i = 1, #HELPER_CONFIG do
		local config = HELPER_CONFIG[i]
		SetHelper(config.ItemIndex, config.Type, config.Movement, config.Height, config.Size, config.SizeSelectChar, config.Miniature, config.SizeMiniature, config.VelocityMiniature, config.Model, config.ObjectModel)
	end
end

function RenderHelper(BMDStruct, ObjectStruct, Type)
	for i = 1, #HELPER_CONFIG do
		local config = HELPER_CONFIG[i]

		if config.ItemIndex == Type or CheckModelById(config.ItemIndex) == Type
		then
			if config.Type == 0
			then
				CreateFlyEffect(BMDStruct, ObjectStruct, config.ItemIndex)
				return
			elseif config.Type == 1
			then
				CreateUniriaEffect(BMDStruct, ObjectStruct, config.ItemIndex)
				return
			elseif config.Type == 2
			then
				CreateDinorantEffect(BMDStruct, ObjectStruct, config.ItemIndex)
				return
			elseif config.Type == 3
			then
				CreateFenrirEffect(BMDStruct, ObjectStruct, config.ItemIndex)
				return
			elseif config.Type == 4
			then
				CreateHorseEffect(BMDStruct, ObjectStruct, config.ItemIndex)
				return
			end

			break
		end
	end
end

function MoveEffects(BMDStruct, ObjectStruct, Type)
	for i = 1, #HELPER_CONFIG do
		local config = HELPER_CONFIG[i]

		if config.ItemIndex == Type or CheckModelById(config.ItemIndex) == Type
		then
			local Bmd = BMD.new(BMDStruct)
			local Obj = Object.new(ObjectStruct)
	
			--Effect
			local helperEffect = HELPER_CONFIG_EFFECT[config.ItemIndex]
			
			if helperEffect ~= nil
			then
				for i = 1, #helperEffect do
					local effect = helperEffect[i]

					if (effect.EffectType == 0)
					then
						Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
						Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
						
					elseif (effect.EffectType == 1)
					then
						Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
						Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
					elseif (effect.EffectType == 2)
					then
						Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
						Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
					end
				end
			end

			Bmd = nil
			Obj = nil

			break
		end
	end
end

function CreateFlyEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
end

function CreateUniriaEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
end

function CreateDinorantEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
end

function CreateFenrirEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	Bmd:BeginRender(1.0)
	
	Bmd:setMesh(0)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	Bmd:setMesh(-1)
	
	if (Obj:getAction() == 4)
	then
		local baseCalc = (math.sin(worldTime())*0.002)*0.2
	
		Bmd:SetLight(1.0, 1.0, 1.0)
		
		Bmd:RenderMesh(1, 70, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		
		--CreateParticle(BMDStruct, 32049, 15, 14, 0.7+(baseCalc*0.05), 1.0, 0.0, 0.0, ObjectStruct)
	end
	
	Bmd:EndRender()
	
	--Render shadow of the model
	Bmd:RenderShadowModel()

	--effects when use skill
	Bmd:CreateEffectsInFenrirUsingSkill(ObjectStruct)
	
	Bmd = nil
	Obj = nil
end

function CreateHorseEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			elseif glow.RenderType == 0
			then
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			elseif glow.RenderType == 3
			then
				Bmd:glColor3fv()
				local Vertex = GetDoubleRender(-1.5, 0.0) + 0.10
	
				if Vertex > 1.0
				then
				Vertex = 1.0
				end
	
				Bmd:SetLight(Vertex, Vertex, Vertex)
	
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
	
				Bmd:SetLight(1.0, 1.0, 1.0)
				Bmd:glColor3fv()
			end

		end
	end
	
	Bmd = nil
	Obj = nil
	
	
	
end