///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "ZzzOpenglUtil.h"
#include "ZzzBMD.h"
#include "ZzzInfomation.h"
#include "ZzzObject.h"
#include "ZzzCharacter.h"
#include "ZzzLodTerrain.h"
#include "ZzzTexture.h"
#include "ZzzAi.h"
#include "ZzzEffect.h"
#include "DSPlaySound.h"
#include "WSClient.h"
#include "Patente.h"

OBJECT	Sprites   [MAX_SPRITES];

int CreateSprite(int Type,vec3_t Position,float Scale,vec3_t Light,OBJECT *Owner,float Rotation,int SubType)
{
	for(int i=0;i<MAX_SPRITES;i++)
	{
		OBJECT *o = &Sprites[i];
		if(!o->Live)
		{
			o->Live           = true;
			o->Type           = Type;
			o->SubType        = SubType;
			o->Owner          = Owner;
			o->AnimationFrame = 1.f;
    		o->Scale          = Scale;
			o->Angle[2]       = Rotation;
			VectorCopy(Position,o->Position);
			VectorCopy(Position,o->StartPosition);
			VectorCopy(Light,o->Light);
			return i;
		}
	}
	return false;
}

void RenderSprite(OBJECT *o,OBJECT *Owner)
{
    if(o->Visible)
	{
		o->AnimationFrame += 0.1f;
		if(o->AnimationFrame > 1.f) 
		{
			o->AnimationFrame = 1.f;
		}
	}
	else
	{
		o->AnimationFrame -= 0.1f;
		if(o->AnimationFrame < 0.2f) 
		{
			o->AnimationFrame = 0.2f;
		}
	}
	float Scale = o->AnimationFrame*o->Scale;
	
	BITMAP_t* pBitmap = Bitmaps.GetTexture(o->Type);
	float Width  = pBitmap->Width * Scale;
	float Height = pBitmap->Height * Scale;

    if ( o->Type==BITMAP_FORMATION_MARK || o->Type == 90001)
    {
		float u = 0.0f, v = 0.0f, uw, vw;
		uw=0.33f; vw=0.33f;
        switch ( o->SubType )
        {
        case 0:
            u=0.f; v=0.f;
            break;

        case 1:
            u=0.33f; v=0.f;
            break;

        case 2:
            u=0.66f; v=0.f;
            break;

        case 3:
            u=0.f; v=0.33f;
            break;

        case 4:
            u=0.33f; v=0.33f;
            break;

        case 5:
            u=0.66f; v=0.33f;
            break;

        case 6:
            u=0.f; v=0.66f;
            break;

        case 7:
            u=0.33f; v=0.66f;
            break;
        }

        RenderSprite( o->Type, o->Position, 64, 64, o->Light, o->Angle[2], u, v, uw, vw );
    }
    else if (o->Type >= BITMAP_PATENTE_START && o->Type <= BITMAP_PATENTE_END)
    {
        auto patenteimage = gPatente.GetPatentImageInfoByImageIndex(o->Type);

        if (patenteimage != NULL)
        {
            float u, v, uw, vh;
            u = 0.5f / (float)pBitmap->Width;
            v = 0.5f / (float)pBitmap->Height;
            uw = ((float)pBitmap->RealWidth - 0.52f) / (float)pBitmap->Width;
            vh = ((float)pBitmap->RealHeight - 0.52f) / (float)pBitmap->Height;
            RenderSprite(o->Type, o->Position, (64 * Scale), (64 * Scale), o->Light, o->Angle[2], u, v, uw, vh);
        }
    }
    else
    {
        RenderSprite(o->Type,o->Position,Width,Height,o->Light,o->Angle[2]);
    }
}

#include "Patente.h"

void RenderSprites ( BYTE byRenderOneMore )
{
	for(int i=0;i<MAX_SPRITES;i++)
	{
		OBJECT *o = &Sprites[i];
        if( byRenderOneMore == 1 )
        {
            if ( o->Position[2] > 350.f ) 
			{
				continue;
			}
        }
        else if( byRenderOneMore == 2 )
        {
            if( o->Position[2] <= 300.f )
            {
                o->Live = false;
                continue;
            }
        }

		if(o->Live)
		{
            if( o->Type == BITMAP_FORMATION_MARK || gPatente.CheckImagesModel(o->Type) == 1)
            {
                EnableAlphaTest ();
            }
            else if(o->SubType == 0)
			{
          	    EnableAlphaBlend();
			}
			else if( o->SubType==1 )
			{
               	EnableAlphaBlendMinus();
			}
            else if( o->SubType==2 )
			{
                EnableAlphaTest();
			}
            else if( o->SubType==3 )
			{
                EnableAlphaBlend2();
			}
    		RenderSprite(o,o->Owner);

            if( byRenderOneMore == 0 || byRenderOneMore == 2 )
            {
                o->Live = false;
            }
		}
	}
}

void CheckSprites()
{
	for(int i=0; i<MAX_SPRITES; i++)
	{
		OBJECT *o = &Sprites[i];
		if(o->Live)
		{
         	o->Visible = true;
		}
	}
}
