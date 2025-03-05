OpenFolder("Definitions")

CUSTOM_ITEM_SIZE = 
{
--	{ItemIndex = GET_ITEM(7, 5), SizeInventory = 0.0130 },
--	{ItemIndex = GET_ITEM(0, 22), SizeInventory = 0.0140 },
	{ItemIndex = GET_ITEM(13, 135), SizeInventory = 0.00140 },
}

function StartLoadItemSize()
	for i = 1, #CUSTOM_ITEM_SIZE do
		SetItemSize(CUSTOM_ITEM_SIZE[i].ItemIndex, CUSTOM_ITEM_SIZE[i].SizeInventory)
	end
end