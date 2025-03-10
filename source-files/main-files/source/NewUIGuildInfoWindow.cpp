//////////////////////////////////////////////////////////////////////
// NewUIGuildInfoWindow.cpp: implementation of the CNewUIGuildInfoWindow class.
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "NewUIGuildInfoWindow.h"
#include "NewUISystem.h"
#include "NewUICommonMessageBox.h"
#include "NewUICustomMessageBox.h"
#include "DSPlaySound.h"
#include "UIGuildInfo.h"
#include "UIControls.h"
#include "UIPopup.h"
#include "ZzzInterface.h"
#include "ZzzInventory.h"
#include "ZzzInfomation.h"
#include "wsclientinline.h"
#include "CharacterManager.h"
#include "GuildManager.h"

int	DeleteIndex = 0;
int AppointStatus = 0;
char DeleteID[100];

extern CUIPopup* g_pUIPopup;
extern MARK_t GuildMark[MAX_MARKS];

using namespace SEASON3B;

void RenderText(char* text, int x, int y, int sx, int sy, DWORD color, DWORD backcolor, int sort)
{
	g_pRenderText->SetFont(g_hFont);

	DWORD backuptextcolor = g_pRenderText->GetTextColor();
	DWORD backuptextbackcolor = g_pRenderText->GetBgColor();

	g_pRenderText->SetTextColor(color);
	g_pRenderText->SetBgColor(backcolor);
	g_pRenderText->RenderText(x, y, text, sx, sy, sort);

	g_pRenderText->SetTextColor(backuptextcolor);
	g_pRenderText->SetBgColor(backuptextbackcolor);
}

int SEASON3B::CNewUIGuildInfoWindow::GetGuildMemberIndex(char* szName)
{
	for (int i = 0; i < g_nGuildMemberCount; ++i)
	{
		if (GuildList[i].Name && !strcmp(GuildList[i].Name, szName))
			return i;
	}

	return -1;
}

SEASON3B::CNewUIGuildInfoWindow::CNewUIGuildInfoWindow() : m_Button(NULL)
{
	m_pNewUIMng = NULL;
	m_Pos.x = m_Pos.y = 0;
	m_nCurrentTab = 1;
	m_EventState = EVENT_NONE;
	m_Loc = 0;
	m_BackUp = 0;
	m_CurrentListPos = 0;
	m_Loc_Bk = 0;
	m_Tot_Notice = 0;
	m_dwPopupID = 0;

	m_bRequestUnionList = false;
}

SEASON3B::CNewUIGuildInfoWindow::~CNewUIGuildInfoWindow()
{
	Release();
}

bool SEASON3B::CNewUIGuildInfoWindow::Create(CNewUIManager* pNewUIMng, int x, int y)
{
	if (NULL == pNewUIMng || NULL == g_pNewUI3DRenderMng || NULL == g_pNewItemMng)
		return false;

	m_pNewUIMng = pNewUIMng;
	m_pNewUIMng->AddUIObj(SEASON3B::INTERFACE_GUILDINFO, this);

	SetPos(x, y);

	LoadImages();
	m_Button = new CNewUIButton[BUTTON_END];

	m_MenuOn[0].ChangeButtonImgState(true, 941004, true);
	m_MenuOn[0].ChangeButtonInfo(0, 0, 54, 29);
	m_MenuOn[0].SetPos(m_Pos.x + 11, m_Pos.y + 75);

	m_MenuOn[1].ChangeButtonImgState(true, 941005, true);
	m_MenuOn[1].ChangeButtonInfo(0, 0, 54, 29);
	m_MenuOn[1].SetPos(m_Pos.x + 68, m_Pos.y + 75);

	m_MenuOn[2].ChangeButtonImgState(true, 941006, true);
	m_MenuOn[2].ChangeButtonInfo(0, 0, 54, 29);
	m_MenuOn[2].SetPos(m_Pos.x + 125, m_Pos.y + 75);
	//

	m_Button[BUTTON_GUILD_OUT].ChangeButtonImgState(true, 941003, true);
	m_Button[BUTTON_GUILD_OUT].ChangeButtonInfo(0, 0, 54, 29);
	m_Button[BUTTON_GUILD_OUT].SetPos(m_Pos.x + 70, m_Pos.y + 350);

	m_Button[BUTTON_GET_POSITION].ChangeButtonImgState(true, 941001, true);
	m_Button[BUTTON_GET_POSITION].ChangeButtonInfo(0, 0, 54, 29);
	m_Button[BUTTON_GET_POSITION].SetPos(m_Pos.x + 64, m_Pos.y + 360);

	m_Button[BUTTON_FREE_POSITION].ChangeButtonImgState(true, 941000, true);
	m_Button[BUTTON_FREE_POSITION].ChangeButtonInfo(0, 0, 54, 29);
	m_Button[BUTTON_FREE_POSITION].SetPos(m_Pos.x + 125, m_Pos.y + 360);

	m_Button[BUTTON_GET_OUT].ChangeButtonImgState(true, 941002, true);
	m_Button[BUTTON_GET_OUT].ChangeButtonInfo(0, 0, 54, 29);
	m_Button[BUTTON_GET_OUT].SetPos(m_Pos.x + 125, m_Pos.y + 392);

	m_BtnExit.ChangeButtonImgState(true, IMAGE_GUILDINFO_EXIT_BTN, false);
	m_BtnExit.ChangeButtonInfo(m_Pos.x + 13, m_Pos.y + 392, 36, 29);
	m_BtnExit.ChangeToolTipText(GlobalText[1002], true);

	Show(false);

	return true;
}

