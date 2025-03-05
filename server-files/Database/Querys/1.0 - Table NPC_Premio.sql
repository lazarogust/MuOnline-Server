/****** Object:  Table [dbo].[NPCPremio]    Script Date: 28/02/2024 03:56:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NPCPremio](
	[IdPremio] [int] NOT NULL,
	[Codigo] [varchar](16) NULL,
	[ListID] [int] IDENTITY(1,1) NOT NULL,
	[Section] [int] NULL,
	[Id] [int] NULL,
	[Level] [int] NULL,
	[Durabilidade] [int] NULL,
	[Skill] [int] NULL,
	[Luck] [int] NULL,
	[Opt] [int] NULL,
	[Excelente] [int] NULL,
	[Dias] [int] NOT NULL,
	[Nome] [varchar](30) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[NPCPremio] ADD  DEFAULT ((1)) FOR [IdPremio]
GO

ALTER TABLE [dbo].[NPCPremio] ADD  DEFAULT ((0)) FOR [Dias]
GO

ALTER TABLE [dbo].[NPCPremio] ADD  DEFAULT ('-') FOR [Nome]
GO


