/****** Object:  UserDefinedFunction [dbo].[NPCPremio_GerarCodigo]    Script Date: 28/02/2024 03:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[NPCPremio_GerarCodigo]()

RETURNS varchar(16)

AS
BEGIN
DECLARE
@CharPool varchar(36),
@RandomString varchar(16)

SET @CharPool = 'ABCDEFGHIJKLMNPQRSTUVWXYZ-0123456789'
SET @RandomString = ''

WHILE (Len(@RandomString) < 16) BEGIN
    SET @RandomString = @RandomString + SUBSTRING(@Charpool, CONVERT(int, (SELECT rndResult FROM rndView) * 36), 1)
END

WHILE exists (SELECT ListID from NPCPremio where Codigo = @RandomString)
BEGIN
	SET @RandomString = ''
	WHILE (Len(@RandomString) < 16) BEGIN
	    SET @RandomString = @RandomString + SUBSTRING(@Charpool, CONVERT(int, (SELECT rndResult FROM rndView) * 36), 1)
	END
END

RETURN @RandomString

END

