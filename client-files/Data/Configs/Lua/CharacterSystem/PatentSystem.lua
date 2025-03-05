--[[
System Config
]]--

local PATENT_SWITCH = 1

local PATENTE_MODEL_IMAGE = {}

PATENTE_MODEL_IMAGE[1] = 
{
	Switch = 1, PatentIndex = 1, Transparence = 0, ImagemIndex = 70000, NameLoad = "Custom\\Patent\\Patente1.tga", BoneBase = 20, x = 130.0, y = 0.0, z = 0.0
}

PATENTE_MODEL_IMAGE[2] = 
{
	Switch = 1, PatentIndex = 2, Transparence = 1, ImagemIndex = 70001, NameLoad = "Custom\\Patent\\Patente2.tga", BoneBase = 20, x = 130.0, y = 0.0, z = 0.0
}

local PATENT_INFO_MODEL = {}

PATENT_INFO_MODEL[1] = 
{ 
	PatentIndex = 1, ModelIndex = -1, ModelFolder = "Custom\\Sign\\Um\\", ModelName = "musign", BoneBase = 20, PosX = 70.0, PosY = -5.0, PosZ = 0.0, AngleX = 0.0, AngleY = 0.0, AngleZ = 45.0
}

local PATENT_MODEL_GLOW = {}

PATENT_MODEL_GLOW[1] = 
{
	{ RenderType = 0, Mesh = 0,  ModelGlow = 2, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
	{ RenderType = 0, Mesh = 0,  ModelGlow = 70, LightR = 1.0, LightG = 0.5, LightB = 0.5 },
}

local PATENT_MODEL_EFFECT = { }

PATENT_MODEL_EFFECT[1] = 
{
	{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 0, Size = 5.8, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 50.0, PosY = 2.0, PosZ = 11.0, Black = 0.0 },
	{ EffectType = 2, EffectIndex = 387, EffectLevel = 0,  Skeleton = -1, Size = 0.0, LightR = 1.0, LightG = 0.0, LightB = 0.2, PosX = 0.0, PosY = 0.0, PosZ = 0.0, Black = 0.0 },
}

--[[
System Manager
--]]

function StartPatentLoadModel()
	for key in pairs(PATENT_INFO_MODEL) do
		SetPatentModel(PATENT_INFO_MODEL[key].PatentIndex, PATENT_INFO_MODEL[key].ModelFolder, PATENT_INFO_MODEL[key].ModelName)
	end
end

function StartPatentLoadImage()
	for key in pairs(PATENTE_MODEL_IMAGE) do
		LoadImage(PATENTE_MODEL_IMAGE[key].NameLoad, PATENTE_MODEL_IMAGE[key].ImagemIndex)
		SetPatentImage(PATENTE_MODEL_IMAGE[key].PatentIndex	, PATENTE_MODEL_IMAGE[key].Transparence, PATENTE_MODEL_IMAGE[key].ImagemIndex)
	end
end

function PatentModelSetIndex(PatentIndex, ModelIndex)
	local patent = PATENT_INFO_MODEL[PatentIndex]
	
	if patent ~= nil
	then
		patent.ModelIndex = ModelIndex
	end
end

function RenderEffectModel(Bmd, Obj, ObjectStruct, PatentIndex)
	local patentEffect = PATENT_MODEL_EFFECT[PatentIndex]
	
	if patentEffect ~= nil
	then
		for i = 1, #patentEffect do
			local effect = patentEffect[i]
			
			if (effect.EffectType == 0)
			then
				Bmd:TransformPosition2(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
				
			elseif (effect.EffectType == 1)
			then
				Bmd:TransformPosition2(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			elseif (effect.EffectType == 2)
			then
				Bmd:TransformPosition2(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			end
		end
	end
end

function RenderGlowPatent(BMDStruct, ObjectStruct, PatentIndex)
	local patentGlow = PATENT_MODEL_GLOW[PatentIndex]
	
	if patentGlow ~= nil
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)
		
		for i = 1, #patentGlow do
			local glow = patentGlow[i]
			
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
		
		RenderEffectModel(Bmd, Obj, ObjectStruct, PatentIndex)
		
		Bmd = nil
		Obj = nil
		return 1
	end
	
	return 0
end

function PatentModelRender(BMDStruct, ObjectStruct, ItemIndex)
	for key in pairs(PATENT_INFO_MODEL) do
		if PATENT_INFO_MODEL[key].ModelIndex == ItemIndex
		then
			local ret = RenderGlowPatent(BMDStruct, ObjectStruct, PATENT_INFO_MODEL[key].PatentIndex)
			
			if ret == 1
			then
				return 1
			else
				goto continue
			end
		end
	end
	
	::continue::
	
	return 0
end

function SetPlayerPatente(arrayUser, PatentType, PatentIndex)
	if PATENT_SWITCH == 0
	then
		return
	end
	
	if PatentType == 0
	then

		local infoPatentImage = PATENTE_MODEL_IMAGE[PatentIndex]

		if infoPatentImage ~= nil
		then
			if infoPatentImage.Switch == 0
			then
				return
			end

			if infoPatentImage.PatentIndex ~= PatentIndex
			then
				return
			end
					
			CreatePartsImage(arrayUser, PatentIndex, infoPatentImage.ImagemIndex, infoPatentImage.BoneBase, infoPatentImage.x, infoPatentImage.y, infoPatentImage.z) 
		end
	end

	if PatentType == 1
	then 

		local infoPatent = PATENT_INFO_MODEL[PatentIndex]

		if infoPatent ~= nil
		then
			if infoPatent.PatentIndex ~= PatentIndex
			then
				return
			end
			
			if infoPatent.ModelIndex == -1
			then
				return
			end
			
			CreatePartsModel(arrayUser, PatentIndex, infoPatent.ModelIndex, infoPatent.BoneBase, 1, infoPatent.PosX, infoPatent.PosY, infoPatent.PosZ, infoPatent.AngleX, infoPatent.AngleY, infoPatent.AngleZ)
		end
	end
end