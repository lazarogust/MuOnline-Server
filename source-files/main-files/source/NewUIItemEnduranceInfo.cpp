// NewUIItemEnduranceInfo.cpp: implementation of the CNewUIItemEnduranceInfo class.
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "NewUIItemEnduranceInfo.h"
#include "NewUISystem.h"
#include "wsclientinline.h"
#include "CharacterManager.h"
#include "NewUIPCPoint.h"
#ifdef PJH_FIX_SPRIT
#include "GIPetManager.h"
#endif //PJH_FIX_SPRIT

extern float g_fScreenRate_x;

using namespace SEASON3B;

CNewUIItemEnduranceInfo::CNewUIItemEnduranceInfo()
{
	memset( &m_UIStartPos, 0, sizeof(POINT) );
	memset( &m_ItemDurUIStartPos, 0, sizeof(POINT) );
	m_iTextEndPosX = 0;
	m_iCurArrowType = ARROWTYPE_NONE;
	m_iTooltipIndex = -1;
	m_UIEndPos = 2;
	m_minimizeState = false;
	m_Show = false;
	m_isVisibleHPBar = true;
}

CNewUIItemEnduranceInfo::~CNewUIItemEnduranceInfo()
{
	Release();
}

bool SEASON3B::CNewUIItemEnduranceInfo::Create( CNewUIManager* pNewUIMng, int x, int y )
{
	if( NULL == pNewUIMng )
		return false;
	
	m_pNewUIMng = pNewUIMng;
	m_pNewUIMng->AddUIObj( SEASON3B::INTERFACE_ITEM_ENDURANCE_INFO, this );
	m_UIEndPos = 2;
	m_minimizeState = false;
	m_Show = false;
	SetPos( x, y );
	LoadImages();
	InitImageIndex();
	Show( true );
	return true;
}

void SEASON3B::CNewUIItemEnduranceInfo::Release()
{
	UnloadImages();
	
	if(m_pNewUIMng)
	{
		m_pNewUIMng->RemoveUIObj( this );
		m_pNewUIMng = NULL;
	}
}

void SEASON3B::CNewUIItemEnduranceInfo::SetPos( int x, int y )
{
	m_UIStartPos.x = GetScreenWidth() - PETHP_FRAME_WIDTH - 5;
	m_UIStartPos.y = y;

	m_ItemDurUIStartPos.x = GetScreenWidth() - ITEM_DUR_WIDTH - 2;
	m_ItemDurUIStartPos.y = 140;

	m_iTextEndPosX = m_UIStartPos.x + PETHP_FRAME_WIDTH;
}

void SEASON3B::CNewUIItemEnduranceInfo::SetPos( int x )
{
	m_UIStartPos.x = x - PETHP_FRAME_WIDTH - 5;
	m_ItemDurUIStartPos.x = x - ITEM_DUR_WIDTH - 2; 
	m_ItemDurUIStartPos.y = 140;
}

