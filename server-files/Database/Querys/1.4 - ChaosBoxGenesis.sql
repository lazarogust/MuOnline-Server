/****** Object:  Table [dbo].[CHAOS_BOX_GENESIS]    Script Date: 26/10/2024 10:56:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CHAOS_BOX_GENESIS](
	[Account] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[State] [int] NOT NULL,
	[SelectedKey] [int] NOT NULL,
	[SelectedComb] [int] NOT NULL,
	[Items] [varbinary](1920) NULL,
	[LastUse] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CHAOS_BOX_GENESIS] ADD  CONSTRAINT [DF_CHAOS_BOX_GENESIS_State]  DEFAULT ((0)) FOR [State]
GO

ALTER TABLE [dbo].[CHAOS_BOX_GENESIS] ADD  CONSTRAINT [DF_CHAOS_BOX_GENESIS_SelectedKey]  DEFAULT ((0)) FOR [SelectedKey]
GO

ALTER TABLE [dbo].[CHAOS_BOX_GENESIS] ADD  CONSTRAINT [DF_CHAOS_BOX_GENESIS_SelectedComb]  DEFAULT ((0)) FOR [SelectedComb]
GO

ALTER TABLE [dbo].[CHAOS_BOX_GENESIS] ADD  CONSTRAINT [DF_CHAOS_BOX_GENESIS_LastUse]  DEFAULT (getdate()) FOR [LastUse]
GO