void SEASON3B::CNewUIGuildInfoWindow::OpenningProcess()
{
	m_nCurrentTab = 1;

	SendRequestGuildList();
}

void SEASON3B::CNewUIGuildInfoWindow::ClosingProcess()
{
	m_bRequestUnionList = false;
}

void SEASON3B::CNewUIGuildInfoWindow::Release()
{
	UnloadImages();

	SAFE_DELETE_ARRAY(m_Button);

	if (m_pNewUIMng)
	{
		m_pNewUIMng->RemoveUIObj(this);
		m_pNewUIMng = NULL;
	}
}

void SEASON3B::CNewUIGuildInfoWindow::SetPos(int x, int y)
{
	m_Pos.x = x;
	m_Pos.y = y;
}

bool SEASON3B::CNewUIGuildInfoWindow::UpdateMouseEvent()
{
	bool ret = true;

	if (SEASON3B::IsPress(VK_LBUTTON))
	{
		ret = Check_Mouse(MouseX, MouseY);
		if (ret == false)
		{
			PlayBuffer(SOUND_CLICK01);
		}
	}

	if (m_EventState == EVENT_SCROLL_BTN_DOWN)
	{
		if (SEASON3B::IsRepeat(VK_LBUTTON))
		{
			/*
			if(GetNumberOfLines() > GetNumberOfShowingLines())
			{
				extern int MouseY;
				if(MouseY-m_iGrapRelativePosY < m_WndPos.y-m_WndSize.cy+WND_TOP_BOTTOM_EDGE)
				{
					Scrolling(GetNumberOfShowingLines()-1);
					m_ScrollBtnPos.y = m_WndPos.y-m_WndSize.cy+WND_TOP_BOTTOM_EDGE;
				}
				else if(MouseY-m_iGrapRelativePosY > m_WndPos.y-SCROLL_BTN_HEIGHT-WND_TOP_BOTTOM_EDGE)
				{
					Scrolling(GetNumberOfLines()-1);
					m_ScrollBtnPos.y = m_WndPos.y-SCROLL_BTN_HEIGHT-WND_TOP_BOTTOM_EDGE;
				}
				else
				{
					float fScrollRate = (float)((MouseY-m_iGrapRelativePosY) - (m_WndPos.y-m_WndSize.cy+WND_TOP_BOTTOM_EDGE))
						/ (float)(m_WndSize.cy-WND_TOP_BOTTOM_EDGE*2-SCROLL_BTN_HEIGHT);
					Scrolling(GetNumberOfShowingLines() + (float)(GetNumberOfLines()-GetNumberOfShowingLines())*fScrollRate);

					m_ScrollBtnPos.y = MouseY - m_iGrapRelativePosY;
				}
			}
			*/
			return false;
		}
		if (SEASON3B::IsRelease(VK_LBUTTON))
		{
			m_EventState = EVENT_NONE;
			return true;
		}
	}

	Check_Btn();

	if (m_nCurrentTab == 0)
	{
		m_GuildNotice.DoAction();
	}
	else if (m_nCurrentTab == 1)
	{
		m_GuildMember.DoAction();
	}
	else if (m_nCurrentTab == 2)
	{
		m_UnionListBox.DoAction();
	}

	if (CheckMouseIn(m_Pos.x, m_Pos.y, GUILDINFO_WIDTH, GUILDINFO_HEIGHT))
	{
		return false;
	}

	return ret;
}

