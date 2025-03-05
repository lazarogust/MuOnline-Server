OpenFolder("Definitions")

CUSTOM_ITEM_POSITION = 
{
	{ItemIndex = GET_ITEM(13, 135), PosX = 0.01, PosY = -0.05, AngleX = 270.0, AngleY = 0.0, AngleZ = 0.0 },
	{ItemIndex = GET_ITEM(4, 30), PosX = -0.1, PosY = 0.09, AngleX = 180.0, AngleY = -90.0, AngleZ = 15.0 },
	{ItemIndex = GET_ITEM(4, 31), PosX = 0.0, PosY = 0.03, AngleX = 90.0, AngleY = 180.0, AngleZ = 20.0 },
}

function StartLoadItemPosition()
	for i = 1, #CUSTOM_ITEM_POSITION do
		SetItemPosition(CUSTOM_ITEM_POSITION[i].ItemIndex, CUSTOM_ITEM_POSITION[i].PosX, CUSTOM_ITEM_POSITION[i].PosY, CUSTOM_ITEM_POSITION[i].AngleX, CUSTOM_ITEM_POSITION[i].AngleY, CUSTOM_ITEM_POSITION[i].AngleZ)
	end
end