bool SEASON3B::CNewUIItemEnduranceInfo::UpdateMouseEvent()
{
	if( true == BtnProcess() )
		return false;
	
	int iNextPosY = m_UIStartPos.y;

	if (!m_Show)
		return true;

	if (CheckMouseIn(m_UIStartPos.x, iNextPosY, 100, 20))
	{
		if (CheckMouseIn(m_UIStartPos.x + 80, iNextPosY + 2, 13, 13) && SEASON3B::IsPress(VK_LBUTTON)) {
			m_minimizeState = !m_minimizeState;

			PlayBuffer(SOUND_CLICK01);
		}
		return false;
	}

	iNextPosY += 20;
	
	if ( Hero->Helper.Type>= MODEL_HELPER && Hero->Helper.Type<=MODEL_HELPER+4
		|| Hero->Helper.Type == MODEL_HELPER+64
		|| Hero->Helper.Type == MODEL_HELPER+65
		|| Hero->Helper.Type == MODEL_HELPER+67
		|| Hero->Helper.Type == MODEL_HELPER+80
		|| Hero->Helper.Type == MODEL_HELPER+106
		|| Hero->Helper.Type == MODEL_HELPER+123
		|| Hero->Helper.Type == MODEL_HELPER+37	)
	{
		if( CheckMouseIn( m_UIStartPos.x, iNextPosY, PETHP_FRAME_WIDTH, PETHP_FRAME_HEIGHT ) )
			return false;
		
		iNextPosY += (UI_INTERVAL_HEIGHT+PETHP_FRAME_HEIGHT);
	}
	
	if ( gCharacterManager.GetBaseClass(Hero->Class) == CLASS_DARK_LORD )
    {
		if( Hero->m_pPet != NULL )
		{
			if( CheckMouseIn( m_UIStartPos.x, iNextPosY, PETHP_FRAME_WIDTH, PETHP_FRAME_HEIGHT ) )
				return false;
			
			iNextPosY += (UI_INTERVAL_HEIGHT+PETHP_FRAME_HEIGHT);
		}
	}
	
	if( gCharacterManager.GetBaseClass(Hero->Class) == CLASS_ELF )
	{
		if( SummonLife > 0)
		{
			if( CheckMouseIn( m_UIStartPos.x, iNextPosY, PETHP_FRAME_WIDTH, PETHP_FRAME_HEIGHT ) )
				return false;
			
			iNextPosY += (UI_INTERVAL_HEIGHT+PETHP_FRAME_HEIGHT);
		}
	}

	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::UpdateKeyEvent()
{
	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::Update()
{
	if( !IsVisible() )
		return true;

	if ( gCharacterManager.GetBaseClass(Hero->Class)==CLASS_ELF )
    {

		if( gCharacterManager.GetEquipedBowType( ) == BOWTYPE_BOW )
		{
			m_iCurArrowType = ARROWTYPE_BOW;
		}
		else if( gCharacterManager.GetEquipedBowType( ) == BOWTYPE_CROSSBOW )
		{
		    m_iCurArrowType = ARROWTYPE_CROSSBOW;
	    }
		else
		{
			m_iCurArrowType = ARROWTYPE_NONE;
		}
    }
	
	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::Render()
{
	EnableAlphaTest();
	glColor3f( 1.f, 1.f, 1.f );
	g_pRenderText->SetFont( g_hFont );
	g_pRenderText->SetBgColor( 0, 0, 0, 0 );
	g_pRenderText->SetTextColor( 255, 255, 255, 255 );
	RenderLeft();
	//RenderRight();
	DisableAlphaBlend();
	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::RenderPCPoints(int iX, int iY)
{
	unicode::t_char szText[256] = { NULL, };
	unicode::_sprintf(szText, GlobalText[2319], CPcPoints::Instance().GetNowPoint(), CPcPoints::Instance().GetMaxPoint());
	//
	g_pRenderText->SetTextColor(255, 128, 255, 255);
	g_pRenderText->SetBgColor(0, 0, 0, 180);

	g_pRenderText->RenderText(iX, iY, szText, 0, 0, RT3_SORT_LEFT);
	return true;
}

//---------------------------------------------------------------------------------------------

void SEASON3B::CNewUIItemEnduranceInfo::RenderLeft()
{
	if (!m_isVisibleHPBar)
	{
		return;
	}
	// Todo
	int iNextPosY = m_UIStartPos.y;
	
	bool render = false;

	if (gCharacterManager.GetBaseClass(Hero->Class) == CLASS_ELF && (m_iCurArrowType != ARROWTYPE_NONE || SummonLife > 0))
	{
		render = true;
	}
	if (Hero->Helper.Type >= MODEL_HELPER && Hero->Helper.Type <= MODEL_HELPER + 4
		|| Hero->Helper.Type == MODEL_HELPER + 64
		|| Hero->Helper.Type == MODEL_HELPER + 65
		|| Hero->Helper.Type == MODEL_HELPER + 67
		|| Hero->Helper.Type == MODEL_HELPER + 80
		|| Hero->Helper.Type == MODEL_HELPER + 106
		|| Hero->Helper.Type == MODEL_HELPER + 123
		|| Hero->Helper.Type == MODEL_HELPER + 37
		|| gHelperSystem.CheckIsHelper(Hero->Helper.Type))
	{
		render = true;
	}

	if (gCharacterManager.GetBaseClass(Hero->Class) == CLASS_DARK_LORD && Hero->m_pPet != NULL)
	{
		render = true;
	}

	if (!render) 
	{
		m_Show = false;
		m_UIEndPos = iNextPosY;
		int iScreenWidth = GetScreenWidth();
		g_pPartyListWindow->SetPos(iScreenWidth);
		return;
	}
	else 
	{
		m_Show = true;
	}


	RenderImageScale(951000, m_UIStartPos.x - 5, iNextPosY, 100.f, 18.f, 0.f, 0.f, 120.f, 20.f);
	g_pRenderText->SetFont(g_hFont);
	g_pRenderText->SetBgColor(0, 0, 0, 0);
	g_pRenderText->SetTextColor(255, 255, 255, 255);
	g_pRenderText->RenderText(m_UIStartPos.x - 5 + (95 / 2), iNextPosY + 5.5f, "Pets/Arrows", 0, 0, RT3_WRITE_CENTER);


	if (m_minimizeState) 
	{
		RenderBitmap(951001, m_UIStartPos.x + 80, iNextPosY + 2, 13, 13, 0.008, 0.263782, 0.51488634, 0.263782, 1, 1, 1.0);
		m_UIEndPos = iNextPosY += 25;
		int iScreenWidth = GetScreenWidth();
		g_pPartyListWindow->SetPos(iScreenWidth);

		return;
	}
	RenderBitmap(951001, m_UIStartPos.x + 80, iNextPosY + 2, 13, 13, 0.008, 0.263782, 0.51488634, 0.263782, 1, 1, 1.0);
	iNextPosY += 20;
	
	if( gCharacterManager.GetBaseClass(Hero->Class) == CLASS_ELF)
	{
		if( RenderNumArrow( m_UIStartPos.x, iNextPosY ) )
		{
			iNextPosY += (UI_INTERVAL_HEIGHT+10);
		}
	}

	if( RenderEquipedHelperLife( m_UIStartPos.x, iNextPosY ) )
	{
		iNextPosY += (UI_INTERVAL_HEIGHT+PETHP_FRAME_HEIGHT);
	}
	
	if ( gCharacterManager.GetBaseClass(Hero->Class) == CLASS_DARK_LORD )
    {
		if( RenderEquipedPetLife( m_UIStartPos.x, iNextPosY ) )
		{
			iNextPosY += (UI_INTERVAL_HEIGHT+PETHP_FRAME_HEIGHT);
		}
	}
	
	if( gCharacterManager.GetBaseClass(Hero->Class) == CLASS_ELF )
	{
		if( RenderSummonMonsterLife( m_UIStartPos.x, iNextPosY ) )
		{
			iNextPosY += (UI_INTERVAL_HEIGHT+PETHP_FRAME_HEIGHT);
		}
	}

	m_UIEndPos = iNextPosY += 10;

	int iScreenWidth = GetScreenWidth();
	g_pPartyListWindow->SetPos(iScreenWidth);
}

void SEASON3B::CNewUIItemEnduranceInfo::RenderRight()
{
	RenderItemEndurance( m_ItemDurUIStartPos.x, m_ItemDurUIStartPos.y );
}

bool SEASON3B::CNewUIItemEnduranceInfo::BtnProcess()
{
	
	return false;
}

float SEASON3B::CNewUIItemEnduranceInfo::GetLayerDepth()
{
	return 3.5f;
}

void SEASON3B::CNewUIItemEnduranceInfo::OpenningProcess()
{

}

void SEASON3B::CNewUIItemEnduranceInfo::ClosingProcess()
{

}

void SEASON3B::CNewUIItemEnduranceInfo::InitImageIndex()
{
	m_iItemDurImageIndex[EQUIPMENT_WEAPON_RIGHT] = IMAGE_ITEM_DUR_WEAPON;
	m_iItemDurImageIndex[EQUIPMENT_WEAPON_LEFT] = IMAGE_ITEM_DUR_SHIELD;
	m_iItemDurImageIndex[EQUIPMENT_HELM] = IMAGE_ITEM_DUR_CAP;
	m_iItemDurImageIndex[EQUIPMENT_ARMOR] = IMAGE_ITEM_DUR_UPPER;
	m_iItemDurImageIndex[EQUIPMENT_PANTS] = IMAGE_ITEM_DUR_LOWER;
	m_iItemDurImageIndex[EQUIPMENT_GLOVES] = IMAGE_ITEM_DUR_GLOVES;
	m_iItemDurImageIndex[EQUIPMENT_BOOTS] = IMAGE_ITEM_DUR_BOOTS;
	m_iItemDurImageIndex[EQUIPMENT_WING] = IMAGE_ITEM_DUR_WING;
	m_iItemDurImageIndex[EQUIPMENT_HELPER] = -1;
	m_iItemDurImageIndex[EQUIPMENT_AMULET] = IMAGE_ITEM_DUR_NECKLACE;
	m_iItemDurImageIndex[EQUIPMENT_RING_RIGHT] = IMAGE_ITEM_DUR_RING;
	m_iItemDurImageIndex[EQUIPMENT_RING_LEFT] = IMAGE_ITEM_DUR_RING;
}

void SEASON3B::CNewUIItemEnduranceInfo::RenderHPUI( int iX, int iY, unicode::t_char* pszName, int iLife, int iMaxLife/*=255*/, bool bWarning/*=false*/ )
{
	EnableAlphaTest();
	
	glColor4f(0.f, 0.f, 0.f, 0.9f);
	RenderColor(iX, iY, PETHP_FRAME_WIDTH, PETHP_FRAME_HEIGHT - 20);
	glColor4f(0.f, 0.f, 0.f, 0.6f);
	RenderColor(iX, iY + 10, PETHP_FRAME_WIDTH, PETHP_FRAME_HEIGHT - 10);
	EndRenderColor();

	glColor4f(1.f, 1.f, 1.f, 1.f);

	float fLife = ((float)iLife / (float)iMaxLife) * (float)PETHP_BAR_WIDTH;

	RenderImageScale(951002, iX + 5, iY + 13, PETHP_BAR_WIDTH, PETHP_BAR_HEIGHT, 0.f, 0.f, 333.f, 14.f);
	RenderImageScale(951003, iX + 5, iY + 13, fLife, PETHP_BAR_HEIGHT, 0.f, 0.f, 333.f, 14.f);

	g_pRenderText->SetFont(g_hFont);
	g_pRenderText->SetBgColor(0, 0, 0, 0);
	if (bWarning == false)
	{
		g_pRenderText->SetTextColor(255, 255, 255, 255);
	}
	else
	{
		g_pRenderText->SetTextColor(200, 20, 20, 255);
	}
	g_pRenderText->RenderText(iX + (PETHP_FRAME_WIDTH / 2), iY + 1, pszName, 0, 0, RT3_WRITE_CENTER);

	unicode::t_char szText[256] = { 0, };
	g_pRenderText->SetTextColor(RGBA(237, 214, 161, 255));
	unicode::_sprintf(szText, GlobalText[358], iLife, iMaxLife);
	g_pRenderText->RenderText(iX + PETHP_FRAME_WIDTH - 5, iY + 15 + PETHP_BAR_HEIGHT, szText, 100, 0, RT3_WRITE_RIGHT_TO_LEFT);
	
	DisableAlphaBlend();
}

void SEASON3B::CNewUIItemEnduranceInfo::RenderTooltip( int iX, int iY, const ITEM* pItem, const DWORD& dwTextColor )
{
	ITEM_ATTRIBUTE *pItemAtt = &ItemAttribute[pItem->Type];
	SIZE TextSize = {0, 0};	

	int iLevel = (pItem->Level>>3)&15;
	int iMaxDurability = calcMaxDurability( pItem, pItemAtt, iLevel );

	unicode::t_char szText[256] = { NULL, };
	unicode::_sprintf( szText, "%s (%d/%d)", pItemAtt->Name, pItem->Durability, iMaxDurability );
	g_pMultiLanguage->_GetTextExtentPoint32( g_pRenderText->GetFontDC(), szText, 1, &TextSize );

	g_pRenderText->SetBgColor( 0, 0, 0, 128 );
	g_pRenderText->SetFont( g_hFontBold );
	g_pRenderText->SetTextColor( dwTextColor );
	int iTextlen = unicode::_strlen( szText );

	int iTooltipWidth = (/*TextSize.cx*/7*iTextlen) / g_fScreenRate_x;

	if( iX+(iTooltipWidth/2) > GetScreenWidth() )
	{
		iX = GetScreenWidth() - (iTooltipWidth/2);
	}

	g_pRenderText->RenderText( iX, iY, szText, 0, 0, RT3_WRITE_CENTER );
		
}

bool SEASON3B::CNewUIItemEnduranceInfo::RenderEquipedHelperLife( int iX, int iY )
{
 	if ( Hero->Helper.Type>= MODEL_HELPER && Hero->Helper.Type<=MODEL_HELPER+4
		|| Hero->Helper.Type == MODEL_HELPER+64
		|| Hero->Helper.Type == MODEL_HELPER+65
		|| Hero->Helper.Type == MODEL_HELPER+67
		|| Hero->Helper.Type == MODEL_HELPER+80
		|| Hero->Helper.Type == MODEL_HELPER+106
		|| Hero->Helper.Type == MODEL_HELPER+123
 		|| Hero->Helper.Type == MODEL_HELPER+37	
		|| gHelperSystem.CheckIsHelper(Hero->Helper.Type))
 	{
		unicode::t_char szText[256] = {NULL, };

 		switch ( Hero->Helper.Type )
 		{
		case MODEL_HELPER:
			{
				unicode::_sprintf( szText, GlobalText[353] );
			}
			break;
		case MODEL_HELPER+1:
			{
				ITEM_ATTRIBUTE *p = &ItemAttribute[Hero->Helper.Type-MODEL_SWORD];	
				unicode::_sprintf( szText, p->Name );
			}
			break;
		case MODEL_HELPER+2:
			{
				unicode::_sprintf( szText,GlobalText[355] );
			}
			break;
		case MODEL_HELPER+3:
			{
				unicode::_sprintf( szText,GlobalText[354] );
			}
			break;
        case MODEL_HELPER+4:
			{
				unicode::_sprintf( szText,GlobalText[1187] );
            }
			break;
		case MODEL_HELPER+37:
			{
				unicode::_sprintf( szText, GlobalText[1916] );
			}
			break;
		case MODEL_HELPER+64:
			{
				unicode::_sprintf( szText, ItemAttribute[ITEM_HELPER+64].Name );
			}
			break;
		case MODEL_HELPER+65:
			{
				unicode::_sprintf( szText, ItemAttribute[ITEM_HELPER+65].Name );
			}
			break;
		case MODEL_HELPER+67:
			{
				unicode::_sprintf( szText, ItemAttribute[ITEM_HELPER+67].Name );
			}
			break;
		case MODEL_HELPER+80:
			{
				unicode::_sprintf( szText, ItemAttribute[ITEM_HELPER+80].Name );
			}
			break;
		case MODEL_HELPER+106:
			{
				unicode::_sprintf( szText, ItemAttribute[ITEM_HELPER+106].Name );
			}
			break;
		case MODEL_HELPER+123:
			{
				unicode::_sprintf( szText, ItemAttribute[ITEM_HELPER+123].Name );
			}
			break;
		}

		if (gHelperSystem.CheckHelperType(Hero->Helper.Type, 0) || gHelperSystem.CheckHelperType(Hero->Helper.Type, 2) || gHelperSystem.CheckHelperType(Hero->Helper.Type, 4) || gHelperSystem.CheckHelperType(Hero->Helper.Type, 8) || gHelperSystem.CheckHelperType(Hero->Helper.Type, 16))
		{
			unicode::_sprintf(szText, ItemAttribute[Hero->Helper.Type - MODEL_ITEM].Name);
		}

		int iLife = CharacterMachine->Equipment[EQUIPMENT_HELPER].Durability;
		
		RenderHPUI( iX, iY, szText, iLife );

		return true;
	}

	return false;
}

bool SEASON3B::CNewUIItemEnduranceInfo::RenderEquipedPetLife( int iX, int iY )
{
	if( Hero->m_pPet == NULL )
		return false;
		
	unicode::t_char szText[256] = {NULL, };
	unicode::_sprintf( szText, GlobalText[1214] );
	
	int iLife = CharacterMachine->Equipment[EQUIPMENT_WEAPON_LEFT].Durability;
	
	RenderHPUI( iX, iY, szText, iLife );
	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::RenderSummonMonsterLife( int iX, int iY )
{
    if( SummonLife <= 0)
		return false;
	
	unicode::t_char szText[256] = {NULL, };
	unicode::_sprintf( szText, GlobalText[356] );
	
	RenderHPUI( iX, iY, szText, SummonLife, 100 );
	
	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::RenderNumArrow( int iX, int iY )
{
	if( m_iCurArrowType == ARROWTYPE_NONE )
		return false;

	unicode::t_char szText[256] = {NULL, };
	int iNumEquipedArrowDurability = 0;
	int iNumArrowSetInInven = 0;

	if( m_iCurArrowType == ARROWTYPE_BOW )
	{
		iNumArrowSetInInven = g_pMyInventory->GetNumItemByType( ARROWTYPE_BOW );

		if(CharacterMachine->Equipment[EQUIPMENT_WEAPON_RIGHT].Type == ITEM_BOW+15)
		{
			iNumEquipedArrowDurability = CharacterMachine->Equipment[EQUIPMENT_WEAPON_RIGHT].Durability;
		}
				
		if( (iNumArrowSetInInven == 0) && (CharacterMachine->Equipment[EQUIPMENT_WEAPON_RIGHT].Type != ITEM_BOW+15) )
			return false;

		unicode::_sprintf( szText, GlobalText[351], iNumEquipedArrowDurability, iNumArrowSetInInven );
	}
	else if( m_iCurArrowType == ARROWTYPE_CROSSBOW )
	{
		iNumArrowSetInInven = g_pMyInventory->GetNumItemByType( ARROWTYPE_CROSSBOW );

		if(CharacterMachine->Equipment[EQUIPMENT_WEAPON_LEFT].Type == ITEM_BOW+7)
		{
			iNumEquipedArrowDurability = CharacterMachine->Equipment[EQUIPMENT_WEAPON_LEFT].Durability;
		}
				
		if( (iNumArrowSetInInven == 0) && (CharacterMachine->Equipment[EQUIPMENT_WEAPON_LEFT].Type != ITEM_BOW+7) )
			return false;

		unicode::_sprintf( szText, GlobalText[352], iNumEquipedArrowDurability, iNumArrowSetInInven );
	}
	
	g_pRenderText->SetBgColor( 0, 0, 0, 180 );
	g_pRenderText->SetTextColor( 255, 160, 0, 255 );
	g_pRenderText->RenderText(iX + (PETHP_FRAME_WIDTH / 2), iY, szText, 90, 0, RT3_WRITE_CENTER);
	
	return true;
}

bool SEASON3B::CNewUIItemEnduranceInfo::RenderItemEndurance( int ix, int iY )
{
	if (g_pNewUISystem->IsVisible(SEASON3B::INTERFACE_TRADE))
		return false;

    glColor4f( 1.f, 1.f, 1.f, 1.f );
    

	POINT ItemDurPos = POINT(m_ItemDurUIStartPos);
	int icntItemDurIcon = 0;
	int iTempImageIndex;
	bool bRenderRingWarning = false;

    for ( int i=EQUIPMENT_WEAPON_RIGHT; i<MAX_EQUIPMENT; ++i )
    {
		ITEM *pItem = &CharacterMachine->Equipment[i];

		iTempImageIndex = m_iItemDurImageIndex[i];
		
		if( (pItem->bPeriodItem == true) && (pItem->bExpiredPeriod == false) )
		{
			continue;
		}

		if( i == EQUIPMENT_HELPER )
		{
			continue;
		}

		if( pItem->Type == -1 )
		{
			continue;
		}

		if( i == EQUIPMENT_WEAPON_RIGHT )
		{
			if( pItem->Type == ITEM_BOW+15 )
			{
				continue;
			}
		}
		else if( i == EQUIPMENT_WEAPON_LEFT)
		{
			if( gCharacterManager.GetEquipedBowType( pItem ) == BOWTYPE_BOW )
			{
				iTempImageIndex = m_iItemDurImageIndex[EQUIPMENT_WEAPON_RIGHT];
			}

			if( pItem->Type == ITEM_BOW+7 )
			{
				continue;
			}
		}

		int iLevel = (pItem->Level>>3)&15;

		if( i == EQUIPMENT_RING_LEFT || i == EQUIPMENT_RING_RIGHT)
		{
			if( pItem->Type == ITEM_HELPER+20 && iLevel == 1 
				|| iLevel == 2 )
			{
				continue;
			}
		}

		ITEM_ATTRIBUTE *pItemAtt = &ItemAttribute[pItem->Type];
		int iMaxDurability = calcMaxDurability( pItem, pItemAtt, iLevel );

		if( pItem->Durability > iMaxDurability*0.5f )		
		{
			continue;
		}

		EnableAlphaTest();
		glColor4f( 1.f, 1.f, 1.f, 1.f );

		if( i != EQUIPMENT_RING_LEFT || bRenderRingWarning != true ) 
		{
			RenderImage( m_iItemDurImageIndex[i], ItemDurPos.x, ItemDurPos.y, ITEM_DUR_WIDTH, ITEM_DUR_HEIGHT );
		}

		if( i == EQUIPMENT_RING_RIGHT )
		{
			bRenderRingWarning = true;
		}
		
		if( pItem->Durability == 0 )
		{
			glColor4f( 1.f, 0.0f, 0.f, 0.5f );
		}
		else if( pItem->Durability <= iMaxDurability*0.2f )
		{
			glColor4f( 1.f, 0.2f, 0.0f, 0.5f );
		}
		else if( pItem->Durability <= iMaxDurability*0.3f )
		{
			glColor4f( 1.0f, 0.5f, 0.f, 0.5f );
		}
		else if( pItem->Durability <= iMaxDurability*0.5f )
		{
			glColor4f( 1.f, 1.f, 0.f, 0.5f );
		}
		
		if( i == EQUIPMENT_RING_RIGHT )
		{
			RenderColor( ItemDurPos.x, ItemDurPos.y, ITEM_DUR_WIDTH/2, ITEM_DUR_HEIGHT );
		}
		else if( i == EQUIPMENT_RING_LEFT )
		{
			RenderColor( ItemDurPos.x+(ITEM_DUR_WIDTH/2), ItemDurPos.y, ITEM_DUR_WIDTH/2, ITEM_DUR_HEIGHT );
			bRenderRingWarning = false;
		}
		else
		{
			RenderColor( ItemDurPos.x, ItemDurPos.y, ITEM_DUR_WIDTH, ITEM_DUR_HEIGHT );
		}
		
		EndRenderColor();
		DisableAlphaBlend();
		
		if( bRenderRingWarning == false )
		{
			icntItemDurIcon++;
			ItemDurPos.y += ( ITEM_DUR_HEIGHT + UI_INTERVAL_WIDTH );	
			
			if( icntItemDurIcon%2 == 0)
			{
				ItemDurPos.y = m_ItemDurUIStartPos.y;
				ItemDurPos.x -= ( ITEM_DUR_WIDTH + UI_INTERVAL_WIDTH );
			}
		}
	}

	if( m_iTooltipIndex != -1 )
	{
		ITEM *pItem = &CharacterMachine->Equipment[m_iTooltipIndex];	
		DWORD dwColor = 0xFFFFFFFF;

		ITEM_ATTRIBUTE* pItemAttr = &ItemAttribute[pItem->Type];
		int iLevel = (pItem->Level>>3)&15;
		int iMaxDurability = calcMaxDurability(pItem, pItemAttr, iLevel);
		
		if( pItem->Durability <= (iMaxDurability*0.5f))
		{
			if(pItem->Durability <= 0)
			{
				dwColor = 0xFF0000FF;
			}
			else if(pItem->Durability <= (iMaxDurability*0.2f))
			{
				dwColor = 0xFF0053FF;
			}
			else if(pItem->Durability <= (iMaxDurability*0.3f))
			{
				dwColor = 0xFF00A8FF;
			}
			else if(pItem->Durability <= (iMaxDurability*0.5f))
			{
				dwColor = 0xFF00FFFF;
			}
			
			RenderTooltip( MouseX, MouseY-10, pItem, dwColor );
			m_iTooltipIndex = -1;
		}	
	}
	return true;
}

void SEASON3B::CNewUIItemEnduranceInfo::LoadImages()
{
	LoadBitmap("Interface\\newui_Pet_Back.tga", IMAGE_PETHP_FRAME, GL_LINEAR);
	LoadBitmap("Interface\\newui_Pet_HpBar.jpg", IMAGE_PETHP_BAR, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_boots.tga", IMAGE_ITEM_DUR_BOOTS, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_cap.tga", IMAGE_ITEM_DUR_CAP, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_gloves.tga", IMAGE_ITEM_DUR_GLOVES, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_lower.tga", IMAGE_ITEM_DUR_LOWER, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_necklace.tga", IMAGE_ITEM_DUR_NECKLACE, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_ring.tga",	 IMAGE_ITEM_DUR_RING, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_shield.tga", IMAGE_ITEM_DUR_SHIELD, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_upper.tga", IMAGE_ITEM_DUR_UPPER, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_weapon.tga", IMAGE_ITEM_DUR_WEAPON, GL_LINEAR);
	LoadBitmap("Interface\\newui_durable_wing.tga",	 IMAGE_ITEM_DUR_WING, GL_LINEAR);
//
	LoadBitmap("Custom\\minimize_bar.jpg", 951000, GL_LINEAR);
	LoadBitmap("Custom\\chat_buttons_size.jpg", 951001, GL_LINEAR);
	LoadBitmap("Custom\\party_info_life_back.jpg", 951002, GL_LINEAR);
	LoadBitmap("Custom\\party_info_life_top.jpg", 951003, GL_LINEAR);
}

void SEASON3B::CNewUIItemEnduranceInfo::UnloadImages()
{
	DeleteBitmap(951003);
	DeleteBitmap(951002);
	DeleteBitmap(951001);
	DeleteBitmap(951000);
	DeleteBitmap(IMAGE_PETHP_FRAME);
	DeleteBitmap(IMAGE_PETHP_BAR);
	DeleteBitmap(IMAGE_ITEM_DUR_BOOTS);
	DeleteBitmap(IMAGE_ITEM_DUR_CAP);
	DeleteBitmap(IMAGE_ITEM_DUR_GLOVES);
	DeleteBitmap(IMAGE_ITEM_DUR_LOWER);
	DeleteBitmap(IMAGE_ITEM_DUR_NECKLACE);
	DeleteBitmap(IMAGE_ITEM_DUR_RING);
	DeleteBitmap(IMAGE_ITEM_DUR_SHIELD);
	DeleteBitmap(IMAGE_ITEM_DUR_UPPER);
	DeleteBitmap(IMAGE_ITEM_DUR_WEAPON);
	DeleteBitmap(IMAGE_ITEM_DUR_WING);
}