bool SEASON3B::CNewUIGuildInfoWindow::Check_Btn()
{
	POINT ptExitBtn1 = { m_Pos.x + 169, m_Pos.y + 7 };

	if (m_BtnExit.UpdateMouseEvent() == true)
	{
		g_pNewUISystem->Hide(SEASON3B::INTERFACE_GUILDINFO);
		m_EventState = EVENT_NONE;
		return false;
	}
	if (SEASON3B::IsPress(VK_LBUTTON) && CheckMouseIn(ptExitBtn1.x, ptExitBtn1.y, 13, 12))
	{
		g_pNewUISystem->Hide(SEASON3B::INTERFACE_GUILDINFO);
		m_EventState = EVENT_NONE;
		return false;
	}

	if (m_EventState == EVENT_SCROLL_BTN_DOWN && SEASON3B::IsRelease(VK_LBUTTON))
	{
		m_EventState = EVENT_NONE;
		return false;
	}

	if (m_MenuOn[0].UpdateMouseEvent())
	{
		m_nCurrentTab = 0;

	}
	if (m_MenuOn[1].UpdateMouseEvent())
	{
		m_nCurrentTab = 1;
		SendRequestGuildList();

	}
	if (m_MenuOn[2].UpdateMouseEvent())
	{
		m_nCurrentTab = 2;
		if (m_bRequestUnionList == false
			&& GuildMark[Hero->GuildMarkIndex].UnionName[0] != NULL)
		{
			SendRequestUnionList();
			m_bRequestUnionList = true;
		}
	}

	if (m_nCurrentTab == 0)
	{
		if (m_Button[BUTTON_GUILD_OUT].UpdateMouseEvent())
		{
			if (Hero->GuildStatus == G_MASTER)
			{
				if (!strcmp(GuildMark[Hero->GuildMarkIndex].GuildName, GuildMark[Hero->GuildMarkIndex].UnionName))
				{
					SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(SEASON3B::CGuildOutPerson));
				}
				else
				{
					DeleteIndex = GetGuildMemberIndex(Hero->ID);
					SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(SEASON3B::CGuildBreakMsgBoxLayout));
				}
			}
			else
			{
				DeleteIndex = GetGuildMemberIndex(Hero->ID);
				SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(SEASON3B::CGuildBreakPasswordMsgBoxLayout));
			}
		}
	}
	else if (m_nCurrentTab == 1)
	{
		if (m_Button[BUTTON_GET_OUT].UpdateMouseEvent())
		{
			if (Hero->GuildStatus == G_MASTER)
			{
				if (GUILDLIST_TEXT* pText = m_GuildMember.GetSelectedText())
				{
					if (pText->m_GuildStatus != G_MASTER)
					{
						if (GUILDLIST_TEXT* pText = m_GuildMember.GetSelectedText())
						{
							DeleteIndex = GetGuildMemberIndex(pText->m_szID);
							SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(SEASON3B::CGuildPerson_Get_Out));
						}
					}
				}
			}
		}
		else if (m_Button[BUTTON_GET_POSITION].UpdateMouseEvent())
		{
			if (GUILDLIST_TEXT* pText = m_GuildMember.GetSelectedText())
			{
				if (Hero->GuildStatus == G_MASTER)
				{
					if (pText->m_GuildStatus != G_MASTER)
					{
						if (GUILDLIST_TEXT* pText = m_GuildMember.GetSelectedText())
						{
							AppointStatus = (GUILD_STATUS)pText->m_GuildStatus;
							DeleteIndex = GetGuildMemberIndex(pText->m_szID);
							SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(CGuild_ToPerson_PositionLayout));
						}
					}
				}
			}
		}
		else if (m_Button[BUTTON_FREE_POSITION].UpdateMouseEvent())
		{
			if (GUILDLIST_TEXT* pText = m_GuildMember.GetSelectedText())
			{
				if (pText->m_GuildStatus == G_SUB_MASTER || pText->m_GuildStatus == G_BATTLE_MASTER)
				{
					if (GUILDLIST_TEXT* pText = m_GuildMember.GetSelectedText())
					{
						AppointStatus = (GUILD_STATUS)pText->m_GuildStatus;
						DeleteIndex = GetGuildMemberIndex(pText->m_szID);
						CNewUICommonMessageBox* pMsgBox = NULL;
						SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(CGuildPerson_Cancel_Position_MsgBoxLayout), &pMsgBox);
						if (pMsgBox != NULL)
						{
							unicode::t_char strText[256];
							unicode::_sprintf(strText, GlobalText[1367], pText->m_szID);
							pMsgBox->AddMsg(strText);
							pMsgBox->AddMsg(GlobalText[1368]);
						}
					}
				}
			}
		}
	}
	else if (m_nCurrentTab == 2)
	{
		if (m_Button[BUTTON_UNION_CREATE].UpdateMouseEvent())
		{
			if (Hero->GuildStatus == G_MASTER)
			{
				if (UNIONGUILD_TEXT* pText = m_UnionListBox.GetSelectedText())
				{
					if (strcmp(pText->szName, GuildMark[Hero->GuildMarkIndex].GuildName))
					{
						strcpy(DeleteID, pText->szName);
						SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(CUnionGuild_Break_MsgBoxLayout));
					}
				}
			}
		}
		else if (m_Button[BUTTON_UNION_OUT].UpdateMouseEvent())
		{
			if (Hero->GuildStatus == G_MASTER)
			{
				if (!strcmp(GuildMark[Hero->GuildMarkIndex].GuildName, GuildMark[Hero->GuildMarkIndex].UnionName))
				{
					SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(CUnionGuild_Out_MsgBoxLayout));
				}
				else
				{
					SendRequestGuildRelationShip(0x01, 0x02, HIBYTE(Hero->Key), LOBYTE(Hero->Key));
				}
			}
		}
	}
	return true;
}

bool SEASON3B::CNewUIGuildInfoWindow::Check_Mouse(int mx, int my)
{
	if (m_nCurrentTab == 0)
	{
		if (SEASON3B::CheckMouseIn(m_Pos.x + 163, m_Pos.y + 262 + m_Loc, 18, 33 + m_Loc) == true && m_EventState == EVENT_NONE)
		{
			m_EventState = EVENT_SCROLL_BTN_DOWN;
			if (m_BackUp == 0)
			{
				m_BackUp = (262 + (MouseY - 262));
			}
			return false;
		}
	}
	else if (m_nCurrentTab == 1)
	{
		if ((MouseX > m_Pos.x + 166 && MouseX < (m_Pos.x + 181) && MouseY > m_Pos.y + 125 + m_Loc && MouseY < (m_Pos.y + 175 + m_Loc)) && m_EventState == EVENT_NONE)
		{
			m_EventState = EVENT_SCROLL_BTN_DOWN;
			if (m_BackUp == 0)
				m_BackUp = (125 + (MouseY - 125));
			return false;
		}
	}
	return true;
}

