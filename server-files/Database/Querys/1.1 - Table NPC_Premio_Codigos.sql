/****** Object:  Table [dbo].[NPCPremio_Codigos]    Script Date: 28/02/2024 03:57:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NPCPremio_Codigos](
	[AccountID] [varchar](10) NULL,
	[Codigo] [varchar](16) NULL,
	[NomePremio] [varchar](50) NULL,
	[DataInicio] [smalldatetime] NULL,
	[DataFim] [smalldatetime] NULL,
	[Validade] [int] NULL
) ON [PRIMARY]
GO


