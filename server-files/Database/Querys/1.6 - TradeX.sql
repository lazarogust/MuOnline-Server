/****** Object:  Table [dbo].[TRADE_X]    Script Date: 26/10/2024 10:57:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRADE_X](
	[account] [nvarchar](10) NOT NULL,
	[name] [nvarchar](10) NOT NULL,
	[items] [varbinary](1920) NULL,
	[targetname] [nvarchar](10) NULL,
	[state] [int] NOT NULL,
	[date] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TRADE_X] ADD  CONSTRAINT [DF_TRADE_X_state]  DEFAULT ((0)) FOR [state]
GO