bool SEASON3B::CNewUIGuildInfoWindow::UpdateKeyEvent()
{
	if (g_pNewUISystem->IsVisible(SEASON3B::INTERFACE_GUILDINFO) == true)
	{
		if (SEASON3B::IsPress(VK_ESCAPE) == true)
		{
			g_pNewUISystem->Hide(SEASON3B::INTERFACE_GUILDINFO);
			PlayBuffer(SOUND_CLICK01);
			return false;
		}
	}

	return true;
}
bool SEASON3B::CNewUIGuildInfoWindow::Update()
{
	return true;
}

bool SEASON3B::CNewUIGuildInfoWindow::Render()
{
	EnableAlphaTest();
	glColor4f(1.f, 1.f, 1.f, 1.f);

	RenderFrame();

	if (Hero->GuildStatus == G_NONE)
	{
		RenderNoneGuild();
	}
	else
	{
		switch (m_nCurrentTab)
		{
		case 0:
			Render_Guild_History();	// JANELA 1
			break;
		case 1:
			Render_Guild_Enum();	 // JANELA 2
			RenderScrollBar();		 // JANELA 2
			break;
		case 2:
			Render_Guild_Info();
			break;
		}

		Render_Text();

		EnableAlphaTest();
		m_MenuOn[0].Render();
		m_MenuOn[1].Render();
		m_MenuOn[2].Render();
		m_BtnExit.Render();
	}

	DisableAlphaBlend();
	return true;
}

void SEASON3B::CNewUIGuildInfoWindow::RenderFrame()
{
	RenderImage(IMAGE_GUILDINFO_BACK, m_Pos.x, m_Pos.y, GUILDINFO_WIDTH, GUILDINFO_HEIGHT);
	RenderImage(IMAGE_GUILDINFO_TOP, m_Pos.x, m_Pos.y, GUILDINFO_WIDTH, 64.f);
	RenderImage(IMAGE_GUILDINFO_LEFT, m_Pos.x, m_Pos.y + 64, 21.f, 320.f);
	RenderImage(IMAGE_GUILDINFO_RIGHT, m_Pos.x + GUILDINFO_WIDTH - 21, m_Pos.y + 64, 21.f, 320.f);
	RenderImage(IMAGE_GUILDINFO_BOTTOM, m_Pos.x, m_Pos.y + GUILDINFO_HEIGHT - 45, GUILDINFO_WIDTH, 45.f);
}

void SEASON3B::CNewUIGuildInfoWindow::RenderNoneGuild()
{
	POINT ptOrigin = { m_Pos.x + 15, m_Pos.y + 38 };
	ptOrigin.x += 10;
	ptOrigin.y += 8;

	unicode::t_char Text[128];
	memset(&Text, 0, sizeof(unicode::t_char) * 128);
	sprintf(Text, GlobalText[180]);
	g_pRenderText->SetTextColor(255, 255, 255, 255);
	g_pRenderText->SetBgColor(0);
	g_pRenderText->SetFont(g_hFontBold);
	g_pRenderText->RenderText(m_Pos.x, m_Pos.y + 15, Text, 190, 0, RT3_SORT_CENTER);

	g_pRenderText->SetFont(g_hFont);
	g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[185]);
	ptOrigin.y += 15;
	g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[186]);
	ptOrigin.y += 15;
	g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[187]);

	m_BtnExit.Render();
}

void SEASON3B::CNewUIGuildInfoWindow::Render_Text()
{
	char Text[300];
	POINT ptOrigin;
	sprintf(Text, GlobalText[180]);
	RenderText(Text, m_Pos.x, m_Pos.y + 12, 190, 0, 0xFFFFFFFF, 0x00000000, RT3_SORT_CENTER);
	ptOrigin.x = m_Pos.x + 35;
	ptOrigin.y = m_Pos.y + 48;

	g_pRenderText->SetTextColor(200, 255, 100, 255);
	sprintf(Text, "%s ( Score:%d )", GuildMark[Hero->GuildMarkIndex].GuildName, GuildTotalScore);
	g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, Text, 120, 0, RT3_SORT_CENTER);

	glColor4f(0.6f, 0.6f, 0.6f, 1.f);

	if (m_nCurrentTab == 0)
	{
		int Nm_Loc = m_Pos.y + 67;
		glColor4f(1.0, 1.0, 1.0, 1.0);
		g_pRenderText->SetFont(g_hFontBold);
		g_pRenderText->SetBgColor(0, 0, 0, 0);
		g_pRenderText->SetTextColor(200, 255, 100, 255);
		Nm_Loc += 103;

		g_pRenderText->SetFont(g_hFont);
		g_pRenderText->SetTextColor(255, 255, 255, 255);
		g_pRenderText->SetBgColor(0, 0, 0, 0);

		sprintf(Text, GlobalText[1256], GuildTotalScore);
		g_pRenderText->RenderText(m_Pos.x + 23, Nm_Loc, Text);

		Nm_Loc += 15;
		if (Hero->GuildStatus == G_MASTER)
		{
			int Class = gCharacterManager.GetBaseClass(CharacterAttribute->Class);
			if (Class == CLASS_DARK_LORD)
			{
				int nCount = CharacterAttribute->Level / 10 + CharacterAttribute->Charisma / 10;
				if (nCount > 80)
					nCount = 80;

				sprintf(Text, GlobalText[1362], g_nGuildMemberCount, nCount);
			}
			else
			{
				sprintf(Text, GlobalText[1362], g_nGuildMemberCount, CharacterAttribute->Level / 10);
			}
		}
		else
		{
			sprintf(Text, GlobalText[1310], g_nGuildMemberCount);
		}
		g_pRenderText->RenderText(m_Pos.x + 22, Nm_Loc, Text);

		Nm_Loc += 15;
		sprintf(Text, "%s: %s", GlobalText[1321], m_RivalGuildName[0] ? m_RivalGuildName : GlobalText[1361]);
		g_pRenderText->RenderText(m_Pos.x + 22, Nm_Loc, Text);

		g_pRenderText->SetFont(g_hFont);
		g_pRenderText->SetBgColor(0, 0, 0, 0);
		g_pRenderText->SetTextColor(247, 128, 0, 255);
		sprintf(Text, GlobalText[1323]);
		g_pRenderText->RenderText(m_Pos.x + 14.5f, m_Pos.y + 250.f, Text, 159, 0, RT3_SORT_CENTER);

		g_pRenderText->SetFont(g_hFont);
		g_pRenderText->SetTextColor(255, 255, 255, 255);
		g_pRenderText->SetBgColor(0, 0, 0, 0);
		m_GuildNotice.SetSize(160, 80);
		m_GuildNotice.SetPosition(m_Pos.x + 15, m_Pos.y + 265 + m_GuildNotice.GetHeight());
		m_GuildNotice.Render();
	}
	else if (m_nCurrentTab == 1)
	{
		glColor4f(1.f, 1.f, 1.f, 1.f);
		RenderText((char*)GlobalText[1389], m_Pos.x + 24, m_Pos.y + 112, 40, 0, 0xFFFFFFFF, 0x00000000, RT3_SORT_LEFT);
		RenderText((char*)GlobalText[1307], m_Pos.x + 89, m_Pos.y + 112, 40, 0, 0xFFFFFFFF, 0x00000000, RT3_SORT_LEFT);
		RenderText((char*)GlobalText[1022], m_Pos.x + 126, m_Pos.y + 112, 40, 0, 0xFFFFFFFF, 0x00000000, RT3_SORT_LEFT);

		m_GuildMember.SetSize(160, 420);
		m_GuildMember.SetPosition(m_Pos.x + 13, m_Pos.y + 123 + m_GuildMember.GetHeight());
		m_GuildMember.Render();
	}
	else if (m_nCurrentTab == 2)
	{
		//BUTTON_UNION_CREATE
		glColor4f(1.f, 1.f, 1.f, 1.f);
		m_Button[BUTTON_UNION_CREATE].SetPos(m_Pos.x + 30, m_Pos.y + 230);
		m_Button[BUTTON_UNION_OUT].SetPos(m_Pos.x + 100, m_Pos.y + 230);
		m_Button[BUTTON_UNION_CREATE].ChangeText(GlobalText[1422]);
		m_Button[BUTTON_UNION_OUT].ChangeText(GlobalText[1324]);
		if (GuildMark[Hero->GuildMarkIndex].UnionName[0] != NULL)
		{
			RenderText((char*)GlobalText[182], m_Pos.x + 34, m_Pos.y + 115, 40, 0, 0xFFFFFFFF, 0x00000000, RT3_SORT_LEFT);
			RenderText((char*)GlobalText[1330], m_Pos.x + 140, m_Pos.y + 115, 40, 0, 0xFFFFFFFF, 0x00000000, RT3_SORT_LEFT);
		}
	}
}

void SEASON3B::CNewUIGuildInfoWindow::Render_Guild_History()
{
	RenderImageScale(941007, m_Pos.x + 70, m_Pos.y + 102, 50.f, 50.f, 0.f, 0.f, 330.f, 212.f);
	CreateGuildMark(Hero->GuildMarkIndex);
	RenderBitmap(BITMAP_GUILD, m_Pos.x + 75.5f, m_Pos.y + 108, 39, 39);

	RenderImageScale(941007, m_Pos.x + 11, m_Pos.y + 155.f, 168.f, 70.f, 0.f, 0.f, 330.f, 212.f);

	glColor4f(0.0f, 0.0f, 0.0f, 0.8f);
	RenderColor(m_Pos.x + 14.5f, m_Pos.y + 245.f, 159.f, 15);
	glColor4f(0.0f, 0.0f, 0.0f, 0.4f);
	RenderColor(m_Pos.x + 14.5f, m_Pos.y + 260.f, 159.f, 83);

	EndRenderColor();

	m_Button[BUTTON_GUILD_OUT].Render();
}

void SEASON3B::CNewUIGuildInfoWindow::RenderScrollBar()
{
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);

	RenderImageScale(941008, m_Pos.x + 162, 123, 15, 233, 0.f, 0.f, 30.f, 375.f);

	int Line = 0;

	if (m_EventState == EVENT_SCROLL_BTN_DOWN && m_BackUp > 0)
	{
		m_Loc = (MouseY - m_BackUp);
		if (m_Loc < 0)
			m_Loc = 0;
		else
			if (m_Loc > 200)
				m_Loc = 200;

		if (m_Loc != m_Loc_Bk)
		{
			int Loc_Scroll = ((float)(g_nGuildMemberCount - m_GuildMember.GetBoxSize()) / (float)200) * (float)m_Loc;
			Line = Loc_Scroll - m_CurrentListPos;
			m_CurrentListPos += Line;
			m_Loc_Bk = m_Loc;
		}
	}


	if (m_EventState == EVENT_SCROLL_BTN_DOWN)
		glColor4f(0.6f, 0.6f, 0.6f, 1.0f);
	else
		glColor4f(0.7f, 0.7f, 0.7f, 1.0f);
	RenderImageScale(941009, m_Pos.x + 163.f, 123 + m_Loc, 13, 30, 0.f, 0.f, 30.f, 60.f);
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);

	m_GuildMember.Scrolling(Line);
}

void SEASON3B::CNewUIGuildInfoWindow::Render_Guild_Info()
{
	POINT ptOrigin = { m_Pos.x + 15, m_Pos.y + 98 };

	if (GuildMark[Hero->GuildMarkIndex].UnionName[0] == NULL)
	{
		ptOrigin.x += 10;
		ptOrigin.y += 8;

		g_pRenderText->SetTextColor(255, 255, 255, 255);
		g_pRenderText->SetBgColor(0);
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1257]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1258]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1259]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1260]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1261]);

		ptOrigin.y += 25;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1262]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1263]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1264]);
		ptOrigin.y += 20;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1265]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1266]);
		ptOrigin.y += 15;
		g_pRenderText->RenderText(ptOrigin.x, ptOrigin.y, GlobalText[1267]);

		g_pRenderText->SetTextColor(0xFFFFFFFF);
	}
	else
	{
		glColor4ub(21, 21, 21, 150);
		RenderColor(m_Pos.x + 12, m_Pos.y + 12 + 113, 165, 85);

		glColor4ub(59, 59, 59, 150);
		RenderColor(m_Pos.x + 12, m_Pos.y + 12 + 98, 165, 15);
		EndRenderColor();

		for (int x = m_Pos.x + 12; x < m_Pos.x + 12 + 166; x++)
		{
			RenderImage(IMAGE_GUILDINFO_TOP_PIXEL, x, m_Pos.y + 109, 1, 14);
			RenderImage(IMAGE_GUILDINFO_BOTTOM_PIXEL, x, m_Pos.y + 109 + 92, 1, 14);
		}
		for (int y = m_Pos.y + 109; y < m_Pos.y + 109 + 100; y++)
		{
			RenderImage(IMAGE_GUILDINFO_LEFT_PIXEL, m_Pos.x + 10, y, 14, 1);
			RenderImage(IMAGE_GUILDINFO_RIGHT_PIXEL, m_Pos.x + 167, y, 14, 1);
		}


		RenderImage(IMAGE_GUILDINFO_TOP_LEFT, m_Pos.x + 10, m_Pos.y + 109, 14, 14);
		RenderImage(IMAGE_GUILDINFO_TOP_RIGHT, m_Pos.x + 167, m_Pos.y + 109, 14, 14);
		RenderImage(IMAGE_GUILDINFO_BOTTOM_LEFT, m_Pos.x + 10, m_Pos.y + 201, 14, 14);
		RenderImage(IMAGE_GUILDINFO_BOTTOM_RIGHT, m_Pos.x + 167, m_Pos.y + 201, 14, 14);

		EndRenderColor();

		m_UnionListBox.SetSize(160, 80);
		m_UnionListBox.SetPosition(m_Pos.x + 15, m_Pos.y + 210);
		m_UnionListBox.Render();

		EnableAlphaTest();

		m_Button[BUTTON_UNION_CREATE].Render();
		m_Button[BUTTON_UNION_OUT].Render();
	}
}

void SEASON3B::CNewUIGuildInfoWindow::Render_Guild_Enum()
{
	glColor4f(0.0f, 0.0f, 0.0f, 0.8f);
	RenderColor(m_Pos.x + 12, m_Pos.y + 12 + 113, 165, 232);
	glColor4f(0.0f, 0.0f, 0.0f, 0.4f);
	RenderColor(m_Pos.x + 12, m_Pos.y + 12 + 93, 165, 20);
	EndRenderColor();

	if (gGuildManager.IsGuildMaster())
	{
		m_Button[BUTTON_GET_POSITION].Render();
		m_Button[BUTTON_FREE_POSITION].Render();
		m_Button[BUTTON_GET_OUT].Render();
	}
}

float SEASON3B::CNewUIGuildInfoWindow::GetLayerDepth()
{
	return 4.5f;
}

void SEASON3B::CNewUIGuildInfoWindow::LoadImages()
{
	LoadBitmap("Interface\\newui_msgbox_back.jpg", IMAGE_GUILDINFO_BACK, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_back01.tga", IMAGE_GUILDINFO_TOP, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_back02-L.tga", IMAGE_GUILDINFO_LEFT, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_back02-R.tga", IMAGE_GUILDINFO_RIGHT, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_back03.tga", IMAGE_GUILDINFO_BOTTOM, GL_LINEAR);
	LoadBitmap("Interface\\newui_guild_tab01.tga", IMAGE_GUILDINFO_TAB_LIST, GL_LINEAR);
	LoadBitmap("Interface\\newui_guild_tab02.tga", IMAGE_GUILDINFO_TAB_POINT, GL_LINEAR);
	LoadBitmap("Interface\\newui_guild_tab03.tga", IMAGE_GUILDINFO_TAB_HEAD, GL_LINEAR);


	LoadBitmap("Interface\\newui_item_table03(Up).tga", IMAGE_GUILDINFO_TOP_PIXEL, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_table03(Dw).tga", IMAGE_GUILDINFO_BOTTOM_PIXEL, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_table03(L).tga", IMAGE_GUILDINFO_LEFT_PIXEL, GL_LINEAR);
	LoadBitmap("Interface\\newui_item_table03(R).tga", IMAGE_GUILDINFO_RIGHT_PIXEL, GL_LINEAR);
	LoadBitmap("Interface\\newui_exit_00.tga", IMAGE_GUILDINFO_EXIT_BTN, GL_LINEAR);
	LoadBitmap("Interface\\newui_btn_empty_small.tga", IMAGE_GUILDINFO_BUTTON, GL_LINEAR);

	LoadBitmap("Interface\\newui_scrollbar_up.tga", IMAGE_GUILDINFO_SCROLL_TOP);
	LoadBitmap("Interface\\newui_scrollbar_m.tga", IMAGE_GUILDINFO_SCROLL_MIDDLE);
	LoadBitmap("Interface\\newui_scrollbar_down.tga", IMAGE_GUILDINFO_SCROLL_BOTTOM);
	LoadBitmap("Interface\\newui_scroll_on.tga", IMAGE_GUILDINFO_SCROLLBAR_ON, GL_LINEAR);
	LoadBitmap("Interface\\newui_scroll_off.tga", IMAGE_GUILDINFO_SCROLLBAR_OFF, GL_LINEAR);
	LoadBitmap("Interface\\newui_scrollbar_stretch.jpg", IMAGE_GUILDINFO_DRAG_BTN, GL_LINEAR);

	//
	LoadBitmap("Custom\\btn_demote.jpg", 941000, GL_LINEAR);
	LoadBitmap("Custom\\btn_position.jpg", 941001, GL_LINEAR);
	LoadBitmap("Custom\\btn_remove.jpg", 941002, GL_LINEAR);
	LoadBitmap("Custom\\btn_delete_guild.jpg", 941003, GL_LINEAR);
	LoadBitmap("Custom\\btn_guild.jpg", 941004, GL_LINEAR);
	LoadBitmap("Custom\\btn_members.jpg", 941005, GL_LINEAR);
	LoadBitmap("Custom\\btn_alliance.jpg", 941006, GL_LINEAR);
	LoadBitmap("Custom\\store_name_big.jpg", 941007, GL_LINEAR);
	LoadBitmap("Custom\\scroll_back.jpg", 941008, GL_LINEAR);
	LoadBitmap("Custom\\scroll_middle.jpg", 941009, GL_LINEAR);

}

void SEASON3B::CNewUIGuildInfoWindow::UnloadImages()
{
	DeleteBitmap(941000);
	DeleteBitmap(941001);
	DeleteBitmap(941002);
	DeleteBitmap(941003);
	DeleteBitmap(941004);
	DeleteBitmap(941005);
	DeleteBitmap(941006);
	DeleteBitmap(941007);
	DeleteBitmap(941008);
	DeleteBitmap(941009);
	//
	DeleteBitmap(IMAGE_GUILDINFO_BOTTOM);
	DeleteBitmap(IMAGE_GUILDINFO_RIGHT);
	DeleteBitmap(IMAGE_GUILDINFO_LEFT);
	DeleteBitmap(IMAGE_GUILDINFO_TOP);
	DeleteBitmap(IMAGE_GUILDINFO_BACK);

	DeleteBitmap(IMAGE_GUILDINFO_TAB_LIST);
	DeleteBitmap(IMAGE_GUILDINFO_TAB_POINT);
	DeleteBitmap(IMAGE_GUILDINFO_TAB_HEAD);
	DeleteBitmap(IMAGE_GUILDINFO_BUTTON);

	DeleteBitmap(IMAGE_GUILDINFO_TOP_PIXEL);
	DeleteBitmap(IMAGE_GUILDINFO_BOTTOM_PIXEL);
	DeleteBitmap(IMAGE_GUILDINFO_RIGHT_PIXEL);

	DeleteBitmap(IMAGE_GUILDINFO_LEFT_PIXEL);
	DeleteBitmap(IMAGE_GUILDINFO_EXIT_BTN);

	DeleteBitmap(IMAGE_GUILDINFO_SCROLL_TOP);
	DeleteBitmap(IMAGE_GUILDINFO_SCROLL_MIDDLE);
	DeleteBitmap(IMAGE_GUILDINFO_SCROLL_BOTTOM);
	DeleteBitmap(IMAGE_GUILDINFO_SCROLLBAR_ON);
	DeleteBitmap(IMAGE_GUILDINFO_SCROLLBAR_OFF);
	DeleteBitmap(IMAGE_GUILDINFO_DRAG_BTN);
}

void SEASON3B::CNewUIGuildInfoWindow::AddGuildNotice(char* szText)
{
	char szTemp[5][MAX_TEXT_LENGTH + 1] = { {0}, {0}, {0}, {0}, {0} };
	CutText3(szText, szTemp[0], 180, 5, MAX_TEXT_LENGTH + 1);

	for (int i = 0; i < 5; ++i)
	{
		if (szTemp[i][0])
		{
			m_GuildNotice.AddText(szTemp[i]);
			m_Tot_Notice++;
		}
	}
	m_GuildNotice.Scrolling(m_GuildNotice.GetLineNum() - m_GuildNotice.GetBoxSize());
}

void SEASON3B::CNewUIGuildInfoWindow::AddGuildMember(GUILD_LIST_t* pInfo)
{
	m_GuildMember.AddText(pInfo->Name, pInfo->Number, pInfo->Server, pInfo->GuildStatus);
	m_GuildMember.Scrolling(-m_GuildMember.GetBoxSize());
}

void SEASON3B::CNewUIGuildInfoWindow::GuildClear()
{
	m_GuildMember.Clear();
}

void SEASON3B::CNewUIGuildInfoWindow::UnionGuildClear()
{
	m_UnionListBox.Clear();
}

void SEASON3B::CNewUIGuildInfoWindow::NoticeClear()
{
	m_GuildNotice.Clear();
}

void SEASON3B::CNewUIGuildInfoWindow::SetRivalGuildName(char* szName)
{
	memcpy(m_RivalGuildName, szName, sizeof(char) * MAX_GUILDNAME);
	m_RivalGuildName[MAX_GUILDNAME] = NULL;
}

void SEASON3B::CNewUIGuildInfoWindow::AddUnionList(BYTE* pGuildMark, char* szGuildName, int nMemberCount)
{
	m_UnionListBox.AddText(pGuildMark, szGuildName, nMemberCount);
	m_bRequestUnionList = false;
}

int SEASON3B::CNewUIGuildInfoWindow::GetUnionCount()
{
	return m_UnionListBox.GetTextCount();
}

void SEASON3B::CNewUIGuildInfoWindow::ReceiveGuildRelationShip(BYTE byRelationShipType, BYTE byRequestType,
	BYTE  byTargetUserIndexH, BYTE byTargetUserIndexL)
{
	if (!g_MessageBox->IsEmpty())
	{
		SendRequestGuildRelationShipResult(byRelationShipType, byRequestType, 0x00, byTargetUserIndexH, byTargetUserIndexL);
	}
	else
	{
		m_MessageInfo.s_byRelationShipType = byRelationShipType;
		m_MessageInfo.s_byRelationShipRequestType = byRequestType;
		m_MessageInfo.s_byTargetUserIndexH = byTargetUserIndexH;
		m_MessageInfo.s_byTargetUserIndexL = byTargetUserIndexL;

		int nCharKey = MAKEWORD(m_MessageInfo.s_byTargetUserIndexL, m_MessageInfo.s_byTargetUserIndexH);
		int nIndex = FindCharacterIndex(nCharKey);
		if (nIndex < 0 || nIndex >= MAX_CHARACTERS_CLIENT)
			return;
		CHARACTER* pPlayer = &CharactersClient[nIndex];

		unicode::t_char szText[3][64];
		ZeroMemory(szText, sizeof(szText));

		if (m_MessageInfo.s_byRelationShipType == 0x01)			// Union
		{
			if (m_MessageInfo.s_byRelationShipRequestType == 0x01)	// Join
			{
				sprintf(szText[0], GlobalText[1280], pPlayer->ID);
				sprintf(szText[1], GlobalText[1281]);
				sprintf(szText[2], GlobalText[1283]);
			}
			else										// Break Off
			{
				sprintf(szText[0], GlobalText[1280], pPlayer->ID);
				sprintf(szText[1], GlobalText[1282]);
				sprintf(szText[2], GlobalText[1283]);
			}
		}
		else if (m_MessageInfo.s_byRelationShipType == 0x02)		// Rival
		{
			if (m_MessageInfo.s_byRelationShipRequestType == 0x01)	// Join
			{
				sprintf(szText[0], GlobalText[1284], pPlayer->ID);
				sprintf(szText[1], GlobalText[1286]);
				sprintf(szText[2], GlobalText[1283]);
			}
			else
			{
				sprintf(szText[0], GlobalText[1284], pPlayer->ID);
				sprintf(szText[1], GlobalText[1285]);
				sprintf(szText[2], GlobalText[1283]);
			}
		}

		SEASON3B::CNewUICommonMessageBox* pMsgBox = NULL;
		SEASON3B::CreateMessageBox(MSGBOX_LAYOUT_CLASS(SEASON3B::CGuildRelationShipMsgBoxLayout), &pMsgBox);
		if (pMsgBox)
		{
			pMsgBox->AddMsg(szText[0]);
			pMsgBox->AddMsg(szText[1]);
			pMsgBox->AddMsg(szText[2]);
		}
	}
}
