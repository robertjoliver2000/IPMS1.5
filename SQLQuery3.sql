SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMP_UBR_UPLOAD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TMP_UBR_UPLOAD](
	[UBR_ID] [int] NULL,
	[Level5Code] [nvarchar](200) NULL,
	[Level5Name] [nvarchar](200) NULL,
	[Level6Code] [nvarchar](200) NULL,
	[Level6Name] [nvarchar](200) NULL,
	[Level7Code] [nvarchar](200) NULL,
	[Level7Name] [nvarchar](200) NULL,
	[Level8Code] [nvarchar](200) NULL,
	[Level8Name] [nvarchar](200) NULL,
	[Level9Code] [nvarchar](200) NULL,
	[Level9Name] [nvarchar](200) NULL,
	[Level10Code] [nvarchar](200) NULL,
	[Level10Name] [nvarchar](200) NULL,
	[CustomGrouping] [nvarchar](200) NULL,
	[action] [nvarchar](200) NULL,
	[NewLevel10Code] [nvarchar](200) NULL,
	[NewLevel10Name] [nvarchar](200) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_ubr_upload_new_structure]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_ubr_upload_new_structure](
	[CODE5] [nvarchar](100) NULL,
	[NAME5] [nvarchar](100) NULL,
	[CODE6] [nvarchar](100) NULL,
	[NAME6] [nvarchar](100) NULL,
	[CODE7] [nvarchar](100) NULL,
	[NAME7] [nvarchar](100) NULL,
	[CODE8] [nvarchar](100) NULL,
	[NAME8] [nvarchar](100) NULL,
	[CODE9] [nvarchar](100) NULL,
	[NAME9] [nvarchar](100) NULL,
	[CODE10] [nvarchar](100) NULL,
	[NAME10] [nvarchar](100) NULL,
	[Custom Group] [nvarchar](100) NULL,
	[Sponsor] [nvarchar](100) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AUDIT_LOG_UBRUPDATES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AUDIT_LOG_UBRUPDATES](
	[OldUBRlevel5Code] [nvarchar](10) NOT NULL,
	[OldUBRlevel5Name] [nvarchar](50) NOT NULL,
	[OldUBRlevel6Code] [nvarchar](10) NOT NULL,
	[OldUBRlevel6Name] [nvarchar](50) NOT NULL,
	[OldUBRlevel7Code] [nvarchar](10) NOT NULL,
	[OldUBRlevel7Name] [nvarchar](50) NOT NULL,
	[OldUBRlevel8Code] [nvarchar](10) NOT NULL,
	[OldUBRlevel8Name] [nvarchar](50) NOT NULL,
	[OldUBRlevel9Code] [nvarchar](10) NOT NULL,
	[OldUBRlevel9Name] [nvarchar](50) NOT NULL,
	[OldUBRlevel10Code] [nvarchar](10) NOT NULL,
	[OldUBRlevel10Name] [nvarchar](50) NOT NULL,
	[NewUBRlevel5Code] [nvarchar](10) NOT NULL,
	[NewUBRlevel5Name] [nvarchar](50) NOT NULL,
	[NewUBRlevel6Code] [nvarchar](10) NOT NULL,
	[NewUBRlevel6Name] [nvarchar](50) NOT NULL,
	[NewUBRlevel7Code] [nvarchar](10) NOT NULL,
	[NewUBRlevel7Name] [nvarchar](50) NOT NULL,
	[NewUBRlevel8Code] [nvarchar](10) NOT NULL,
	[NewUBRlevel8Name] [nvarchar](50) NOT NULL,
	[NewUBRlevel9Code] [nvarchar](10) NOT NULL,
	[NewUBRlevel9Name] [nvarchar](50) NOT NULL,
	[NewUBRlevel10Code] [nvarchar](10) NOT NULL,
	[NewUBRlevel10Name] [nvarchar](50) NOT NULL,
	[DateReleased] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
	[NoFinancialRecordsChanged] [int] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeProject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeProject](
	[InitiativeProjectID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[ExternalProjectID] [nvarchar](10) NOT NULL,
	[ProjectName] [nvarchar](150) NULL,
	[ProjectDescription] [ntext] NULL,
	[ProgramName] [nvarchar](150) NULL,
	[ProjectType] [nvarchar](50) NULL,
	[ProjectTypeID] [int] NULL,
	[PercentRequired] [decimal](18, 2) NULL,
	[TotalPlanLocalCurrency] [decimal](18, 2) NULL,
	[BaseCurrency] [nvarchar](10) NULL,
	[BaseCurrencyID] [int] NULL,
	[FXRate] [decimal](18, 2) NULL,
	[AmountRequested] [decimal](18, 2) NULL,
 CONSTRAINT [PK_InitiativeProject] PRIMARY KEY CLUSTERED 
(
	[InitiativeProjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeProject]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeProject]
ON [dbo].[InitiativeProject]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeProject]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:59 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeProject]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeProjectID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeProject]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ExternalProjectID'',
		CONVERT(nvarchar(4000),OLD.[ExternalProjectID])
	FROM deleted OLD
	WHERE
		OLD.[ExternalProjectID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectName'',
		CONVERT(nvarchar(4000),OLD.[ProjectName])
	FROM deleted OLD
	WHERE
		OLD.[ProjectName] Is Not Null


	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProgramName'',
		CONVERT(nvarchar(4000),OLD.[ProgramName])
	FROM deleted OLD
	WHERE
		OLD.[ProgramName] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectType'',
		CONVERT(nvarchar(4000),OLD.[ProjectType])
	FROM deleted OLD
	WHERE
		OLD.[ProjectType] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectTypeID'',
		CONVERT(nvarchar(4000),OLD.[ProjectTypeID])
	FROM deleted OLD
	WHERE
		OLD.[ProjectTypeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''PercentRequired'',
		CONVERT(nvarchar(4000),OLD.[PercentRequired])
	FROM deleted OLD
	WHERE
		OLD.[PercentRequired] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''TotalPlanLocalCurrency'',
		CONVERT(nvarchar(4000),OLD.[TotalPlanLocalCurrency])
	FROM deleted OLD
	WHERE
		OLD.[TotalPlanLocalCurrency] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''BaseCurrency'',
		CONVERT(nvarchar(4000),OLD.[BaseCurrency])
	FROM deleted OLD
	WHERE
		OLD.[BaseCurrency] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''BaseCurrencyID'',
		CONVERT(nvarchar(4000),OLD.[BaseCurrencyID])
	FROM deleted OLD
	WHERE
		OLD.[BaseCurrencyID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(OLD.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''FXRate'',
		CONVERT(nvarchar(4000),OLD.[FXRate])
	FROM deleted OLD
	WHERE
		OLD.[FXRate] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeProject]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeProject]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeProject]
ON [dbo].[InitiativeProject]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeProject]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:59 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeProjectID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeProject]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeProject]	*/
	/*	INSERT audit traces For [ExternalProjectID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ExternalProjectID'',
		convert(nvarchar(4000), [ExternalProjectID]) 
	FROM inserted
	WHERE [ExternalProjectID] Is Not Null

	/*	INSERT audit traces For [ProjectName]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectName'',
		convert(nvarchar(4000), [ProjectName]) 
	FROM inserted
	WHERE [ProjectName] Is Not Null

	/*	INSERT audit traces For [ProjectDescription]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST(NEW.[InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectDescription'',
			ORD.[ProjectDescription]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeProject] ORD 
                    ON ORD.[InitiativeProjectID]=NEW.[InitiativeProjectID]		WHERE
			ORD.[ProjectDescription] Is Not Null


	/*	INSERT audit traces For [ProgramName]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProgramName'',
		convert(nvarchar(4000), [ProgramName]) 
	FROM inserted
	WHERE [ProgramName] Is Not Null

	/*	INSERT audit traces For [ProjectType]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectType'',
		convert(nvarchar(4000), [ProjectType]) 
	FROM inserted
	WHERE [ProjectType] Is Not Null

	/*	INSERT audit traces For [ProjectTypeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''ProjectTypeID'',
		convert(nvarchar(4000), [ProjectTypeID]) 
	FROM inserted
	WHERE [ProjectTypeID] Is Not Null

	/*	INSERT audit traces For [PercentRequired]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''PercentRequired'',
		convert(nvarchar(4000), [PercentRequired]) 
	FROM inserted
	WHERE [PercentRequired] Is Not Null

	/*	INSERT audit traces For [TotalPlanLocalCurrency]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''TotalPlanLocalCurrency'',
		convert(nvarchar(4000), [TotalPlanLocalCurrency]) 
	FROM inserted
	WHERE [TotalPlanLocalCurrency] Is Not Null

	/*	INSERT audit traces For [BaseCurrency]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''BaseCurrency'',
		convert(nvarchar(4000), [BaseCurrency]) 
	FROM inserted
	WHERE [BaseCurrency] Is Not Null

	/*	INSERT audit traces For [BaseCurrencyID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''BaseCurrencyID'',
		convert(nvarchar(4000), [BaseCurrencyID]) 
	FROM inserted
	WHERE [BaseCurrencyID] Is Not Null

	/*	INSERT audit traces For [FXRate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProjectID]=N''''''+CAST([InitiativeProjectID] as nvarchar(4000))+'''''''',
        ''FXRate'',
		convert(nvarchar(4000), [FXRate]) 
	FROM inserted
	WHERE [FXRate] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeProject]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeProject]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeProject]
ON [dbo].[InitiativeProject]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeProject]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:59 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeProjectID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeProject]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeProject]	*/
	/*	INSERT audit traces For [ExternalProjectID]	 column	*/
	If UPDATE([ExternalProjectID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''ExternalProjectID'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ExternalProjectID]),
			CONVERT(nvarchar(4000),NEW.[ExternalProjectID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[ExternalProjectID] <>
					OLD.[ExternalProjectID]
				) Or
				(
					NEW.[ExternalProjectID] Is Null And
					OLD.[ExternalProjectID] Is Not Null
				) Or
				(
					NEW.[ExternalProjectID] Is Not Null And
					OLD.[ExternalProjectID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProjectName]	 column	*/
	If UPDATE([ProjectName])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''ProjectName'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ProjectName]),
			CONVERT(nvarchar(4000),NEW.[ProjectName])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[ProjectName] <>
					OLD.[ProjectName]
				) Or
				(
					NEW.[ProjectName] Is Null And
					OLD.[ProjectName] Is Not Null
				) Or
				(
					NEW.[ProjectName] Is Not Null And
					OLD.[ProjectName] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProjectDescription]	 column	*/
	If UPDATE([ProjectDescription])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(ORD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''ProjectDescription'',
''ntext'', 
			ORD.[ProjectDescription]
		FROM inserted NEW JOIN [dbo].[InitiativeProject] ORD 
                    ON ORD.[InitiativeProjectID]=NEW.[InitiativeProjectID]
				/*
			AND (
				(
					SUBSTRING(NEW.[ProjectDescription], 0, 1024) <>
					SUBSTRING(ORD.[ProjectDescription], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[ProjectDescription], 0, 1024) Is Null And
					SUBSTRING(ORD.[ProjectDescription], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[ProjectDescription], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[ProjectDescription], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[ProjectDescription] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProgramName]	 column	*/
	If UPDATE([ProgramName])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''ProgramName'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ProgramName]),
			CONVERT(nvarchar(4000),NEW.[ProgramName])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[ProgramName] <>
					OLD.[ProgramName]
				) Or
				(
					NEW.[ProgramName] Is Null And
					OLD.[ProgramName] Is Not Null
				) Or
				(
					NEW.[ProgramName] Is Not Null And
					OLD.[ProgramName] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProjectType]	 column	*/
	If UPDATE([ProjectType])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''ProjectType'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ProjectType]),
			CONVERT(nvarchar(4000),NEW.[ProjectType])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[ProjectType] <>
					OLD.[ProjectType]
				) Or
				(
					NEW.[ProjectType] Is Null And
					OLD.[ProjectType] Is Not Null
				) Or
				(
					NEW.[ProjectType] Is Not Null And
					OLD.[ProjectType] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProjectTypeID]	 column	*/
	If UPDATE([ProjectTypeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''ProjectTypeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ProjectTypeID]),
			CONVERT(nvarchar(4000),NEW.[ProjectTypeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[ProjectTypeID] <>
					OLD.[ProjectTypeID]
				) Or
				(
					NEW.[ProjectTypeID] Is Null And
					OLD.[ProjectTypeID] Is Not Null
				) Or
				(
					NEW.[ProjectTypeID] Is Not Null And
					OLD.[ProjectTypeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PercentRequired]	 column	*/
	If UPDATE([PercentRequired])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''PercentRequired'',
''decimal'', 
			CONVERT(nvarchar(4000),OLD.[PercentRequired]),
			CONVERT(nvarchar(4000),NEW.[PercentRequired])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[PercentRequired] <>
					OLD.[PercentRequired]
				) Or
				(
					NEW.[PercentRequired] Is Null And
					OLD.[PercentRequired] Is Not Null
				) Or
				(
					NEW.[PercentRequired] Is Not Null And
					OLD.[PercentRequired] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TotalPlanLocalCurrency]	 column	*/
	If UPDATE([TotalPlanLocalCurrency])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''TotalPlanLocalCurrency'',
''decimal'', 
			CONVERT(nvarchar(4000),OLD.[TotalPlanLocalCurrency]),
			CONVERT(nvarchar(4000),NEW.[TotalPlanLocalCurrency])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[TotalPlanLocalCurrency] <>
					OLD.[TotalPlanLocalCurrency]
				) Or
				(
					NEW.[TotalPlanLocalCurrency] Is Null And
					OLD.[TotalPlanLocalCurrency] Is Not Null
				) Or
				(
					NEW.[TotalPlanLocalCurrency] Is Not Null And
					OLD.[TotalPlanLocalCurrency] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BaseCurrency]	 column	*/
	If UPDATE([BaseCurrency])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''BaseCurrency'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BaseCurrency]),
			CONVERT(nvarchar(4000),NEW.[BaseCurrency])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[BaseCurrency] <>
					OLD.[BaseCurrency]
				) Or
				(
					NEW.[BaseCurrency] Is Null And
					OLD.[BaseCurrency] Is Not Null
				) Or
				(
					NEW.[BaseCurrency] Is Not Null And
					OLD.[BaseCurrency] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BaseCurrencyID]	 column	*/
	If UPDATE([BaseCurrencyID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''BaseCurrencyID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[BaseCurrencyID]),
			CONVERT(nvarchar(4000),NEW.[BaseCurrencyID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[BaseCurrencyID] <>
					OLD.[BaseCurrencyID]
				) Or
				(
					NEW.[BaseCurrencyID] Is Null And
					OLD.[BaseCurrencyID] Is Not Null
				) Or
				(
					NEW.[BaseCurrencyID] Is Not Null And
					OLD.[BaseCurrencyID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [FXRate]	 column	*/
	If UPDATE([FXRate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProjectID]=N''''''+CAST(IsNull(OLD.[InitiativeProjectID], NEW.[InitiativeProjectID]) as nvarchar(4000))+'''''''',
                ''FXRate'',
''decimal'', 
			CONVERT(nvarchar(4000),OLD.[FXRate]),
			CONVERT(nvarchar(4000),NEW.[FXRate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProjectID] = OLD.[InitiativeProjectID])
			AND (
				(
					NEW.[FXRate] <>
					OLD.[FXRate]
				) Or
				(
					NEW.[FXRate] Is Null And
					OLD.[FXRate] Is Not Null
				) Or
				(
					NEW.[FXRate] Is Not Null And
					OLD.[FXRate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeProject]', @order=N'Last', @stmttype=N'UPDATE'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'InitiativeProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'InitiativeProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'InitiativeProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=13 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'InitiativeProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'InitiativeProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1815 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'InitiativeProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'InitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'InitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'InitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'InitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'InitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'InitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ExternalProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ExternalProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ExternalProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ExternalProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ExternalProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1800 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ExternalProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2475 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectDescription'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectDescription'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectDescription'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=12 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectDescription'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectDescription'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2115 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectDescription'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProgramName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProgramName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProgramName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=4 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProgramName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProgramName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2835 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProgramName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectType'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectType'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectType'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=5 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectType'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectType'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectType'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectTypeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectTypeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectTypeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=7 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectTypeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'ProjectTypeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'ProjectTypeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'PercentRequired'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'PercentRequired'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'PercentRequired'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=8 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'PercentRequired'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'PercentRequired'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1620 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'PercentRequired'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'TotalPlanLocalCurrency'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'TotalPlanLocalCurrency'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'TotalPlanLocalCurrency'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=6 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'TotalPlanLocalCurrency'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'TotalPlanLocalCurrency'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2235 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'TotalPlanLocalCurrency'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'BaseCurrency'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'BaseCurrency'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'BaseCurrency'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=9 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'BaseCurrency'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'BaseCurrency'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'BaseCurrency'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'BaseCurrencyID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'BaseCurrencyID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'BaseCurrencyID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=10 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'BaseCurrencyID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'BaseCurrencyID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1650 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'BaseCurrencyID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'FXRate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'FXRate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'FXRate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=11 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'FXRate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', N'COLUMN',N'FXRate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject', @level2type=N'COLUMN',@level2name=N'FXRate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DefaultView' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Filter' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_OrderBy' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_OrderByOn' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Orientation' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_TableMaxRecords' , N'SCHEMA',N'dbo', N'TABLE',N'InitiativeProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'InitiativeProject'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeSponsor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeSponsor](
	[InitiativeSponsorID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[SponsorID] [int] NULL,
	[Allocation] [decimal](18, 4) NULL,
	[StoreSponsorLevel] [bit] NULL DEFAULT (1),
 CONSTRAINT [PK_InitiativeSponsor] PRIMARY KEY CLUSTERED 
(
	[InitiativeSponsorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeSponsor]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeSponsor]
ON [dbo].[InitiativeSponsor]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeSponsor]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:02 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeSponsor]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeSponsorID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeSponsor]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeSponsorID]=N''''''+CAST(OLD.[InitiativeSponsorID] as nvarchar(4000))+'''''''',
        ''SponsorID'',
		CONVERT(nvarchar(4000),OLD.[SponsorID])
	FROM deleted OLD
	WHERE
		OLD.[SponsorID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeSponsorID]=N''''''+CAST(OLD.[InitiativeSponsorID] as nvarchar(4000))+'''''''',
        ''Allocation'',
		CONVERT(nvarchar(4000),OLD.[Allocation])
	FROM deleted OLD
	WHERE
		OLD.[Allocation] Is Not Null

	/* Added 2007-11-19, GMcF, for Bug 49 - Sponsor UBR Allocation not rolled into new version - include StoreSponsorLevel in audit */
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeSponsorID]=N''''''+CAST(OLD.[InitiativeSponsorID] as nvarchar(4000))+'''''''',
        ''StoreSponsorLevel'',
		CONVERT(nvarchar(4000),OLD.[StoreSponsorLevel])
	FROM deleted OLD
	WHERE
		OLD.[StoreSponsorLevel] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END

' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeSponsor]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeSponsor]
ON [dbo].[InitiativeSponsor]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeSponsor]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:02 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeSponsorID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeSponsor]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeSponsor]	*/
	/*	INSERT audit traces For [SponsorID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeSponsorID]=N''''''+CAST([InitiativeSponsorID] as nvarchar(4000))+'''''''',
        ''SponsorID'',
		convert(nvarchar(4000), [SponsorID]) 
	FROM inserted
	WHERE [SponsorID] Is Not Null

	/*	INSERT audit traces For [Allocation]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeSponsorID]=N''''''+CAST([InitiativeSponsorID] as nvarchar(4000))+'''''''',
        ''Allocation'',
		convert(nvarchar(4000), [Allocation]) 
	FROM inserted
	WHERE [Allocation] Is Not Null

	/*  Added 2007-11-19, GMcF, for Bug 49 - Sponsor UBR Allocation not rolled into new version - include StoreSponsorLevel in audit */
	/*	INSERT audit traces For [StoreSponsorLevel]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeSponsorID]=N''''''+CAST([InitiativeSponsorID] as nvarchar(4000))+'''''''',
        ''StoreSponsorLevel'',
		convert(nvarchar(4000), [StoreSponsorLevel]) 
	FROM inserted
	WHERE [StoreSponsorLevel] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End

' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeSponsor]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeSponsor]
ON [dbo].[InitiativeSponsor]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeSponsor]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:02 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeSponsorID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeSponsor]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeSponsor]	*/
	/*	INSERT audit traces For [SponsorID]	 column	*/
	If UPDATE([SponsorID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeSponsorID]=N''''''+CAST(IsNull(OLD.[InitiativeSponsorID], NEW.[InitiativeSponsorID]) as nvarchar(4000))+'''''''',
                ''SponsorID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[SponsorID]),
			CONVERT(nvarchar(4000),NEW.[SponsorID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeSponsorID] = OLD.[InitiativeSponsorID])
			AND (
				(
					NEW.[SponsorID] <>
					OLD.[SponsorID]
				) Or
				(
					NEW.[SponsorID] Is Null And
					OLD.[SponsorID] Is Not Null
				) Or
				(
					NEW.[SponsorID] Is Not Null And
					OLD.[SponsorID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Allocation]	 column	*/
	If UPDATE([Allocation])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeSponsorID]=N''''''+CAST(IsNull(OLD.[InitiativeSponsorID], NEW.[InitiativeSponsorID]) as nvarchar(4000))+'''''''',
                ''Allocation'',
''decimal'', 
			CONVERT(nvarchar(4000),OLD.[Allocation]),
			CONVERT(nvarchar(4000),NEW.[Allocation])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeSponsorID] = OLD.[InitiativeSponsorID])
			AND (
				(
					NEW.[Allocation] <>
					OLD.[Allocation]
				) Or
				(
					NEW.[Allocation] Is Null And
					OLD.[Allocation] Is Not Null
				) Or
				(
					NEW.[Allocation] Is Not Null And
					OLD.[Allocation] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*  Added 2007-11-19, GMcF, for Bug 49 - Sponsor UBR Allocation not rolled into new version - include StoreSponsorLevel in audit */
	/*	INSERT audit traces For [StoreSponsorLevel]	 column	*/
	If UPDATE([StoreSponsorLevel])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeSponsorID]=N''''''+CAST(IsNull(OLD.[InitiativeSponsorID], NEW.[InitiativeSponsorID]) as nvarchar(4000))+'''''''',
                ''StoreSponsorLevel'',
''bit'', 
			CONVERT(nvarchar(4000),OLD.[StoreSponsorLevel]),
			CONVERT(nvarchar(4000),NEW.[StoreSponsorLevel])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeSponsorID] = OLD.[InitiativeSponsorID])
			AND (
				(
					NEW.[StoreSponsorLevel] <>
					OLD.[StoreSponsorLevel]
				) Or
				(
					NEW.[StoreSponsorLevel] Is Null And
					OLD.[StoreSponsorLevel] Is Not Null
				) Or
				(
					NEW.[StoreSponsorLevel] Is Not Null And
					OLD.[StoreSponsorLevel] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReferenceIGApprovalStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReferenceIGApprovalStatus](
	[ReferenceID] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
 CONSTRAINT [PK_ReferenceIGApprovalStatus] PRIMARY KEY CLUSTERED 
(
	[ReferenceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UBRLookupold]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UBRLookupold](
	[UBR_ID] [int] NOT NULL,
	[Level5Code] [nvarchar](10) NULL,
	[Level5Name] [nvarchar](50) NULL,
	[Level6Code] [nvarchar](10) NULL,
	[Level6Name] [nvarchar](50) NULL,
	[Level7Code] [nvarchar](10) NULL,
	[Level7Name] [nvarchar](50) NULL,
	[Level8Code] [nvarchar](10) NULL,
	[Level8Name] [nvarchar](50) NULL,
	[Level9Code] [nvarchar](10) NULL,
	[Level9Name] [nvarchar](50) NULL,
	[Level10Code] [nvarchar](10) NULL,
	[Level10Name] [nvarchar](50) NULL,
	[CustomGrouping] [nvarchar](50) NULL,
 CONSTRAINT [PK_UBRLookup] PRIMARY KEY CLUSTERED 
(
	[UBR_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ubr_upload_log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ubr_upload_log](
	[ubr_upload_log_id] [int] IDENTITY(1,1) NOT NULL,
	[log_time] [datetime] NULL CONSTRAINT [DF_ubr_upload_log_log_time]  DEFAULT (getdate()),
	[message] [nvarchar](200) NULL,
	[err] [int] NULL,
	[rows_affected] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryField]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CategoryField](
	[CategoryFieldID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[TableName] [nvarchar](100) NULL,
	[ColumnName] [nvarchar](100) NULL,
	[IDColumnName] [nvarchar](100) NULL,
 CONSTRAINT [PK_CategoryField] PRIMARY KEY CLUSTERED 
(
	[CategoryFieldID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportFieldColour]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportFieldColour](
	[ReportName] [nvarchar](128) NOT NULL,
	[ReportField] [nvarchar](128) NOT NULL,
	[FieldValue] [nvarchar](150) NOT NULL,
	[FieldColour] [char](6) NOT NULL,
 CONSTRAINT [PK_ReportFieldColour] PRIMARY KEY CLUSTERED 
(
	[ReportName] ASC,
	[ReportField] ASC,
	[FieldValue] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportLookupException]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ImportLookupException](
	[ExceptionID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[IGIdentifier] [nvarchar](50) NULL,
	[CategoryID] [int] NULL,
	[CategoryName] [nvarchar](75) NULL,
	[LookupValue] [nvarchar](50) NULL,
	[SectionName] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_SponsorAllocMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_SponsorAllocMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UploadColumn] [sysname] NULL,
	[SponsorID] [int] NULL,
 CONSTRAINT [PK_IU_SponsorAllocMapping] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SponsorContact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SponsorContact](
	[SponsorContactID] [int] IDENTITY(1,1) NOT NULL,
	[SponsorID] [int] NULL,
	[SponsorContactEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_SponsorContact] PRIMARY KEY CLUSTERED 
(
	[SponsorContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiative]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiative](
	[ExternalUniqueIdentifier] [uniqueidentifier] NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[IGBusinessAreaCode] [nvarchar](10) NULL,
	[IGIdentifierCode] [nvarchar](10) NULL,
	[IGVersionNumber] [int] NULL,
	[IGReviewDate] [datetime] NULL,
	[IGIdentifier] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[InvestmentTier] [nvarchar](50) NULL,
	[InvestmentTierID] [int] NULL,
	[PrimarySponsoringArea] [nvarchar](50) NULL,
	[OtherSponsoringAreas] [nvarchar](50) NULL,
	[BusinessSponsorName] [nvarchar](50) NULL,
	[BusinessSponsorID] [int] NULL,
	[BusinessInitiativeManager] [nvarchar](50) NULL,
	[BusinessInitiativeManagerID] [int] NULL,
	[GTOManagingBusinessArea] [nvarchar](50) NULL,
	[GTOInitiativeManager] [nvarchar](50) NULL,
	[GTOInitiativeManagerID] [int] NULL,
	[FunctionalDomain] [nvarchar](50) NULL,
	[FunctionalDomainID] [int] NULL,
	[SecondaryFunctionalDomain] [nvarchar](50) NULL,
	[SecondaryFunctionalDomainID] [int] NULL,
	[MajorApplicationName] [nvarchar](50) NULL,
	[MajorApplicationID] [int] NULL,
	[InitiativeBusinessDrivers] [ntext] NULL,
	[InitiativeScopeAndObjectives] [ntext] NULL,
	[InitiativeBenefitCalculation] [ntext] NULL,
	[StrategicInitiativeInterfaces] [ntext] NULL,
	[SmartsourcingComponent] [ntext] NULL,
	[ArchitecturalCompliance] [ntext] NULL,
	[ArchitecturalComplianceType] [nvarchar](50) NULL,
	[ArchitecturalComplianceTypeID] [int] NULL,
	[AllocationsAgreed] [nvarchar](50) NULL,
	[AllocationsAgreedID] [int] NULL,
	[InitiativeBudgeted] [nvarchar](50) NULL,
	[InitiativeBudgetedID] [int] NULL,
	[PayBackPeriod] [nvarchar](50) NULL,
	[PayBackPeriodID] [int] NULL,
	[CompletionDate] [nvarchar](50) NULL,
	[CompletionDateID] [int] NULL,
	[RTBAdditionalConsumption] [nvarchar](50) NULL,
	[RTBAdditionalConsumptionID] [int] NULL,
	[ImpactOfNotDoingThisInvestment] [ntext] NULL,
	[ShutdownComments] [ntext] NULL,
	[KeyPerformanceIndicators] [ntext] NULL,
	[BenefitCalculation] [ntext] NULL,
	[IESArchitectureApproverID] [int] NULL,
	[IESArchitectureApprover] [nvarchar](50) NULL,
	[IESArchitectureApprovalDate] [datetime] NULL,
	[IESFullyCompliantID] [int] NULL,
	[IESFullyCompliant] [nvarchar](50) NULL,
	[IESFinancialJustification] [ntext] NULL,
	[CIOArchitectureApproverID] [int] NULL,
	[CIOArchitectureApprover] [nvarchar](50) NULL,
	[CIOArchitectureApprovalDate] [datetime] NULL,
	[UsesApproved3rdPartySoftwareID] [int] NULL,
	[UsesApproved3rdPartySoftware] [nvarchar](50) NULL,
	[TechnicalArchitectureCompliantID] [int] NULL,
	[TechnicalArchitectureCompliant] [nvarchar](50) NULL,
	[BusinessArchitectureInfoProvidedID] [int] NULL,
	[BusinessArchitectureInfoProvided] [nvarchar](50) NULL,
	[ApplicationArchitetureCompliantID] [int] NULL,
	[ApplicationArchitetureCompliant] [nvarchar](50) NULL,
	[TechnicalArchitectureSatisfiedID] [int] NULL,
	[TechnicalArchitectureSatisfied] [nvarchar](50) NULL,
	[DevelopmentArchitectureCompliantID] [int] NULL,
	[DevelopmentArchitectureCompliant] [nvarchar](50) NULL,
	[GTOJustification4Deviation] [ntext] NULL,
	[RisksIssuesDeps] [ntext] NULL,
	[OverallIGComment] [ntext] NULL,
	[IGApprovalCommittee] [nvarchar](50) NULL,
	[IGApprovalCommitteeID] [int] NULL,
	[IGApprovalDate] [datetime] NULL,
	[IGApprovalStatus] [nvarchar](50) NULL,
	[IGApprovalStatusID] [int] NULL,
	[InitiativeImpactCategory] [nvarchar](50) NULL,
	[InitiativeImpactCategoryID] [int] NULL,
	[InitiativeGTOReviewLevel] [nvarchar](50) NULL,
	[InitiativeGTOReviewLevelID] [int] NULL,
	[AlignedToBusinessStrategy] [nvarchar](50) NULL,
	[AlignedToBusinessStrategyID] [int] NULL,
	[FirstTimeInitiative] [nvarchar](50) NULL,
	[FirstTimeInitiativeID] [int] NULL,
	[NonDuplication] [nvarchar](50) NULL,
	[NonDuplicationID] [int] NULL,
	[ActiveUserID] [int] NULL,
	[SecurityID] [int] NULL,
	[SubmissionDate] [datetime] NULL,
	[BasisForAllocation] [nvarchar](50) NULL,
	[BasisForAllocationID] [int] NULL,
	[BasisForAllocationDescription] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NULL,
	[RegionID] [int] NULL,
	[TechnologyFunction] [nvarchar](50) NULL,
	[TechnologyFunctionID] [int] NULL,
	[MajorApplicationInvestmentStrategy] [nvarchar](50) NULL,
	[PIRFinancialComments] [ntext] NULL,
	[PIRStartDate] [datetime] NULL,
	[PIREndDate] [datetime] NULL,
	[PIRStatus] [nvarchar](50) NULL,
	[PIRStatusID] [int] NULL,
	[PIRSuccesses] [ntext] NULL,
	[PIRIssues] [ntext] NULL,
	[PIRKeyMetricSpendStatus] [nvarchar](50) NULL,
	[PIRKeyMetricSpendStatusID] [int] NULL,
	[PIRKeyMetricSpendComments] [ntext] NULL,
	[PIRKeyMetricDeliveryStatus] [nvarchar](50) NULL,
	[PIRKeyMetricDeliveryStatusID] [int] NULL,
	[PIRKeyMetricDeliveryComments] [ntext] NULL,
	[PIRKeyMetricImpactStatus] [nvarchar](50) NULL,
	[PIRKeyMetricImpactStatusID] [int] NULL,
	[PIRKeyMetricImpactComments] [ntext] NULL,
	[PIRKeyMetricScopeStatus] [nvarchar](50) NULL,
	[PIRKeyMetricScopeStatusID] [int] NULL,
	[PIRKeyMetricScopeComments] [ntext] NULL,
	[PIRKeyMetricProjManStatus] [nvarchar](50) NULL,
	[PIRKeyMetricProjManStatusID] [int] NULL,
	[PIRKeyMetricProjManComments] [ntext] NULL,
	[PIRKeyMetricRiskManStatus] [nvarchar](50) NULL,
	[PIRKeyMetricRiskManStatusID] [int] NULL,
	[PIRKeyMetricRiskManComments] [ntext] NULL,
	[PIRKeyMetricAlphaStatus] [nvarchar](50) NULL,
	[PIRKeyMetricAlphaStatusID] [int] NULL,
	[PIRKeyMetricAlphaComments] [ntext] NULL,
	[PrimarySBUID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeApplication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeApplication](
	[InitiativeApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ApplicationID] [int] NULL,
	[DecommisioningDate] [datetime] NULL,
	[Impact] [ntext] NULL,
	[InvestmentStrategy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeApplicationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMP_UBR_UPLOAD_1_TO_MANY]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TMP_UBR_UPLOAD_1_TO_MANY](
	[OldLevel10Code] [nvarchar](200) NULL,
	[IGBusinessAreaCode] [nvarchar](50) NULL,
	[IGIdentifierCode] [nvarchar](50) NULL,
	[NewLevel10Code] [nvarchar](200) NULL,
	[InitiativeName] [nvarchar](200) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeDeliverable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeDeliverable](
	[DeliverableID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[Name] [nvarchar](200) NULL,
	[DueDate] [datetime] NULL,
	[Cost] [money] NULL,
	[AffectedApplications] [nvarchar](200) NULL,
	[PIRCommentary] [nvarchar](4000) NULL,
	[PIRStatus] [nvarchar](50) NULL,
	[PIRStatusID] [int] NULL,
	[PIRActualDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DeliverableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeFinancial]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeFinancial](
	[InitiativeFinancialID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[Category] [nvarchar](50) NULL,
	[CategoryID] [int] NULL,
	[Type] [nvarchar](50) NULL,
	[TypeID] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[DescriptionID] [int] NULL,
	[Comments] [nvarchar](255) NULL,
	[OwnerID] [int] NULL,
	[BusinessGTLevel5Name] [nvarchar](50) NULL,
	[BusinessGTLevel5Code] [nvarchar](10) NULL,
	[BusinessGTLevel6Name] [nvarchar](50) NULL,
	[BusinessGTLevel6Code] [nvarchar](10) NULL,
	[BusinessGTLevel7Name] [nvarchar](50) NULL,
	[BusinessGTLevel7Code] [nvarchar](10) NULL,
	[BusinessGTLevel8Name] [nvarchar](50) NULL,
	[BusinessGTLevel8Code] [nvarchar](10) NULL,
	[BusinessGTLevel9Name] [nvarchar](50) NULL,
	[BusinessGTLevel9Code] [nvarchar](10) NULL,
	[BusinessGTLevel10Name] [nvarchar](50) NULL,
	[BusinessGTLevel10Code] [nvarchar](10) NULL,
	[UBR_ID] [int] NULL,
	[StartDate] [datetime] NULL,
	[CustomGrouping] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeFinancialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Options]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Options](
	[Scope] [nvarchar](255) NULL,
	[RefField] [nvarchar](255) NULL,
	[RefID] [nvarchar](255) NULL,
	[Option] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeImpact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeImpact](
	[InitiativeImpactID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[NonComplianceTypeID] [int] NULL,
	[NonComplianceType] [nvarchar](50) NULL,
	[AgreedAlternative] [ntext] NULL,
	[CTB_RTBID] [int] NULL,
	[CTB_RTB] [nvarchar](10) NULL,
	[CIO_CTOID] [int] NULL,
	[CIO_CTO] [nvarchar](10) NULL,
	[Remediation] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeImpactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_ubr_upload_checks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_ubr_upload_checks](
	[step] [varchar](10) NULL,
	[table_name] [nvarchar](128) NULL,
	[level10code] [nvarchar](100) NULL,
	[record_count] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeReview]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeReview](
	[InitiativeID] [int] NOT NULL,
	[Comment_RG] [nvarchar](200) NULL,
	[Comment_CR] [nvarchar](200) NULL,
	[Comment_RR] [nvarchar](200) NULL,
	[Comment_CA] [nvarchar](200) NULL,
	[Comment_RLA] [nvarchar](200) NULL,
	[Comment_RoI] [nvarchar](200) NULL,
	[Comment_CTB] [nvarchar](200) NULL,
	[Comment_MAN] [nvarchar](200) NULL,
	[Comment_RTB] [nvarchar](200) NULL,
	[Comment_RTB_Existing] [nvarchar](200) NULL,
 CONSTRAINT [PK_InitiativeReview] PRIMARY KEY CLUSTERED 
(
	[InitiativeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeReview]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeReview]
ON [dbo].[InitiativeReview]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeReview]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:00 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeReview]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeReview]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RG'',
		CONVERT(nvarchar(4000),OLD.[Comment_RG])
	FROM deleted OLD
	WHERE
		OLD.[Comment_RG] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_CR'',
		CONVERT(nvarchar(4000),OLD.[Comment_CR])
	FROM deleted OLD
	WHERE
		OLD.[Comment_CR] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RR'',
		CONVERT(nvarchar(4000),OLD.[Comment_RR])
	FROM deleted OLD
	WHERE
		OLD.[Comment_RR] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_CA'',
		CONVERT(nvarchar(4000),OLD.[Comment_CA])
	FROM deleted OLD
	WHERE
		OLD.[Comment_CA] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RLA'',
		CONVERT(nvarchar(4000),OLD.[Comment_RLA])
	FROM deleted OLD
	WHERE
		OLD.[Comment_RLA] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RoI'',
		CONVERT(nvarchar(4000),OLD.[Comment_RoI])
	FROM deleted OLD
	WHERE
		OLD.[Comment_RoI] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_CTB'',
		CONVERT(nvarchar(4000),OLD.[Comment_CTB])
	FROM deleted OLD
	WHERE
		OLD.[Comment_CTB] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_MAN'',
		CONVERT(nvarchar(4000),OLD.[Comment_MAN])
	FROM deleted OLD
	WHERE
		OLD.[Comment_MAN] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RTB'',
		CONVERT(nvarchar(4000),OLD.[Comment_RTB])
	FROM deleted OLD
	WHERE
		OLD.[Comment_RTB] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RTB_Existing'',
		CONVERT(nvarchar(4000),OLD.[Comment_RTB_Existing])
	FROM deleted OLD
	WHERE
		OLD.[Comment_RTB_Existing] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeReview]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeReview]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeReview]
ON [dbo].[InitiativeReview]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeReview]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:00 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeReview]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeReview]	*/
	/*	INSERT audit traces For [Comment_RG]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RG'',
		convert(nvarchar(4000), [Comment_RG]) 
	FROM inserted
	WHERE [Comment_RG] Is Not Null

	/*	INSERT audit traces For [Comment_CR]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_CR'',
		convert(nvarchar(4000), [Comment_CR]) 
	FROM inserted
	WHERE [Comment_CR] Is Not Null

	/*	INSERT audit traces For [Comment_RR]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RR'',
		convert(nvarchar(4000), [Comment_RR]) 
	FROM inserted
	WHERE [Comment_RR] Is Not Null

	/*	INSERT audit traces For [Comment_CA]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_CA'',
		convert(nvarchar(4000), [Comment_CA]) 
	FROM inserted
	WHERE [Comment_CA] Is Not Null

	/*	INSERT audit traces For [Comment_RLA]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RLA'',
		convert(nvarchar(4000), [Comment_RLA]) 
	FROM inserted
	WHERE [Comment_RLA] Is Not Null

	/*	INSERT audit traces For [Comment_RoI]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RoI'',
		convert(nvarchar(4000), [Comment_RoI]) 
	FROM inserted
	WHERE [Comment_RoI] Is Not Null

	/*	INSERT audit traces For [Comment_CTB]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_CTB'',
		convert(nvarchar(4000), [Comment_CTB]) 
	FROM inserted
	WHERE [Comment_CTB] Is Not Null

	/*	INSERT audit traces For [Comment_MAN]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_MAN'',
		convert(nvarchar(4000), [Comment_MAN]) 
	FROM inserted
	WHERE [Comment_MAN] Is Not Null

	/*	INSERT audit traces For [Comment_RTB]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RTB'',
		convert(nvarchar(4000), [Comment_RTB]) 
	FROM inserted
	WHERE [Comment_RTB] Is Not Null

	/*	INSERT audit traces For [Comment_RTB_Existing]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Comment_RTB_Existing'',
		convert(nvarchar(4000), [Comment_RTB_Existing]) 
	FROM inserted
	WHERE [Comment_RTB_Existing] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeReview]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeReview]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeReview]
ON [dbo].[InitiativeReview]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeReview]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:00 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeReview]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeReview]	*/
	/*	INSERT audit traces For [Comment_RG]	 column	*/
	If UPDATE([Comment_RG])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_RG'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_RG]),
			CONVERT(nvarchar(4000),NEW.[Comment_RG])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_RG] <>
					OLD.[Comment_RG]
				) Or
				(
					NEW.[Comment_RG] Is Null And
					OLD.[Comment_RG] Is Not Null
				) Or
				(
					NEW.[Comment_RG] Is Not Null And
					OLD.[Comment_RG] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_CR]	 column	*/
	If UPDATE([Comment_CR])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_CR'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_CR]),
			CONVERT(nvarchar(4000),NEW.[Comment_CR])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_CR] <>
					OLD.[Comment_CR]
				) Or
				(
					NEW.[Comment_CR] Is Null And
					OLD.[Comment_CR] Is Not Null
				) Or
				(
					NEW.[Comment_CR] Is Not Null And
					OLD.[Comment_CR] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_RR]	 column	*/
	If UPDATE([Comment_RR])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_RR'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_RR]),
			CONVERT(nvarchar(4000),NEW.[Comment_RR])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_RR] <>
					OLD.[Comment_RR]
				) Or
				(
					NEW.[Comment_RR] Is Null And
					OLD.[Comment_RR] Is Not Null
				) Or
				(
					NEW.[Comment_RR] Is Not Null And
					OLD.[Comment_RR] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_CA]	 column	*/
	If UPDATE([Comment_CA])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_CA'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_CA]),
			CONVERT(nvarchar(4000),NEW.[Comment_CA])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_CA] <>
					OLD.[Comment_CA]
				) Or
				(
					NEW.[Comment_CA] Is Null And
					OLD.[Comment_CA] Is Not Null
				) Or
				(
					NEW.[Comment_CA] Is Not Null And
					OLD.[Comment_CA] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_RLA]	 column	*/
	If UPDATE([Comment_RLA])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_RLA'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_RLA]),
			CONVERT(nvarchar(4000),NEW.[Comment_RLA])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_RLA] <>
					OLD.[Comment_RLA]
				) Or
				(
					NEW.[Comment_RLA] Is Null And
					OLD.[Comment_RLA] Is Not Null
				) Or
				(
					NEW.[Comment_RLA] Is Not Null And
					OLD.[Comment_RLA] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_RoI]	 column	*/
	If UPDATE([Comment_RoI])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_RoI'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_RoI]),
			CONVERT(nvarchar(4000),NEW.[Comment_RoI])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_RoI] <>
					OLD.[Comment_RoI]
				) Or
				(
					NEW.[Comment_RoI] Is Null And
					OLD.[Comment_RoI] Is Not Null
				) Or
				(
					NEW.[Comment_RoI] Is Not Null And
					OLD.[Comment_RoI] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_CTB]	 column	*/
	If UPDATE([Comment_CTB])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_CTB'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_CTB]),
			CONVERT(nvarchar(4000),NEW.[Comment_CTB])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_CTB] <>
					OLD.[Comment_CTB]
				) Or
				(
					NEW.[Comment_CTB] Is Null And
					OLD.[Comment_CTB] Is Not Null
				) Or
				(
					NEW.[Comment_CTB] Is Not Null And
					OLD.[Comment_CTB] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_MAN]	 column	*/
	If UPDATE([Comment_MAN])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_MAN'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_MAN]),
			CONVERT(nvarchar(4000),NEW.[Comment_MAN])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_MAN] <>
					OLD.[Comment_MAN]
				) Or
				(
					NEW.[Comment_MAN] Is Null And
					OLD.[Comment_MAN] Is Not Null
				) Or
				(
					NEW.[Comment_MAN] Is Not Null And
					OLD.[Comment_MAN] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_RTB]	 column	*/
	If UPDATE([Comment_RTB])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_RTB'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_RTB]),
			CONVERT(nvarchar(4000),NEW.[Comment_RTB])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_RTB] <>
					OLD.[Comment_RTB]
				) Or
				(
					NEW.[Comment_RTB] Is Null And
					OLD.[Comment_RTB] Is Not Null
				) Or
				(
					NEW.[Comment_RTB] Is Not Null And
					OLD.[Comment_RTB] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comment_RTB_Existing]	 column	*/
	If UPDATE([Comment_RTB_Existing])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Comment_RTB_Existing'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comment_RTB_Existing]),
			CONVERT(nvarchar(4000),NEW.[Comment_RTB_Existing])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Comment_RTB_Existing] <>
					OLD.[Comment_RTB_Existing]
				) Or
				(
					NEW.[Comment_RTB_Existing] Is Null And
					OLD.[Comment_RTB_Existing] Is Not Null
				) Or
				(
					NEW.[Comment_RTB_Existing] Is Not Null And
					OLD.[Comment_RTB_Existing] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeReview]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeITPolicy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeITPolicy](
	[InitiativeITPolicyID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ITPolicyID] [int] NULL,
	[ITPolicyValue] [nvarchar](50) NULL,
	[ITPolicyValueID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeITPolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeProduct](
	[InitiativeProductID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductTypeID] [int] NULL,
	[ProductType] [nvarchar](50) NULL,
	[TVendor] [nvarchar](50) NULL,
	[CTB_RTBID] [int] NULL,
	[CTB_RTB] [nvarchar](50) NULL,
	[CIO_IESID] [int] NULL,
	[CIO_IES] [nvarchar](50) NULL,
	[Remediation] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeProject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeProject](
	[InitiativeProjectID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[ExternalProjectID] [nvarchar](10) NOT NULL,
	[ProjectName] [nvarchar](150) NULL,
	[ProjectDescription] [ntext] NULL,
	[ProgramName] [nvarchar](150) NULL,
	[ProjectType] [nvarchar](50) NULL,
	[ProjectTypeID] [int] NULL,
	[PercentRequired] [decimal](18, 2) NULL,
	[TotalPlanLocalCurrency] [decimal](18, 2) NULL,
	[BaseCurrency] [nvarchar](10) NULL,
	[BaseCurrencyID] [int] NULL,
	[FXRate] [decimal](18, 2) NULL,
	[AmountRequested] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeProjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeDetailedFunctionalDomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeDetailedFunctionalDomain](
	[InitiativeDetailedFunctionalDomainID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[DetailedFunctionalDomainReferenceID] [int] NOT NULL,
	[DetailedFunctionalDomainDescription] [nvarchar](50) NULL,
	[Allocation] [decimal](9, 2) NOT NULL,
	[Comments] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeDetailedFunctionalDomainID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeDetailedFunctionalDomain]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeDetailedFunctionalDomain]
ON [dbo].[InitiativeDetailedFunctionalDomain]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeDetailedFunctionalDomain]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeDetailedFunctionalDomainID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeDetailedFunctionalDomain]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(OLD.[InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''DetailedFunctionalDomainReferenceID'',
		CONVERT(nvarchar(4000),OLD.[DetailedFunctionalDomainReferenceID])
	FROM deleted OLD
	WHERE
		OLD.[DetailedFunctionalDomainReferenceID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(OLD.[InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''DetailedFunctionalDomainDescription'',
		CONVERT(nvarchar(4000),OLD.[DetailedFunctionalDomainDescription])
	FROM deleted OLD
	WHERE
		OLD.[DetailedFunctionalDomainDescription] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(OLD.[InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''Allocation'',
		CONVERT(nvarchar(4000),OLD.[Allocation])
	FROM deleted OLD
	WHERE
		OLD.[Allocation] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(OLD.[InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''Comments'',
		CONVERT(nvarchar(4000),OLD.[Comments])
	FROM deleted OLD
	WHERE
		OLD.[Comments] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END

' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeDetailedFunctionalDomain]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeDetailedFunctionalDomain]
ON [dbo].[InitiativeDetailedFunctionalDomain]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeDetailedFunctionalDomain]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeDetailedFunctionalDomainID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeDeliverable]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeDetailedFunctionalDomain]	*/
	/*	INSERT audit traces For [DetailedFunctionalDomainReferenceID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST([InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''DetailedFunctionalDomainReferenceID'',
		convert(nvarchar(4000), [DetailedFunctionalDomainReferenceID]) 
	FROM inserted
	WHERE [DetailedFunctionalDomainReferenceID] Is Not Null

	/*	INSERT audit traces For [DetailedFunctionalDomainDescription]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST([InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''DetailedFunctionalDomainDescription'',
		convert(nvarchar(4000), [DetailedFunctionalDomainDescription]) 
	FROM inserted
	WHERE [DetailedFunctionalDomainDescription] Is Not Null

	/*	INSERT audit traces For [Allocation]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST([InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''Allocation'',
		convert(nvarchar(4000), [Allocation]) 
	FROM inserted
	WHERE [Allocation] Is Not Null

	/*	INSERT audit traces For [Comments]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST([InitiativeDetailedFunctionalDomainID] as nvarchar(4000))+'''''''',
        ''Comments'',
		convert(nvarchar(4000), [Comments]) 
	FROM inserted
	WHERE [Comments] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End

' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeDetailedFunctionalDomain]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeDetailedFunctionalDomain]
ON [dbo].[InitiativeDetailedFunctionalDomain]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeDetailedFunctionalDomain]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeDetailedFunctionalDomainID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeDetailedFunctionalDomain]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeDetailedFunctionalDomain]	*/
	/*	INSERT audit traces For [DetailedFunctionalDomainReferenceID]	 column	*/
	If UPDATE([DetailedFunctionalDomainReferenceID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(IsNull(OLD.[InitiativeDetailedFunctionalDomainID], NEW.[InitiativeDetailedFunctionalDomainID]) as nvarchar(4000))+'''''''',
            ''DetailedFunctionalDomainReferenceID'',
			''int'', 
			CONVERT(nvarchar(4000),OLD.[DetailedFunctionalDomainReferenceID]),
			CONVERT(nvarchar(4000),NEW.[DetailedFunctionalDomainReferenceID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeDetailedFunctionalDomainID] = OLD.[InitiativeDetailedFunctionalDomainID])
			AND (
				(
					NEW.[DetailedFunctionalDomainReferenceID] <>
					OLD.[DetailedFunctionalDomainReferenceID]
				) Or
				(
					NEW.[DetailedFunctionalDomainReferenceID] Is Null And
					OLD.[DetailedFunctionalDomainReferenceID] Is Not Null
				) Or
				(
					NEW.[DetailedFunctionalDomainReferenceID] Is Not Null And
					OLD.[DetailedFunctionalDomainReferenceID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DetailedFunctionalDomainDescription]	 column	*/
	If UPDATE([DetailedFunctionalDomainDescription])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(IsNull(OLD.[InitiativeDetailedFunctionalDomainID], NEW.[InitiativeDetailedFunctionalDomainID]) as nvarchar(4000))+'''''''',
            ''DetailedFunctionalDomainDescription'',
			''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[DetailedFunctionalDomainDescription]),
			CONVERT(nvarchar(4000),NEW.[DetailedFunctionalDomainDescription])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeDetailedFunctionalDomainID] = OLD.[InitiativeDetailedFunctionalDomainID])
			AND (
				(
					NEW.[DetailedFunctionalDomainDescription] <>
					OLD.[DetailedFunctionalDomainDescription]
				) Or
				(
					NEW.[DetailedFunctionalDomainDescription] Is Null And
					OLD.[DetailedFunctionalDomainDescription] Is Not Null
				) Or
				(
					NEW.[DetailedFunctionalDomainDescription] Is Not Null And
					OLD.[DetailedFunctionalDomainDescription] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Allocation]	 column	*/
	If UPDATE([Allocation])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(IsNull(OLD.[InitiativeDetailedFunctionalDomainID], NEW.[InitiativeDetailedFunctionalDomainID]) as nvarchar(4000))+'''''''',
            ''Allocation'',
			''decimal'', 
			CONVERT(nvarchar(4000),OLD.[Allocation]),
			CONVERT(nvarchar(4000),NEW.[Allocation])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeDetailedFunctionalDomainID] = OLD.[InitiativeDetailedFunctionalDomainID])
			AND (
				(
					NEW.[Allocation] <>
					OLD.[Allocation]
				) Or
				(
					NEW.[Allocation] Is Null And
					OLD.[Allocation] Is Not Null
				) Or
				(
					NEW.[Allocation] Is Not Null And
					OLD.[Allocation] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comments]	 column	*/
	If UPDATE([Comments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeDetailedFunctionalDomainID]=N''''''+CAST(IsNull(OLD.[InitiativeDetailedFunctionalDomainID], NEW.[InitiativeDetailedFunctionalDomainID]) as nvarchar(4000))+'''''''',
            ''Comments'',
			''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comments]),
			CONVERT(nvarchar(4000),NEW.[Comments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeDetailedFunctionalDomainID] = OLD.[InitiativeDetailedFunctionalDomainID])
			AND (
				(
					NEW.[Comments] <>
					OLD.[Comments]
				) Or
				(
					NEW.[Comments] Is Null And
					OLD.[Comments] Is Not Null
				) Or
				(
					NEW.[Comments] Is Not Null And
					OLD.[Comments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeExtended]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeExtended](
	[InitiativeId] [int] NOT NULL,
	[PPR_CostDate] [datetime] NULL,
	[PPR_CostChangedBy] [nvarchar](50) NULL,
	[PPR_CostChangedByID] [int] NULL,
	[PPR_DeliverablesDate] [datetime] NULL,
	[PPR_DeliverablesChangedBy] [nvarchar](50) NULL,
	[PPR_DeliverablesChangedByID] [int] NULL,
	[PPR_TimeDate] [datetime] NULL,
	[PPR_TimeChangedBy] [nvarchar](50) NULL,
	[PPR_TimeChangedByID] [int] NULL,
	[PPR_RisksDate] [datetime] NULL,
	[PPR_RisksChangedBy] [nvarchar](50) NULL,
	[PPR_RisksChangedByID] [int] NULL,
	[PPR_BenefitsDate] [datetime] NULL,
	[PPR_BenefitsChangedBy] [nvarchar](50) NULL,
	[PPR_BenefitsChangedByID] [int] NULL,
	[PPR_OverallDate] [datetime] NULL,
	[PPR_OverallChangedBy] [nvarchar](50) NULL,
	[PPR_OverallChangedByID] [int] NULL,
	[PPR_Comments] [nvarchar](200) NULL,
	[PPR_CommentsDate] [datetime] NULL,
	[PPR_CommentsChangedBy] [nvarchar](50) NULL,
	[PPR_CommentsChangedByID] [int] NULL,
	[PIRKeymetricTimeStatus] [nvarchar](50) NULL,
	[PIRKeyMetricTimeStatusID] [int] NULL,
	[PIRKeyMetricTimeComments] [ntext] NULL,
	[InPPR] [char](1) NULL,
 CONSTRAINT [PK_deleteInitiativeExtended] PRIMARY KEY CLUSTERED 
(
	[InitiativeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeReview]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeReview](
	[InitiativeID] [int] NOT NULL,
	[Comment_RG] [nvarchar](200) NULL,
	[Comment_CR] [nvarchar](200) NULL,
	[Comment_RR] [nvarchar](200) NULL,
	[Comment_CA] [nvarchar](200) NULL,
	[Comment_RLA] [nvarchar](200) NULL,
	[Comment_RoI] [nvarchar](200) NULL,
	[Comment_CTB] [nvarchar](200) NULL,
	[Comment_MAN] [nvarchar](200) NULL,
	[Comment_RTB] [nvarchar](200) NULL,
	[Comment_RTB_Existing] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sponsor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sponsor](
	[SponsorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Owner] [nvarchar](10) NULL,
	[shortname] [nvarchar](20) NULL,
	[sortorder] [int] NULL,
 CONSTRAINT [PK_Sponsor] PRIMARY KEY CLUSTERED 
(
	[SponsorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeExtended]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeExtended](
	[InitiativeId] [int] NOT NULL,
	[PPR_CostDate] [datetime] NULL,
	[PPR_CostChangedBy] [nvarchar](50) NULL,
	[PPR_CostChangedByID] [int] NULL,
	[PPR_DeliverablesDate] [datetime] NULL,
	[PPR_DeliverablesChangedBy] [nvarchar](50) NULL,
	[PPR_DeliverablesChangedByID] [int] NULL,
	[PPR_TimeDate] [datetime] NULL,
	[PPR_TimeChangedBy] [nvarchar](50) NULL,
	[PPR_TimeChangedByID] [int] NULL,
	[PPR_RisksDate] [datetime] NULL,
	[PPR_RisksChangedBy] [nvarchar](50) NULL,
	[PPR_RisksChangedByID] [int] NULL,
	[PPR_BenefitsDate] [datetime] NULL,
	[PPR_BenefitsChangedBy] [nvarchar](50) NULL,
	[PPR_BenefitsChangedByID] [int] NULL,
	[PPR_OverallDate] [datetime] NULL,
	[PPR_OverallChangedBy] [nvarchar](50) NULL,
	[PPR_OverallChangedByID] [int] NULL,
	[PPR_Comments] [nvarchar](200) NULL,
	[PPR_CommentsDate] [datetime] NULL,
	[PPR_CommentsChangedBy] [nvarchar](50) NULL,
	[PPR_CommentsChangedByID] [int] NULL,
	[PIRKeymetricTimeStatus] [nvarchar](50) NULL,
	[PIRKeyMetricTimeStatusID] [int] NULL,
	[PIRKeyMetricTimeComments] [ntext] NULL,
	[InPPR] [char](1) NULL CONSTRAINT [DF__InitExtended__InPPR]  DEFAULT ('N'),
	[PPR_TimeStatus]  AS ([PIRKeyMetricTimeStatus]),
	[PPR_TimeStatusId]  AS ([PIRKeyMetricTimeStatusId]),
 CONSTRAINT [PK_InitiativeExtended] PRIMARY KEY CLUSTERED 
(
	[InitiativeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeExtended]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeExtended]
ON [dbo].[InitiativeExtended]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[Initiative]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:54 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[Initiative]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeExtended]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CostDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_CostDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_CostDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CostChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_CostChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_CostChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CostChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_CostChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_CostChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_DeliverablesDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_DeliverablesDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_DeliverablesDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_DeliverablesChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_DeliverablesChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_DeliverablesChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_DeliverablesChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_DeliverablesChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_DeliverablesChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_TimeDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_TimeDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_TimeDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_TimeChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_TimeChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_TimeChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_TimeChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_TimeChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_TimeChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_RisksDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_RisksDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_RisksDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_RisksChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_RisksChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_RisksChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_RisksChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_RisksChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_RisksChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_BenefitsDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_BenefitsDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_BenefitsDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_BenefitsChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_BenefitsChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_BenefitsChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_BenefitsChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_BenefitsChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_BenefitsChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_OverallDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_OverallDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_OverallDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_OverallChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_OverallChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_OverallChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_OverallChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_OverallChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_OverallChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_Comments'',
		CONVERT(nvarchar(4000),OLD.[PPR_Comments])
	FROM deleted OLD
	WHERE
		OLD.[PPR_Comments] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CommentsDate'',
		CONVERT(nvarchar(4000),OLD.[PPR_CommentsDate])
	FROM deleted OLD
	WHERE
		OLD.[PPR_CommentsDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CommentsChangedBy'',
		CONVERT(nvarchar(4000),OLD.[PPR_CommentsChangedBy])
	FROM deleted OLD
	WHERE
		OLD.[PPR_CommentsChangedBy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CommentsChangedByID'',
		CONVERT(nvarchar(4000),OLD.[PPR_CommentsChangedByID])
	FROM deleted OLD
	WHERE
		OLD.[PPR_CommentsChangedByID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeymetricTimeStatus'',
		CONVERT(nvarchar(4000),OLD.[PIRKeymetricTimeStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeymetricTimeStatus] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricTimeStatusID'',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricTimeStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricTimeStatusID] Is Not Null


-- ntext field - not audited
--
-- 	INSERT
-- 	INTO dbo.AUDIT_LOG_DATA
-- 	(
-- 		AUDIT_LOG_TRANSACTION_ID,
-- 		PRIMARY_KEY_DATA,
-- 		COL_NAME,
-- 		OLD_VALUE_LONG
-- 	)
-- 	SELECT
-- 		@AUDIT_LOG_TRANSACTION_ID,
--         ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
--         ''PIRKeyMetricTimeComments'',
-- 		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricTimeComments])
-- 	FROM deleted OLD
-- 	WHERE
-- 		OLD.[PIRKeyMetricTimeComments] Is Not Null


	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InPPR'',
		CONVERT(nvarchar(4000),OLD.[InPPR])
	FROM deleted OLD
	WHERE
		OLD.[InPPR] Is Not Null


	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
  SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

END



' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeExtended]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeExtended]
ON [dbo].[InitiativeExtended]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[Initiative]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:53 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeExtended]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY


	/*	INSERT audit traces For table [dbo].[InitiativeExtended]	*/

	/*	INSERT audit traces For [PPR_CostDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CostDate'',
		convert(nvarchar(4000), [PPR_CostDate]) 
	FROM inserted
	WHERE [PPR_CostDate] Is Not Null


	/*	INSERT audit traces For [PPR_CostChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CostChangedBy'',
		convert(nvarchar(4000), [PPR_CostChangedBy]) 
	FROM inserted
	WHERE [PPR_CostChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_CostChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CostChangedByID'',
		convert(nvarchar(4000), [PPR_CostChangedByID]) 
	FROM inserted
	WHERE [PPR_CostChangedByID] Is Not Null


	/*	INSERT audit traces For [PPR_DeliverablesDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_DeliverablesDate'',
		convert(nvarchar(4000), [PPR_DeliverablesDate]) 
	FROM inserted
	WHERE [PPR_DeliverablesDate] Is Not Null


	/*	INSERT audit traces For [PPR_DeliverablesChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_DeliverablesChangedBy'',
		convert(nvarchar(4000), [PPR_DeliverablesChangedBy]) 
	FROM inserted
	WHERE [PPR_DeliverablesChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_DeliverablesChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_DeliverablesChangedByID'',
		convert(nvarchar(4000), [PPR_DeliverablesChangedByID]) 
	FROM inserted
	WHERE [PPR_DeliverablesChangedByID] Is Not Null


	/*	INSERT audit traces For [PPR_TimeDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_TimeDate'',
		convert(nvarchar(4000), [PPR_TimeDate]) 
	FROM inserted
	WHERE [PPR_TimeDate] Is Not Null


	/*	INSERT audit traces For [PPR_TimeChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_TimeChangedBy'',
		convert(nvarchar(4000), [PPR_TimeChangedBy]) 
	FROM inserted
	WHERE [PPR_TimeChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_TimeChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_TimeChangedByID'',
		convert(nvarchar(4000), [PPR_TimeChangedByID]) 
	FROM inserted
	WHERE [PPR_TimeChangedByID] Is Not Null


	/*	INSERT audit traces For [PPR_RisksDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_RisksDate'',
		convert(nvarchar(4000), [PPR_RisksDate]) 
	FROM inserted
	WHERE [PPR_RisksDate] Is Not Null


	/*	INSERT audit traces For [PPR_RisksChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_RisksChangedBy'',
		convert(nvarchar(4000), [PPR_RisksChangedBy]) 
	FROM inserted
	WHERE [PPR_RisksChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_RisksChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_RisksChangedByID'',
		convert(nvarchar(4000), [PPR_RisksChangedByID]) 
	FROM inserted
	WHERE [PPR_RisksChangedByID] Is Not Null


	/*	INSERT audit traces For [PPR_BenefitsDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_BenefitsDate'',
		convert(nvarchar(4000), [PPR_BenefitsDate]) 
	FROM inserted
	WHERE [PPR_BenefitsDate] Is Not Null


	/*	INSERT audit traces For [PPR_BenefitsChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_BenefitsChangedBy'',
		convert(nvarchar(4000), [PPR_BenefitsChangedBy]) 
	FROM inserted
	WHERE [PPR_BenefitsChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_BenefitsChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_BenefitsChangedByID'',
		convert(nvarchar(4000), [PPR_BenefitsChangedByID]) 
	FROM inserted
	WHERE [PPR_BenefitsChangedByID] Is Not Null


	/*	INSERT audit traces For [PPR_OverallDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_OverallDate'',
		convert(nvarchar(4000), [PPR_OverallDate]) 
	FROM inserted
	WHERE [PPR_OverallDate] Is Not Null


	/*	INSERT audit traces For [PPR_OverallChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_OverallChangedBy'',
		convert(nvarchar(4000), [PPR_OverallChangedBy]) 
	FROM inserted
	WHERE [PPR_OverallChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_OverallChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_OverallChangedByID'',
		convert(nvarchar(4000), [PPR_OverallChangedByID]) 
	FROM inserted
	WHERE [PPR_OverallChangedByID] Is Not Null


	/*	INSERT audit traces For [PPR_Comments]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_Comments'',
		convert(nvarchar(4000), [PPR_Comments]) 
	FROM inserted
	WHERE [PPR_Comments] Is Not Null


	/*	INSERT audit traces For [PPR_CommentsDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CommentsDate'',
		convert(nvarchar(4000), [PPR_CommentsDate]) 
	FROM inserted
	WHERE [PPR_CommentsDate] Is Not Null


	/*	INSERT audit traces For [PPR_CommentsChangedBy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CommentsChangedBy'',
		convert(nvarchar(4000), [PPR_CommentsChangedBy]) 
	FROM inserted
	WHERE [PPR_CommentsChangedBy] Is Not Null


	/*	INSERT audit traces For [PPR_CommentsChangedByID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PPR_CommentsChangedByID'',
		convert(nvarchar(4000), [PPR_CommentsChangedByID]) 
	FROM inserted
	WHERE [PPR_CommentsChangedByID] Is Not Null


	/*	INSERT audit traces For [PIRKeymetricTimeStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeymetricTimeStatus'',
		convert(nvarchar(4000), [PIRKeymetricTimeStatus]) 
	FROM inserted
	WHERE [PIRKeymetricTimeStatus] Is Not Null


	/*	INSERT audit traces For [PIRKeyMetricTimeStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricTimeStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricTimeStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricTimeStatusID] Is Not Null


--  ntext field - not audited
--
-- 	/*	INSERT audit traces For [PIRKeyMetricTimeComments]	 column	*/
-- 	INSERT
-- 	INTO dbo.AUDIT_LOG_DATA
-- 	(
-- 		AUDIT_LOG_TRANSACTION_ID,
-- 		PRIMARY_KEY_DATA,
-- 		COL_NAME,
-- 		NEW_VALUE_LONG
-- 	)
-- 	SELECT
-- 		@AUDIT_LOG_TRANSACTION_ID,
--         ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
--         ''PIRKeyMetricTimeComments'',
-- 		convert(nvarchar(4000), [PIRKeyMetricTimeComments]) 
-- 	FROM inserted
-- 	WHERE [PIRKeyMetricTimeComments] Is Not Null


	/*	INSERT audit traces For [InPPR]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InPPR'',
		convert(nvarchar(4000), [InPPR]) 
	FROM inserted
	WHERE [InPPR] Is Not Null


	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End



' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeExtended]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeExtended]
ON [dbo].[InitiativeExtended]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[Initiative]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:53 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeExtended]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeExtended]	*/
	
	/*	INSERT audit traces For [PPR_CostDate]	 column	*/
	If UPDATE([PPR_CostDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_CostDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_CostDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_CostDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_CostDate] <>
					OLD.[PPR_CostDate]
				) Or
				(
					NEW.[PPR_CostDate] Is Null And
					OLD.[PPR_CostDate] Is Not Null
				) Or
				(
					NEW.[PPR_CostDate] Is Not Null And
					OLD.[PPR_CostDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_CostChangedBy]	 column	*/
	If UPDATE([PPR_CostChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_CostChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_CostChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_CostChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_CostChangedBy] <>
					OLD.[PPR_CostChangedBy]
				) Or
				(
					NEW.[PPR_CostChangedBy] Is Null And
					OLD.[PPR_CostChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_CostChangedBy] Is Not Null And
					OLD.[PPR_CostChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_CostChangedByID]	 column	*/
	If UPDATE([PPR_CostChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_CostChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_CostChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_CostChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_CostChangedByID] <>
					OLD.[PPR_CostChangedByID]
				) Or
				(
					NEW.[PPR_CostChangedByID] Is Null And
					OLD.[PPR_CostChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_CostChangedByID] Is Not Null And
					OLD.[PPR_CostChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_DeliverablesDate]	 column	*/
	If UPDATE([PPR_DeliverablesDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_DeliverablesDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_DeliverablesDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_DeliverablesDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_DeliverablesDate] <>
					OLD.[PPR_DeliverablesDate]
				) Or
				(
					NEW.[PPR_DeliverablesDate] Is Null And
					OLD.[PPR_DeliverablesDate] Is Not Null
				) Or
				(
					NEW.[PPR_DeliverablesDate] Is Not Null And
					OLD.[PPR_DeliverablesDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_DeliverablesChangedBy]	 column	*/
	If UPDATE([PPR_DeliverablesChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_DeliverablesChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_DeliverablesChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_DeliverablesChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_DeliverablesChangedBy] <>
					OLD.[PPR_DeliverablesChangedBy]
				) Or
				(
					NEW.[PPR_DeliverablesChangedBy] Is Null And
					OLD.[PPR_DeliverablesChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_DeliverablesChangedBy] Is Not Null And
					OLD.[PPR_DeliverablesChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_DeliverablesChangedByID]	 column	*/
	If UPDATE([PPR_DeliverablesChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_DeliverablesChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_DeliverablesChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_DeliverablesChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_DeliverablesChangedByID] <>
					OLD.[PPR_DeliverablesChangedByID]
				) Or
				(
					NEW.[PPR_DeliverablesChangedByID] Is Null And
					OLD.[PPR_DeliverablesChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_DeliverablesChangedByID] Is Not Null And
					OLD.[PPR_DeliverablesChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_TimeDate]	 column	*/
	If UPDATE([PPR_TimeDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_TimeDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_TimeDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_TimeDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_TimeDate] <>
					OLD.[PPR_TimeDate]
				) Or
				(
					NEW.[PPR_TimeDate] Is Null And
					OLD.[PPR_TimeDate] Is Not Null
				) Or
				(
					NEW.[PPR_TimeDate] Is Not Null And
					OLD.[PPR_TimeDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_TimeChangedBy]	 column	*/
	If UPDATE([PPR_TimeChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_TimeChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_TimeChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_TimeChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_TimeChangedBy] <>
					OLD.[PPR_TimeChangedBy]
				) Or
				(
					NEW.[PPR_TimeChangedBy] Is Null And
					OLD.[PPR_TimeChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_TimeChangedBy] Is Not Null And
					OLD.[PPR_TimeChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_TimeChangedByID]	 column	*/
	If UPDATE([PPR_TimeChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_TimeChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_TimeChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_TimeChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_TimeChangedByID] <>
					OLD.[PPR_TimeChangedByID]
				) Or
				(
					NEW.[PPR_TimeChangedByID] Is Null And
					OLD.[PPR_TimeChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_TimeChangedByID] Is Not Null And
					OLD.[PPR_TimeChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_RisksDate]	 column	*/
	If UPDATE([PPR_RisksDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_RisksDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_RisksDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_RisksDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_RisksDate] <>
					OLD.[PPR_RisksDate]
				) Or
				(
					NEW.[PPR_RisksDate] Is Null And
					OLD.[PPR_RisksDate] Is Not Null
				) Or
				(
					NEW.[PPR_RisksDate] Is Not Null And
					OLD.[PPR_RisksDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_RisksChangedBy]	 column	*/
	If UPDATE([PPR_RisksChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_RisksChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_RisksChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_RisksChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_RisksChangedBy] <>
					OLD.[PPR_RisksChangedBy]
				) Or
				(
					NEW.[PPR_RisksChangedBy] Is Null And
					OLD.[PPR_RisksChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_RisksChangedBy] Is Not Null And
					OLD.[PPR_RisksChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_RisksChangedByID]	 column	*/
	If UPDATE([PPR_RisksChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_RisksChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_RisksChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_RisksChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_RisksChangedByID] <>
					OLD.[PPR_RisksChangedByID]
				) Or
				(
					NEW.[PPR_RisksChangedByID] Is Null And
					OLD.[PPR_RisksChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_RisksChangedByID] Is Not Null And
					OLD.[PPR_RisksChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_BenefitsDate]	 column	*/
	If UPDATE([PPR_BenefitsDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_BenefitsDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_BenefitsDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_BenefitsDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_BenefitsDate] <>
					OLD.[PPR_BenefitsDate]
				) Or
				(
					NEW.[PPR_BenefitsDate] Is Null And
					OLD.[PPR_BenefitsDate] Is Not Null
				) Or
				(
					NEW.[PPR_BenefitsDate] Is Not Null And
					OLD.[PPR_BenefitsDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_BenefitsChangedBy]	 column	*/
	If UPDATE([PPR_BenefitsChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_BenefitsChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_BenefitsChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_BenefitsChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_BenefitsChangedBy] <>
					OLD.[PPR_BenefitsChangedBy]
				) Or
				(
					NEW.[PPR_BenefitsChangedBy] Is Null And
					OLD.[PPR_BenefitsChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_BenefitsChangedBy] Is Not Null And
					OLD.[PPR_BenefitsChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_BenefitsChangedByID]	 column	*/
	If UPDATE([PPR_BenefitsChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_BenefitsChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_BenefitsChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_BenefitsChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_BenefitsChangedByID] <>
					OLD.[PPR_BenefitsChangedByID]
				) Or
				(
					NEW.[PPR_BenefitsChangedByID] Is Null And
					OLD.[PPR_BenefitsChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_BenefitsChangedByID] Is Not Null And
					OLD.[PPR_BenefitsChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_OverallDate]	 column	*/
	If UPDATE([PPR_OverallDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_OverallDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_OverallDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_OverallDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_OverallDate] <>
					OLD.[PPR_OverallDate]
				) Or
				(
					NEW.[PPR_OverallDate] Is Null And
					OLD.[PPR_OverallDate] Is Not Null
				) Or
				(
					NEW.[PPR_OverallDate] Is Not Null And
					OLD.[PPR_OverallDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_OverallChangedBy]	 column	*/
	If UPDATE([PPR_OverallChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_OverallChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_OverallChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_OverallChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_OverallChangedBy] <>
					OLD.[PPR_OverallChangedBy]
				) Or
				(
					NEW.[PPR_OverallChangedBy] Is Null And
					OLD.[PPR_OverallChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_OverallChangedBy] Is Not Null And
					OLD.[PPR_OverallChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_OverallChangedByID]	 column	*/
	If UPDATE([PPR_OverallChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_OverallChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_OverallChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_OverallChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_OverallChangedByID] <>
					OLD.[PPR_OverallChangedByID]
				) Or
				(
					NEW.[PPR_OverallChangedByID] Is Null And
					OLD.[PPR_OverallChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_OverallChangedByID] Is Not Null And
					OLD.[PPR_OverallChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_Comments]	 column	*/
	If UPDATE([PPR_Comments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_Comments'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_Comments]),
			CONVERT(nvarchar(4000),NEW.[PPR_Comments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_Comments] <>
					OLD.[PPR_Comments]
				) Or
				(
					NEW.[PPR_Comments] Is Null And
					OLD.[PPR_Comments] Is Not Null
				) Or
				(
					NEW.[PPR_Comments] Is Not Null And
					OLD.[PPR_Comments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_CommentsDate]	 column	*/
	If UPDATE([PPR_CommentsDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_CommentsDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PPR_CommentsDate]),
			CONVERT(nvarchar(4000),NEW.[PPR_CommentsDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_CommentsDate] <>
					OLD.[PPR_CommentsDate]
				) Or
				(
					NEW.[PPR_CommentsDate] Is Null And
					OLD.[PPR_CommentsDate] Is Not Null
				) Or
				(
					NEW.[PPR_CommentsDate] Is Not Null And
					OLD.[PPR_CommentsDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_CommentsChangedBy]	 column	*/
	If UPDATE([PPR_CommentsChangedBy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_CommentsChangedBy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PPR_CommentsChangedBy]),
			CONVERT(nvarchar(4000),NEW.[PPR_CommentsChangedBy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_CommentsChangedBy] <>
					OLD.[PPR_CommentsChangedBy]
				) Or
				(
					NEW.[PPR_CommentsChangedBy] Is Null And
					OLD.[PPR_CommentsChangedBy] Is Not Null
				) Or
				(
					NEW.[PPR_CommentsChangedBy] Is Not Null And
					OLD.[PPR_CommentsChangedBy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PPR_CommentsChangedByID]	 column	*/
	If UPDATE([PPR_CommentsChangedByID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PPR_CommentsChangedByID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PPR_CommentsChangedByID]),
			CONVERT(nvarchar(4000),NEW.[PPR_CommentsChangedByID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PPR_CommentsChangedByID] <>
					OLD.[PPR_CommentsChangedByID]
				) Or
				(
					NEW.[PPR_CommentsChangedByID] Is Null And
					OLD.[PPR_CommentsChangedByID] Is Not Null
				) Or
				(
					NEW.[PPR_CommentsChangedByID] Is Not Null And
					OLD.[PPR_CommentsChangedByID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PIRKeymetricTimeStatus]	 column	*/
	If UPDATE([PIRKeymetricTimeStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeymetricTimeStatus'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeymetricTimeStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeymetricTimeStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeymetricTimeStatus] <>
					OLD.[PIRKeymetricTimeStatus]
				) Or
				(
					NEW.[PIRKeymetricTimeStatus] Is Null And
					OLD.[PIRKeymetricTimeStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeymetricTimeStatus] Is Not Null And
					OLD.[PIRKeymetricTimeStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/*	INSERT audit traces For [PIRKeyMetricTimeStatusID]	 column	*/
	If UPDATE([PIRKeyMetricTimeStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricTimeStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricTimeStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricTimeStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricTimeStatusID] <>
					OLD.[PIRKeyMetricTimeStatusID]
				) Or
				(
					NEW.[PIRKeyMetricTimeStatusID] Is Null And
					OLD.[PIRKeyMetricTimeStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricTimeStatusID] Is Not Null And
					OLD.[PIRKeyMetricTimeStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

-- ntext column - not audited
--
-- 	/*	INSERT audit traces For [PIRKeyMetricTimeComments]	 column	*/
-- 	If UPDATE([PIRKeyMetricTimeComments])
-- 	BEGIN
-- 		INSERT
-- 		INTO dbo.AUDIT_LOG_DATA
-- 		(
-- 			AUDIT_LOG_TRANSACTION_ID,
-- 			PRIMARY_KEY_DATA,
-- 			COL_NAME,
-- 			COL_TYPE,
-- 			OLD_VALUE_LONG,
-- 			NEW_VALUE_LONG
-- 		)
-- 		SELECT
-- 			@AUDIT_LOG_TRANSACTION_ID,
--             ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
--                 ''PIRKeyMetricTimeComments'',
-- ''ntext'', 
-- 			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricTimeComments]),
-- 			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricTimeComments])
-- 		FROM deleted OLD Join inserted NEW On
--             (NEW.[InitiativeID] = OLD.[InitiativeID])
-- 			AND (
-- 				(
-- 					NEW.[PIRKeyMetricTimeComments] <>
-- 					OLD.[PIRKeyMetricTimeComments]
-- 				) Or
-- 				(
-- 					NEW.[PIRKeyMetricTimeComments] Is Null And
-- 					OLD.[PIRKeyMetricTimeComments] Is Not Null
-- 				) Or
-- 				(
-- 					NEW.[PIRKeyMetricTimeComments] Is Not Null And
-- 					OLD.[PIRKeyMetricTimeComments] Is Null
-- 				)
-- 				)
-- 		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
-- 	END


	/*	INSERT audit traces For [InPPR]	 column	*/
	If UPDATE([InPPR])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InPPR'',
''char'', 
			CONVERT(nvarchar(4000),OLD.[InPPR]),
			CONVERT(nvarchar(4000),NEW.[InPPR])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InPPR] <>
					OLD.[InPPR]
				) Or
				(
					NEW.[InPPR] Is Null And
					OLD.[InPPR] Is Not Null
				) Or
				(
					NEW.[InPPR] Is Not Null And
					OLD.[InPPR] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End



' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeRisk]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeRisk](
	[InitiativeRiskID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[RiskCategoryID] [int] NULL,
	[RiskCategory] [nvarchar](50) NULL,
	[CalculatedRisk] [decimal](18, 2) NULL,
	[AdjustedRisk] [decimal](18, 2) NULL,
	[EurosAtRisk] [money] NULL,
	[Probability] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeRiskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeDeliverable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeDeliverable](
	[DeliverableID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[Name] [nvarchar](4000) NULL,
	[DueDate] [datetime] NULL,
	[Cost] [money] NULL,
	[AffectedApplications] [nvarchar](200) NULL,
	[PIRCommentary] [nvarchar](4000) NULL,
	[PIRStatus] [nvarchar](50) NULL,
	[PIRStatusID] [int] NULL,
	[PIRActualDate] [datetime] NULL,
 CONSTRAINT [PK_InitiativeDeliverable] PRIMARY KEY CLUSTERED 
(
	[DeliverableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeDeliverable]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeDeliverable]
ON [dbo].[InitiativeDeliverable]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeDeliverable]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.DeliverableID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeDeliverable]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''Name'',
		CONVERT(nvarchar(4000),OLD.[Name])
	FROM deleted OLD
	WHERE
		OLD.[Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''DueDate'',
		CONVERT(nvarchar(4000),OLD.[DueDate])
	FROM deleted OLD
	WHERE
		OLD.[DueDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''Cost'',
		CONVERT(nvarchar(4000),OLD.[Cost])
	FROM deleted OLD
	WHERE
		OLD.[Cost] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''AffectedApplications'',
		CONVERT(nvarchar(4000),OLD.[AffectedApplications])
	FROM deleted OLD
	WHERE
		OLD.[AffectedApplications] Is Not Null


	/* Added 2008-01-29, GMcF, for PIR */
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRCommentary'',
		CONVERT(nvarchar(4000),OLD.[PIRCommentary])
	FROM deleted OLD
	WHERE
		OLD.[PIRCommentary] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRStatus'',
		CONVERT(nvarchar(4000),OLD.[PIRStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRStatus] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRStatusID'',
		CONVERT(nvarchar(4000),OLD.[PIRStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRStatusID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST(OLD.[DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRActualDate'',
		CONVERT(nvarchar(4000),OLD.[PIRActualDate])
	FROM deleted OLD
	WHERE
		OLD.[PIRActualDate] Is Not Null

	/* End of code added 2008-01-29 */



	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeDeliverable]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeDeliverable]
ON [dbo].[InitiativeDeliverable]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.DeliverableID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeDeliverable]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeDeliverable]	*/
	/*	INSERT audit traces For [Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''Name'',
		convert(nvarchar(4000), [Name]) 
	FROM inserted
	WHERE [Name] Is Not Null

	/*	INSERT audit traces For [DueDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''DueDate'',
		convert(nvarchar(4000), [DueDate]) 
	FROM inserted
	WHERE [DueDate] Is Not Null

	/*	INSERT audit traces For [Cost]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''Cost'',
		convert(nvarchar(4000), [Cost]) 
	FROM inserted
	WHERE [Cost] Is Not Null

	/*	INSERT audit traces For [AffectedApplications]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''AffectedApplications'',
		convert(nvarchar(4000), [AffectedApplications]) 
	FROM inserted
	WHERE [AffectedApplications] Is Not Null


	/* Added 2008-01-29, GMcF, for PIR */

	/*	INSERT audit traces For [PIRCommentary]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRCommentary'',
		convert(nvarchar(4000), [PIRCommentary]) 
	FROM inserted
	WHERE [PIRCommentary] Is Not Null

	/*	INSERT audit traces For [PIRStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRStatus'',
		convert(nvarchar(4000), [PIRStatus]) 
	FROM inserted
	WHERE [PIRStatus] Is Not Null

	/*	INSERT audit traces For [PIRStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRStatusID'',
		convert(nvarchar(4000), [PIRStatusID]) 
	FROM inserted
	WHERE [PIRStatusID] Is Not Null

	/*	INSERT audit traces For [PIRActualDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[DeliverableID]=N''''''+CAST([DeliverableID] as nvarchar(4000))+'''''''',
        ''PIRActualDate'',
		convert(nvarchar(4000), [PIRActualDate]) 
	FROM inserted
	WHERE [PIRActualDate] Is Not Null

	/* End of code added 2008-01-29 */



	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeDeliverable]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeDeliverable]
ON [dbo].[InitiativeDeliverable]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.DeliverableID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeDeliverable]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeDeliverable]	*/
	/*	INSERT audit traces For [Name]	 column	*/
	If UPDATE([Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Name]),
			CONVERT(nvarchar(4000),NEW.[Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[Name] <>
					OLD.[Name]
				) Or
				(
					NEW.[Name] Is Null And
					OLD.[Name] Is Not Null
				) Or
				(
					NEW.[Name] Is Not Null And
					OLD.[Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRCommentary]	 column	*/
	If UPDATE([PIRCommentary])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''PIRCommentary'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PIRCommentary]),
			CONVERT(nvarchar(4000),NEW.[PIRCommentary])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[PIRCommentary] <>
					OLD.[PIRCommentary]
				) Or
				(
					NEW.[PIRCommentary] Is Null And
					OLD.[PIRCommentary] Is Not Null
				) Or
				(
					NEW.[PIRCommentary] Is Not Null And
					OLD.[PIRCommentary] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DueDate]	 column	*/
	If UPDATE([DueDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''DueDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[DueDate]),
			CONVERT(nvarchar(4000),NEW.[DueDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[DueDate] <>
					OLD.[DueDate]
				) Or
				(
					NEW.[DueDate] Is Null And
					OLD.[DueDate] Is Not Null
				) Or
				(
					NEW.[DueDate] Is Not Null And
					OLD.[DueDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Cost]	 column	*/
	If UPDATE([Cost])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''Cost'',
''money'', 
			CONVERT(nvarchar(4000),OLD.[Cost]),
			CONVERT(nvarchar(4000),NEW.[Cost])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[Cost] <>
					OLD.[Cost]
				) Or
				(
					NEW.[Cost] Is Null And
					OLD.[Cost] Is Not Null
				) Or
				(
					NEW.[Cost] Is Not Null And
					OLD.[Cost] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AffectedApplications]	 column	*/
	If UPDATE([AffectedApplications])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''AffectedApplications'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[AffectedApplications]),
			CONVERT(nvarchar(4000),NEW.[AffectedApplications])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[AffectedApplications] <>
					OLD.[AffectedApplications]
				) Or
				(
					NEW.[AffectedApplications] Is Null And
					OLD.[AffectedApplications] Is Not Null
				) Or
				(
					NEW.[AffectedApplications] Is Not Null And
					OLD.[AffectedApplications] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	/* Added 2008-01-29, GMcF, for PIR */
/*
	/*	INSERT audit traces For [PIRCommentary]	 column	*/
	If UPDATE([PIRCommentary])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''PIRCommentary'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PIRCommentary]),
			CONVERT(nvarchar(4000),NEW.[PIRCommentary])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[PIRCommentary] <>
					OLD.[PIRCommentary]
				) Or
				(
					NEW.[PIRCommentary] Is Null And
					OLD.[PIRCommentary] Is Not Null
				) Or
				(
					NEW.[PIRCommentary] Is Not Null And
					OLD.[PIRCommentary] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/
	/*	INSERT audit traces For [PIRStatus]	 column	*/
	If UPDATE([PIRStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''PIRStatus'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PIRStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[PIRStatus] <>
					OLD.[PIRStatus]
				) Or
				(
					NEW.[PIRStatus] Is Null And
					OLD.[PIRStatus] Is Not Null
				) Or
				(
					NEW.[PIRStatus] Is Not Null And
					OLD.[PIRStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRStatusID]	 column	*/
	If UPDATE([PIRStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''PIRStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[PIRStatusID] <>
					OLD.[PIRStatusID]
				) Or
				(
					NEW.[PIRStatusID] Is Null And
					OLD.[PIRStatusID] Is Not Null
				) Or
				(
					NEW.[PIRStatusID] Is Not Null And
					OLD.[PIRStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRActualDate]	 column	*/
	If UPDATE([PIRActualDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[DeliverableID]=N''''''+CAST(IsNull(OLD.[DeliverableID], NEW.[DeliverableID]) as nvarchar(4000))+'''''''',
                ''PIRActualDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[PIRActualDate]),
			CONVERT(nvarchar(4000),NEW.[PIRActualDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[DeliverableID] = OLD.[DeliverableID])
			AND (
				(
					NEW.[PIRActualDate] <>
					OLD.[PIRActualDate]
				) Or
				(
					NEW.[PIRActualDate] Is Null And
					OLD.[PIRActualDate] Is Not Null
				) Or
				(
					NEW.[PIRActualDate] Is Not Null And
					OLD.[PIRActualDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/* End of code added 2008-01-29 */



	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeServer](
	[InitiativeServerID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ServerID] [int] NULL,
	[DecommissioningDate] [datetime] NULL,
	[Impact] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeDetailedFunctionalDomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeDetailedFunctionalDomain](
	[InitiativeDetailedFunctionalDomainID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[DetailedFunctionalDomainReferenceID] [int] NOT NULL,
	[DetailedFunctionalDomainDescription] [nvarchar](50) NULL,
	[Allocation] [decimal](9, 2) NOT NULL,
	[Comments] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeDetailedFunctionalDomainID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeSponsorUBRAllocation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeSponsorUBRAllocation](
	[InitiativeSponsorUBRAllocationID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[SponsorID] [int] NULL,
	[UBRCode] [nvarchar](50) NULL,
	[UBRAllocation] [decimal](18, 4) NULL,
	[Percentage] [bit] NULL CONSTRAINT [DF_deleteInitiativeSponsorUBRAllocation_Percentage]  DEFAULT (1)
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeSponsor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeSponsor](
	[InitiativeSponsorID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[SponsorID] [int] NULL,
	[Allocation] [decimal](18, 4) NULL,
	[StoreSponsorLevel] [bit] NULL DEFAULT (1),
PRIMARY KEY CLUSTERED 
(
	[InitiativeSponsorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeSponsorUBRAllocation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeSponsorUBRAllocation](
	[InitiativeSponsorUBRAllocationID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[SponsorID] [int] NULL,
	[UBRCode] [nvarchar](50) NULL,
	[UBRAllocation] [decimal](18, 4) NULL,
	[Percentage] [bit] NULL CONSTRAINT [DF_InitiativeSponsorUBRAllocation_Percentage]  DEFAULT (1)
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeScopeChange]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeScopeChange](
	[InitiativeScopeChangeID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[ScopeChange] [nvarchar](200) NOT NULL,
	[Commentary] [nvarchar](4000) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[StatusID] [int] NOT NULL,
 CONSTRAINT [PK__deleteInitiativeScopeChange] PRIMARY KEY CLUSTERED 
(
	[InitiativeScopeChangeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deleteInitiativeValue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deleteInitiativeValue](
	[InitiativeValueID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[TypeID] [int] NULL,
	[ReferenceID] [int] NULL,
	[PeriodID] [int] NULL,
	[QuarterNo] [int] NULL,
	[Amount] [decimal](19, 6) NULL,
PRIMARY KEY CLUSTERED 
(
	[InitiativeValueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeScopeChange]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeScopeChange](
	[InitiativeScopeChangeID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[ScopeChange] [nvarchar](200) NOT NULL,
	[Commentary] [nvarchar](4000) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[StatusID] [int] NOT NULL,
 CONSTRAINT [PK__InitiativeScopeChange] PRIMARY KEY CLUSTERED 
(
	[InitiativeScopeChangeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeScopeChange]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeScopeChange]
ON [dbo].[InitiativeScopeChange]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeScopeChange]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeScopeChangeID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeScopeChange]	*/

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST(OLD.[InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''ScopeChange'',
		CONVERT(nvarchar(4000),OLD.[ScopeChange])
	FROM deleted OLD
	WHERE
		OLD.[ScopeChange] Is Not Null

/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST(OLD.[InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''Commentary'',
		CONVERT(nvarchar(4000),OLD.[Commentary])
	FROM deleted OLD
	WHERE
		OLD.[Commentary] Is Not Null
*/

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST(OLD.[InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''Status'',
		CONVERT(nvarchar(4000),OLD.[Status])
	FROM deleted OLD
	WHERE
		OLD.[Status] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST(OLD.[InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''StatusID'',
		CONVERT(nvarchar(4000),OLD.[StatusID])
	FROM deleted OLD
	WHERE
		OLD.[StatusID] Is Not Null



	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeScopeChange]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeScopeChange]
ON [dbo].[InitiativeScopeChange]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeScopeChangeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeScopeChange]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeScopeChange]	*/
	/*	INSERT audit traces For [ScopeChange]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST([InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''ScopeChange'',
		convert(nvarchar(4000), [ScopeChange]) 
	FROM inserted
	WHERE [ScopeChange] Is Not Null

	/*	INSERT audit traces For [Commentary]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST([InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''Commentary'',
		convert(nvarchar(4000), [Commentary]) 
	FROM inserted
	WHERE [Commentary] Is Not Null

	/*	INSERT audit traces For [Status]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST([InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''Status'',
		convert(nvarchar(4000), [Status])
	FROM inserted
	WHERE [Status] Is Not Null

	/*	INSERT audit traces For [StatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeScopeChangeID]=N''''''+CAST([InitiativeScopeChangeID] as nvarchar(4000))+'''''''',
        ''StatusID'',
		convert(nvarchar(4000), [StatusID]) 
	FROM inserted
	WHERE [StatusID] Is Not Null



	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeScopeChange]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeScopeChange]
ON [dbo].[InitiativeScopeChange]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeDeliverable]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeScopeChangeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeScopeChange]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeScopeChange]	*/
	/*	INSERT audit traces For [ScopeChange]	 column	*/
	If UPDATE([ScopeChange])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeScopeChangeID]=N''''''+CAST(IsNull(OLD.[InitiativeScopeChangeID], NEW.[InitiativeScopeChangeID]) as nvarchar(4000))+'''''''',
                ''ScopeChange'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ScopeChange]),
			CONVERT(nvarchar(4000),NEW.[ScopeChange])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeScopeChangeID] = OLD.[InitiativeScopeChangeID])
			AND (
				(
					NEW.[ScopeChange] <>
					OLD.[ScopeChange]
				) Or
				(
					NEW.[ScopeChange] Is Null And
					OLD.[ScopeChange] Is Not Null
				) Or
				(
					NEW.[ScopeChange] Is Not Null And
					OLD.[ScopeChange] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Commentary]	 column	*/
	If UPDATE([Commentary])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeScopeChangeID]=N''''''+CAST(IsNull(OLD.[InitiativeScopeChangeID], NEW.[InitiativeScopeChangeID]) as nvarchar(4000))+'''''''',
                ''Commentary'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Commentary]),
			CONVERT(nvarchar(4000),NEW.[Commentary])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeScopeChangeID] = OLD.[InitiativeScopeChangeID])
			AND (
				(
					NEW.[Commentary] <>
					OLD.[Commentary]
				) Or
				(
					NEW.[Commentary] Is Null And
					OLD.[Commentary] Is Not Null
				) Or
				(
					NEW.[Commentary] Is Not Null And
					OLD.[Commentary] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Status]	 column	*/
	If UPDATE([Status])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeScopeChangeID]=N''''''+CAST(IsNull(OLD.[InitiativeScopeChangeID], NEW.[InitiativeScopeChangeID]) as nvarchar(4000))+'''''''',
                ''Status'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Status]),
			CONVERT(nvarchar(4000),NEW.[Status])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeScopeChangeID] = OLD.[InitiativeScopeChangeID])
			AND (
				(
					NEW.[Status] <>
					OLD.[Status]
				) Or
				(
					NEW.[Status] Is Null And
					OLD.[Status] Is Not Null
				) Or
				(
					NEW.[Status] Is Not Null And
					OLD.[Status] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [StatusID]	 column	*/
	If UPDATE([StatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeScopeChangeID]=N''''''+CAST(IsNull(OLD.[InitiativeScopeChangeID], NEW.[InitiativeScopeChangeID]) as nvarchar(4000))+'''''''',
                ''StatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[StatusID]),
			CONVERT(nvarchar(4000),NEW.[StatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeScopeChangeID] = OLD.[InitiativeScopeChangeID])
			AND (
				(
					NEW.[StatusID] <>
					OLD.[StatusID]
				) Or
				(
					NEW.[StatusID] Is Null And
					OLD.[StatusID] Is Not Null
				) Or
				(
					NEW.[StatusID] Is Not Null And
					OLD.[StatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END



	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End


' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FinancialCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FinancialCategory](
	[CategoryID] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
	[ReportingCategory] [nvarchar](50) NULL,
	[ReportingCategoryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReferenceCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReferenceCategory](
	[CategoryID] [int] NOT NULL,
	[Description] [nvarchar](75) NULL,
	[IsEditable] [bit] NOT NULL CONSTRAINT [DF__Reference__IsEdi__7928F116]  DEFAULT (1),
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Initiative]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Initiative](
	[ExternalUniqueIdentifier] [uniqueidentifier] NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[IGBusinessAreaCode] [nvarchar](10) NULL,
	[IGIdentifierCode] [nvarchar](10) NULL,
	[IGVersionNumber] [int] NULL,
	[IGReviewDate] [datetime] NULL,
	[IGIdentifier] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[InvestmentTier] [nvarchar](50) NULL,
	[InvestmentTierID] [int] NULL,
	[PrimarySponsoringArea] [nvarchar](50) NULL,
	[OtherSponsoringAreas] [nvarchar](50) NULL,
	[BusinessSponsorName] [nvarchar](50) NULL,
	[BusinessSponsorID] [int] NULL,
	[BusinessInitiativeManager] [nvarchar](50) NULL,
	[BusinessInitiativeManagerID] [int] NULL,
	[GTOManagingBusinessArea] [nvarchar](50) NULL,
	[GTOInitiativeManager] [nvarchar](50) NULL,
	[GTOInitiativeManagerID] [int] NULL,
	[FunctionalDomain] [nvarchar](50) NULL,
	[FunctionalDomainID] [int] NULL,
	[SecondaryFunctionalDomain] [nvarchar](50) NULL,
	[SecondaryFunctionalDomainID] [int] NULL,
	[MajorApplicationName] [nvarchar](50) NULL,
	[MajorApplicationID] [int] NULL,
	[InitiativeBusinessDrivers] [ntext] NULL,
	[InitiativeScopeAndObjectives] [ntext] NULL,
	[InitiativeBenefitCalculation] [ntext] NULL,
	[StrategicInitiativeInterfaces] [ntext] NULL,
	[SmartsourcingComponent] [ntext] NULL,
	[ArchitecturalCompliance] [ntext] NULL,
	[ArchitecturalComplianceType] [nvarchar](50) NULL,
	[ArchitecturalComplianceTypeID] [int] NULL,
	[AllocationsAgreed] [nvarchar](50) NULL,
	[AllocationsAgreedID] [int] NULL,
	[InitiativeBudgeted] [nvarchar](50) NULL,
	[InitiativeBudgetedID] [int] NULL,
	[PayBackPeriod] [nvarchar](50) NULL,
	[PayBackPeriodID] [int] NULL,
	[CompletionDate] [nvarchar](50) NULL,
	[CompletionDateID] [int] NULL,
	[RTBAdditionalConsumption] [nvarchar](50) NULL,
	[RTBAdditionalConsumptionID] [int] NULL,
	[ImpactOfNotDoingThisInvestment] [ntext] NULL,
	[ShutdownComments] [ntext] NULL,
	[KeyPerformanceIndicators] [ntext] NULL,
	[BenefitCalculation] [ntext] NULL,
	[IESArchitectureApproverID] [int] NULL,
	[IESArchitectureApprover] [nvarchar](50) NULL,
	[IESArchitectureApprovalDate] [datetime] NULL,
	[IESFullyCompliantID] [int] NULL,
	[IESFullyCompliant] [nvarchar](50) NULL,
	[IESFinancialJustification] [ntext] NULL,
	[CIOArchitectureApproverID] [int] NULL,
	[CIOArchitectureApprover] [nvarchar](50) NULL,
	[CIOArchitectureApprovalDate] [datetime] NULL,
	[UsesApproved3rdPartySoftwareID] [int] NULL,
	[UsesApproved3rdPartySoftware] [nvarchar](50) NULL,
	[TechnicalArchitectureCompliantID] [int] NULL,
	[TechnicalArchitectureCompliant] [nvarchar](50) NULL,
	[BusinessArchitectureInfoProvidedID] [int] NULL,
	[BusinessArchitectureInfoProvided] [nvarchar](50) NULL,
	[ApplicationArchitetureCompliantID] [int] NULL,
	[ApplicationArchitetureCompliant] [nvarchar](50) NULL,
	[TechnicalArchitectureSatisfiedID] [int] NULL,
	[TechnicalArchitectureSatisfied] [nvarchar](50) NULL,
	[DevelopmentArchitectureCompliantID] [int] NULL,
	[DevelopmentArchitectureCompliant] [nvarchar](50) NULL,
	[GTOJustification4Deviation] [ntext] NULL,
	[RisksIssuesDeps] [ntext] NULL,
	[OverallIGComment] [ntext] NULL,
	[IGApprovalCommittee] [nvarchar](50) NULL,
	[IGApprovalCommitteeID] [int] NULL,
	[IGApprovalDate] [datetime] NULL,
	[IGApprovalStatus] [nvarchar](50) NULL,
	[IGApprovalStatusID] [int] NULL,
	[InitiativeImpactCategory] [nvarchar](50) NULL,
	[InitiativeImpactCategoryID] [int] NULL,
	[InitiativeGTOReviewLevel] [nvarchar](50) NULL,
	[InitiativeGTOReviewLevelID] [int] NULL,
	[AlignedToBusinessStrategy] [nvarchar](50) NULL,
	[AlignedToBusinessStrategyID] [int] NULL,
	[FirstTimeInitiative] [nvarchar](50) NULL,
	[FirstTimeInitiativeID] [int] NULL,
	[NonDuplication] [nvarchar](50) NULL,
	[NonDuplicationID] [int] NULL,
	[ActiveUserID] [int] NULL,
	[SecurityID] [int] NULL,
	[SubmissionDate] [datetime] NULL,
	[BasisForAllocation] [nvarchar](50) NULL,
	[BasisForAllocationID] [int] NULL,
	[BasisForAllocationDescription] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NULL,
	[RegionID] [int] NULL,
	[TechnologyFunction] [nvarchar](50) NULL,
	[TechnologyFunctionID] [int] NULL,
	[MajorApplicationInvestmentStrategy] [nvarchar](50) NULL,
	[PIRFinancialComments] [ntext] NULL,
	[PIRStartDate] [datetime] NULL,
	[PIREndDate] [datetime] NULL,
	[PIRStatus] [nvarchar](50) NULL,
	[PIRStatusID] [int] NULL,
	[PIRSuccesses] [ntext] NULL,
	[PIRIssues] [ntext] NULL,
	[PIRKeyMetricSpendStatus] [nvarchar](50) NULL,
	[PIRKeyMetricSpendStatusID] [int] NULL,
	[PIRKeyMetricSpendComments] [ntext] NULL,
	[PIRKeyMetricDeliveryStatus] [nvarchar](50) NULL,
	[PIRKeyMetricDeliveryStatusID] [int] NULL,
	[PIRKeyMetricDeliveryComments] [ntext] NULL,
	[PIRKeyMetricImpactStatus] [nvarchar](50) NULL,
	[PIRKeyMetricImpactStatusID] [int] NULL,
	[PIRKeyMetricImpactComments] [ntext] NULL,
	[PIRKeyMetricScopeStatus] [nvarchar](50) NULL,
	[PIRKeyMetricScopeStatusID] [int] NULL,
	[PIRKeyMetricScopeComments] [ntext] NULL,
	[PIRKeyMetricProjManStatus] [nvarchar](50) NULL,
	[PIRKeyMetricProjManStatusID] [int] NULL,
	[PIRKeyMetricProjManComments] [ntext] NULL,
	[PIRKeyMetricRiskManStatus] [nvarchar](50) NULL,
	[PIRKeyMetricRiskManStatusID] [int] NULL,
	[PIRKeyMetricRiskManComments] [ntext] NULL,
	[PIRKeyMetricAlphaStatus] [nvarchar](50) NULL,
	[PIRKeyMetricAlphaStatusID] [int] NULL,
	[PIRKeyMetricAlphaComments] [ntext] NULL,
	[PPR_CostStatus]  AS ([PIRKeyMetricSpendStatus]),
	[PPR_CostStatusId]  AS ([PIRKeyMetricSpendStatusId]),
	[PPR_DeliverablesStatus]  AS ([PIRKeyMetricDeliveryStatus]),
	[PPR_DeliverablesStatusId]  AS ([PIRKeyMetricDeliveryStatusId]),
	[PPR_RisksStatus]  AS ([PIRKeyMetricRiskManStatus]),
	[PPR_RisksStatusId]  AS ([PIRKeyMetricRiskManStatusId]),
	[PPR_BenefitsStatus]  AS ([PIRKeyMetricImpactStatus]),
	[PPR_BenefitsStatusId]  AS ([PIRKeyMetricImpactStatusId]),
	[PrimarySBUID] [int] NULL,
	[PPR_OverallStatus]  AS ([PIRStatus]),
	[PPR_OverallStatusID]  AS ([PIRStatusID]),
	[PrimarySBU]  AS ([PrimarySponsoringArea]),
	[SecondarySBU]  AS ([OtherSponsoringAreas]),
PRIMARY KEY CLUSTERED 
(
	[InitiativeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_Initiative]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_Initiative]
ON [dbo].[Initiative]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[Initiative]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:54 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[Initiative]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[Initiative]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGBusinessAreaCode'',
		CONVERT(nvarchar(4000),OLD.[IGBusinessAreaCode])
	FROM deleted OLD
	WHERE
		OLD.[IGBusinessAreaCode] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGIdentifierCode'',
		CONVERT(nvarchar(4000),OLD.[IGIdentifierCode])
	FROM deleted OLD
	WHERE
		OLD.[IGIdentifierCode] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGVersionNumber'',
		CONVERT(nvarchar(4000),OLD.[IGVersionNumber])
	FROM deleted OLD
	WHERE
		OLD.[IGVersionNumber] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGIdentifier'',
		CONVERT(nvarchar(4000),OLD.[IGIdentifier])
	FROM deleted OLD
	WHERE
		OLD.[IGIdentifier] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Name'',
		CONVERT(nvarchar(4000),OLD.[Name])
	FROM deleted OLD
	WHERE
		OLD.[Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InvestmentTier'',
		CONVERT(nvarchar(4000),OLD.[InvestmentTier])
	FROM deleted OLD
	WHERE
		OLD.[InvestmentTier] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InvestmentTierID'',
		CONVERT(nvarchar(4000),OLD.[InvestmentTierID])
	FROM deleted OLD
	WHERE
		OLD.[InvestmentTierID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PrimarySponsoringArea'',
		CONVERT(nvarchar(4000),OLD.[PrimarySponsoringArea])
	FROM deleted OLD
	WHERE
		OLD.[PrimarySponsoringArea] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''OtherSponsoringAreas'',
		CONVERT(nvarchar(4000),OLD.[OtherSponsoringAreas])
	FROM deleted OLD
	WHERE
		OLD.[OtherSponsoringAreas] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessSponsorName'',
		CONVERT(nvarchar(4000),OLD.[BusinessSponsorName])
	FROM deleted OLD
	WHERE
		OLD.[BusinessSponsorName] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessSponsorID'',
		CONVERT(nvarchar(4000),OLD.[BusinessSponsorID])
	FROM deleted OLD
	WHERE
		OLD.[BusinessSponsorID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessInitiativeManager'',
		CONVERT(nvarchar(4000),OLD.[BusinessInitiativeManager])
	FROM deleted OLD
	WHERE
		OLD.[BusinessInitiativeManager] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessInitiativeManagerID'',
		CONVERT(nvarchar(4000),OLD.[BusinessInitiativeManagerID])
	FROM deleted OLD
	WHERE
		OLD.[BusinessInitiativeManagerID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''Region'',
		CONVERT(nvarchar(4000),OLD.[Region])
	FROM deleted OLD
	WHERE
		OLD.[Region] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''RegionID'',
		CONVERT(nvarchar(4000),OLD.[RegionID])
	FROM deleted OLD
	WHERE
		OLD.[RegionID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOManagingBusinessArea'',
		CONVERT(nvarchar(4000),OLD.[GTOManagingBusinessArea])
	FROM deleted OLD
	WHERE
		OLD.[GTOManagingBusinessArea] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOInitiativeManager'',
		CONVERT(nvarchar(4000),OLD.[GTOInitiativeManager])
	FROM deleted OLD
	WHERE
		OLD.[GTOInitiativeManager] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOInitiativeManagerID'',
		CONVERT(nvarchar(4000),OLD.[GTOInitiativeManagerID])
	FROM deleted OLD
	WHERE
		OLD.[GTOInitiativeManagerID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''FunctionalDomain'',
		CONVERT(nvarchar(4000),OLD.[FunctionalDomain])
	FROM deleted OLD
	WHERE
		OLD.[FunctionalDomain] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''FunctionalDomainID'',
		CONVERT(nvarchar(4000),OLD.[FunctionalDomainID])
	FROM deleted OLD
	WHERE
		OLD.[FunctionalDomainID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''SecondaryFunctionalDomain'',
		CONVERT(nvarchar(4000),OLD.[SecondaryFunctionalDomain])
	FROM deleted OLD
	WHERE
		OLD.[SecondaryFunctionalDomain] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''SecondaryFunctionalDomainID'',
		CONVERT(nvarchar(4000),OLD.[SecondaryFunctionalDomainID])
	FROM deleted OLD
	WHERE
		OLD.[SecondaryFunctionalDomainID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnologyFunction'',
		CONVERT(nvarchar(4000),OLD.[TechnologyFunction])
	FROM deleted OLD
	WHERE
		OLD.[TechnologyFunction] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnologyFunctionID'',
		CONVERT(nvarchar(4000),OLD.[TechnologyFunctionID])
	FROM deleted OLD
	WHERE
		OLD.[TechnologyFunctionID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''MajorApplicationName'',
		CONVERT(nvarchar(4000),OLD.[MajorApplicationName])
	FROM deleted OLD
	WHERE
		OLD.[MajorApplicationName] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''MajorApplicationInvestmentStrategy'',
		CONVERT(nvarchar(4000),OLD.[MajorApplicationInvestmentStrategy])
	FROM deleted OLD
	WHERE
		OLD.[MajorApplicationInvestmentStrategy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''MajorApplicationID'',
		CONVERT(nvarchar(4000),OLD.[MajorApplicationID])
	FROM deleted OLD
	WHERE
		OLD.[MajorApplicationID] Is Not Null







	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ArchitecturalComplianceType'',
		CONVERT(nvarchar(4000),OLD.[ArchitecturalComplianceType])
	FROM deleted OLD
	WHERE
		OLD.[ArchitecturalComplianceType] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ArchitecturalComplianceTypeID'',
		CONVERT(nvarchar(4000),OLD.[ArchitecturalComplianceTypeID])
	FROM deleted OLD
	WHERE
		OLD.[ArchitecturalComplianceTypeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''AllocationsAgreed'',
		CONVERT(nvarchar(4000),OLD.[AllocationsAgreed])
	FROM deleted OLD
	WHERE
		OLD.[AllocationsAgreed] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''AllocationsAgreedID'',
		CONVERT(nvarchar(4000),OLD.[AllocationsAgreedID])
	FROM deleted OLD
	WHERE
		OLD.[AllocationsAgreedID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeBudgeted'',
		CONVERT(nvarchar(4000),OLD.[InitiativeBudgeted])
	FROM deleted OLD
	WHERE
		OLD.[InitiativeBudgeted] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeBudgetedID'',
		CONVERT(nvarchar(4000),OLD.[InitiativeBudgetedID])
	FROM deleted OLD
	WHERE
		OLD.[InitiativeBudgetedID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PayBackPeriod'',
		CONVERT(nvarchar(4000),OLD.[PayBackPeriod])
	FROM deleted OLD
	WHERE
		OLD.[PayBackPeriod] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''PayBackPeriodID'',
		CONVERT(nvarchar(4000),OLD.[PayBackPeriodID])
	FROM deleted OLD
	WHERE
		OLD.[PayBackPeriodID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''CompletionDate'',
		CONVERT(nvarchar(4000),OLD.[CompletionDate])
	FROM deleted OLD
	WHERE
		OLD.[CompletionDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''CompletionDateID'',
		CONVERT(nvarchar(4000),OLD.[CompletionDateID])
	FROM deleted OLD
	WHERE
		OLD.[CompletionDateID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''RTBAdditionalConsumption'',
		CONVERT(nvarchar(4000),OLD.[RTBAdditionalConsumption])
	FROM deleted OLD
	WHERE
		OLD.[RTBAdditionalConsumption] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''RTBAdditionalConsumptionID'',
		CONVERT(nvarchar(4000),OLD.[RTBAdditionalConsumptionID])
	FROM deleted OLD
	WHERE
		OLD.[RTBAdditionalConsumptionID] Is Not Null





	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IESArchitectureApproverID'',
		CONVERT(nvarchar(4000),OLD.[IESArchitectureApproverID])
	FROM deleted OLD
	WHERE
		OLD.[IESArchitectureApproverID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IESArchitectureApprover'',
		CONVERT(nvarchar(4000),OLD.[IESArchitectureApprover])
	FROM deleted OLD
	WHERE
		OLD.[IESArchitectureApprover] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IESArchitectureApprovalDate'',
		CONVERT(nvarchar(4000),OLD.[IESArchitectureApprovalDate])
	FROM deleted OLD
	WHERE
		OLD.[IESArchitectureApprovalDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IESFullyCompliantID'',
		CONVERT(nvarchar(4000),OLD.[IESFullyCompliantID])
	FROM deleted OLD
	WHERE
		OLD.[IESFullyCompliantID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IESFullyCompliant'',
		CONVERT(nvarchar(4000),OLD.[IESFullyCompliant])
	FROM deleted OLD
	WHERE
		OLD.[IESFullyCompliant] Is Not Null


	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''CIOArchitectureApproverID'',
		CONVERT(nvarchar(4000),OLD.[CIOArchitectureApproverID])
	FROM deleted OLD
	WHERE
		OLD.[CIOArchitectureApproverID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
 ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''CIOArchitectureApprover'',
		CONVERT(nvarchar(4000),OLD.[CIOArchitectureApprover])
	FROM deleted OLD
	WHERE
		OLD.[CIOArchitectureApprover] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''CIOArchitectureApprovalDate'',
		CONVERT(nvarchar(4000),OLD.[CIOArchitectureApprovalDate])
	FROM deleted OLD
	WHERE
		OLD.[CIOArchitectureApprovalDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''UsesApproved3rdPartySoftwareID'',
		CONVERT(nvarchar(4000),OLD.[UsesApproved3rdPartySoftwareID])
	FROM deleted OLD
	WHERE
		OLD.[UsesApproved3rdPartySoftwareID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''UsesApproved3rdPartySoftware'',
		CONVERT(nvarchar(4000),OLD.[UsesApproved3rdPartySoftware])
	FROM deleted OLD
	WHERE
		OLD.[UsesApproved3rdPartySoftware] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureCompliantID'',
		CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureCompliantID])
	FROM deleted OLD
	WHERE
		OLD.[TechnicalArchitectureCompliantID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureCompliant'',
		CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureCompliant])
	FROM deleted OLD
	WHERE
		OLD.[TechnicalArchitectureCompliant] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessArchitectureInfoProvidedID'',
		CONVERT(nvarchar(4000),OLD.[BusinessArchitectureInfoProvidedID])
	FROM deleted OLD
	WHERE
		OLD.[BusinessArchitectureInfoProvidedID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessArchitectureInfoProvided'',
		CONVERT(nvarchar(4000),OLD.[BusinessArchitectureInfoProvided])
	FROM deleted OLD
	WHERE
		OLD.[BusinessArchitectureInfoProvided] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ApplicationArchitetureCompliantID'',
		CONVERT(nvarchar(4000),OLD.[ApplicationArchitetureCompliantID])
	FROM deleted OLD
	WHERE
		OLD.[ApplicationArchitetureCompliantID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ApplicationArchitetureCompliant'',
		CONVERT(nvarchar(4000),OLD.[ApplicationArchitetureCompliant])
	FROM deleted OLD
	WHERE
		OLD.[ApplicationArchitetureCompliant] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureSatisfiedID'',
		CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureSatisfiedID])
	FROM deleted OLD
	WHERE
		OLD.[TechnicalArchitectureSatisfiedID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureSatisfied'',
		CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureSatisfied])
	FROM deleted OLD
	WHERE
		OLD.[TechnicalArchitectureSatisfied] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''DevelopmentArchitectureCompliantID'',
		CONVERT(nvarchar(4000),OLD.[DevelopmentArchitectureCompliantID])
	FROM deleted OLD
	WHERE
		OLD.[DevelopmentArchitectureCompliantID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''DevelopmentArchitectureCompliant'',
		CONVERT(nvarchar(4000),OLD.[DevelopmentArchitectureCompliant])
	FROM deleted OLD
	WHERE
		OLD.[DevelopmentArchitectureCompliant] Is Not Null




	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalCommittee'',
		CONVERT(nvarchar(4000),OLD.[IGApprovalCommittee])
	FROM deleted OLD
	WHERE
		OLD.[IGApprovalCommittee] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalCommitteeID'',
		CONVERT(nvarchar(4000),OLD.[IGApprovalCommitteeID])
	FROM deleted OLD
	WHERE
		OLD.[IGApprovalCommitteeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalDate'',
		CONVERT(nvarchar(4000),OLD.[IGApprovalDate])
	FROM deleted OLD
	WHERE
		OLD.[IGApprovalDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalStatus'',
		CONVERT(nvarchar(4000),OLD.[IGApprovalStatus])
	FROM deleted OLD
	WHERE
		OLD.[IGApprovalStatus] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalStatusID'',
		CONVERT(nvarchar(4000),OLD.[IGApprovalStatusID])
	FROM deleted OLD
	WHERE
		OLD.[IGApprovalStatusID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeImpactCategory'',
		CONVERT(nvarchar(4000),OLD.[InitiativeImpactCategory])
	FROM deleted OLD
	WHERE
		OLD.[InitiativeImpactCategory] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeImpactCategoryID'',
		CONVERT(nvarchar(4000),OLD.[InitiativeImpactCategoryID])
	FROM deleted OLD
	WHERE
		OLD.[InitiativeImpactCategoryID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeGTOReviewLevel'',
		CONVERT(nvarchar(4000),OLD.[InitiativeGTOReviewLevel])
	FROM deleted OLD
	WHERE
		OLD.[InitiativeGTOReviewLevel] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeGTOReviewLevelID'',
		CONVERT(nvarchar(4000),OLD.[InitiativeGTOReviewLevelID])
	FROM deleted OLD
	WHERE
		OLD.[InitiativeGTOReviewLevelID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''AlignedToBusinessStrategy'',
		CONVERT(nvarchar(4000),OLD.[AlignedToBusinessStrategy])
	FROM deleted OLD
	WHERE
		OLD.[AlignedToBusinessStrategy] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA

	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''AlignedToBusinessStrategyID'',
		CONVERT(nvarchar(4000),OLD.[AlignedToBusinessStrategyID])
	FROM deleted OLD
	WHERE
		OLD.[AlignedToBusinessStrategyID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''FirstTimeInitiative'',
		CONVERT(nvarchar(4000),OLD.[FirstTimeInitiative])
	FROM deleted OLD
	WHERE
		OLD.[FirstTimeInitiative] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''FirstTimeInitiativeID'',
		CONVERT(nvarchar(4000),OLD.[FirstTimeInitiativeID])
	FROM deleted OLD
	WHERE
		OLD.[FirstTimeInitiativeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''NonDuplication'',
		CONVERT(nvarchar(4000),OLD.[NonDuplication])
	FROM deleted OLD
	WHERE
		OLD.[NonDuplication] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
        ''NonDuplicationID'',
		CONVERT(nvarchar(4000),OLD.[NonDuplicationID])
	FROM deleted OLD
	WHERE
		OLD.[NonDuplicationID] Is Not Null


	-- Added 2008-01-22, GMcF, for PIR

	-- executive summary
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRStatusID] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRStartDate])
	FROM deleted OLD
	WHERE
		OLD.[PIRStartDate] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIREndDate])
	FROM deleted OLD
	WHERE
		OLD.[PIREndDate] Is Not Null

/*	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRSuccesses])
	FROM deleted OLD
	WHERE
		OLD.[PIRSuccesses] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRIssues])
	FROM deleted OLD
	WHERE
		OLD.[PIRIssues] Is Not Null
*/
	
	-- financial comments
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRFinancialComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRFinancialComments] Is Not Null
*/

	-- key metrics
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricSpendStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricSpendStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricSpendStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricSpendStatusID] Is Not Null
	
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricSpendComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricSpendComments] Is Not Null
*/
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricDeliveryStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricDeliveryStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricDeliveryStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricDeliveryStatusID] Is Not Null

/*	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricDeliveryComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricDeliveryComments] Is Not Null
*/
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricImpactStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricImpactStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricImpactStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricImpactStatusID] Is Not Null

/*	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricImpactComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricImpactComments] Is Not Null
*/
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricScopeStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricScopeStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricScopeStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricScopeStatusID] Is Not Null

/*	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricScopeComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricScopeComments] Is Not Null
*/
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricProjManStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricProjManStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricProjManStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricProjManStatusID] Is Not Null

/*	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricProjManComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricProjManComments] Is Not Null
*/
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricRiskManStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricRiskManStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricRiskManStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricRiskManStatusID] Is Not Null
	
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricRiskManComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricRiskManComments] Is Not Null
*/
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaStatus])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricAlphaStatus] Is Not Null
	
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricAlphaStatusID] Is Not Null
	
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaComments])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricAlphaComments] Is Not Null
*/

	-- End of code added 2008-01-22, GMcF, for PIR


	-- Added 2008-05-09, GMcF, for Phase 2.1 - Programme Performance Reporting
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		''[InitiativeID]=N''''''+CAST(OLD.[InitiativeID] as nvarchar(4000))+'''''''',
		'''',
		CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaStatusID])
	FROM deleted OLD
	WHERE
		OLD.[PIRKeyMetricAlphaStatusID] Is Not Null
	-- End of code added 2008-05-09


	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
  SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

END


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_Initiative]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_Initiative]
ON [dbo].[Initiative]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[Initiative]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:53 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[Initiative]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[Initiative]	*/
	/*	INSERT audit traces For [IGBusinessAreaCode]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGBusinessAreaCode'',
		convert(nvarchar(4000), [IGBusinessAreaCode]) 
	FROM inserted
	WHERE [IGBusinessAreaCode] Is Not Null

	/*	INSERT audit traces For [IGIdentifierCode]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGIdentifierCode'',
		convert(nvarchar(4000), [IGIdentifierCode]) 
	FROM inserted
	WHERE [IGIdentifierCode] Is Not Null

	/*	INSERT audit traces For [IGVersionNumber]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGVersionNumber'',
		convert(nvarchar(4000), [IGVersionNumber]) 
	FROM inserted
	WHERE [IGVersionNumber] Is Not Null

	/*	INSERT audit traces For [IGIdentifier]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGIdentifier'',
		convert(nvarchar(4000), [IGIdentifier]) 
	FROM inserted
	WHERE [IGIdentifier] Is Not Null

	/*	INSERT audit traces For [Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Name'',
		convert(nvarchar(4000), [Name]) 
	FROM inserted
	WHERE [Name] Is Not Null

	/*	INSERT audit traces For [InvestmentTier]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InvestmentTier'',
		convert(nvarchar(4000), [InvestmentTier]) 
	FROM inserted
	WHERE [InvestmentTier] Is Not Null

	/*	INSERT audit traces For [InvestmentTierID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InvestmentTierID'',
		convert(nvarchar(4000), [InvestmentTierID]) 
	FROM inserted
	WHERE [InvestmentTierID] Is Not Null

	/*	INSERT audit traces For [PrimarySponsoringArea]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PrimarySponsoringArea'',
		convert(nvarchar(4000), [PrimarySponsoringArea]) 
	FROM inserted
	WHERE [PrimarySponsoringArea] Is Not Null

	/*	INSERT audit traces For [OtherSponsoringAreas]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''OtherSponsoringAreas'',
		convert(nvarchar(4000), [OtherSponsoringAreas]) 
	FROM inserted
	WHERE [OtherSponsoringAreas] Is Not Null

	/*	INSERT audit traces For [BusinessSponsorName]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessSponsorName'',
		convert(nvarchar(4000), [BusinessSponsorName]) 
	FROM inserted
	WHERE [BusinessSponsorName] Is Not Null

	/*	INSERT audit traces For [BusinessSponsorID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessSponsorID'',
		convert(nvarchar(4000), [BusinessSponsorID]) 
	FROM inserted
	WHERE [BusinessSponsorID] Is Not Null

	/*	INSERT audit traces For [BusinessInitiativeManager]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessInitiativeManager'',
		convert(nvarchar(4000), [BusinessInitiativeManager]) 
	FROM inserted
	WHERE [BusinessInitiativeManager] Is Not Null

	/*	INSERT audit traces For [BusinessInitiativeManagerID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessInitiativeManagerID'',
		convert(nvarchar(4000), [BusinessInitiativeManagerID]) 
	FROM inserted
	WHERE [BusinessInitiativeManagerID] Is Not Null

	/*	INSERT audit traces For [Region]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''Region'',
		convert(nvarchar(4000), [Region]) 
	FROM inserted
	WHERE [Region] Is Not Null

	/*	INSERT audit traces For [RegionID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''RegionID'',
		convert(nvarchar(4000), [RegionID]) 
	FROM inserted
	WHERE [RegionID] Is Not Null

	/*	INSERT audit traces For [GTOManagingBusinessArea]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOManagingBusinessArea'',
		convert(nvarchar(4000), [GTOManagingBusinessArea]) 
	FROM inserted
	WHERE [GTOManagingBusinessArea] Is Not Null

	/*	INSERT audit traces For [GTOInitiativeManager]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOInitiativeManager'',
		convert(nvarchar(4000), [GTOInitiativeManager]) 
	FROM inserted
	WHERE [GTOInitiativeManager] Is Not Null

	/*	INSERT audit traces For [GTOInitiativeManagerID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOInitiativeManagerID'',
		convert(nvarchar(4000), [GTOInitiativeManagerID]) 
	FROM inserted
	WHERE [GTOInitiativeManagerID] Is Not Null

	/*	INSERT audit traces For [FunctionalDomain]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''FunctionalDomain'',
		convert(nvarchar(4000), [FunctionalDomain]) 
	FROM inserted
	WHERE [FunctionalDomain] Is Not Null

	/*	INSERT audit traces For [FunctionalDomainID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''FunctionalDomainID'',
		convert(nvarchar(4000), [FunctionalDomainID]) 
	FROM inserted
	WHERE [FunctionalDomainID] Is Not Null

	/*	INSERT audit traces For [SecondaryFunctionalDomain]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''SecondaryFunctionalDomain'',
		convert(nvarchar(4000), [SecondaryFunctionalDomain]) 
	FROM inserted
	WHERE [SecondaryFunctionalDomain] Is Not Null

	/*	INSERT audit traces For [SecondaryFunctionalDomainID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''SecondaryFunctionalDomainID'',
		convert(nvarchar(4000), [SecondaryFunctionalDomainID]) 
	FROM inserted
	WHERE [SecondaryFunctionalDomainID] Is Not Null

	/*	INSERT audit traces For [TechnologyFunction]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnologyFunction'',
		convert(nvarchar(4000), [TechnologyFunction]) 
	FROM inserted
	WHERE [TechnologyFunction] Is Not Null

	/*	INSERT audit traces For [TechnologyFunctionID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnologyFunctionID'',
		convert(nvarchar(4000), [TechnologyFunctionID]) 
	FROM inserted
	WHERE [TechnologyFunctionID] Is Not Null

	/*	INSERT audit traces For [MajorApplicationName]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''MajorApplicationName'',
		convert(nvarchar(4000), [MajorApplicationName]) 
	FROM inserted
	WHERE [MajorApplicationName] Is Not Null

	/*	INSERT audit traces For [MajorApplicationInvestmentStrategy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''MajorApplicationInvestmentStrategy'',
		convert(nvarchar(4000), [MajorApplicationInvestmentStrategy]) 
	FROM inserted
	WHERE [MajorApplicationInvestmentStrategy] Is Not Null

	/*	INSERT audit traces For [MajorApplicationID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''MajorApplicationID'',
		convert(nvarchar(4000), [MajorApplicationID]) 
	FROM inserted
	WHERE [MajorApplicationID] Is Not Null

	/*	INSERT audit traces For [InitiativeBusinessDrivers]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeBusinessDrivers'',
			ORD.[InitiativeBusinessDrivers]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[InitiativeBusinessDrivers] Is Not Null


	/*	INSERT audit traces For [InitiativeScopeAndObjectives]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeScopeAndObjectives'',
			ORD.[InitiativeScopeAndObjectives]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[InitiativeScopeAndObjectives] Is Not Null


	/*	INSERT audit traces For [InitiativeBenefitCalculation]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeBenefitCalculation'',
			ORD.[InitiativeBenefitCalculation]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[InitiativeBenefitCalculation] Is Not Null


	/*	INSERT audit traces For [StrategicInitiativeInterfaces]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''StrategicInitiativeInterfaces'',
			ORD.[StrategicInitiativeInterfaces]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[StrategicInitiativeInterfaces] Is Not Null


	/*	INSERT audit traces For [SmartsourcingComponent]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''SmartsourcingComponent'',
			ORD.[SmartsourcingComponent]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[SmartsourcingComponent] Is Not Null


	/*	INSERT audit traces For [ArchitecturalCompliance]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ArchitecturalCompliance'',
			ORD.[ArchitecturalCompliance]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[ArchitecturalCompliance] Is Not Null


	/*	INSERT audit traces For [ArchitecturalComplianceType]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''ArchitecturalComplianceType'',
		convert(nvarchar(4000), [ArchitecturalComplianceType]) 
	FROM inserted
	WHERE [ArchitecturalComplianceType] Is Not Null

	/*	INSERT audit traces For [ArchitecturalComplianceTypeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''ArchitecturalComplianceTypeID'',
		convert(nvarchar(4000), [ArchitecturalComplianceTypeID]) 
	FROM inserted
	WHERE [ArchitecturalComplianceTypeID] Is Not Null

	/*	INSERT audit traces For [AllocationsAgreed]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''AllocationsAgreed'',
		convert(nvarchar(4000), [AllocationsAgreed]) 
	FROM inserted
	WHERE [AllocationsAgreed] Is Not Null

	/*	INSERT audit traces For [AllocationsAgreedID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''AllocationsAgreedID'',
		convert(nvarchar(4000), [AllocationsAgreedID]) 
	FROM inserted
	WHERE [AllocationsAgreedID] Is Not Null

	/*	INSERT audit traces For [InitiativeBudgeted]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeBudgeted'',
		convert(nvarchar(4000), [InitiativeBudgeted]) 
	FROM inserted
	WHERE [InitiativeBudgeted] Is Not Null

	/*	INSERT audit traces For [InitiativeBudgetedID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeBudgetedID'',
		convert(nvarchar(4000), [InitiativeBudgetedID]) 
	FROM inserted
	WHERE [InitiativeBudgetedID] Is Not Null

	/*	INSERT audit traces For [PayBackPeriod]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PayBackPeriod'',
		convert(nvarchar(4000), [PayBackPeriod]) 
	FROM inserted
	WHERE [PayBackPeriod] Is Not Null

	/*	INSERT audit traces For [PayBackPeriodID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PayBackPeriodID'',
		convert(nvarchar(4000), [PayBackPeriodID]) 
	FROM inserted
	WHERE [PayBackPeriodID] Is Not Null

	/*	INSERT audit traces For [CompletionDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''CompletionDate'',
		convert(nvarchar(4000), [CompletionDate]) 
	FROM inserted
	WHERE [CompletionDate] Is Not Null

	/*	INSERT audit traces For [CompletionDateID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''CompletionDateID'',
		convert(nvarchar(4000), [CompletionDateID]) 
	FROM inserted
	WHERE [CompletionDateID] Is Not Null

	/*	INSERT audit traces For [RTBAdditionalConsumption]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''RTBAdditionalConsumption'',
		convert(nvarchar(4000), [RTBAdditionalConsumption]) 
	FROM inserted
	WHERE [RTBAdditionalConsumption] Is Not Null

	/*	INSERT audit traces For [RTBAdditionalConsumptionID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''RTBAdditionalConsumptionID'',
		convert(nvarchar(4000), [RTBAdditionalConsumptionID]) 
	FROM inserted
	WHERE [RTBAdditionalConsumptionID] Is Not Null

	/*	INSERT audit traces For [ImpactOfNotDoingThisInvestment]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ImpactOfNotDoingThisInvestment'',
			ORD.[ImpactOfNotDoingThisInvestment]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[ImpactOfNotDoingThisInvestment] Is Not Null


	/*	INSERT audit traces For [ShutdownComments]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''ShutdownComments'',
			ORD.[ShutdownComments]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[ShutdownComments] Is Not Null


	/*	INSERT audit traces For [KeyPerformanceIndicators]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''KeyPerformanceIndicators'',
			ORD.[KeyPerformanceIndicators]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[KeyPerformanceIndicators] Is Not Null


	/*	INSERT audit traces For [BenefitCalculation]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''BenefitCalculation'',
			ORD.[BenefitCalculation]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[BenefitCalculation] Is Not Null


	/*	INSERT audit traces For [IESArchitectureApproverID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IESArchitectureApproverID'',
		convert(nvarchar(4000), [IESArchitectureApproverID]) 
	FROM inserted
	WHERE [IESArchitectureApproverID] Is Not Null

	/*	INSERT audit traces For [IESArchitectureApprover]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IESArchitectureApprover'',
		convert(nvarchar(4000), [IESArchitectureApprover]) 
	FROM inserted
	WHERE [IESArchitectureApprover] Is Not Null

	/*	INSERT audit traces For [IESArchitectureApprovalDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IESArchitectureApprovalDate'',
		convert(nvarchar(4000), [IESArchitectureApprovalDate]) 
	FROM inserted
	WHERE [IESArchitectureApprovalDate] Is Not Null

	/*	INSERT audit traces For [IESFullyCompliantID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IESFullyCompliantID'',
		convert(nvarchar(4000), [IESFullyCompliantID]) 
	FROM inserted
	WHERE [IESFullyCompliantID] Is Not Null

	/*	INSERT audit traces For [IESFullyCompliant]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IESFullyCompliant'',
		convert(nvarchar(4000), [IESFullyCompliant]) 
	FROM inserted
	WHERE [IESFullyCompliant] Is Not Null

	/*	INSERT audit traces For [IESFinancialJustification]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''IESFinancialJustification'',
			ORD.[IESFinancialJustification]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[IESFinancialJustification] Is Not Null


	/*	INSERT audit traces For [CIOArchitectureApproverID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''CIOArchitectureApproverID'',
		convert(nvarchar(4000), [CIOArchitectureApproverID]) 
	FROM inserted
	WHERE [CIOArchitectureApproverID] Is Not Null

	/*	INSERT audit traces For [CIOArchitectureApprover]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''CIOArchitectureApprover'',
		convert(nvarchar(4000), [CIOArchitectureApprover]) 
	FROM inserted
	WHERE [CIOArchitectureApprover] Is Not Null

	/*	INSERT audit traces For [CIOArchitectureApprovalDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''CIOArchitectureApprovalDate'',
		convert(nvarchar(4000), [CIOArchitectureApprovalDate]) 
	FROM inserted
	WHERE [CIOArchitectureApprovalDate] Is Not Null

	/*	INSERT audit traces For [UsesApproved3rdPartySoftwareID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''UsesApproved3rdPartySoftwareID'',
		convert(nvarchar(4000), [UsesApproved3rdPartySoftwareID]) 
	FROM inserted
	WHERE [UsesApproved3rdPartySoftwareID] Is Not Null

	/*	INSERT audit traces For [UsesApproved3rdPartySoftware]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''UsesApproved3rdPartySoftware'',
		convert(nvarchar(4000), [UsesApproved3rdPartySoftware]) 
	FROM inserted
	WHERE [UsesApproved3rdPartySoftware] Is Not Null

	/*	INSERT audit traces For [TechnicalArchitectureCompliantID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureCompliantID'',
		convert(nvarchar(4000), [TechnicalArchitectureCompliantID]) 
	FROM inserted
	WHERE [TechnicalArchitectureCompliantID] Is Not Null

	/*	INSERT audit traces For [TechnicalArchitectureCompliant]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureCompliant'',
		convert(nvarchar(4000), [TechnicalArchitectureCompliant]) 
	FROM inserted
	WHERE [TechnicalArchitectureCompliant] Is Not Null

	/*	INSERT audit traces For [BusinessArchitectureInfoProvidedID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessArchitectureInfoProvidedID'',
		convert(nvarchar(4000), [BusinessArchitectureInfoProvidedID]) 
	FROM inserted
	WHERE [BusinessArchitectureInfoProvidedID] Is Not Null

	/*	INSERT audit traces For [BusinessArchitectureInfoProvided]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
 ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''BusinessArchitectureInfoProvided'',
		convert(nvarchar(4000), [BusinessArchitectureInfoProvided]) 
	FROM inserted
	WHERE [BusinessArchitectureInfoProvided] Is Not Null

	/*	INSERT audit traces For [ApplicationArchitetureCompliantID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''ApplicationArchitetureCompliantID'',
		convert(nvarchar(4000), [ApplicationArchitetureCompliantID]) 
	FROM inserted
	WHERE [ApplicationArchitetureCompliantID] Is Not Null

	/*	INSERT audit traces For [ApplicationArchitetureCompliant]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''ApplicationArchitetureCompliant'',
		convert(nvarchar(4000), [ApplicationArchitetureCompliant]) 
	FROM inserted
	WHERE [ApplicationArchitetureCompliant] Is Not Null

	/*	INSERT audit traces For [TechnicalArchitectureSatisfiedID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureSatisfiedID'',
		convert(nvarchar(4000), [TechnicalArchitectureSatisfiedID]) 
	FROM inserted
	WHERE [TechnicalArchitectureSatisfiedID] Is Not Null

	/*	INSERT audit traces For [TechnicalArchitectureSatisfied]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''TechnicalArchitectureSatisfied'',
		convert(nvarchar(4000), [TechnicalArchitectureSatisfied]) 
	FROM inserted
	WHERE [TechnicalArchitectureSatisfied] Is Not Null

	/*	INSERT audit traces For [DevelopmentArchitectureCompliantID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''DevelopmentArchitectureCompliantID'',
		convert(nvarchar(4000), [DevelopmentArchitectureCompliantID]) 
	FROM inserted
	WHERE [DevelopmentArchitectureCompliantID] Is Not Null

	/*	INSERT audit traces For [DevelopmentArchitectureCompliant]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''DevelopmentArchitectureCompliant'',
		convert(nvarchar(4000), [DevelopmentArchitectureCompliant]) 
	FROM inserted
	WHERE [DevelopmentArchitectureCompliant] Is Not Null

	/*	INSERT audit traces For [GTOJustification4Deviation]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''GTOJustification4Deviation'',
			ORD.[GTOJustification4Deviation]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[GTOJustification4Deviation] Is Not Null


	/*	INSERT audit traces For [RisksIssuesDeps]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''RisksIssuesDeps'',
			ORD.[RisksIssuesDeps]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[RisksIssuesDeps] Is Not Null


	/*	INSERT audit traces For [OverallIGComment]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST(NEW.[InitiativeID] as nvarchar(4000))+'''''''',
        ''OverallIGComment'',
			ORD.[OverallIGComment]
		FROM inserted NEW
                INNER JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]		WHERE
			ORD.[OverallIGComment] Is Not Null


	/*	INSERT audit traces For [IGApprovalCommittee]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalCommittee'',
		convert(nvarchar(4000), [IGApprovalCommittee]) 
	FROM inserted
	WHERE [IGApprovalCommittee] Is Not Null

	/*	INSERT audit traces For [IGApprovalCommitteeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalCommitteeID'',
		convert(nvarchar(4000), [IGApprovalCommitteeID]) 
	FROM inserted
	WHERE [IGApprovalCommitteeID] Is Not Null

	/*	INSERT audit traces For [IGApprovalDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalDate'',
		convert(nvarchar(4000), [IGApprovalDate]) 
	FROM inserted
	WHERE [IGApprovalDate] Is Not Null

	/*	INSERT audit traces For [IGApprovalStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalStatus'',
		convert(nvarchar(4000), [IGApprovalStatus]) 
	FROM inserted
	WHERE [IGApprovalStatus] Is Not Null

	/*	INSERT audit traces For [IGApprovalStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''IGApprovalStatusID'',
		convert(nvarchar(4000), [IGApprovalStatusID]) 
	FROM inserted
	WHERE [IGApprovalStatusID] Is Not Null

	/*	INSERT audit traces For [InitiativeImpactCategory]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeImpactCategory'',
		convert(nvarchar(4000), [InitiativeImpactCategory]) 
	FROM inserted
	WHERE [InitiativeImpactCategory] Is Not Null

	/*	INSERT audit traces For [InitiativeImpactCategoryID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeImpactCategoryID'',
		convert(nvarchar(4000), [InitiativeImpactCategoryID]) 
	FROM inserted
	WHERE [InitiativeImpactCategoryID] Is Not Null

	/*	INSERT audit traces For [InitiativeGTOReviewLevel]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeGTOReviewLevel'',
		convert(nvarchar(4000), [InitiativeGTOReviewLevel]) 
	FROM inserted
	WHERE [InitiativeGTOReviewLevel] Is Not Null

	/*	INSERT audit traces For [InitiativeGTOReviewLevelID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''InitiativeGTOReviewLevelID'',
		convert(nvarchar(4000), [InitiativeGTOReviewLevelID]) 
	FROM inserted
	WHERE [InitiativeGTOReviewLevelID] Is Not Null

	/*	INSERT audit traces For [AlignedToBusinessStrategy]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''AlignedToBusinessStrategy'',
		convert(nvarchar(4000), [AlignedToBusinessStrategy]) 
	FROM inserted
	WHERE [AlignedToBusinessStrategy] Is Not Null

	/*	INSERT audit traces For [AlignedToBusinessStrategyID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''AlignedToBusinessStrategyID'',
		convert(nvarchar(4000), [AlignedToBusinessStrategyID]) 
	FROM inserted
	WHERE [AlignedToBusinessStrategyID] Is Not Null

	/*	INSERT audit traces For [FirstTimeInitiative]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''FirstTimeInitiative'',
		convert(nvarchar(4000), [FirstTimeInitiative]) 
	FROM inserted
	WHERE [FirstTimeInitiative] Is Not Null

	/*	INSERT audit traces For [FirstTimeInitiativeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''FirstTimeInitiativeID'',
		convert(nvarchar(4000), [FirstTimeInitiativeID]) 
	FROM inserted
	WHERE [FirstTimeInitiativeID] Is Not Null

	/*	INSERT audit traces For [NonDuplication]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''NonDuplication'',
		convert(nvarchar(4000), [NonDuplication]) 
	FROM inserted
	WHERE [NonDuplication] Is Not Null

	/*	INSERT audit traces For [NonDuplicationID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''NonDuplicationID'',
		convert(nvarchar(4000), [NonDuplicationID]) 
	FROM inserted
	WHERE [NonDuplicationID] Is Not Null

	-- Added 2008-01-22, GMcF, for PIR

	-- executive summary

	/*	INSERT audit traces For [PIRStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRStatus'',
		convert(nvarchar(4000), [PIRStatus]) 
	FROM inserted
	WHERE [PIRStatus] Is Not Null

	/*	INSERT audit traces For [PIRStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRStatusID'',
		convert(nvarchar(4000), [PIRStatusID]) 
	FROM inserted
	WHERE [PIRStatusID] Is Not Null

	/*	INSERT audit traces For [PIRStartDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRStartDate'',
		convert(nvarchar(4000), [PIRStartDate]) 
	FROM inserted
	WHERE [PIRStartDate] Is Not Null

	/*	INSERT audit traces For [PIREndDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIREndDate'',
		convert(nvarchar(4000), [PIREndDate]) 
	FROM inserted
	WHERE [PIREndDate] Is Not Null

	/*	INSERT audit traces For [PIRSuccesses]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRSuccesses'',
		convert(nvarchar(4000), [PIRSuccesses]) 
	FROM inserted
	WHERE [PIRSuccesses] Is Not Null
*/

	/*	INSERT audit traces For [PIRIssues]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRIssues'',
		convert(nvarchar(4000), [PIRIssues]) 
	FROM inserted
	WHERE [PIRIssues] Is Not Null
*/
	-- financial comments

	/*	INSERT audit traces For [PIRFinancialComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRFinancialComments'',
		convert(nvarchar(4000), [PIRFinancialComments]) 
	FROM inserted
	WHERE [PIRFinancialComments] Is Not Null
*/

	-- key metrics

	/*	INSERT audit traces For [PIRKeyMetricSpendStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricSpendStatus'',
		convert(nvarchar(4000), [PIRKeyMetricSpendStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricSpendStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricSpendStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricSpendStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricSpendStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricSpendStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricSpendComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricSpendComments'',
		convert(nvarchar(4000), [PIRKeyMetricSpendComments]) 
	FROM inserted
	WHERE [PIRKeyMetricSpendComments] Is Not Null
*/

	/*	INSERT audit traces For [PIRKeyMetricDeliveryStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricDeliveryStatus'',
		convert(nvarchar(4000), [PIRKeyMetricDeliveryStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricDeliveryStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricDeliveryStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricDeliveryStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricDeliveryStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricDeliveryStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricDeliveryComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricDeliveryComments'',
		convert(nvarchar(4000), [PIRKeyMetricDeliveryComments]) 
	FROM inserted
	WHERE [PIRKeyMetricDeliveryComments] Is Not Null
*/

	/*	INSERT audit traces For [PIRKeyMetricImpactStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricImpactStatus'',
		convert(nvarchar(4000), [PIRKeyMetricImpactStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricImpactStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricImpactStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricImpactStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricImpactStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricImpactStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricImpactComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricImpactComments'',
		convert(nvarchar(4000), [PIRKeyMetricImpactComments]) 
	FROM inserted
	WHERE [PIRKeyMetricImpactComments] Is Not Null
*/

	/*	INSERT audit traces For [PIRKeyMetricScopeStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricScopeStatus'',
		convert(nvarchar(4000), [PIRKeyMetricScopeStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricScopeStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricScopeStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricScopeStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricScopeStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricScopeStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricScopeComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricScopeComments'',
		convert(nvarchar(4000), [PIRKeyMetricScopeComments]) 
	FROM inserted
	WHERE [PIRKeyMetricScopeComments] Is Not Null
*/

	/*	INSERT audit traces For [PIRKeyMetricProjManStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricProjManStatus'',
		convert(nvarchar(4000), [PIRKeyMetricProjManStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricProjManStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricProjManStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricProjManStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricProjManStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricProjManStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricProjManComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricProjManComments'',
		convert(nvarchar(4000), [PIRKeyMetricProjManComments]) 
	FROM inserted
	WHERE [PIRKeyMetricProjManComments] Is Not Null
*/

	/*	INSERT audit traces For [PIRKeyMetricRiskManStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricRiskManStatus'',
		convert(nvarchar(4000), [PIRKeyMetricRiskManStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricRiskManStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricRiskManStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricRiskManStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricRiskManStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricRiskManStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricRiskManComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricRiskManComments'',
		convert(nvarchar(4000), [PIRKeyMetricRiskManComments]) 
	FROM inserted
	WHERE [PIRKeyMetricRiskManComments] Is Not Null
*/

	/*	INSERT audit traces For [PIRKeyMetricAlphaStatus]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricAlphaStatus'',
		convert(nvarchar(4000), [PIRKeyMetricAlphaStatus]) 
	FROM inserted
	WHERE [PIRKeyMetricAlphaStatus] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricAlphaStatusID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricAlphaStatusID'',
		convert(nvarchar(4000), [PIRKeyMetricAlphaStatusID]) 
	FROM inserted
	WHERE [PIRKeyMetricAlphaStatusID] Is Not Null

	/*	INSERT audit traces For [PIRKeyMetricAlphaComments]	 column	*/
/*
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PIRKeyMetricAlphaComments'',
		convert(nvarchar(4000), [PIRKeyMetricAlphaComments]) 
	FROM inserted
	WHERE [PIRKeyMetricAlphaComments] Is Not Null
*/
	-- End of code added 2008-01-22


	-- Added 2008-05-08, GMcF, for Phase 2.1, Programme Performance Reporting
	/*	INSERT audit traces For [PrimarySBUID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeID]=N''''''+CAST([InitiativeID] as nvarchar(4000))+'''''''',
        ''PrimarySBUID'',
		convert(nvarchar(4000), [PrimarySBUID]) 
	FROM inserted
	WHERE [PrimarySBUID] Is Not Null
	-- End of code added 2008-05-08


	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_Initiative]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_Initiative]
ON [dbo].[Initiative]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[Initiative]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:53 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[Initiative]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[Initiative]	*/
	/*	INSERT audit traces For [IGBusinessAreaCode]	 column	*/
	If UPDATE([IGBusinessAreaCode])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGBusinessAreaCode'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IGBusinessAreaCode]),
			CONVERT(nvarchar(4000),NEW.[IGBusinessAreaCode])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGBusinessAreaCode] <>
					OLD.[IGBusinessAreaCode]
				) Or
				(
					NEW.[IGBusinessAreaCode] Is Null And
					OLD.[IGBusinessAreaCode] Is Not Null
				) Or
				(
					NEW.[IGBusinessAreaCode] Is Not Null And
					OLD.[IGBusinessAreaCode] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGIdentifierCode]	 column	*/
	If UPDATE([IGIdentifierCode])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGIdentifierCode'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IGIdentifierCode]),
			CONVERT(nvarchar(4000),NEW.[IGIdentifierCode])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGIdentifierCode] <>
					OLD.[IGIdentifierCode]
				) Or
				(
					NEW.[IGIdentifierCode] Is Null And
					OLD.[IGIdentifierCode] Is Not Null
				) Or
				(
					NEW.[IGIdentifierCode] Is Not Null And
					OLD.[IGIdentifierCode] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGVersionNumber]	 column	*/
	If UPDATE([IGVersionNumber])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGVersionNumber'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[IGVersionNumber]),
			CONVERT(nvarchar(4000),NEW.[IGVersionNumber])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGVersionNumber] <>
					OLD.[IGVersionNumber]
				) Or
				(
					NEW.[IGVersionNumber] Is Null And
					OLD.[IGVersionNumber] Is Not Null
				) Or
				(
					NEW.[IGVersionNumber] Is Not Null And
					OLD.[IGVersionNumber] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGIdentifier]	 column	*/
	If UPDATE([IGIdentifier])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGIdentifier'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IGIdentifier]),
			CONVERT(nvarchar(4000),NEW.[IGIdentifier])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGIdentifier] <>
					OLD.[IGIdentifier]
				) Or
				(
					NEW.[IGIdentifier] Is Null And
					OLD.[IGIdentifier] Is Not Null
				) Or
				(
					NEW.[IGIdentifier] Is Not Null And
					OLD.[IGIdentifier] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Name]	 column	*/
	If UPDATE([Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Name]),
			CONVERT(nvarchar(4000),NEW.[Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Name] <>
					OLD.[Name]
				) Or
				(
					NEW.[Name] Is Null And
					OLD.[Name] Is Not Null
				) Or
				(
					NEW.[Name] Is Not Null And
					OLD.[Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InvestmentTier]	 column	*/
	If UPDATE([InvestmentTier])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InvestmentTier'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[InvestmentTier]),
			CONVERT(nvarchar(4000),NEW.[InvestmentTier])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InvestmentTier] <>
					OLD.[InvestmentTier]
				) Or
				(
					NEW.[InvestmentTier] Is Null And
					OLD.[InvestmentTier] Is Not Null
				) Or
				(
					NEW.[InvestmentTier] Is Not Null And
					OLD.[InvestmentTier] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InvestmentTierID]	 column	*/
	If UPDATE([InvestmentTierID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InvestmentTierID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[InvestmentTierID]),
			CONVERT(nvarchar(4000),NEW.[InvestmentTierID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InvestmentTierID] <>
					OLD.[InvestmentTierID]
				) Or
				(
					NEW.[InvestmentTierID] Is Null And
					OLD.[InvestmentTierID] Is Not Null
				) Or
				(
					NEW.[InvestmentTierID] Is Not Null And
					OLD.[InvestmentTierID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PrimarySponsoringArea]	 column	*/
	If UPDATE([PrimarySponsoringArea])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PrimarySponsoringArea'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PrimarySponsoringArea]),
			CONVERT(nvarchar(4000),NEW.[PrimarySponsoringArea])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PrimarySponsoringArea] <>
					OLD.[PrimarySponsoringArea]
				) Or
				(
					NEW.[PrimarySponsoringArea] Is Null And
					OLD.[PrimarySponsoringArea] Is Not Null
				) Or
				(
					NEW.[PrimarySponsoringArea] Is Not Null And
					OLD.[PrimarySponsoringArea] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [OtherSponsoringAreas]	 column	*/
	If UPDATE([OtherSponsoringAreas])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''OtherSponsoringAreas'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[OtherSponsoringAreas]),
			CONVERT(nvarchar(4000),NEW.[OtherSponsoringAreas])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[OtherSponsoringAreas] <>
					OLD.[OtherSponsoringAreas]
				) Or
				(
					NEW.[OtherSponsoringAreas] Is Null And
					OLD.[OtherSponsoringAreas] Is Not Null
				) Or
				(
					NEW.[OtherSponsoringAreas] Is Not Null And
					OLD.[OtherSponsoringAreas] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessSponsorName]	 column	*/
	If UPDATE([BusinessSponsorName])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BusinessSponsorName'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessSponsorName]),
			CONVERT(nvarchar(4000),NEW.[BusinessSponsorName])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[BusinessSponsorName] <>
					OLD.[BusinessSponsorName]
				) Or
				(
					NEW.[BusinessSponsorName] Is Null And
					OLD.[BusinessSponsorName] Is Not Null
				) Or
				(
					NEW.[BusinessSponsorName] Is Not Null And
					OLD.[BusinessSponsorName] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessSponsorID]	 column	*/
	If UPDATE([BusinessSponsorID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BusinessSponsorID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[BusinessSponsorID]),
			CONVERT(nvarchar(4000),NEW.[BusinessSponsorID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[BusinessSponsorID] <>
					OLD.[BusinessSponsorID]
				) Or
				(
					NEW.[BusinessSponsorID] Is Null And
					OLD.[BusinessSponsorID] Is Not Null
				) Or
				(
					NEW.[BusinessSponsorID] Is Not Null And
					OLD.[BusinessSponsorID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessInitiativeManager]	 column	*/
	If UPDATE([BusinessInitiativeManager])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BusinessInitiativeManager'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessInitiativeManager]),
			CONVERT(nvarchar(4000),NEW.[BusinessInitiativeManager])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[BusinessInitiativeManager] <>
					OLD.[BusinessInitiativeManager]
				) Or
				(
					NEW.[BusinessInitiativeManager] Is Null And
					OLD.[BusinessInitiativeManager] Is Not Null
				) Or
				(
					NEW.[BusinessInitiativeManager] Is Not Null And
					OLD.[BusinessInitiativeManager] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessInitiativeManagerID]	 column	*/
	If UPDATE([BusinessInitiativeManagerID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BusinessInitiativeManagerID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[BusinessInitiativeManagerID]),
			CONVERT(nvarchar(4000),NEW.[BusinessInitiativeManagerID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[BusinessInitiativeManagerID] <>
					OLD.[BusinessInitiativeManagerID]
				) Or
				(
					NEW.[BusinessInitiativeManagerID] Is Null And
					OLD.[BusinessInitiativeManagerID] Is Not Null
				) Or
				(
					NEW.[BusinessInitiativeManagerID] Is Not Null And
					OLD.[BusinessInitiativeManagerID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Region]	 column	*/
	If UPDATE([Region])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''Region'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Region]),
			CONVERT(nvarchar(4000),NEW.[Region])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[Region] <>
					OLD.[Region]
				) Or
				(
					NEW.[Region] Is Null And
					OLD.[Region] Is Not Null
				) Or
				(
					NEW.[Region] Is Not Null And
					OLD.[Region] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [RegionID]	 column	*/
	If UPDATE([RegionID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''RegionID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[RegionID]),
			CONVERT(nvarchar(4000),NEW.[RegionID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[RegionID] <>
					OLD.[RegionID]
				) Or
				(
					NEW.[RegionID] Is Null And
					OLD.[RegionID] Is Not Null
				) Or
				(
					NEW.[RegionID] Is Not Null And
					OLD.[RegionID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [GTOManagingBusinessArea]	 column	*/
	If UPDATE([GTOManagingBusinessArea])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''GTOManagingBusinessArea'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[GTOManagingBusinessArea]),
			CONVERT(nvarchar(4000),NEW.[GTOManagingBusinessArea])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[GTOManagingBusinessArea] <>
					OLD.[GTOManagingBusinessArea]
				) Or
				(
					NEW.[GTOManagingBusinessArea] Is Null And
					OLD.[GTOManagingBusinessArea] Is Not Null
				) Or
				(
					NEW.[GTOManagingBusinessArea] Is Not Null And
					OLD.[GTOManagingBusinessArea] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [GTOInitiativeManager]	 column	*/
	If UPDATE([GTOInitiativeManager])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''GTOInitiativeManager'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[GTOInitiativeManager]),
			CONVERT(nvarchar(4000),NEW.[GTOInitiativeManager])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[GTOInitiativeManager] <>
					OLD.[GTOInitiativeManager]
				) Or
				(
					NEW.[GTOInitiativeManager] Is Null And
					OLD.[GTOInitiativeManager] Is Not Null
				) Or
				(
					NEW.[GTOInitiativeManager] Is Not Null And
					OLD.[GTOInitiativeManager] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [GTOInitiativeManagerID]	 column	*/
	If UPDATE([GTOInitiativeManagerID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''GTOInitiativeManagerID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[GTOInitiativeManagerID]),
			CONVERT(nvarchar(4000),NEW.[GTOInitiativeManagerID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[GTOInitiativeManagerID] <>
					OLD.[GTOInitiativeManagerID]
				) Or
				(
					NEW.[GTOInitiativeManagerID] Is Null And
					OLD.[GTOInitiativeManagerID] Is Not Null
				) Or
				(
					NEW.[GTOInitiativeManagerID] Is Not Null And
					OLD.[GTOInitiativeManagerID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [FunctionalDomain]	 column	*/
	If UPDATE([FunctionalDomain])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''FunctionalDomain'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[FunctionalDomain]),
			CONVERT(nvarchar(4000),NEW.[FunctionalDomain])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[FunctionalDomain] <>
					OLD.[FunctionalDomain]
				) Or
				(
					NEW.[FunctionalDomain] Is Null And
					OLD.[FunctionalDomain] Is Not Null
				) Or
				(
					NEW.[FunctionalDomain] Is Not Null And
					OLD.[FunctionalDomain] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [FunctionalDomainID]	 column	*/
	If UPDATE([FunctionalDomainID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''FunctionalDomainID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[FunctionalDomainID]),
			CONVERT(nvarchar(4000),NEW.[FunctionalDomainID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[FunctionalDomainID] <>
					OLD.[FunctionalDomainID]
				) Or
				(
					NEW.[FunctionalDomainID] Is Null And
					OLD.[FunctionalDomainID] Is Not Null
				) Or
				(
					NEW.[FunctionalDomainID] Is Not Null And
					OLD.[FunctionalDomainID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [SecondaryFunctionalDomain]	 column	*/
	If UPDATE([SecondaryFunctionalDomain])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''SecondaryFunctionalDomain'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[SecondaryFunctionalDomain]),
			CONVERT(nvarchar(4000),NEW.[SecondaryFunctionalDomain])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[SecondaryFunctionalDomain] <>
					OLD.[SecondaryFunctionalDomain]
				) Or
				(
					NEW.[SecondaryFunctionalDomain] Is Null And
					OLD.[SecondaryFunctionalDomain] Is Not Null
				) Or
				(
					NEW.[SecondaryFunctionalDomain] Is Not Null And
					OLD.[SecondaryFunctionalDomain] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [SecondaryFunctionalDomainID]	 column	*/
	If UPDATE([SecondaryFunctionalDomainID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''SecondaryFunctionalDomainID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[SecondaryFunctionalDomainID]),
			CONVERT(nvarchar(4000),NEW.[SecondaryFunctionalDomainID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[SecondaryFunctionalDomainID] <>
					OLD.[SecondaryFunctionalDomainID]
				) Or
				(
					NEW.[SecondaryFunctionalDomainID] Is Null And
					OLD.[SecondaryFunctionalDomainID] Is Not Null
				) Or
				(
					NEW.[SecondaryFunctionalDomainID] Is Not Null And
					OLD.[SecondaryFunctionalDomainID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TechnologyFunction]	 column	*/
	If UPDATE([TechnologyFunction])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''TechnologyFunction'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[TechnologyFunction]),
			CONVERT(nvarchar(4000),NEW.[TechnologyFunction])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[TechnologyFunction] <>
					OLD.[TechnologyFunction]
				) Or
				(
					NEW.[TechnologyFunction] Is Null And
					OLD.[TechnologyFunction] Is Not Null
				) Or
				(
					NEW.[TechnologyFunction] Is Not Null And
					OLD.[TechnologyFunction] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TechnologyFunctionID]	 column	*/
	If UPDATE([TechnologyFunctionID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''TechnologyFunctionID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[TechnologyFunctionID]),
			CONVERT(nvarchar(4000),NEW.[TechnologyFunctionID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[TechnologyFunctionID] <>
					OLD.[TechnologyFunctionID]
				) Or
				(
					NEW.[TechnologyFunctionID] Is Null And
					OLD.[TechnologyFunctionID] Is Not Null
				) Or
				(
					NEW.[TechnologyFunctionID] Is Not Null And
					OLD.[TechnologyFunctionID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [MajorApplicationName]	 column	*/
	If UPDATE([MajorApplicationName])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''MajorApplicationName'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[MajorApplicationName]),
			CONVERT(nvarchar(4000),NEW.[MajorApplicationName])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[MajorApplicationName] <>
					OLD.[MajorApplicationName]
				) Or
				(
					NEW.[MajorApplicationName] Is Null And
					OLD.[MajorApplicationName] Is Not Null
				) Or
				(
					NEW.[MajorApplicationName] Is Not Null And
					OLD.[MajorApplicationName] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [MajorApplicationInvestmentStrategy]	 column	*/
	If UPDATE([MajorApplicationInvestmentStrategy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''MajorApplicationInvestmentStrategy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[MajorApplicationInvestmentStrategy]),
			CONVERT(nvarchar(4000),NEW.[MajorApplicationInvestmentStrategy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[MajorApplicationInvestmentStrategy] <>
					OLD.[MajorApplicationInvestmentStrategy]
				) Or
				(
					NEW.[MajorApplicationInvestmentStrategy] Is Null And
					OLD.[MajorApplicationInvestmentStrategy] Is Not Null
				) Or
				(
					NEW.[MajorApplicationInvestmentStrategy] Is Not Null And
					OLD.[MajorApplicationInvestmentStrategy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [MajorApplicationID]	 column	*/
	If UPDATE([MajorApplicationID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''MajorApplicationID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[MajorApplicationID]),
			CONVERT(nvarchar(4000),NEW.[MajorApplicationID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[MajorApplicationID] <>
					OLD.[MajorApplicationID]
				) Or
				(
					NEW.[MajorApplicationID] Is Null And
					OLD.[MajorApplicationID] Is Not Null
				) Or
				(
					NEW.[MajorApplicationID] Is Not Null And
					OLD.[MajorApplicationID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeBusinessDrivers]	 column	*/
	If UPDATE([InitiativeBusinessDrivers])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeBusinessDrivers'',
''ntext'', 
			ORD.[InitiativeBusinessDrivers]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[InitiativeBusinessDrivers], 0, 1024) <>
					SUBSTRING(ORD.[InitiativeBusinessDrivers], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[InitiativeBusinessDrivers], 0, 1024) Is Null And
					SUBSTRING(ORD.[InitiativeBusinessDrivers], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[InitiativeBusinessDrivers], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[InitiativeBusinessDrivers], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[InitiativeBusinessDrivers] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeScopeAndObjectives]	 column	*/
	If UPDATE([InitiativeScopeAndObjectives])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeScopeAndObjectives'',
''ntext'', 
			ORD.[InitiativeScopeAndObjectives]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[InitiativeScopeAndObjectives], 0, 1024) <>
					SUBSTRING(ORD.[InitiativeScopeAndObjectives], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[InitiativeScopeAndObjectives], 0, 1024) Is Null And
					SUBSTRING(ORD.[InitiativeScopeAndObjectives], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[InitiativeScopeAndObjectives], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[InitiativeScopeAndObjectives], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[InitiativeScopeAndObjectives] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeBenefitCalculation]	 column	*/
	If UPDATE([InitiativeBenefitCalculation])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeBenefitCalculation'',
''ntext'', 
			ORD.[InitiativeBenefitCalculation]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[InitiativeBenefitCalculation], 0, 1024) <>
					SUBSTRING(ORD.[InitiativeBenefitCalculation], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[InitiativeBenefitCalculation], 0, 1024) Is Null And
					SUBSTRING(ORD.[InitiativeBenefitCalculation], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[InitiativeBenefitCalculation], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[InitiativeBenefitCalculation], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[InitiativeBenefitCalculation] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [StrategicInitiativeInterfaces]	 column	*/
	If UPDATE([StrategicInitiativeInterfaces])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''StrategicInitiativeInterfaces'',
''ntext'', 
			ORD.[StrategicInitiativeInterfaces]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[StrategicInitiativeInterfaces], 0, 1024) <>
					SUBSTRING(ORD.[StrategicInitiativeInterfaces], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[StrategicInitiativeInterfaces], 0, 1024) Is Null And
					SUBSTRING(ORD.[StrategicInitiativeInterfaces], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[StrategicInitiativeInterfaces], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[StrategicInitiativeInterfaces], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[StrategicInitiativeInterfaces] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [SmartsourcingComponent]	 column	*/
	If UPDATE([SmartsourcingComponent])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''SmartsourcingComponent'',
''ntext'', 
			ORD.[SmartsourcingComponent]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[SmartsourcingComponent], 0, 1024) <>
					SUBSTRING(ORD.[SmartsourcingComponent], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[SmartsourcingComponent], 0, 1024) Is Null And
					SUBSTRING(ORD.[SmartsourcingComponent], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[SmartsourcingComponent], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[SmartsourcingComponent], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[SmartsourcingComponent] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ArchitecturalCompliance]	 column	*/
	If UPDATE([ArchitecturalCompliance])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ArchitecturalCompliance'',
''ntext'', 
			ORD.[ArchitecturalCompliance]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[ArchitecturalCompliance], 0, 1024) <>
					SUBSTRING(ORD.[ArchitecturalCompliance], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[ArchitecturalCompliance], 0, 1024) Is Null And
					SUBSTRING(ORD.[ArchitecturalCompliance], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[ArchitecturalCompliance], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[ArchitecturalCompliance], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[ArchitecturalCompliance] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ArchitecturalComplianceType]	 column	*/
	If UPDATE([ArchitecturalComplianceType])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ArchitecturalComplianceType'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ArchitecturalComplianceType]),
			CONVERT(nvarchar(4000),NEW.[ArchitecturalComplianceType])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[ArchitecturalComplianceType] <>
					OLD.[ArchitecturalComplianceType]
				) Or
				(
					NEW.[ArchitecturalComplianceType] Is Null And
					OLD.[ArchitecturalComplianceType] Is Not Null
				) Or
				(
					NEW.[ArchitecturalComplianceType] Is Not Null And
					OLD.[ArchitecturalComplianceType] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ArchitecturalComplianceTypeID]	 column	*/
	If UPDATE([ArchitecturalComplianceTypeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ArchitecturalComplianceTypeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ArchitecturalComplianceTypeID]),
			CONVERT(nvarchar(4000),NEW.[ArchitecturalComplianceTypeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[ArchitecturalComplianceTypeID] <>
					OLD.[ArchitecturalComplianceTypeID]
				) Or
				(
					NEW.[ArchitecturalComplianceTypeID] Is Null And
					OLD.[ArchitecturalComplianceTypeID] Is Not Null
				) Or
				(
					NEW.[ArchitecturalComplianceTypeID] Is Not Null And
					OLD.[ArchitecturalComplianceTypeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AllocationsAgreed]	 column	*/
	If UPDATE([AllocationsAgreed])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''AllocationsAgreed'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[AllocationsAgreed]),
			CONVERT(nvarchar(4000),NEW.[AllocationsAgreed])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[AllocationsAgreed] <>
					OLD.[AllocationsAgreed]
				) Or
				(
					NEW.[AllocationsAgreed] Is Null And
					OLD.[AllocationsAgreed] Is Not Null
				) Or
				(
					NEW.[AllocationsAgreed] Is Not Null And
					OLD.[AllocationsAgreed] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AllocationsAgreedID]	 column	*/
	If UPDATE([AllocationsAgreedID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''AllocationsAgreedID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[AllocationsAgreedID]),
			CONVERT(nvarchar(4000),NEW.[AllocationsAgreedID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[AllocationsAgreedID] <>
					OLD.[AllocationsAgreedID]
				) Or
				(
					NEW.[AllocationsAgreedID] Is Null And
					OLD.[AllocationsAgreedID] Is Not Null
				) Or
				(
					NEW.[AllocationsAgreedID] Is Not Null And
					OLD.[AllocationsAgreedID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeBudgeted]	 column	*/
	If UPDATE([InitiativeBudgeted])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeBudgeted'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[InitiativeBudgeted]),
			CONVERT(nvarchar(4000),NEW.[InitiativeBudgeted])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InitiativeBudgeted] <>
					OLD.[InitiativeBudgeted]
				) Or
				(
					NEW.[InitiativeBudgeted] Is Null And
					OLD.[InitiativeBudgeted] Is Not Null
				) Or
				(
					NEW.[InitiativeBudgeted] Is Not Null And
					OLD.[InitiativeBudgeted] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeBudgetedID]	 column	*/
	If UPDATE([InitiativeBudgetedID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeBudgetedID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[InitiativeBudgetedID]),
			CONVERT(nvarchar(4000),NEW.[InitiativeBudgetedID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InitiativeBudgetedID] <>
					OLD.[InitiativeBudgetedID]
				) Or
				(
					NEW.[InitiativeBudgetedID] Is Null And
					OLD.[InitiativeBudgetedID] Is Not Null
				) Or
				(
					NEW.[InitiativeBudgetedID] Is Not Null And
					OLD.[InitiativeBudgetedID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PayBackPeriod]	 column	*/
	If UPDATE([PayBackPeriod])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PayBackPeriod'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[PayBackPeriod]),
			CONVERT(nvarchar(4000),NEW.[PayBackPeriod])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PayBackPeriod] <>
					OLD.[PayBackPeriod]
				) Or
				(
					NEW.[PayBackPeriod] Is Null And
					OLD.[PayBackPeriod] Is Not Null
				) Or
				(
					NEW.[PayBackPeriod] Is Not Null And
					OLD.[PayBackPeriod] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PayBackPeriodID]	 column	*/
	If UPDATE([PayBackPeriodID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PayBackPeriodID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PayBackPeriodID]),
			CONVERT(nvarchar(4000),NEW.[PayBackPeriodID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PayBackPeriodID] <>
					OLD.[PayBackPeriodID]
				) Or
				(
					NEW.[PayBackPeriodID] Is Null And
					OLD.[PayBackPeriodID] Is Not Null
				) Or
				(
					NEW.[PayBackPeriodID] Is Not Null And
					OLD.[PayBackPeriodID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CompletionDate]	 column	*/
	If UPDATE([CompletionDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''CompletionDate'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CompletionDate]),
			CONVERT(nvarchar(4000),NEW.[CompletionDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[CompletionDate] <>
					OLD.[CompletionDate]
				) Or
				(
					NEW.[CompletionDate] Is Null And
					OLD.[CompletionDate] Is Not Null
				) Or
				(
					NEW.[CompletionDate] Is Not Null And
					OLD.[CompletionDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CompletionDateID]	 column	*/
	If UPDATE([CompletionDateID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''CompletionDateID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CompletionDateID]),
			CONVERT(nvarchar(4000),NEW.[CompletionDateID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[CompletionDateID] <>
					OLD.[CompletionDateID]
				) Or
				(
					NEW.[CompletionDateID] Is Null And
					OLD.[CompletionDateID] Is Not Null
				) Or
				(
					NEW.[CompletionDateID] Is Not Null And
					OLD.[CompletionDateID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [RTBAdditionalConsumption]	 column	*/
	If UPDATE([RTBAdditionalConsumption])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''RTBAdditionalConsumption'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[RTBAdditionalConsumption]),
			CONVERT(nvarchar(4000),NEW.[RTBAdditionalConsumption])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[RTBAdditionalConsumption] <>
					OLD.[RTBAdditionalConsumption]
				) Or
				(
					NEW.[RTBAdditionalConsumption] Is Null And
					OLD.[RTBAdditionalConsumption] Is Not Null
				) Or
				(
					NEW.[RTBAdditionalConsumption] Is Not Null And
					OLD.[RTBAdditionalConsumption] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [RTBAdditionalConsumptionID]	 column	*/
	If UPDATE([RTBAdditionalConsumptionID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''RTBAdditionalConsumptionID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[RTBAdditionalConsumptionID]),
			CONVERT(nvarchar(4000),NEW.[RTBAdditionalConsumptionID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[RTBAdditionalConsumptionID] <>
					OLD.[RTBAdditionalConsumptionID]
				) Or
				(
					NEW.[RTBAdditionalConsumptionID] Is Null And
					OLD.[RTBAdditionalConsumptionID] Is Not Null
				) Or
				(
					NEW.[RTBAdditionalConsumptionID] Is Not Null And
					OLD.[RTBAdditionalConsumptionID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ImpactOfNotDoingThisInvestment]	 column	*/
	If UPDATE([ImpactOfNotDoingThisInvestment])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ImpactOfNotDoingThisInvestment'',
''ntext'', 
			ORD.[ImpactOfNotDoingThisInvestment]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[ImpactOfNotDoingThisInvestment], 0, 1024) <>
					SUBSTRING(ORD.[ImpactOfNotDoingThisInvestment], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[ImpactOfNotDoingThisInvestment], 0, 1024) Is Null And
					SUBSTRING(ORD.[ImpactOfNotDoingThisInvestment], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[ImpactOfNotDoingThisInvestment], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[ImpactOfNotDoingThisInvestment], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[ImpactOfNotDoingThisInvestment] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ShutdownComments]	 column	*/
	If UPDATE([ShutdownComments])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ShutdownComments'',
''ntext'', 
			ORD.[ShutdownComments]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[ShutdownComments], 0, 1024) <>
					SUBSTRING(ORD.[ShutdownComments], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[ShutdownComments], 0, 1024) Is Null And
					SUBSTRING(ORD.[ShutdownComments], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[ShutdownComments], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[ShutdownComments], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[ShutdownComments] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [KeyPerformanceIndicators]	 column	*/
	If UPDATE([KeyPerformanceIndicators])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''KeyPerformanceIndicators'',
''ntext'', 
			ORD.[KeyPerformanceIndicators]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[KeyPerformanceIndicators], 0, 1024) <>
					SUBSTRING(ORD.[KeyPerformanceIndicators], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[KeyPerformanceIndicators], 0, 1024) Is Null And
					SUBSTRING(ORD.[KeyPerformanceIndicators], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[KeyPerformanceIndicators], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[KeyPerformanceIndicators], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[KeyPerformanceIndicators] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BenefitCalculation]	 column	*/
	If UPDATE([BenefitCalculation])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BenefitCalculation'',
''ntext'', 
			ORD.[BenefitCalculation]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[BenefitCalculation], 0, 1024) <>
					SUBSTRING(ORD.[BenefitCalculation], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[BenefitCalculation], 0, 1024) Is Null And
					SUBSTRING(ORD.[BenefitCalculation], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[BenefitCalculation], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[BenefitCalculation], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[BenefitCalculation] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IESArchitectureApproverID]	 column	*/
	If UPDATE([IESArchitectureApproverID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IESArchitectureApproverID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[IESArchitectureApproverID]),
			CONVERT(nvarchar(4000),NEW.[IESArchitectureApproverID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IESArchitectureApproverID] <>
					OLD.[IESArchitectureApproverID]
				) Or
				(
					NEW.[IESArchitectureApproverID] Is Null And
					OLD.[IESArchitectureApproverID] Is Not Null
				) Or
				(
					NEW.[IESArchitectureApproverID] Is Not Null And
					OLD.[IESArchitectureApproverID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IESArchitectureApprover]	 column	*/
	If UPDATE([IESArchitectureApprover])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IESArchitectureApprover'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IESArchitectureApprover]),
			CONVERT(nvarchar(4000),NEW.[IESArchitectureApprover])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IESArchitectureApprover] <>
					OLD.[IESArchitectureApprover]
				) Or
				(
					NEW.[IESArchitectureApprover] Is Null And
					OLD.[IESArchitectureApprover] Is Not Null
				) Or
				(
					NEW.[IESArchitectureApprover] Is Not Null And
					OLD.[IESArchitectureApprover] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IESArchitectureApprovalDate]	 column	*/
	If UPDATE([IESArchitectureApprovalDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IESArchitectureApprovalDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[IESArchitectureApprovalDate]),
			CONVERT(nvarchar(4000),NEW.[IESArchitectureApprovalDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IESArchitectureApprovalDate] <>
					OLD.[IESArchitectureApprovalDate]
				) Or
				(
					NEW.[IESArchitectureApprovalDate] Is Null And
					OLD.[IESArchitectureApprovalDate] Is Not Null
				) Or
				(
					NEW.[IESArchitectureApprovalDate] Is Not Null And
					OLD.[IESArchitectureApprovalDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IESFullyCompliantID]	 column	*/
	If UPDATE([IESFullyCompliantID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IESFullyCompliantID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[IESFullyCompliantID]),
			CONVERT(nvarchar(4000),NEW.[IESFullyCompliantID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IESFullyCompliantID] <>
					OLD.[IESFullyCompliantID]
				) Or
				(
					NEW.[IESFullyCompliantID] Is Null And
					OLD.[IESFullyCompliantID] Is Not Null
				) Or
				(
					NEW.[IESFullyCompliantID] Is Not Null And
					OLD.[IESFullyCompliantID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IESFullyCompliant]	 column	*/
	If UPDATE([IESFullyCompliant])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IESFullyCompliant'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IESFullyCompliant]),
			CONVERT(nvarchar(4000),NEW.[IESFullyCompliant])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IESFullyCompliant] <>
					OLD.[IESFullyCompliant]
				) Or
				(
					NEW.[IESFullyCompliant] Is Null And
					OLD.[IESFullyCompliant] Is Not Null
				) Or
				(
					NEW.[IESFullyCompliant] Is Not Null And
					OLD.[IESFullyCompliant] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IESFinancialJustification]	 column	*/
	If UPDATE([IESFinancialJustification])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IESFinancialJustification'',
''ntext'', 
			ORD.[IESFinancialJustification]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[IESFinancialJustification], 0, 1024) <>
					SUBSTRING(ORD.[IESFinancialJustification], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[IESFinancialJustification], 0, 1024) Is Null And
					SUBSTRING(ORD.[IESFinancialJustification], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[IESFinancialJustification], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[IESFinancialJustification], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[IESFinancialJustification] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIOArchitectureApproverID]	 column	*/
	If UPDATE([CIOArchitectureApproverID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''CIOArchitectureApproverID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CIOArchitectureApproverID]),
			CONVERT(nvarchar(4000),NEW.[CIOArchitectureApproverID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[CIOArchitectureApproverID] <>
					OLD.[CIOArchitectureApproverID]
				) Or
				(
					NEW.[CIOArchitectureApproverID] Is Null And
					OLD.[CIOArchitectureApproverID] Is Not Null
				) Or
				(
					NEW.[CIOArchitectureApproverID] Is Not Null And
					OLD.[CIOArchitectureApproverID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIOArchitectureApprover]	 column	*/
	If UPDATE([CIOArchitectureApprover])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''CIOArchitectureApprover'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CIOArchitectureApprover]),
			CONVERT(nvarchar(4000),NEW.[CIOArchitectureApprover])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[CIOArchitectureApprover] <>
					OLD.[CIOArchitectureApprover]
				) Or
				(
					NEW.[CIOArchitectureApprover] Is Null And
					OLD.[CIOArchitectureApprover] Is Not Null
				) Or
				(
					NEW.[CIOArchitectureApprover] Is Not Null And
					OLD.[CIOArchitectureApprover] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIOArchitectureApprovalDate]	 column	*/
	If UPDATE([CIOArchitectureApprovalDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''CIOArchitectureApprovalDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[CIOArchitectureApprovalDate]),
			CONVERT(nvarchar(4000),NEW.[CIOArchitectureApprovalDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[CIOArchitectureApprovalDate] <>
					OLD.[CIOArchitectureApprovalDate]
				) Or
				(
					NEW.[CIOArchitectureApprovalDate] Is Null And
					OLD.[CIOArchitectureApprovalDate] Is Not Null
				) Or
				(
					NEW.[CIOArchitectureApprovalDate] Is Not Null And
					OLD.[CIOArchitectureApprovalDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [UsesApproved3rdPartySoftwareID]	 column	*/
	If UPDATE([UsesApproved3rdPartySoftwareID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''UsesApproved3rdPartySoftwareID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[UsesApproved3rdPartySoftwareID]),
			CONVERT(nvarchar(4000),NEW.[UsesApproved3rdPartySoftwareID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[UsesApproved3rdPartySoftwareID] <>
					OLD.[UsesApproved3rdPartySoftwareID]
				) Or
				(
					NEW.[UsesApproved3rdPartySoftwareID] Is Null And
					OLD.[UsesApproved3rdPartySoftwareID] Is Not Null
				) Or
				(
					NEW.[UsesApproved3rdPartySoftwareID] Is Not Null And
					OLD.[UsesApproved3rdPartySoftwareID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [UsesApproved3rdPartySoftware]	 column	*/
	If UPDATE([UsesApproved3rdPartySoftware])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''UsesApproved3rdPartySoftware'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[UsesApproved3rdPartySoftware]),
			CONVERT(nvarchar(4000),NEW.[UsesApproved3rdPartySoftware])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[UsesApproved3rdPartySoftware] <>
					OLD.[UsesApproved3rdPartySoftware]
				) Or
				(
					NEW.[UsesApproved3rdPartySoftware] Is Null And
					OLD.[UsesApproved3rdPartySoftware] Is Not Null
				) Or
				(
					NEW.[UsesApproved3rdPartySoftware] Is Not Null And
					OLD.[UsesApproved3rdPartySoftware] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TechnicalArchitectureCompliantID]	 column	*/
	If UPDATE([TechnicalArchitectureCompliantID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''TechnicalArchitectureCompliantID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureCompliantID]),
			CONVERT(nvarchar(4000),NEW.[TechnicalArchitectureCompliantID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[TechnicalArchitectureCompliantID] <>
					OLD.[TechnicalArchitectureCompliantID]
				) Or
				(
					NEW.[TechnicalArchitectureCompliantID] Is Null And
					OLD.[TechnicalArchitectureCompliantID] Is Not Null
				) Or
				(
					NEW.[TechnicalArchitectureCompliantID] Is Not Null And
					OLD.[TechnicalArchitectureCompliantID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TechnicalArchitectureCompliant]	 column	*/
	If UPDATE([TechnicalArchitectureCompliant])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''TechnicalArchitectureCompliant'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureCompliant]),
			CONVERT(nvarchar(4000),NEW.[TechnicalArchitectureCompliant])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[TechnicalArchitectureCompliant] <>
					OLD.[TechnicalArchitectureCompliant]
				) Or
				(
					NEW.[TechnicalArchitectureCompliant] Is Null And
					OLD.[TechnicalArchitectureCompliant] Is Not Null
				) Or
				(
					NEW.[TechnicalArchitectureCompliant] Is Not Null And
					OLD.[TechnicalArchitectureCompliant] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessArchitectureInfoProvidedID]	 column	*/
	If UPDATE([BusinessArchitectureInfoProvidedID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BusinessArchitectureInfoProvidedID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[BusinessArchitectureInfoProvidedID]),
			CONVERT(nvarchar(4000),NEW.[BusinessArchitectureInfoProvidedID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[BusinessArchitectureInfoProvidedID] <>
					OLD.[BusinessArchitectureInfoProvidedID]
				) Or
				(
					NEW.[BusinessArchitectureInfoProvidedID] Is Null And
					OLD.[BusinessArchitectureInfoProvidedID] Is Not Null
				) Or
				(
					NEW.[BusinessArchitectureInfoProvidedID] Is Not Null And
					OLD.[BusinessArchitectureInfoProvidedID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessArchitectureInfoProvided]	 column	*/
	If UPDATE([BusinessArchitectureInfoProvided])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''BusinessArchitectureInfoProvided'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessArchitectureInfoProvided]),
			CONVERT(nvarchar(4000),NEW.[BusinessArchitectureInfoProvided])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[BusinessArchitectureInfoProvided] <>
					OLD.[BusinessArchitectureInfoProvided]
				) Or
				(
					NEW.[BusinessArchitectureInfoProvided] Is Null And
					OLD.[BusinessArchitectureInfoProvided] Is Not Null
				) Or
				(
					NEW.[BusinessArchitectureInfoProvided] Is Not Null And
					OLD.[BusinessArchitectureInfoProvided] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ApplicationArchitetureCompliantID]	 column	*/
	If UPDATE([ApplicationArchitetureCompliantID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ApplicationArchitetureCompliantID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ApplicationArchitetureCompliantID]),
			CONVERT(nvarchar(4000),NEW.[ApplicationArchitetureCompliantID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[ApplicationArchitetureCompliantID] <>
					OLD.[ApplicationArchitetureCompliantID]
				) Or
				(
					NEW.[ApplicationArchitetureCompliantID] Is Null And
					OLD.[ApplicationArchitetureCompliantID] Is Not Null
				) Or
				(
					NEW.[ApplicationArchitetureCompliantID] Is Not Null And
					OLD.[ApplicationArchitetureCompliantID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ApplicationArchitetureCompliant]	 column	*/
	If UPDATE([ApplicationArchitetureCompliant])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''ApplicationArchitetureCompliant'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ApplicationArchitetureCompliant]),
			CONVERT(nvarchar(4000),NEW.[ApplicationArchitetureCompliant])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[ApplicationArchitetureCompliant] <>
					OLD.[ApplicationArchitetureCompliant]
				) Or
				(
					NEW.[ApplicationArchitetureCompliant] Is Null And
					OLD.[ApplicationArchitetureCompliant] Is Not Null
				) Or
				(
					NEW.[ApplicationArchitetureCompliant] Is Not Null And
					OLD.[ApplicationArchitetureCompliant] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TechnicalArchitectureSatisfiedID]	 column	*/
	If UPDATE([TechnicalArchitectureSatisfiedID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''TechnicalArchitectureSatisfiedID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureSatisfiedID]),
			CONVERT(nvarchar(4000),NEW.[TechnicalArchitectureSatisfiedID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[TechnicalArchitectureSatisfiedID] <>
					OLD.[TechnicalArchitectureSatisfiedID]
				) Or
				(
					NEW.[TechnicalArchitectureSatisfiedID] Is Null And
					OLD.[TechnicalArchitectureSatisfiedID] Is Not Null
				) Or
				(
					NEW.[TechnicalArchitectureSatisfiedID] Is Not Null And
					OLD.[TechnicalArchitectureSatisfiedID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TechnicalArchitectureSatisfied]	 column	*/
	If UPDATE([TechnicalArchitectureSatisfied])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''TechnicalArchitectureSatisfied'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[TechnicalArchitectureSatisfied]),
			CONVERT(nvarchar(4000),NEW.[TechnicalArchitectureSatisfied])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[TechnicalArchitectureSatisfied] <>
					OLD.[TechnicalArchitectureSatisfied]
				) Or
				(
					NEW.[TechnicalArchitectureSatisfied] Is Null And
					OLD.[TechnicalArchitectureSatisfied] Is Not Null
				) Or
				(
					NEW.[TechnicalArchitectureSatisfied] Is Not Null And
					OLD.[TechnicalArchitectureSatisfied] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DevelopmentArchitectureCompliantID]	 column	*/
	If UPDATE([DevelopmentArchitectureCompliantID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''DevelopmentArchitectureCompliantID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[DevelopmentArchitectureCompliantID]),
			CONVERT(nvarchar(4000),NEW.[DevelopmentArchitectureCompliantID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[DevelopmentArchitectureCompliantID] <>
					OLD.[DevelopmentArchitectureCompliantID]
				) Or
				(
					NEW.[DevelopmentArchitectureCompliantID] Is Null And
					OLD.[DevelopmentArchitectureCompliantID] Is Not Null
				) Or
				(
					NEW.[DevelopmentArchitectureCompliantID] Is Not Null And
					OLD.[DevelopmentArchitectureCompliantID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DevelopmentArchitectureCompliant]	 column	*/
	If UPDATE([DevelopmentArchitectureCompliant])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''DevelopmentArchitectureCompliant'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[DevelopmentArchitectureCompliant]),
			CONVERT(nvarchar(4000),NEW.[DevelopmentArchitectureCompliant])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[DevelopmentArchitectureCompliant] <>
					OLD.[DevelopmentArchitectureCompliant]
				) Or
				(
					NEW.[DevelopmentArchitectureCompliant] Is Null And
					OLD.[DevelopmentArchitectureCompliant] Is Not Null
				) Or
				(
					NEW.[DevelopmentArchitectureCompliant] Is Not Null And
					OLD.[DevelopmentArchitectureCompliant] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [GTOJustification4Deviation]	 column	*/
	If UPDATE([GTOJustification4Deviation])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''GTOJustification4Deviation'',
''ntext'', 
			ORD.[GTOJustification4Deviation]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[GTOJustification4Deviation], 0, 1024) <>
					SUBSTRING(ORD.[GTOJustification4Deviation], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[GTOJustification4Deviation], 0, 1024) Is Null And
					SUBSTRING(ORD.[GTOJustification4Deviation], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[GTOJustification4Deviation], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[GTOJustification4Deviation], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[GTOJustification4Deviation] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [RisksIssuesDeps]	 column	*/
	If UPDATE([RisksIssuesDeps])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''RisksIssuesDeps'',
''ntext'', 
			ORD.[RisksIssuesDeps]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[RisksIssuesDeps], 0, 1024) <>
					SUBSTRING(ORD.[RisksIssuesDeps], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[RisksIssuesDeps], 0, 1024) Is Null And
					SUBSTRING(ORD.[RisksIssuesDeps], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[RisksIssuesDeps], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[RisksIssuesDeps], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[RisksIssuesDeps] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [OverallIGComment]	 column	*/
	If UPDATE([OverallIGComment])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(ORD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''OverallIGComment'',
''ntext'', 
			ORD.[OverallIGComment]
		FROM inserted NEW JOIN [dbo].[Initiative] ORD 
                    ON ORD.[InitiativeID]=NEW.[InitiativeID]
				/*
			AND (
				(
					SUBSTRING(NEW.[OverallIGComment], 0, 1024) <>
					SUBSTRING(ORD.[OverallIGComment], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[OverallIGComment], 0, 1024) Is Null And
					SUBSTRING(ORD.[OverallIGComment], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[OverallIGComment], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[OverallIGComment], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[OverallIGComment] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGApprovalCommittee]	 column	*/
	If UPDATE([IGApprovalCommittee])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGApprovalCommittee'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IGApprovalCommittee]),
			CONVERT(nvarchar(4000),NEW.[IGApprovalCommittee])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGApprovalCommittee] <>
					OLD.[IGApprovalCommittee]
				) Or
				(
					NEW.[IGApprovalCommittee] Is Null And
					OLD.[IGApprovalCommittee] Is Not Null
				) Or
				(
					NEW.[IGApprovalCommittee] Is Not Null And
					OLD.[IGApprovalCommittee] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGApprovalCommitteeID]	 column	*/
	If UPDATE([IGApprovalCommitteeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGApprovalCommitteeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[IGApprovalCommitteeID]),
			CONVERT(nvarchar(4000),NEW.[IGApprovalCommitteeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGApprovalCommitteeID] <>
					OLD.[IGApprovalCommitteeID]
				) Or
				(
					NEW.[IGApprovalCommitteeID] Is Null And
					OLD.[IGApprovalCommitteeID] Is Not Null
				) Or
				(
					NEW.[IGApprovalCommitteeID] Is Not Null And
					OLD.[IGApprovalCommitteeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGApprovalDate]	 column	*/
	If UPDATE([IGApprovalDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGApprovalDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[IGApprovalDate]),
			CONVERT(nvarchar(4000),NEW.[IGApprovalDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGApprovalDate] <>
					OLD.[IGApprovalDate]
				) Or
				(
					NEW.[IGApprovalDate] Is Null And
					OLD.[IGApprovalDate] Is Not Null
				) Or
				(
					NEW.[IGApprovalDate] Is Not Null And
					OLD.[IGApprovalDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGApprovalStatus]	 column	*/
	If UPDATE([IGApprovalStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGApprovalStatus'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[IGApprovalStatus]),
			CONVERT(nvarchar(4000),NEW.[IGApprovalStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGApprovalStatus] <>
					OLD.[IGApprovalStatus]
				) Or
				(
					NEW.[IGApprovalStatus] Is Null And
					OLD.[IGApprovalStatus] Is Not Null
				) Or
				(
					NEW.[IGApprovalStatus] Is Not Null And
					OLD.[IGApprovalStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [IGApprovalStatusID]	 column	*/
	If UPDATE([IGApprovalStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''IGApprovalStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[IGApprovalStatusID]),
			CONVERT(nvarchar(4000),NEW.[IGApprovalStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[IGApprovalStatusID] <>
					OLD.[IGApprovalStatusID]
				) Or
				(
					NEW.[IGApprovalStatusID] Is Null And
					OLD.[IGApprovalStatusID] Is Not Null
				) Or
				(
					NEW.[IGApprovalStatusID] Is Not Null And
					OLD.[IGApprovalStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeImpactCategory]	 column	*/
	If UPDATE([InitiativeImpactCategory])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeImpactCategory'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[InitiativeImpactCategory]),
			CONVERT(nvarchar(4000),NEW.[InitiativeImpactCategory])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InitiativeImpactCategory] <>
					OLD.[InitiativeImpactCategory]
				) Or
				(
					NEW.[InitiativeImpactCategory] Is Null And
					OLD.[InitiativeImpactCategory] Is Not Null
				) Or
				(
					NEW.[InitiativeImpactCategory] Is Not Null And
					OLD.[InitiativeImpactCategory] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeImpactCategoryID]	 column	*/
	If UPDATE([InitiativeImpactCategoryID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeImpactCategoryID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[InitiativeImpactCategoryID]),
			CONVERT(nvarchar(4000),NEW.[InitiativeImpactCategoryID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InitiativeImpactCategoryID] <>
					OLD.[InitiativeImpactCategoryID]
				) Or
				(
					NEW.[InitiativeImpactCategoryID] Is Null And
					OLD.[InitiativeImpactCategoryID] Is Not Null
				) Or
				(
					NEW.[InitiativeImpactCategoryID] Is Not Null And
					OLD.[InitiativeImpactCategoryID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeGTOReviewLevel]	 column	*/
	If UPDATE([InitiativeGTOReviewLevel])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeGTOReviewLevel'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[InitiativeGTOReviewLevel]),
			CONVERT(nvarchar(4000),NEW.[InitiativeGTOReviewLevel])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InitiativeGTOReviewLevel] <>
					OLD.[InitiativeGTOReviewLevel]
				) Or
				(
					NEW.[InitiativeGTOReviewLevel] Is Null And
					OLD.[InitiativeGTOReviewLevel] Is Not Null
				) Or
				(
					NEW.[InitiativeGTOReviewLevel] Is Not Null And
					OLD.[InitiativeGTOReviewLevel] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InitiativeGTOReviewLevelID]	 column	*/
	If UPDATE([InitiativeGTOReviewLevelID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''InitiativeGTOReviewLevelID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[InitiativeGTOReviewLevelID]),
			CONVERT(nvarchar(4000),NEW.[InitiativeGTOReviewLevelID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[InitiativeGTOReviewLevelID] <>
					OLD.[InitiativeGTOReviewLevelID]
				) Or
				(
					NEW.[InitiativeGTOReviewLevelID] Is Null And
					OLD.[InitiativeGTOReviewLevelID] Is Not Null
				) Or
				(
					NEW.[InitiativeGTOReviewLevelID] Is Not Null And
					OLD.[InitiativeGTOReviewLevelID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AlignedToBusinessStrategy]	 column	*/
	If UPDATE([AlignedToBusinessStrategy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''AlignedToBusinessStrategy'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[AlignedToBusinessStrategy]),
			CONVERT(nvarchar(4000),NEW.[AlignedToBusinessStrategy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[AlignedToBusinessStrategy] <>
					OLD.[AlignedToBusinessStrategy]
				) Or
				(
					NEW.[AlignedToBusinessStrategy] Is Null And
					OLD.[AlignedToBusinessStrategy] Is Not Null
				) Or
				(
					NEW.[AlignedToBusinessStrategy] Is Not Null And
					OLD.[AlignedToBusinessStrategy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AlignedToBusinessStrategyID]	 column	*/
	If UPDATE([AlignedToBusinessStrategyID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''AlignedToBusinessStrategyID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[AlignedToBusinessStrategyID]),
			CONVERT(nvarchar(4000),NEW.[AlignedToBusinessStrategyID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[AlignedToBusinessStrategyID] <>
					OLD.[AlignedToBusinessStrategyID]
				) Or
				(
					NEW.[AlignedToBusinessStrategyID] Is Null And
					OLD.[AlignedToBusinessStrategyID] Is Not Null
				) Or
				(
					NEW.[AlignedToBusinessStrategyID] Is Not Null And
					OLD.[AlignedToBusinessStrategyID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [FirstTimeInitiative]	 column	*/
	If UPDATE([FirstTimeInitiative])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''FirstTimeInitiative'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[FirstTimeInitiative]),
			CONVERT(nvarchar(4000),NEW.[FirstTimeInitiative])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[FirstTimeInitiative] <>
					OLD.[FirstTimeInitiative]
				) Or
				(
					NEW.[FirstTimeInitiative] Is Null And
					OLD.[FirstTimeInitiative] Is Not Null
				) Or
				(
					NEW.[FirstTimeInitiative] Is Not Null And
					OLD.[FirstTimeInitiative] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [FirstTimeInitiativeID]	 column	*/
	If UPDATE([FirstTimeInitiativeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''FirstTimeInitiativeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[FirstTimeInitiativeID]),
			CONVERT(nvarchar(4000),NEW.[FirstTimeInitiativeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[FirstTimeInitiativeID] <>
					OLD.[FirstTimeInitiativeID]
				) Or
				(
					NEW.[FirstTimeInitiativeID] Is Null And
					OLD.[FirstTimeInitiativeID] Is Not Null
				) Or
				(
					NEW.[FirstTimeInitiativeID] Is Not Null And
					OLD.[FirstTimeInitiativeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [NonDuplication]	 column	*/
	If UPDATE([NonDuplication])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''NonDuplication'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[NonDuplication]),
			CONVERT(nvarchar(4000),NEW.[NonDuplication])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[NonDuplication] <>
					OLD.[NonDuplication]
				) Or
				(
					NEW.[NonDuplication] Is Null And
					OLD.[NonDuplication] Is Not Null
				) Or
				(
					NEW.[NonDuplication] Is Not Null And
					OLD.[NonDuplication] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [NonDuplicationID]	 column	*/
	If UPDATE([NonDuplicationID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''NonDuplicationID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[NonDuplicationID]),
			CONVERT(nvarchar(4000),NEW.[NonDuplicationID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[NonDuplicationID] <>
					OLD.[NonDuplicationID]
				) Or
				(
					NEW.[NonDuplicationID] Is Null And
					OLD.[NonDuplicationID] Is Not Null
				) Or
				(
					NEW.[NonDuplicationID] Is Not Null And
					OLD.[NonDuplicationID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END


	-- Added 2008-01-22, GMcF, for PIR

-- executive summary
	/*	INSERT audit traces For [PIRStatus]	 column	*/
	If UPDATE([PIRStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRStatus] <>
					OLD.[PIRStatus]
				) Or
				(
					NEW.[PIRStatus] Is Null And
					OLD.[PIRStatus] Is Not Null
				) Or
				(
					NEW.[PIRStatus] Is Not Null And
					OLD.[PIRStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRStatusID]	 column	*/
	If UPDATE([PIRStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRStatusID] <>
					OLD.[PIRStatusID]
				) Or
				(
					NEW.[PIRStatusID] Is Null And
					OLD.[PIRStatusID] Is Not Null
				) Or
				(
					NEW.[PIRStatusID] Is Not Null And
					OLD.[PIRStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRStartDate]	 column	*/
	If UPDATE([PIRStartDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRStartDate'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRStartDate]),
			CONVERT(nvarchar(4000),NEW.[PIRStartDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRStartDate] <>
					OLD.[PIRStartDate]
				) Or
				(
					NEW.[PIRStartDate] Is Null And
					OLD.[PIRStartDate] Is Not Null
				) Or
				(
					NEW.[PIRStartDate] Is Not Null And
					OLD.[PIRStartDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIREndDate]	 column	*/
	If UPDATE([PIREndDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIREndDate'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIREndDate]),
			CONVERT(nvarchar(4000),NEW.[PIREndDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIREndDate] <>
					OLD.[PIREndDate]
				) Or
				(
					NEW.[PIREndDate] Is Null And
					OLD.[PIREndDate] Is Not Null
				) Or
				(
					NEW.[PIREndDate] Is Not Null And
					OLD.[PIREndDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRSuccesses]	 column	*/
/*
	If UPDATE([PIRSuccesses])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRSuccesses'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRSuccesses]),
			CONVERT(nvarchar(4000),NEW.[PIRSuccesses])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRSuccesses] <>
					OLD.[PIRSuccesses]
				) Or
				(
					NEW.[PIRSuccesses] Is Null And
					OLD.[PIRSuccesses] Is Not Null
				) Or
				(
					NEW.[PIRSuccesses] Is Not Null And
					OLD.[PIRSuccesses] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/
	/*	INSERT audit traces For [PIRIssues]	 column	*/
/*
	If UPDATE([PIRIssues])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRIssues'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRIssues]),
			CONVERT(nvarchar(4000),NEW.[PIRIssues])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRIssues] <>
					OLD.[PIRIssues]
				) Or
				(
					NEW.[PIRIssues] Is Null And
					OLD.[PIRIssues] Is Not Null
				) Or
				(
					NEW.[PIRIssues] Is Not Null And
					OLD.[PIRIssues] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

-- financial comments

	/*	INSERT audit traces For [PIRFinancialComments]	 column	*/
/*
	If UPDATE([PIRFinancialComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRFinancialComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRFinancialComments]),
			CONVERT(nvarchar(4000),NEW.[PIRFinancialComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRFinancialComments] <>
					OLD.[PIRFinancialComments]
				) Or
				(
					NEW.[PIRFinancialComments] Is Null And
					OLD.[PIRFinancialComments] Is Not Null
				) Or
				(
					NEW.[PIRFinancialComments] Is Not Null And
					OLD.[PIRFinancialComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

-- key metrics

	/*	INSERT audit traces For [PIRKeyMetricSpendStatus]	 column	*/
	If UPDATE([PIRKeyMetricSpendStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricSpendStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricSpendStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricSpendStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricSpendStatus] <>
					OLD.[PIRKeyMetricSpendStatus]
				) Or
				(
					NEW.[PIRKeyMetricSpendStatus] Is Null And
					OLD.[PIRKeyMetricSpendStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricSpendStatus] Is Not Null And
					OLD.[PIRKeyMetricSpendStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricSpendStatusID]	 column	*/
	If UPDATE([PIRKeyMetricSpendStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricSpendStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricSpendStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricSpendStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricSpendStatusID] <>
					OLD.[PIRKeyMetricSpendStatusID]
				) Or
				(
					NEW.[PIRKeyMetricSpendStatusID] Is Null And
					OLD.[PIRKeyMetricSpendStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricSpendStatusID] Is Not Null And
					OLD.[PIRKeyMetricSpendStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricSpendComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricSpendComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricSpendComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricSpendComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricSpendComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricSpendComments] <>
					OLD.[PIRKeyMetricSpendComments]
				) Or
				(
					NEW.[PIRKeyMetricSpendComments] Is Null And
					OLD.[PIRKeyMetricSpendComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricSpendComments] Is Not Null And
					OLD.[PIRKeyMetricSpendComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

	/*	INSERT audit traces For [PIRKeyMetricDeliveryStatus]	 column	*/
	If UPDATE([PIRKeyMetricDeliveryStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricDeliveryStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricDeliveryStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricDeliveryStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricDeliveryStatus] <>
					OLD.[PIRKeyMetricDeliveryStatus]
				) Or
				(
					NEW.[PIRKeyMetricDeliveryStatus] Is Null And
					OLD.[PIRKeyMetricDeliveryStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricDeliveryStatus] Is Not Null And
					OLD.[PIRKeyMetricDeliveryStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricDeliveryStatusID]	 column	*/
	If UPDATE([PIRKeyMetricDeliveryStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricDeliveryStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricDeliveryStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricDeliveryStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricDeliveryStatusID] <>
					OLD.[PIRKeyMetricDeliveryStatusID]
				) Or
				(
					NEW.[PIRKeyMetricDeliveryStatusID] Is Null And
					OLD.[PIRKeyMetricDeliveryStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricDeliveryStatusID] Is Not Null And
					OLD.[PIRKeyMetricDeliveryStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricDeliveryComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricDeliveryComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricDeliveryComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricDeliveryComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricDeliveryComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricDeliveryComments] <>
					OLD.[PIRKeyMetricDeliveryComments]
				) Or
				(
					NEW.[PIRKeyMetricDeliveryComments] Is Null And
					OLD.[PIRKeyMetricDeliveryComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricDeliveryComments] Is Not Null And
					OLD.[PIRKeyMetricDeliveryComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

	/*	INSERT audit traces For [PIRKeyMetricImpactStatus]	 column	*/
	If UPDATE([PIRKeyMetricImpactStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricImpactStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricImpactStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricImpactStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricImpactStatus] <>
					OLD.[PIRKeyMetricImpactStatus]
				) Or
				(
					NEW.[PIRKeyMetricImpactStatus] Is Null And
					OLD.[PIRKeyMetricImpactStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricImpactStatus] Is Not Null And
					OLD.[PIRKeyMetricImpactStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricImpactStatusID]	 column	*/
	If UPDATE([PIRKeyMetricImpactStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricImpactStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricImpactStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricImpactStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricImpactStatusID] <>
					OLD.[PIRKeyMetricImpactStatusID]
				) Or
				(
					NEW.[PIRKeyMetricImpactStatusID] Is Null And
					OLD.[PIRKeyMetricImpactStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricImpactStatusID] Is Not Null And
					OLD.[PIRKeyMetricImpactStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricImpactComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricImpactComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricImpactComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricImpactComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricImpactComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricImpactComments] <>
					OLD.[PIRKeyMetricImpactComments]
				) Or
				(
					NEW.[PIRKeyMetricImpactComments] Is Null And
					OLD.[PIRKeyMetricImpactComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricImpactComments] Is Not Null And
					OLD.[PIRKeyMetricImpactComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

	/*	INSERT audit traces For [PIRKeyMetricScopeStatus]	 column	*/
	If UPDATE([PIRKeyMetricScopeStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricScopeStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricScopeStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricScopeStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricScopeStatus] <>
					OLD.[PIRKeyMetricScopeStatus]
				) Or
				(
					NEW.[PIRKeyMetricScopeStatus] Is Null And
					OLD.[PIRKeyMetricScopeStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricScopeStatus] Is Not Null And
					OLD.[PIRKeyMetricScopeStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricScopeStatusID]	 column	*/
	If UPDATE([PIRKeyMetricScopeStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricScopeStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricScopeStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricScopeStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricScopeStatusID] <>
					OLD.[PIRKeyMetricScopeStatusID]
				) Or
				(
					NEW.[PIRKeyMetricScopeStatusID] Is Null And
					OLD.[PIRKeyMetricScopeStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricScopeStatusID] Is Not Null And
					OLD.[PIRKeyMetricScopeStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricScopeComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricScopeComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricScopeComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricScopeComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricScopeComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricScopeComments] <>
					OLD.[PIRKeyMetricScopeComments]
				) Or
				(
					NEW.[PIRKeyMetricScopeComments] Is Null And
					OLD.[PIRKeyMetricScopeComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricScopeComments] Is Not Null And
					OLD.[PIRKeyMetricScopeComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/
	/*	INSERT audit traces For [PIRKeyMetricProjManStatus]	 column	*/
	If UPDATE([PIRKeyMetricProjManStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricProjManStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricProjManStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricProjManStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricProjManStatus] <>
					OLD.[PIRKeyMetricProjManStatus]
				) Or
				(
					NEW.[PIRKeyMetricProjManStatus] Is Null And
					OLD.[PIRKeyMetricProjManStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricProjManStatus] Is Not Null And
					OLD.[PIRKeyMetricProjManStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricProjManStatusID]	 column	*/
	If UPDATE([PIRKeyMetricProjManStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricProjManStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricProjManStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricProjManStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricProjManStatusID] <>
					OLD.[PIRKeyMetricProjManStatusID]
				) Or
				(
					NEW.[PIRKeyMetricProjManStatusID] Is Null And
					OLD.[PIRKeyMetricProjManStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricProjManStatusID] Is Not Null And
					OLD.[PIRKeyMetricProjManStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricProjManComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricProjManComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricProjManComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricProjManComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricProjManComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricProjManComments] <>
					OLD.[PIRKeyMetricProjManComments]
				) Or
				(
					NEW.[PIRKeyMetricProjManComments] Is Null And
					OLD.[PIRKeyMetricProjManComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricProjManComments] Is Not Null And
					OLD.[PIRKeyMetricProjManComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

	/*	INSERT audit traces For [PIRKeyMetricRiskManStatus]	 column	*/
	If UPDATE([PIRKeyMetricRiskManStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricRiskManStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricRiskManStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricRiskManStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricRiskManStatus] <>
					OLD.[PIRKeyMetricRiskManStatus]
				) Or
				(
					NEW.[PIRKeyMetricRiskManStatus] Is Null And
					OLD.[PIRKeyMetricRiskManStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricRiskManStatus] Is Not Null And
					OLD.[PIRKeyMetricRiskManStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricRiskManStatusID]	 column	*/
	If UPDATE([PIRKeyMetricRiskManStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricRiskManStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricRiskManStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricRiskManStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricRiskManStatusID] <>
					OLD.[PIRKeyMetricRiskManStatusID]
				) Or
				(
					NEW.[PIRKeyMetricRiskManStatusID] Is Null And
					OLD.[PIRKeyMetricRiskManStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricRiskManStatusID] Is Not Null And
					OLD.[PIRKeyMetricRiskManStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricRiskManComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricRiskManComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricRiskManComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricRiskManComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricRiskManComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricRiskManComments] <>
					OLD.[PIRKeyMetricRiskManComments]
				) Or
				(
					NEW.[PIRKeyMetricRiskManComments] Is Null And
					OLD.[PIRKeyMetricRiskManComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricRiskManComments] Is Not Null And
					OLD.[PIRKeyMetricRiskManComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/

	/*	INSERT audit traces For [PIRKeyMetricAlphaStatus]	 column	*/
	If UPDATE([PIRKeyMetricAlphaStatus])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricAlphaStatus'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaStatus]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricAlphaStatus])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricAlphaStatus] <>
					OLD.[PIRKeyMetricAlphaStatus]
				) Or
				(
					NEW.[PIRKeyMetricAlphaStatus] Is Null And
					OLD.[PIRKeyMetricAlphaStatus] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricAlphaStatus] Is Not Null And
					OLD.[PIRKeyMetricAlphaStatus] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricAlphaStatusID]	 column	*/
	If UPDATE([PIRKeyMetricAlphaStatusID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricAlphaStatusID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaStatusID]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricAlphaStatusID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricAlphaStatusID] <>
					OLD.[PIRKeyMetricAlphaStatusID]
				) Or
				(
					NEW.[PIRKeyMetricAlphaStatusID] Is Null And
					OLD.[PIRKeyMetricAlphaStatusID] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricAlphaStatusID] Is Not Null And
					OLD.[PIRKeyMetricAlphaStatusID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PIRKeyMetricAlphaComments]	 column	*/
/*
	If UPDATE([PIRKeyMetricAlphaComments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PIRKeyMetricAlphaComments'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PIRKeyMetricAlphaComments]),
			CONVERT(nvarchar(4000),NEW.[PIRKeyMetricAlphaComments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PIRKeyMetricAlphaComments] <>
					OLD.[PIRKeyMetricAlphaComments]
				) Or
				(
					NEW.[PIRKeyMetricAlphaComments] Is Null And
					OLD.[PIRKeyMetricAlphaComments] Is Not Null
				) Or
				(
					NEW.[PIRKeyMetricAlphaComments] Is Not Null And
					OLD.[PIRKeyMetricAlphaComments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
*/
	-- End of code added 2008-01-22

	-- Added 2008-05-08, GMcF, for Phase 2.1, Programme Performance Reporting
	/*	INSERT audit traces For [PIRKeyMetricAlphaStatusID]	 column	*/
	If UPDATE([PrimarySBUID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeID]=N''''''+CAST(IsNull(OLD.[InitiativeID], NEW.[InitiativeID]) as nvarchar(4000))+'''''''',
                ''PrimarySBUID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PrimarySBUID]),
			CONVERT(nvarchar(4000),NEW.[PrimarySBUID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeID] = OLD.[InitiativeID])
			AND (
				(
					NEW.[PrimarySBUID] <>
					OLD.[PrimarySBUID]
				) Or
				(
					NEW.[PrimarySBUID] Is Null And
					OLD.[PrimarySBUID] Is Not Null
				) Or
				(
					NEW.[PrimarySBUID] Is Not Null And
					OLD.[PrimarySBUID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	-- End of code added 2008-05-08


	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End


' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ExternalUniqueIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ExternalUniqueIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ExternalUniqueIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ExternalUniqueIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ExternalUniqueIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3960 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ExternalUniqueIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGBusinessAreaCode'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGBusinessAreaCode'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGBusinessAreaCode'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGBusinessAreaCode'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGBusinessAreaCode'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGBusinessAreaCode'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGIdentifierCode'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGIdentifierCode'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGIdentifierCode'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGIdentifierCode'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGIdentifierCode'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGIdentifierCode'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGVersionNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGVersionNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGVersionNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGVersionNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGVersionNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGVersionNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGReviewDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGReviewDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGReviewDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGReviewDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGReviewDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGReviewDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'Name'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'Name'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'Name'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'Name'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'Name'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2280 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'Name'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InvestmentTier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InvestmentTier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InvestmentTier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InvestmentTier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InvestmentTier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InvestmentTier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InvestmentTierID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InvestmentTierID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InvestmentTierID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InvestmentTierID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InvestmentTierID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InvestmentTierID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PrimarySponsoringArea'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PrimarySponsoringArea'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PrimarySponsoringArea'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PrimarySponsoringArea'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PrimarySponsoringArea'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PrimarySponsoringArea'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'OtherSponsoringAreas'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'OtherSponsoringAreas'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'OtherSponsoringAreas'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'OtherSponsoringAreas'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'OtherSponsoringAreas'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'OtherSponsoringAreas'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessSponsorName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessSponsorName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessSponsorName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessSponsorName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessSponsorName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessSponsorName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessSponsorID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessSponsorID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessSponsorID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessSponsorID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessSponsorID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessSponsorID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessInitiativeManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessInitiativeManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessInitiativeManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessInitiativeManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessInitiativeManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessInitiativeManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessInitiativeManagerID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessInitiativeManagerID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessInitiativeManagerID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessInitiativeManagerID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessInitiativeManagerID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessInitiativeManagerID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOManagingBusinessArea'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOManagingBusinessArea'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOManagingBusinessArea'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOManagingBusinessArea'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOManagingBusinessArea'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOManagingBusinessArea'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOInitiativeManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOInitiativeManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOInitiativeManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOInitiativeManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOInitiativeManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOInitiativeManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOInitiativeManagerID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOInitiativeManagerID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOInitiativeManagerID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOInitiativeManagerID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOInitiativeManagerID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOInitiativeManagerID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FunctionalDomain'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FunctionalDomain'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FunctionalDomain'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FunctionalDomain'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FunctionalDomain'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FunctionalDomain'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FunctionalDomainID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FunctionalDomainID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FunctionalDomainID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FunctionalDomainID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FunctionalDomainID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FunctionalDomainID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecondaryFunctionalDomain'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecondaryFunctionalDomain'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecondaryFunctionalDomain'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecondaryFunctionalDomain'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecondaryFunctionalDomain'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecondaryFunctionalDomain'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecondaryFunctionalDomainID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecondaryFunctionalDomainID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecondaryFunctionalDomainID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecondaryFunctionalDomainID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecondaryFunctionalDomainID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecondaryFunctionalDomainID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'MajorApplicationName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'MajorApplicationName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'MajorApplicationName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'MajorApplicationName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'MajorApplicationName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'MajorApplicationName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'MajorApplicationID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'MajorApplicationID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'MajorApplicationID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'MajorApplicationID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'MajorApplicationID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'MajorApplicationID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBusinessDrivers'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBusinessDrivers'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBusinessDrivers'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBusinessDrivers'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBusinessDrivers'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBusinessDrivers'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeScopeAndObjectives'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeScopeAndObjectives'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeScopeAndObjectives'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeScopeAndObjectives'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeScopeAndObjectives'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeScopeAndObjectives'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBenefitCalculation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBenefitCalculation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBenefitCalculation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBenefitCalculation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBenefitCalculation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBenefitCalculation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'StrategicInitiativeInterfaces'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'StrategicInitiativeInterfaces'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'StrategicInitiativeInterfaces'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'StrategicInitiativeInterfaces'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'StrategicInitiativeInterfaces'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'StrategicInitiativeInterfaces'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SmartsourcingComponent'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SmartsourcingComponent'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SmartsourcingComponent'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SmartsourcingComponent'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SmartsourcingComponent'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SmartsourcingComponent'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalCompliance'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalCompliance'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalCompliance'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalCompliance'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalCompliance'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalCompliance'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalComplianceType'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalComplianceType'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalComplianceType'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalComplianceType'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalComplianceType'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalComplianceType'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalComplianceTypeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalComplianceTypeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalComplianceTypeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalComplianceTypeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ArchitecturalComplianceTypeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ArchitecturalComplianceTypeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AllocationsAgreed'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AllocationsAgreed'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AllocationsAgreed'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AllocationsAgreed'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AllocationsAgreed'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AllocationsAgreed'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AllocationsAgreedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AllocationsAgreedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AllocationsAgreedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AllocationsAgreedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AllocationsAgreedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AllocationsAgreedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBudgeted'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBudgeted'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBudgeted'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBudgeted'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBudgeted'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBudgeted'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBudgetedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBudgetedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBudgetedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBudgetedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeBudgetedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeBudgetedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PayBackPeriod'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PayBackPeriod'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PayBackPeriod'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PayBackPeriod'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PayBackPeriod'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PayBackPeriod'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PayBackPeriodID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PayBackPeriodID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PayBackPeriodID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PayBackPeriodID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'PayBackPeriodID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'PayBackPeriodID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CompletionDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CompletionDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CompletionDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CompletionDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CompletionDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CompletionDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CompletionDateID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CompletionDateID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CompletionDateID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CompletionDateID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CompletionDateID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CompletionDateID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RTBAdditionalConsumption'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RTBAdditionalConsumption'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RTBAdditionalConsumption'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RTBAdditionalConsumption'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RTBAdditionalConsumption'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RTBAdditionalConsumption'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RTBAdditionalConsumptionID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RTBAdditionalConsumptionID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RTBAdditionalConsumptionID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RTBAdditionalConsumptionID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RTBAdditionalConsumptionID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RTBAdditionalConsumptionID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ImpactOfNotDoingThisInvestment'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ImpactOfNotDoingThisInvestment'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ImpactOfNotDoingThisInvestment'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ImpactOfNotDoingThisInvestment'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ImpactOfNotDoingThisInvestment'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ImpactOfNotDoingThisInvestment'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ShutdownComments'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ShutdownComments'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ShutdownComments'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ShutdownComments'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ShutdownComments'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ShutdownComments'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'KeyPerformanceIndicators'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'KeyPerformanceIndicators'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'KeyPerformanceIndicators'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'KeyPerformanceIndicators'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'KeyPerformanceIndicators'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'KeyPerformanceIndicators'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BenefitCalculation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BenefitCalculation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BenefitCalculation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BenefitCalculation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BenefitCalculation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BenefitCalculation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApproverID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApproverID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApproverID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApproverID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApproverID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApproverID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApprover'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApprover'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApprover'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApprover'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApprover'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApprover'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESArchitectureApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESArchitectureApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFullyCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFullyCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFullyCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFullyCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFullyCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFullyCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFullyCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFullyCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFullyCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFullyCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFullyCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFullyCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFinancialJustification'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFinancialJustification'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFinancialJustification'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFinancialJustification'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IESFinancialJustification'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IESFinancialJustification'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApproverID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApproverID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApproverID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApproverID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApproverID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApproverID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApprover'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApprover'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApprover'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApprover'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApprover'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApprover'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'CIOArchitectureApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'CIOArchitectureApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'UsesApproved3rdPartySoftwareID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'UsesApproved3rdPartySoftwareID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'UsesApproved3rdPartySoftwareID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'UsesApproved3rdPartySoftwareID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'UsesApproved3rdPartySoftwareID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'UsesApproved3rdPartySoftwareID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'UsesApproved3rdPartySoftware'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'UsesApproved3rdPartySoftware'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'UsesApproved3rdPartySoftware'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'UsesApproved3rdPartySoftware'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'UsesApproved3rdPartySoftware'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'UsesApproved3rdPartySoftware'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessArchitectureInfoProvidedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessArchitectureInfoProvidedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessArchitectureInfoProvidedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessArchitectureInfoProvidedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessArchitectureInfoProvidedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessArchitectureInfoProvidedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessArchitectureInfoProvided'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessArchitectureInfoProvided'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessArchitectureInfoProvided'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessArchitectureInfoProvided'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'BusinessArchitectureInfoProvided'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'BusinessArchitectureInfoProvided'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ApplicationArchitetureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ApplicationArchitetureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ApplicationArchitetureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ApplicationArchitetureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ApplicationArchitetureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ApplicationArchitetureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ApplicationArchitetureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ApplicationArchitetureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ApplicationArchitetureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ApplicationArchitetureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ApplicationArchitetureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ApplicationArchitetureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureSatisfiedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureSatisfiedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureSatisfiedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureSatisfiedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureSatisfiedID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureSatisfiedID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureSatisfied'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureSatisfied'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureSatisfied'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureSatisfied'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'TechnicalArchitectureSatisfied'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'TechnicalArchitectureSatisfied'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'DevelopmentArchitectureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'DevelopmentArchitectureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'DevelopmentArchitectureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'DevelopmentArchitectureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'DevelopmentArchitectureCompliantID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'DevelopmentArchitectureCompliantID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'DevelopmentArchitectureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'DevelopmentArchitectureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'DevelopmentArchitectureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'DevelopmentArchitectureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'DevelopmentArchitectureCompliant'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'DevelopmentArchitectureCompliant'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOJustification4Deviation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOJustification4Deviation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOJustification4Deviation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOJustification4Deviation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'GTOJustification4Deviation'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'GTOJustification4Deviation'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RisksIssuesDeps'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RisksIssuesDeps'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RisksIssuesDeps'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RisksIssuesDeps'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'RisksIssuesDeps'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'RisksIssuesDeps'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'OverallIGComment'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'OverallIGComment'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'OverallIGComment'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'OverallIGComment'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'OverallIGComment'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'OverallIGComment'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalCommittee'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalCommittee'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalCommittee'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalCommittee'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalCommittee'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalCommittee'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalCommitteeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalCommitteeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalCommitteeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalCommitteeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalCommitteeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalCommitteeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalDate'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalDate'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalStatus'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalStatus'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalStatus'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalStatus'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalStatus'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalStatus'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalStatusID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalStatusID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalStatusID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalStatusID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'IGApprovalStatusID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'IGApprovalStatusID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeImpactCategory'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeImpactCategory'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeImpactCategory'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeImpactCategory'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeImpactCategory'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeImpactCategory'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeImpactCategoryID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeImpactCategoryID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeImpactCategoryID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeImpactCategoryID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeImpactCategoryID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeImpactCategoryID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeGTOReviewLevel'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeGTOReviewLevel'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeGTOReviewLevel'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeGTOReviewLevel'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeGTOReviewLevel'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeGTOReviewLevel'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeGTOReviewLevelID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeGTOReviewLevelID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeGTOReviewLevelID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeGTOReviewLevelID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'InitiativeGTOReviewLevelID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'InitiativeGTOReviewLevelID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AlignedToBusinessStrategy'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AlignedToBusinessStrategy'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AlignedToBusinessStrategy'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AlignedToBusinessStrategy'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AlignedToBusinessStrategy'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AlignedToBusinessStrategy'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AlignedToBusinessStrategyID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AlignedToBusinessStrategyID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AlignedToBusinessStrategyID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AlignedToBusinessStrategyID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'AlignedToBusinessStrategyID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'AlignedToBusinessStrategyID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FirstTimeInitiative'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FirstTimeInitiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FirstTimeInitiative'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FirstTimeInitiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FirstTimeInitiative'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FirstTimeInitiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FirstTimeInitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FirstTimeInitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FirstTimeInitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FirstTimeInitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'FirstTimeInitiativeID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'FirstTimeInitiativeID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'NonDuplication'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'NonDuplication'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'NonDuplication'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'NonDuplication'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'NonDuplication'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'NonDuplication'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'NonDuplicationID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'NonDuplicationID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'NonDuplicationID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'NonDuplicationID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'NonDuplicationID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'NonDuplicationID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ActiveUserID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ActiveUserID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ActiveUserID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ActiveUserID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'ActiveUserID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'ActiveUserID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecurityID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecurityID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecurityID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecurityID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', N'COLUMN',N'SecurityID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative', @level2type=N'COLUMN',@level2name=N'SecurityID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DefaultView' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Filter' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_OrderBy' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_OrderByOn' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Orientation' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_TableMaxRecords' , N'SCHEMA',N'dbo', N'TABLE',N'Initiative', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Initiative'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editInitiativeSponsorUBRAllocation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[editInitiativeSponsorUBRAllocation](
	[editId] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [nvarchar](38) NULL,
	[InitiativeId] [int] NULL,
	[SponsorId] [int] NULL,
	[UBRCode] [nvarchar](50) NULL,
	[UBRAllocation] [decimal](18, 4) NULL,
	[Percentage] [bit] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UBRLookup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UBRLookup](
	[UBR_ID] [int] IDENTITY(1,1) NOT NULL,
	[Level5Code] [nvarchar](100) NULL,
	[Level5Name] [nvarchar](100) NULL,
	[Level6Code] [nvarchar](100) NULL,
	[Level6Name] [nvarchar](100) NULL,
	[Level7Code] [nvarchar](100) NULL,
	[Level7Name] [nvarchar](100) NULL,
	[Level8Code] [nvarchar](100) NULL,
	[Level8Name] [nvarchar](100) NULL,
	[Level9Code] [nvarchar](100) NULL,
	[Level9Name] [nvarchar](100) NULL,
	[Level10Code] [nvarchar](100) NULL,
	[Level10Name] [nvarchar](100) NULL,
	[CustomGrouping] [nvarchar](100) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reference]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Reference](
	[ReferenceID] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
	[CategoryID] [int] NOT NULL,
	[Category] [nvarchar](75) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Reference__IsDel__764C846B]  DEFAULT (0),
	[IsApproved] [bit] NULL CONSTRAINT [DF_Reference_IsApproved]  DEFAULT (0),
	[ReportingCategory] [int] NULL CONSTRAINT [DF_Reference_ReportingCategory]  DEFAULT (0),
	[ParentReferenceID] [int] NULL,
	[SortOrder] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC,
	[ReferenceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Application]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Application](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationInstanceName] [nvarchar](4000) NULL,
	[ExternalApplicationID] [nvarchar](4000) NULL,
	[InvestmentStrategy] [nvarchar](4000) NULL,
	[IsDeleted] [bit] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeProduct](
	[InitiativeProductID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductTypeID] [int] NULL,
	[ProductType] [nvarchar](50) NULL,
	[TVendor] [nvarchar](50) NULL,
	[CTB_RTBID] [int] NULL,
	[CTB_RTB] [nvarchar](50) NULL,
	[CIO_IESID] [int] NULL,
	[CIO_IES] [nvarchar](50) NULL,
	[Remediation] [ntext] NULL,
 CONSTRAINT [PK_InitiativeProduct] PRIMARY KEY CLUSTERED 
(
	[InitiativeProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeProduct]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeProduct]
ON [dbo].[InitiativeProduct]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeProduct]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:59 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeProduct]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeProductID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeProduct]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''ProductName'',
		CONVERT(nvarchar(4000),OLD.[ProductName])
	FROM deleted OLD
	WHERE
		OLD.[ProductName] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''ProductTypeID'',
		CONVERT(nvarchar(4000),OLD.[ProductTypeID])
	FROM deleted OLD
	WHERE
		OLD.[ProductTypeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''ProductType'',
		CONVERT(nvarchar(4000),OLD.[ProductType])
	FROM deleted OLD
	WHERE
		OLD.[ProductType] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''TVendor'',
		CONVERT(nvarchar(4000),OLD.[TVendor])
	FROM deleted OLD
	WHERE
		OLD.[TVendor] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CTB_RTBID'',
		CONVERT(nvarchar(4000),OLD.[CTB_RTBID])
	FROM deleted OLD
	WHERE
		OLD.[CTB_RTBID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CTB_RTB'',
		CONVERT(nvarchar(4000),OLD.[CTB_RTB])
	FROM deleted OLD
	WHERE
		OLD.[CTB_RTB] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CIO_IESID'',
		CONVERT(nvarchar(4000),OLD.[CIO_IESID])
	FROM deleted OLD
	WHERE
		OLD.[CIO_IESID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(OLD.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CIO_IES'',
		CONVERT(nvarchar(4000),OLD.[CIO_IES])
	FROM deleted OLD
	WHERE
		OLD.[CIO_IES] Is Not Null


	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeProduct]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeProduct]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeProduct]
ON [dbo].[InitiativeProduct]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeProduct]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:59 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeProductID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeProduct]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeProduct]	*/
	/*	INSERT audit traces For [ProductName]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''ProductName'',
		convert(nvarchar(4000), [ProductName]) 
	FROM inserted
	WHERE [ProductName] Is Not Null

	/*	INSERT audit traces For [ProductTypeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''ProductTypeID'',
		convert(nvarchar(4000), [ProductTypeID]) 
	FROM inserted
	WHERE [ProductTypeID] Is Not Null

	/*	INSERT audit traces For [ProductType]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''ProductType'',
		convert(nvarchar(4000), [ProductType]) 
	FROM inserted
	WHERE [ProductType] Is Not Null

	/*	INSERT audit traces For [TVendor]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''TVendor'',
		convert(nvarchar(4000), [TVendor]) 
	FROM inserted
	WHERE [TVendor] Is Not Null

	/*	INSERT audit traces For [CTB_RTBID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CTB_RTBID'',
		convert(nvarchar(4000), [CTB_RTBID]) 
	FROM inserted
	WHERE [CTB_RTBID] Is Not Null

	/*	INSERT audit traces For [CTB_RTB]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CTB_RTB'',
		convert(nvarchar(4000), [CTB_RTB]) 
	FROM inserted
	WHERE [CTB_RTB] Is Not Null

	/*	INSERT audit traces For [CIO_IESID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CIO_IESID'',
		convert(nvarchar(4000), [CIO_IESID]) 
	FROM inserted
	WHERE [CIO_IESID] Is Not Null

	/*	INSERT audit traces For [CIO_IES]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST([InitiativeProductID] as nvarchar(4000))+'''''''',
        ''CIO_IES'',
		convert(nvarchar(4000), [CIO_IES]) 
	FROM inserted
	WHERE [CIO_IES] Is Not Null

	/*	INSERT audit traces For [Remediation]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeProductID]=N''''''+CAST(NEW.[InitiativeProductID] as nvarchar(4000))+'''''''',
        ''Remediation'',
			ORD.[Remediation]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeProduct] ORD 
                    ON ORD.[InitiativeProductID]=NEW.[InitiativeProductID]		WHERE
			ORD.[Remediation] Is Not Null


	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeProduct]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeProduct]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeProduct]
ON [dbo].[InitiativeProduct]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeProduct]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:59 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeProductID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeProduct]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeProduct]	*/
	/*	INSERT audit traces For [ProductName]	 column	*/
	If UPDATE([ProductName])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''ProductName'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ProductName]),
			CONVERT(nvarchar(4000),NEW.[ProductName])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[ProductName] <>
					OLD.[ProductName]
				) Or
				(
					NEW.[ProductName] Is Null And
					OLD.[ProductName] Is Not Null
				) Or
				(
					NEW.[ProductName] Is Not Null And
					OLD.[ProductName] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProductTypeID]	 column	*/
	If UPDATE([ProductTypeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''ProductTypeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ProductTypeID]),
			CONVERT(nvarchar(4000),NEW.[ProductTypeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[ProductTypeID] <>
					OLD.[ProductTypeID]
				) Or
				(
					NEW.[ProductTypeID] Is Null And
					OLD.[ProductTypeID] Is Not Null
				) Or
				(
					NEW.[ProductTypeID] Is Not Null And
					OLD.[ProductTypeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ProductType]	 column	*/
	If UPDATE([ProductType])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''ProductType'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ProductType]),
			CONVERT(nvarchar(4000),NEW.[ProductType])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[ProductType] <>
					OLD.[ProductType]
				) Or
				(
					NEW.[ProductType] Is Null And
					OLD.[ProductType] Is Not Null
				) Or
				(
					NEW.[ProductType] Is Not Null And
					OLD.[ProductType] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TVendor]	 column	*/
	If UPDATE([TVendor])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''TVendor'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[TVendor]),
			CONVERT(nvarchar(4000),NEW.[TVendor])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[TVendor] <>
					OLD.[TVendor]
				) Or
				(
					NEW.[TVendor] Is Null And
					OLD.[TVendor] Is Not Null
				) Or
				(
					NEW.[TVendor] Is Not Null And
					OLD.[TVendor] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CTB_RTBID]	 column	*/
	If UPDATE([CTB_RTBID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''CTB_RTBID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CTB_RTBID]),
			CONVERT(nvarchar(4000),NEW.[CTB_RTBID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[CTB_RTBID] <>
					OLD.[CTB_RTBID]
				) Or
				(
					NEW.[CTB_RTBID] Is Null And
					OLD.[CTB_RTBID] Is Not Null
				) Or
				(
					NEW.[CTB_RTBID] Is Not Null And
					OLD.[CTB_RTBID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CTB_RTB]	 column	*/
	If UPDATE([CTB_RTB])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''CTB_RTB'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CTB_RTB]),
			CONVERT(nvarchar(4000),NEW.[CTB_RTB])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[CTB_RTB] <>
					OLD.[CTB_RTB]
				) Or
				(
					NEW.[CTB_RTB] Is Null And
					OLD.[CTB_RTB] Is Not Null
				) Or
				(
					NEW.[CTB_RTB] Is Not Null And
					OLD.[CTB_RTB] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIO_IESID]	 column	*/
	If UPDATE([CIO_IESID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''CIO_IESID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CIO_IESID]),
			CONVERT(nvarchar(4000),NEW.[CIO_IESID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[CIO_IESID] <>
					OLD.[CIO_IESID]
				) Or
				(
					NEW.[CIO_IESID] Is Null And
					OLD.[CIO_IESID] Is Not Null
				) Or
				(
					NEW.[CIO_IESID] Is Not Null And
					OLD.[CIO_IESID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIO_IES]	 column	*/
	If UPDATE([CIO_IES])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(OLD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''CIO_IES'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CIO_IES]),
			CONVERT(nvarchar(4000),NEW.[CIO_IES])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeProductID] = OLD.[InitiativeProductID])
			AND (
				(
					NEW.[CIO_IES] <>
					OLD.[CIO_IES]
				) Or
				(
					NEW.[CIO_IES] Is Null And
					OLD.[CIO_IES] Is Not Null
				) Or
				(
					NEW.[CIO_IES] Is Not Null And
					OLD.[CIO_IES] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Remediation]	 column	*/
	If UPDATE([Remediation])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeProductID]=N''''''+CAST(IsNull(ORD.[InitiativeProductID], NEW.[InitiativeProductID]) as nvarchar(4000))+'''''''',
                ''Remediation'',
''ntext'', 
			ORD.[Remediation]
		FROM inserted NEW JOIN [dbo].[InitiativeProduct] ORD 
                    ON ORD.[InitiativeProductID]=NEW.[InitiativeProductID]
				/*
			AND (
				(
					SUBSTRING(NEW.[Remediation], 0, 1024) <>
					SUBSTRING(ORD.[Remediation], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[Remediation], 0, 1024) Is Null And
					SUBSTRING(ORD.[Remediation], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[Remediation], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[Remediation], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[Remediation] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeProduct]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Initiative]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Initiative](
	[Name] [nvarchar](255) NULL,
	[PrimarySponsoringArea] [nvarchar](255) NULL,
	[OtherSponsoringAreas] [nvarchar](50) NULL,
	[BusinessSponsorName] [nvarchar](255) NULL,
	[BusinessInitiativeManager] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[GTOManagingBusinessArea] [nvarchar](255) NULL,
	[GTOInitiativeManager] [nvarchar](255) NULL,
	[FunctionalDomain] [nvarchar](255) NULL,
	[MajorApplicationName] [nvarchar](255) NULL,
	[InitiativeBusinessDrivers] [ntext] NULL,
	[InitiativeScopeAndObjectives] [ntext] NULL,
	[InitiativeBenefitCalculation] [ntext] NULL,
	[StrategicInitiativeInterfaces] [ntext] NULL,
	[SmartsourcingComponent] [ntext] NULL,
	[ArchitecturalComplianceType] [nvarchar](50) NULL,
	[ArchitecturalCompliance] [ntext] NULL,
	[PayBackPeriod] [nvarchar](50) NULL,
	[CompletionDate] [nvarchar](50) NULL,
	[RowCommand] [varchar](5) NULL,
	[_PrimarySBUID] [int] NULL,
	[_BusinessSponsorID] [int] NULL,
	[_BusinessInitiativeManagerID] [int] NULL,
	[_RegionID] [int] NULL,
	[_GTOInitiativeManagerID] [int] NULL,
	[_FunctionalDomainID] [int] NULL,
	[_MajorApplicationID] [int] NULL,
	[_ArchitecturalComplianceTypeID] [int] NULL,
	[_PayBackPeriodID] [int] NULL,
	[_CompletionDateID] [int] NULL,
	[_UploadID] [int] NOT NULL,
	[_InitiativeID] [int] NULL,
	[_NewFlag] [bit] NULL,
	[_Validated] [bit] NULL,
	[_IsValid] [bit] NULL,
	[_Committed] [bit] NULL,
	[_Fault] [ntext] NULL DEFAULT (''),
	[_FaultCount] [tinyint] NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AUDIT_LOG_DATA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AUDIT_LOG_DATA](
	[AUDIT_LOG_DATA_ID] [int] IDENTITY(1,1) NOT NULL,
	[AUDIT_LOG_TRANSACTION_ID] [int] NOT NULL,
	[PRIMARY_KEY_DATA] [nvarchar](3500) NOT NULL,
	[COL_NAME] [nvarchar](128) NOT NULL,
	[COL_TYPE] [nvarchar](128) NULL,
	[OLD_VALUE_LONG] [ntext] NULL,
	[NEW_VALUE_LONG] [ntext] NULL,
	[NEW_VALUE_BLOB] [image] NULL,
	[NEW_VALUE]  AS (isnull(convert(varchar(8000),[NEW_VALUE_LONG]),convert(varchar(8000),convert(varbinary(8000),substring([NEW_VALUE_BLOB],1,8000))))),
	[OLD_VALUE]  AS (convert(varchar(8000),[OLD_VALUE_LONG])),
	[PRIMARY_KEY]  AS ([PRIMARY_KEY_DATA])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AUDIT_LOG_TRANSACTIONS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AUDIT_LOG_TRANSACTIONS](
	[AUDIT_LOG_TRANSACTION_ID] [int] IDENTITY(1,1) NOT NULL,
	[TABLE_NAME] [nvarchar](261) NOT NULL,
	[AUDIT_ACTION_ID] [tinyint] NOT NULL,
	[HOST_NAME] [varchar](128) NULL,
	[APP_NAME] [varchar](128) NULL,
	[MODIFIED_BY] [varchar](128) NOT NULL,
	[MODIFIED_DATE] [datetime] NOT NULL,
	[AFFECTED_ROWS] [int] NOT NULL,
	[SYSOBJ_ID]  AS (object_id([TABLE_NAME])),
	[ACTIVE_USER_ID] [int] NULL,
	[INITIATIVE_ID] [int] NULL,
	[REFERENCE_ID] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Product](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[TechnologyVendor] [nvarchar](50) NULL,
	[ProductTypeID] [int] NULL,
 CONSTRAINT [PK__Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Sponsor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Sponsor](
	[Name] [nvarchar](255) NULL,
	[InitiativeBudgeted] [nvarchar](255) NULL,
	[AllocationsAgreed] [nvarchar](255) NULL,
	[BasisForAllocation] [nvarchar](255) NULL,
	[BasisForAllocationDescription] [nvarchar](255) NULL,
	[SponsAllocBusinessGM] [varchar](20) NULL,
	[SponsAllocBusinessGB-GCF] [varchar](20) NULL,
	[SponsAllocBusinessGB-GTB] [varchar](20) NULL,
	[SponsAllocBusinessPBC] [varchar](20) NULL,
	[SponsAllocBusinessPWM] [varchar](20) NULL,
	[SponsAllocBusinessAM] [varchar](20) NULL,
	[SponsAllocBusinessCA_S] [varchar](20) NULL,
	[SponsAllocBusinessCI] [varchar](20) NULL,
	[SponsAllocGTOIB_IT] [varchar](20) NULL,
	[SponsAllocGTOIB_OPS] [varchar](20) NULL,
	[SponsAllocGTOPCB_ITO] [varchar](20) NULL,
	[SponsAllocGTOAM_ITO] [varchar](20) NULL,
	[SponsAllocGTOSOM_OPS] [varchar](20) NULL,
	[SponsAllocGTOIES] [varchar](20) NULL,
	[SponsAllocGTOOTH] [varchar](20) NULL,
	[SponsAllocCFFINANCE] [varchar](20) NULL,
	[SponsAllocCFRISK_TREAS] [varchar](20) NULL,
	[SponsAllocCFCOMP_LEG] [varchar](20) NULL,
	[SponsAllocCFHR] [varchar](20) NULL,
	[SponsAllocCFGM_TMG] [varchar](20) NULL,
	[SponsAllocCFREG_MGMT] [varchar](20) NULL,
	[SponsAllocCFOTH-CF] [varchar](20) NULL,
	[RowCommand] [varchar](5) NULL,
	[_InitiativeBudgetedID] [int] NULL,
	[_AllocationsAgreedID] [int] NULL,
	[_BasisForAllocationID] [int] NULL,
	[_UploadID] [int] NOT NULL,
	[_InitiativeID] [int] NULL,
	[_CalculatedTotal] [decimal](19, 8) NULL,
	[_NewFlag] [bit] NULL,
	[_Validated] [bit] NULL,
	[_IsValid] [bit] NULL,
	[_Committed] [bit] NULL,
	[_Fault] [ntext] NULL DEFAULT (''),
	[_FaultCount] [tinyint] NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_StaticData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_StaticData](
	[Name] [nvarchar](255) NULL,
	[IGApprovalCommittee] [nvarchar](255) NULL,
	[IGApprovalStatus] [nvarchar](255) NULL,
	[IGIdentifier] [nvarchar](255) NULL,
	[IGApprovalDate] [varchar](25) NULL,
	[RTBAdditionalConsumption] [nvarchar](255) NULL,
	[AlignedToBusinessStrategy] [nvarchar](255) NULL,
	[InitiativeImpactCategory] [nvarchar](255) NULL,
	[FirstTimeInitiative] [nvarchar](255) NULL,
	[InitiativeGTOReviewLevel] [nvarchar](255) NULL,
	[NonDuplication] [nvarchar](255) NULL,
	[RowCommand] [varchar](5) NULL,
	[_IGApprovalCommitteeID] [int] NULL,
	[_IGApprovalStatusID] [int] NULL,
	[_RTBAdditionalConsumptionID] [int] NULL,
	[_AlignedToBusinessStrategyID] [int] NULL,
	[_InitiativeImpactCategoryID] [int] NULL,
	[_FirstTimeInitiativeID] [int] NULL,
	[_InitiativeGTOReviewLevelID] [int] NULL,
	[_NonDuplicationID] [int] NULL,
	[_IGBusinessAreaCode] [nvarchar](20) NULL,
	[_IGIdentifierCode] [nvarchar](20) NULL,
	[_UploadID] [int] NOT NULL,
	[_InitiativeID] [int] NULL,
	[_NewFlag] [bit] NULL,
	[_Validated] [bit] NULL,
	[_IsValid] [bit] NULL,
	[_Committed] [bit] NULL,
	[_Fault] [ntext] NULL DEFAULT (''),
	[_FaultCount] [tinyint] NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeRisk]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeRisk](
	[InitiativeRiskID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[RiskCategoryID] [int] NULL,
	[RiskCategory] [nvarchar](50) NULL,
	[CalculatedRisk] [decimal](18, 2) NULL,
	[AdjustedRisk] [decimal](18, 2) NULL,
	[EurosAtRisk] [money] NULL,
	[Probability] [nvarchar](10) NULL,
 CONSTRAINT [PK_InitiativeRisk] PRIMARY KEY CLUSTERED 
(
	[InitiativeRiskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeRisk]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeRisk]
ON [dbo].[InitiativeRisk]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeRisk]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:01 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeRisk]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeRiskID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeRisk]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST(OLD.[InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''RiskCategoryID'',
		CONVERT(nvarchar(4000),OLD.[RiskCategoryID])
	FROM deleted OLD
	WHERE
		OLD.[RiskCategoryID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST(OLD.[InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''RiskCategory'',
		CONVERT(nvarchar(4000),OLD.[RiskCategory])
	FROM deleted OLD
	WHERE
		OLD.[RiskCategory] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST(OLD.[InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''CalculatedRisk'',
		CONVERT(nvarchar(4000),OLD.[CalculatedRisk])
	FROM deleted OLD
	WHERE
		OLD.[CalculatedRisk] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST(OLD.[InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''AdjustedRisk'',
		CONVERT(nvarchar(4000),OLD.[AdjustedRisk])
	FROM deleted OLD
	WHERE
		OLD.[AdjustedRisk] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST(OLD.[InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''EurosAtRisk'',
		CONVERT(nvarchar(4000),OLD.[EurosAtRisk])
	FROM deleted OLD
	WHERE
		OLD.[EurosAtRisk] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST(OLD.[InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''Probability'',
		CONVERT(nvarchar(4000),OLD.[Probability])
	FROM deleted OLD
	WHERE
		OLD.[Probability] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeRisk]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeRisk]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeRisk]
ON [dbo].[InitiativeRisk]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeRisk]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:01 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeRiskID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeRisk]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeRisk]	*/
	/*	INSERT audit traces For [RiskCategoryID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST([InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''RiskCategoryID'',
		convert(nvarchar(4000), [RiskCategoryID]) 
	FROM inserted
	WHERE [RiskCategoryID] Is Not Null

	/*	INSERT audit traces For [RiskCategory]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST([InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''RiskCategory'',
		convert(nvarchar(4000), [RiskCategory]) 
	FROM inserted
	WHERE [RiskCategory] Is Not Null

	/*	INSERT audit traces For [CalculatedRisk]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST([InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''CalculatedRisk'',
		convert(nvarchar(4000), [CalculatedRisk]) 
	FROM inserted
	WHERE [CalculatedRisk] Is Not Null

	/*	INSERT audit traces For [AdjustedRisk]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST([InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''AdjustedRisk'',
		convert(nvarchar(4000), [AdjustedRisk]) 
	FROM inserted
	WHERE [AdjustedRisk] Is Not Null

	/*	INSERT audit traces For [EurosAtRisk]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST([InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''EurosAtRisk'',
		convert(nvarchar(4000), [EurosAtRisk]) 
	FROM inserted
	WHERE [EurosAtRisk] Is Not Null

	/*	INSERT audit traces For [Probability]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeRiskID]=N''''''+CAST([InitiativeRiskID] as nvarchar(4000))+'''''''',
        ''Probability'',
		convert(nvarchar(4000), [Probability]) 
	FROM inserted
	WHERE [Probability] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeRisk]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeRisk]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeRisk]
ON [dbo].[InitiativeRisk]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeRisk]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:01 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeRiskID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeRisk]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeRisk]	*/
	/*	INSERT audit traces For [RiskCategoryID]	 column	*/
	If UPDATE([RiskCategoryID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeRiskID]=N''''''+CAST(IsNull(OLD.[InitiativeRiskID], NEW.[InitiativeRiskID]) as nvarchar(4000))+'''''''',
                ''RiskCategoryID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[RiskCategoryID]),
			CONVERT(nvarchar(4000),NEW.[RiskCategoryID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeRiskID] = OLD.[InitiativeRiskID])
			AND (
				(
					NEW.[RiskCategoryID] <>
					OLD.[RiskCategoryID]
				) Or
				(
					NEW.[RiskCategoryID] Is Null And
					OLD.[RiskCategoryID] Is Not Null
				) Or
				(
					NEW.[RiskCategoryID] Is Not Null And
					OLD.[RiskCategoryID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [RiskCategory]	 column	*/
	If UPDATE([RiskCategory])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeRiskID]=N''''''+CAST(IsNull(OLD.[InitiativeRiskID], NEW.[InitiativeRiskID]) as nvarchar(4000))+'''''''',
                ''RiskCategory'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[RiskCategory]),
			CONVERT(nvarchar(4000),NEW.[RiskCategory])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeRiskID] = OLD.[InitiativeRiskID])
			AND (
				(
					NEW.[RiskCategory] <>
					OLD.[RiskCategory]
				) Or
				(
					NEW.[RiskCategory] Is Null And
					OLD.[RiskCategory] Is Not Null
				) Or
				(
					NEW.[RiskCategory] Is Not Null And
					OLD.[RiskCategory] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CalculatedRisk]	 column	*/
	If UPDATE([CalculatedRisk])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeRiskID]=N''''''+CAST(IsNull(OLD.[InitiativeRiskID], NEW.[InitiativeRiskID]) as nvarchar(4000))+'''''''',
                ''CalculatedRisk'',
''decimal'', 
			CONVERT(nvarchar(4000),OLD.[CalculatedRisk]),
			CONVERT(nvarchar(4000),NEW.[CalculatedRisk])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeRiskID] = OLD.[InitiativeRiskID])
			AND (
				(
					NEW.[CalculatedRisk] <>
					OLD.[CalculatedRisk]
				) Or
				(
					NEW.[CalculatedRisk] Is Null And
					OLD.[CalculatedRisk] Is Not Null
				) Or
				(
					NEW.[CalculatedRisk] Is Not Null And
					OLD.[CalculatedRisk] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AdjustedRisk]	 column	*/
	If UPDATE([AdjustedRisk])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeRiskID]=N''''''+CAST(IsNull(OLD.[InitiativeRiskID], NEW.[InitiativeRiskID]) as nvarchar(4000))+'''''''',
                ''AdjustedRisk'',
''decimal'', 
			CONVERT(nvarchar(4000),OLD.[AdjustedRisk]),
			CONVERT(nvarchar(4000),NEW.[AdjustedRisk])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeRiskID] = OLD.[InitiativeRiskID])
			AND (
				(
					NEW.[AdjustedRisk] <>
					OLD.[AdjustedRisk]
				) Or
				(
					NEW.[AdjustedRisk] Is Null And
					OLD.[AdjustedRisk] Is Not Null
				) Or
				(
					NEW.[AdjustedRisk] Is Not Null And
					OLD.[AdjustedRisk] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [EurosAtRisk]	 column	*/
	If UPDATE([EurosAtRisk])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeRiskID]=N''''''+CAST(IsNull(OLD.[InitiativeRiskID], NEW.[InitiativeRiskID]) as nvarchar(4000))+'''''''',
                ''EurosAtRisk'',
''money'', 
			CONVERT(nvarchar(4000),OLD.[EurosAtRisk]),
			CONVERT(nvarchar(4000),NEW.[EurosAtRisk])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeRiskID] = OLD.[InitiativeRiskID])
			AND (
				(
					NEW.[EurosAtRisk] <>
					OLD.[EurosAtRisk]
				) Or
				(
					NEW.[EurosAtRisk] Is Null And
					OLD.[EurosAtRisk] Is Not Null
				) Or
				(
					NEW.[EurosAtRisk] Is Not Null And
					OLD.[EurosAtRisk] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Probability]	 column	*/
	If UPDATE([Probability])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeRiskID]=N''''''+CAST(IsNull(OLD.[InitiativeRiskID], NEW.[InitiativeRiskID]) as nvarchar(4000))+'''''''',
                ''Probability'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Probability]),
			CONVERT(nvarchar(4000),NEW.[Probability])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeRiskID] = OLD.[InitiativeRiskID])
			AND (
				(
					NEW.[Probability] <>
					OLD.[Probability]
				) Or
				(
					NEW.[Probability] Is Null And
					OLD.[Probability] Is Not Null
				) Or
				(
					NEW.[Probability] Is Not Null And
					OLD.[Probability] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeRisk]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Deliverable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Deliverable](
	[Name] [nvarchar](255) NULL,
	[DeliverableDescription] [nvarchar](4000) NULL,
	[DueDate] [varchar](25) NULL,
	[Cost] [varchar](25) NULL,
	[AffectedApplications] [nvarchar](200) NULL,
	[RowCommand] [varchar](5) NULL,
	[_UploadID] [int] NOT NULL,
	[_InitiativeID] [int] NULL,
	[_DeliverableID] [int] NULL,
	[_NewFlag] [bit] NULL,
	[_Validated] [bit] NULL,
	[_IsValid] [bit] NULL,
	[_Committed] [bit] NULL,
	[_Fault] [ntext] NULL DEFAULT (''),
	[_FaultCount] [tinyint] NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PPR_Pop_Recent_Versions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PPR_Pop_Recent_Versions](
	[IGIdentifier] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[InPPR] [nvarchar](255) NULL,
	[PPR_OverallStatus] [nvarchar](255) NULL,
	[PPR_CostStatus] [nvarchar](255) NULL,
	[PPR_DeliverablesStatus] [nvarchar](255) NULL,
	[PPR_TimeStatus] [nvarchar](255) NULL,
	[PPR_RisksStatus] [nvarchar](255) NULL,
	[PPR_BenefitsStatus] [nvarchar](255) NULL,
	[PPR_Comments] [ntext] NULL,
	[PPR_OverallDate] [smalldatetime] NULL,
	[PPR_CostDate] [smalldatetime] NULL,
	[PPR_DeliverablesDate] [smalldatetime] NULL,
	[PPR_TimeDate] [smalldatetime] NULL,
	[PPR_RisksDate] [smalldatetime] NULL,
	[PPR_BenefitsDate] [smalldatetime] NULL,
	[PPR_CommentsDate] [smalldatetime] NULL,
	[PPR_OverallChangedBy] [nvarchar](255) NULL,
	[PPR_CostChangedBy] [nvarchar](255) NULL,
	[PPR_DeliverablesChangedBy] [nvarchar](255) NULL,
	[PPR_TimeChangedBy] [nvarchar](255) NULL,
	[PPR_RisksChangedBy] [nvarchar](255) NULL,
	[PPR_BenefitsChangedBy] [nvarchar](255) NULL,
	[PPR_CommentsChangedBy] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PPR_Pop_Latest_Version]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PPR_Pop_Latest_Version](
	[IGIdentifier] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[PrimarySponsoringBusinessUnit] [nvarchar](255) NULL,
	[OtherSponsoringBusinessUnit] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Financial]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Financial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[FinancialCategory] [nvarchar](255) NULL,
	[CategoryType] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Detail] [ntext] NULL,
	[Owner] [nvarchar](255) NULL,
	[StartDate] [varchar](25) NULL,
	[Level9UBR] [nvarchar](255) NULL,
	[_Level10UBR] [nvarchar](255) NULL,
	[PreviousYear] [varchar](20) NULL,
	[Q1CurrentYear] [varchar](20) NULL,
	[Q2CurrentYear] [varchar](20) NULL,
	[Q3CurrentYear] [varchar](20) NULL,
	[Q4CurrentYear] [varchar](20) NULL,
	[Q1SubsequentYear] [varchar](20) NULL,
	[Q2SubsequentYear] [varchar](20) NULL,
	[Q3SubsequentYear] [varchar](20) NULL,
	[Q4SubsequentYear] [varchar](20) NULL,
	[CurrentYearPlus2] [varchar](20) NULL,
	[CurrentYearPlus3] [varchar](20) NULL,
	[CurrentYearPlus4] [varchar](20) NULL,
	[Total] [varchar](20) NULL,
	[InitiativeFinancialID] [int] NULL,
	[RowCommand] [varchar](5) NULL,
	[RowType] [nvarchar](20) NULL,
	[_CategoryID] [int] NULL,
	[_TypeID] [int] NULL,
	[_DescriptionID] [int] NULL,
	[_OwnerID] [int] NULL,
	[_Level9UBRCode] [nvarchar](100) NULL,
	[_Level10UBRCode] [nvarchar](100) NULL,
	[_UBR_ID] [int] NULL,
	[_CalculatedTotal] [decimal](19, 8) NULL,
	[_UploadID] [int] NOT NULL,
	[_InitiativeID] [int] NULL,
	[_NewFlag] [bit] NULL,
	[_Validated] [bit] NULL,
	[_IsValid] [bit] NULL,
	[_Committed] [bit] NULL,
	[_Fault] [ntext] NULL DEFAULT (''),
	[_FaultCount] [tinyint] NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_BenRec]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_BenRec](
	[Name] [nvarchar](255) NULL,
	[ProjectID] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](255) NULL,
	[ProgramName] [nvarchar](255) NULL,
	[ProjectType] [nvarchar](255) NULL,
	[TotalPlanCurrentyearEUR] [varchar](50) NULL,
	[TotalPlanCurrentYearLocalCurrency] [varchar](50) NULL,
	[BaseCurrency] [nvarchar](255) NULL,
	[FXRate] [varchar](50) NULL,
	[RowCommand] [varchar](5) NULL,
	[_ProjectTypeID] [int] NULL,
	[_BaseCurrencyID] [int] NULL,
	[_UploadID] [int] NOT NULL,
	[_InitiativeID] [int] NULL,
	[_NewFlag] [bit] NULL,
	[_Validated] [bit] NULL,
	[_IsValid] [bit] NULL,
	[_Committed] [bit] NULL,
	[_Fault] [ntext] NULL DEFAULT (''),
	[_FaultCount] [tinyint] NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CapexDepreciation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CapexDepreciation](
	[CapexDepreciationID] [int] IDENTITY(1,1) NOT NULL,
	[CapexFinancialID] [int] NULL,
	[DepreciationFinancialID] [int] NULL,
	[InitiativeID] [int] NULL,
 CONSTRAINT [PK_CapexDepreciation] PRIMARY KEY CLUSTERED 
(
	[CapexDepreciationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Result]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Result](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UploadID] [int] NOT NULL,
	[Tab] [varchar](50) NOT NULL,
	[Stage] [varchar](100) NULL,
	[Description] [varchar](1000) NULL,
	[RowsAffected] [int] NULL,
	[Validated] [bit] NULL DEFAULT ((0)),
	[Committed] [bit] NULL DEFAULT ((0))
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Control]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Control](
	[UploadID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[UploadDate] [datetime] NULL
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[IU_Control_UploadDate]'))
EXEC dbo.sp_executesql @statement = N'
		CREATE TRIGGER [dbo].[IU_Control_UploadDate] ON [dbo].[IU_Control] 
		FOR INSERT, UPDATE 
		AS
		UPDATE IU_Control
		SET UploadDate = GetUTCDate()
		FROM Inserted  I, IU_Control L
		WHERE I.UploadID = L.UploadID
		--GO
		SET QUOTED_IDENTIFIER OFF 
		--GO
		SET ANSI_NULLS ON 
		--GO
			

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeITPolicy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeITPolicy](
	[InitiativeITPolicyID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ITPolicyID] [int] NULL,
	[ITPolicyValue] [nvarchar](50) NULL,
	[ITPolicyValueID] [int] NULL,
 CONSTRAINT [PK_InitiativeITPolicy] PRIMARY KEY CLUSTERED 
(
	[InitiativeITPolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeITPolicy]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeITPolicy]
ON [dbo].[InitiativeITPolicy]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeITPolicy]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:58 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeITPolicy]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeITPolicyID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeITPolicy]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeITPolicyID]=N''''''+CAST(OLD.[InitiativeITPolicyID] as nvarchar(4000))+'''''''',
        ''ITPolicyID'',
		CONVERT(nvarchar(4000),OLD.[ITPolicyID])
	FROM deleted OLD
	WHERE
		OLD.[ITPolicyID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeITPolicyID]=N''''''+CAST(OLD.[InitiativeITPolicyID] as nvarchar(4000))+'''''''',
        ''ITPolicyValue'',
		CONVERT(nvarchar(4000),OLD.[ITPolicyValue])
	FROM deleted OLD
	WHERE
		OLD.[ITPolicyValue] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeITPolicyID]=N''''''+CAST(OLD.[InitiativeITPolicyID] as nvarchar(4000))+'''''''',
        ''ITPolicyValueID'',
		CONVERT(nvarchar(4000),OLD.[ITPolicyValueID])
	FROM deleted OLD
	WHERE
		OLD.[ITPolicyValueID] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeITPolicy]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeITPolicy]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeITPolicy]
ON [dbo].[InitiativeITPolicy]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeITPolicy]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:58 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeITPolicyID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeITPolicy]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeITPolicy]	*/
	/*	INSERT audit traces For [ITPolicyID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeITPolicyID]=N''''''+CAST([InitiativeITPolicyID] as nvarchar(4000))+'''''''',
        ''ITPolicyID'',
		convert(nvarchar(4000), [ITPolicyID]) 
	FROM inserted
	WHERE [ITPolicyID] Is Not Null

	/*	INSERT audit traces For [ITPolicyValue]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeITPolicyID]=N''''''+CAST([InitiativeITPolicyID] as nvarchar(4000))+'''''''',
        ''ITPolicyValue'',
		convert(nvarchar(4000), [ITPolicyValue]) 
	FROM inserted
	WHERE [ITPolicyValue] Is Not Null

	/*	INSERT audit traces For [ITPolicyValueID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeITPolicyID]=N''''''+CAST([InitiativeITPolicyID] as nvarchar(4000))+'''''''',
        ''ITPolicyValueID'',
		convert(nvarchar(4000), [ITPolicyValueID]) 
	FROM inserted
	WHERE [ITPolicyValueID] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeITPolicy]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeITPolicy]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeITPolicy]
ON [dbo].[InitiativeITPolicy]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeITPolicy]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:58 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeITPolicyID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeITPolicy]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeITPolicy]	*/
	/*	INSERT audit traces For [ITPolicyID]	 column	*/
	If UPDATE([ITPolicyID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeITPolicyID]=N''''''+CAST(IsNull(OLD.[InitiativeITPolicyID], NEW.[InitiativeITPolicyID]) as nvarchar(4000))+'''''''',
                ''ITPolicyID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ITPolicyID]),
			CONVERT(nvarchar(4000),NEW.[ITPolicyID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeITPolicyID] = OLD.[InitiativeITPolicyID])
			AND (
				(
					NEW.[ITPolicyID] <>
					OLD.[ITPolicyID]
				) Or
				(
					NEW.[ITPolicyID] Is Null And
					OLD.[ITPolicyID] Is Not Null
				) Or
				(
					NEW.[ITPolicyID] Is Not Null And
					OLD.[ITPolicyID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ITPolicyValue]	 column	*/
	If UPDATE([ITPolicyValue])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeITPolicyID]=N''''''+CAST(IsNull(OLD.[InitiativeITPolicyID], NEW.[InitiativeITPolicyID]) as nvarchar(4000))+'''''''',
                ''ITPolicyValue'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[ITPolicyValue]),
			CONVERT(nvarchar(4000),NEW.[ITPolicyValue])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeITPolicyID] = OLD.[InitiativeITPolicyID])
			AND (
				(
					NEW.[ITPolicyValue] <>
					OLD.[ITPolicyValue]
				) Or
				(
					NEW.[ITPolicyValue] Is Null And
					OLD.[ITPolicyValue] Is Not Null
				) Or
				(
					NEW.[ITPolicyValue] Is Not Null And
					OLD.[ITPolicyValue] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ITPolicyValueID]	 column	*/
	If UPDATE([ITPolicyValueID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeITPolicyID]=N''''''+CAST(IsNull(OLD.[InitiativeITPolicyID], NEW.[InitiativeITPolicyID]) as nvarchar(4000))+'''''''',
                ''ITPolicyValueID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ITPolicyValueID]),
			CONVERT(nvarchar(4000),NEW.[ITPolicyValueID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeITPolicyID] = OLD.[InitiativeITPolicyID])
			AND (
				(
					NEW.[ITPolicyValueID] <>
					OLD.[ITPolicyValueID]
				) Or
				(
					NEW.[ITPolicyValueID] Is Null And
					OLD.[ITPolicyValueID] Is Not Null
				) Or
				(
					NEW.[ITPolicyValueID] Is Not Null And
					OLD.[ITPolicyValueID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeITPolicy]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IU_Log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IU_Log](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[UploadID] [int] NOT NULL,
	[Description] [varchar](4000) NULL,
	[RecordsAffected] [int] NULL,
	[LogDate] [datetime] NULL
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[IU_Log_LogDate]'))
EXEC dbo.sp_executesql @statement = N'

		CREATE TRIGGER [dbo].[IU_Log_LogDate] ON [dbo].[IU_Log] 
		FOR INSERT, UPDATE 
		AS
		UPDATE IU_Log
		SET LogDate = GetUTCDate()
		FROM Inserted  I, IU_Log L
		WHERE I.LogID = L.LogID
		--GO
		SET QUOTED_IDENTIFIER OFF 
		--GO
		SET ANSI_NULLS ON 
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITPolicy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ITPolicy](
	[ITPolicyID] [int] NOT NULL,
	[ITPolicyText] [ntext] NULL,
	[CategoryID] [int] NULL,
	[ControlID] [nvarchar](20) NULL,
 CONSTRAINT [PK__InitiativeStatic] PRIMARY KEY CLUSTERED 
(
	[ITPolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[initiativeapplicationcopy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[initiativeapplicationcopy](
	[InitiativeApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ApplicationID] [int] NULL,
	[DecommisioningDate] [datetime] NULL,
	[Impact] [ntext] NULL,
	[InvestmentStrategy] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Period]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Period](
	[PeriodID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[HasQuarters] [bit] NOT NULL,
	[PeriodYear] [int] NOT NULL DEFAULT (0),
PRIMARY KEY CLUSTERED 
(
	[PeriodID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValueType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ValueType](
	[TypeID] [int] NOT NULL,
	[TableName] [nvarchar](50) NULL,
	[QuartersEnabled] [bit] NULL,
 CONSTRAINT [PK_ValueTypes] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeValue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeValue](
	[InitiativeValueID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[TypeID] [int] NULL,
	[ReferenceID] [int] NULL,
	[PeriodID] [int] NULL,
	[QuarterNo] [int] NULL,
	[Amount] [decimal](19, 6) NULL,
 CONSTRAINT [PK_InitiativeValue] PRIMARY KEY CLUSTERED 
(
	[InitiativeValueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeValue]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeValue]
ON [dbo].[InitiativeValue]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeValue]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:02 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeValue]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeValueID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeValue]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST(OLD.[InitiativeValueID] as nvarchar(4000))+'''''''',
        ''TypeID'',
		CONVERT(nvarchar(4000),OLD.[TypeID])
	FROM deleted OLD
	WHERE
		OLD.[TypeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST(OLD.[InitiativeValueID] as nvarchar(4000))+'''''''',
        ''ReferenceID'',
		CONVERT(nvarchar(4000),OLD.[ReferenceID])
	FROM deleted OLD
	WHERE
		OLD.[ReferenceID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST(OLD.[InitiativeValueID] as nvarchar(4000))+'''''''',
        ''PeriodID'',
		CONVERT(nvarchar(4000),OLD.[PeriodID])
	FROM deleted OLD
	WHERE
		OLD.[PeriodID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST(OLD.[InitiativeValueID] as nvarchar(4000))+'''''''',
        ''QuarterNo'',
		CONVERT(nvarchar(4000),OLD.[QuarterNo])
	FROM deleted OLD
	WHERE
		OLD.[QuarterNo] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST(OLD.[InitiativeValueID] as nvarchar(4000))+'''''''',
        ''Amount'',
		CONVERT(nvarchar(4000),OLD.[Amount])
	FROM deleted OLD
	WHERE
		OLD.[Amount] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeValue]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeValue]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeValue]
ON [dbo].[InitiativeValue]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeValue]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:02 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeValueID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeValue]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeValue]	*/
	/*	INSERT audit traces For [TypeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST([InitiativeValueID] as nvarchar(4000))+'''''''',
        ''TypeID'',
		convert(nvarchar(4000), [TypeID]) 
	FROM inserted
	WHERE [TypeID] Is Not Null

	/*	INSERT audit traces For [ReferenceID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST([InitiativeValueID] as nvarchar(4000))+'''''''',
        ''ReferenceID'',
		convert(nvarchar(4000), [ReferenceID]) 
	FROM inserted
	WHERE [ReferenceID] Is Not Null

	/*	INSERT audit traces For [PeriodID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST([InitiativeValueID] as nvarchar(4000))+'''''''',
        ''PeriodID'',
		convert(nvarchar(4000), [PeriodID]) 
	FROM inserted
	WHERE [PeriodID] Is Not Null

	/*	INSERT audit traces For [QuarterNo]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST([InitiativeValueID] as nvarchar(4000))+'''''''',
        ''QuarterNo'',
		convert(nvarchar(4000), [QuarterNo]) 
	FROM inserted
	WHERE [QuarterNo] Is Not Null

	/*	INSERT audit traces For [Amount]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeValueID]=N''''''+CAST([InitiativeValueID] as nvarchar(4000))+'''''''',
        ''Amount'',
		convert(nvarchar(4000), [Amount]) 
	FROM inserted
	WHERE [Amount] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeValue]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeValue]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeValue]
ON [dbo].[InitiativeValue]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeValue]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:02 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeValueID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeValue]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeValue]	*/
	/*	INSERT audit traces For [TypeID]	 column	*/
	If UPDATE([TypeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeValueID]=N''''''+CAST(IsNull(OLD.[InitiativeValueID], NEW.[InitiativeValueID]) as nvarchar(4000))+'''''''',
                ''TypeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[TypeID]),
			CONVERT(nvarchar(4000),NEW.[TypeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeValueID] = OLD.[InitiativeValueID])
			AND (
				(
					NEW.[TypeID] <>
					OLD.[TypeID]
				) Or
				(
					NEW.[TypeID] Is Null And
					OLD.[TypeID] Is Not Null
				) Or
				(
					NEW.[TypeID] Is Not Null And
					OLD.[TypeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [ReferenceID]	 column	*/
	If UPDATE([ReferenceID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeValueID]=N''''''+CAST(IsNull(OLD.[InitiativeValueID], NEW.[InitiativeValueID]) as nvarchar(4000))+'''''''',
                ''ReferenceID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ReferenceID]),
			CONVERT(nvarchar(4000),NEW.[ReferenceID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeValueID] = OLD.[InitiativeValueID])
			AND (
				(
					NEW.[ReferenceID] <>
					OLD.[ReferenceID]
				) Or
				(
					NEW.[ReferenceID] Is Null And
					OLD.[ReferenceID] Is Not Null
				) Or
				(
					NEW.[ReferenceID] Is Not Null And
					OLD.[ReferenceID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [PeriodID]	 column	*/
	If UPDATE([PeriodID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeValueID]=N''''''+CAST(IsNull(OLD.[InitiativeValueID], NEW.[InitiativeValueID]) as nvarchar(4000))+'''''''',
                ''PeriodID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[PeriodID]),
			CONVERT(nvarchar(4000),NEW.[PeriodID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeValueID] = OLD.[InitiativeValueID])
			AND (
				(
					NEW.[PeriodID] <>
					OLD.[PeriodID]
				) Or
				(
					NEW.[PeriodID] Is Null And
					OLD.[PeriodID] Is Not Null
				) Or
				(
					NEW.[PeriodID] Is Not Null And
					OLD.[PeriodID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [QuarterNo]	 column	*/
	If UPDATE([QuarterNo])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeValueID]=N''''''+CAST(IsNull(OLD.[InitiativeValueID], NEW.[InitiativeValueID]) as nvarchar(4000))+'''''''',
                ''QuarterNo'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[QuarterNo]),
			CONVERT(nvarchar(4000),NEW.[QuarterNo])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeValueID] = OLD.[InitiativeValueID])
			AND (
				(
					NEW.[QuarterNo] <>
					OLD.[QuarterNo]
				) Or
				(
					NEW.[QuarterNo] Is Null And
					OLD.[QuarterNo] Is Not Null
				) Or
				(
					NEW.[QuarterNo] Is Not Null And
					OLD.[QuarterNo] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Amount]	 column	*/
	If UPDATE([Amount])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeValueID]=N''''''+CAST(IsNull(OLD.[InitiativeValueID], NEW.[InitiativeValueID]) as nvarchar(4000))+'''''''',
                ''Amount'',
''money'', 
			CONVERT(nvarchar(4000),OLD.[Amount]),
			CONVERT(nvarchar(4000),NEW.[Amount])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeValueID] = OLD.[InitiativeValueID])
			AND (
				(
					NEW.[Amount] <>
					OLD.[Amount]
				) Or
				(
					NEW.[Amount] Is Null And
					OLD.[Amount] Is Not Null
				) Or
				(
					NEW.[Amount] Is Not Null And
					OLD.[Amount] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeValue]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applicationold]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Applicationold](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationInstanceName] [nvarchar](50) NULL,
	[ExternalApplicationID] [nvarchar](10) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Applicati__IsDel__7740A8A4]  DEFAULT (0),
PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jg_tmpInsert]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[jg_tmpInsert](
	[i] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Quarter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Quarter](
	[QuarterNo] [int] NOT NULL,
 CONSTRAINT [PK_Quarters] PRIMARY KEY CLUSTERED 
(
	[QuarterNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeImpact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeImpact](
	[InitiativeImpactID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[NonComplianceTypeID] [int] NULL,
	[NonComplianceType] [nvarchar](50) NULL,
	[AgreedAlternative] [ntext] NULL,
	[CTB_RTBID] [int] NULL,
	[CTB_RTB] [nvarchar](10) NULL,
	[CIO_CTOID] [int] NULL,
	[CIO_CTO] [nvarchar](10) NULL,
	[Remediation] [ntext] NULL,
 CONSTRAINT [PK__InitiativeImpact] PRIMARY KEY CLUSTERED 
(
	[InitiativeImpactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeImpact]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeImpact]
ON [dbo].[InitiativeImpact]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeImpact]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:58 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeImpact]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeImpactID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeImpact]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(OLD.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''NonComplianceTypeID'',
		CONVERT(nvarchar(4000),OLD.[NonComplianceTypeID])
	FROM deleted OLD
	WHERE
		OLD.[NonComplianceTypeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(OLD.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''NonComplianceType'',
		CONVERT(nvarchar(4000),OLD.[NonComplianceType])
	FROM deleted OLD
	WHERE
		OLD.[NonComplianceType] Is Not Null


	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(OLD.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CTB_RTBID'',
		CONVERT(nvarchar(4000),OLD.[CTB_RTBID])
	FROM deleted OLD
	WHERE
		OLD.[CTB_RTBID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(OLD.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CTB_RTB'',
		CONVERT(nvarchar(4000),OLD.[CTB_RTB])
	FROM deleted OLD
	WHERE
		OLD.[CTB_RTB] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(OLD.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CIO_CTOID'',
		CONVERT(nvarchar(4000),OLD.[CIO_CTOID])
	FROM deleted OLD
	WHERE
		OLD.[CIO_CTOID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(OLD.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CIO_CTO'',
		CONVERT(nvarchar(4000),OLD.[CIO_CTO])
	FROM deleted OLD
	WHERE
		OLD.[CIO_CTO] Is Not Null


	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeImpact]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeImpact]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeImpact]
ON [dbo].[InitiativeImpact]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeImpact]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:58 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeImpactID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeImpact]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeImpact]	*/
	/*	INSERT audit traces For [NonComplianceTypeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST([InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''NonComplianceTypeID'',
		convert(nvarchar(4000), [NonComplianceTypeID]) 
	FROM inserted
	WHERE [NonComplianceTypeID] Is Not Null

	/*	INSERT audit traces For [NonComplianceType]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST([InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''NonComplianceType'',
		convert(nvarchar(4000), [NonComplianceType]) 
	FROM inserted
	WHERE [NonComplianceType] Is Not Null

	/*	INSERT audit traces For [AgreedAlternative]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(NEW.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''AgreedAlternative'',
			ORD.[AgreedAlternative]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeImpact] ORD 
                    ON ORD.[InitiativeImpactID]=NEW.[InitiativeImpactID]		WHERE
			ORD.[AgreedAlternative] Is Not Null


	/*	INSERT audit traces For [CTB_RTBID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST([InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CTB_RTBID'',
		convert(nvarchar(4000), [CTB_RTBID]) 
	FROM inserted
	WHERE [CTB_RTBID] Is Not Null

	/*	INSERT audit traces For [CTB_RTB]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST([InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CTB_RTB'',
		convert(nvarchar(4000), [CTB_RTB]) 
	FROM inserted
	WHERE [CTB_RTB] Is Not Null

	/*	INSERT audit traces For [CIO_CTOID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST([InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CIO_CTOID'',
		convert(nvarchar(4000), [CIO_CTOID]) 
	FROM inserted
	WHERE [CIO_CTOID] Is Not Null

	/*	INSERT audit traces For [CIO_CTO]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST([InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''CIO_CTO'',
		convert(nvarchar(4000), [CIO_CTO]) 
	FROM inserted
	WHERE [CIO_CTO] Is Not Null

	/*	INSERT audit traces For [Remediation]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeImpactID]=N''''''+CAST(NEW.[InitiativeImpactID] as nvarchar(4000))+'''''''',
        ''Remediation'',
			ORD.[Remediation]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeImpact] ORD 
                    ON ORD.[InitiativeImpactID]=NEW.[InitiativeImpactID]		WHERE
			ORD.[Remediation] Is Not Null


	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeImpact]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeImpact]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeImpact]
ON [dbo].[InitiativeImpact]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeImpact]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:58 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeImpactID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeImpact]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeImpact]	*/
	/*	INSERT audit traces For [NonComplianceTypeID]	 column	*/
	If UPDATE([NonComplianceTypeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(OLD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''NonComplianceTypeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[NonComplianceTypeID]),
			CONVERT(nvarchar(4000),NEW.[NonComplianceTypeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeImpactID] = OLD.[InitiativeImpactID])
			AND (
				(
					NEW.[NonComplianceTypeID] <>
					OLD.[NonComplianceTypeID]
				) Or
				(
					NEW.[NonComplianceTypeID] Is Null And
					OLD.[NonComplianceTypeID] Is Not Null
				) Or
				(
					NEW.[NonComplianceTypeID] Is Not Null And
					OLD.[NonComplianceTypeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [NonComplianceType]	 column	*/
	If UPDATE([NonComplianceType])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(OLD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''NonComplianceType'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[NonComplianceType]),
			CONVERT(nvarchar(4000),NEW.[NonComplianceType])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeImpactID] = OLD.[InitiativeImpactID])
			AND (
				(
					NEW.[NonComplianceType] <>
					OLD.[NonComplianceType]
				) Or
				(
					NEW.[NonComplianceType] Is Null And
					OLD.[NonComplianceType] Is Not Null
				) Or
				(
					NEW.[NonComplianceType] Is Not Null And
					OLD.[NonComplianceType] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [AgreedAlternative]	 column	*/
	If UPDATE([AgreedAlternative])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(ORD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''AgreedAlternative'',
''ntext'', 
			ORD.[AgreedAlternative]
		FROM inserted NEW JOIN [dbo].[InitiativeImpact] ORD 
                    ON ORD.[InitiativeImpactID]=NEW.[InitiativeImpactID]
				/*
			AND (
				(
					SUBSTRING(NEW.[AgreedAlternative], 0, 1024) <>
					SUBSTRING(ORD.[AgreedAlternative], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[AgreedAlternative], 0, 1024) Is Null And
					SUBSTRING(ORD.[AgreedAlternative], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[AgreedAlternative], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[AgreedAlternative], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[AgreedAlternative] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CTB_RTBID]	 column	*/
	If UPDATE([CTB_RTBID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(OLD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''CTB_RTBID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CTB_RTBID]),
			CONVERT(nvarchar(4000),NEW.[CTB_RTBID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeImpactID] = OLD.[InitiativeImpactID])
			AND (
				(
					NEW.[CTB_RTBID] <>
					OLD.[CTB_RTBID]
				) Or
				(
					NEW.[CTB_RTBID] Is Null And
					OLD.[CTB_RTBID] Is Not Null
				) Or
				(
					NEW.[CTB_RTBID] Is Not Null And
					OLD.[CTB_RTBID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CTB_RTB]	 column	*/
	If UPDATE([CTB_RTB])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(OLD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''CTB_RTB'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CTB_RTB]),
			CONVERT(nvarchar(4000),NEW.[CTB_RTB])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeImpactID] = OLD.[InitiativeImpactID])
			AND (
				(
					NEW.[CTB_RTB] <>
					OLD.[CTB_RTB]
				) Or
				(
					NEW.[CTB_RTB] Is Null And
					OLD.[CTB_RTB] Is Not Null
				) Or
				(
					NEW.[CTB_RTB] Is Not Null And
					OLD.[CTB_RTB] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIO_CTOID]	 column	*/
	If UPDATE([CIO_CTOID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(OLD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''CIO_CTOID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CIO_CTOID]),
			CONVERT(nvarchar(4000),NEW.[CIO_CTOID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeImpactID] = OLD.[InitiativeImpactID])
			AND (
				(
					NEW.[CIO_CTOID] <>
					OLD.[CIO_CTOID]
				) Or
				(
					NEW.[CIO_CTOID] Is Null And
					OLD.[CIO_CTOID] Is Not Null
				) Or
				(
					NEW.[CIO_CTOID] Is Not Null And
					OLD.[CIO_CTOID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CIO_CTO]	 column	*/
	If UPDATE([CIO_CTO])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(OLD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''CIO_CTO'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CIO_CTO]),
			CONVERT(nvarchar(4000),NEW.[CIO_CTO])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeImpactID] = OLD.[InitiativeImpactID])
			AND (
				(
					NEW.[CIO_CTO] <>
					OLD.[CIO_CTO]
				) Or
				(
					NEW.[CIO_CTO] Is Null And
					OLD.[CIO_CTO] Is Not Null
				) Or
				(
					NEW.[CIO_CTO] Is Not Null And
					OLD.[CIO_CTO] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Remediation]	 column	*/
	If UPDATE([Remediation])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeImpactID]=N''''''+CAST(IsNull(ORD.[InitiativeImpactID], NEW.[InitiativeImpactID]) as nvarchar(4000))+'''''''',
                ''Remediation'',
''ntext'', 
			ORD.[Remediation]
		FROM inserted NEW JOIN [dbo].[InitiativeImpact] ORD 
                    ON ORD.[InitiativeImpactID]=NEW.[InitiativeImpactID]
				/*
			AND (
				(
					SUBSTRING(NEW.[Remediation], 0, 1024) <>
					SUBSTRING(ORD.[Remediation], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[Remediation], 0, 1024) Is Null And
					SUBSTRING(ORD.[Remediation], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[Remediation], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[Remediation], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[Remediation] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeImpact]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Server]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Server](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[ServerNodeName] [nvarchar](50) NULL,
	[ExternalServerNodeID] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Server__IsDelete__7834CCDD]  DEFAULT (0),
PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UBRSponsorMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UBRSponsorMapping](
	[CustomGrouping] [nvarchar](50) NOT NULL,
	[SponsorID] [char](10) NULL,
	[Owner] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeApplication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeApplication](
	[InitiativeApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ApplicationID] [int] NULL,
	[DecommisioningDate] [datetime] NULL,
	[Impact] [ntext] NULL,
	[InvestmentStrategy] [nvarchar](50) NULL,
 CONSTRAINT [PK_InitiativeApplication] PRIMARY KEY CLUSTERED 
(
	[InitiativeApplicationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeApplication]'))
EXEC dbo.sp_executesql @statement = N'


CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeApplication]
ON [dbo].[InitiativeApplication]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeApplication]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeApplication]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeApplicationID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeApplication]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST(OLD.[InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''ApplicationID'',
		CONVERT(nvarchar(4000),OLD.[ApplicationID])
	FROM deleted OLD
	WHERE
		OLD.[ApplicationID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST(OLD.[InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''DecommisioningDate'',
		CONVERT(nvarchar(4000),OLD.[DecommisioningDate])
	FROM deleted OLD
	WHERE
		OLD.[DecommisioningDate] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST(OLD.[InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''InvestmentStrategy'',
		CONVERT(nvarchar(4000),OLD.[InvestmentStrategy])
	FROM deleted OLD
	WHERE
		OLD.[InvestmentStrategy] Is Not Null

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeApplication]'))
EXEC dbo.sp_executesql @statement = N'


CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeApplication]
ON [dbo].[InitiativeApplication]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeApplication]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeApplicationID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeApplication]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeApplication]	*/
	/*	INSERT audit traces For [ApplicationID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST([InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''ApplicationID'',
		convert(nvarchar(4000), [ApplicationID]) 
	FROM inserted
	WHERE [ApplicationID] Is Not Null

	/*	INSERT audit traces For [DecommisioningDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST([InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''DecommisioningDate'',
		convert(nvarchar(4000), [DecommisioningDate]) 
	FROM inserted
	WHERE [DecommisioningDate] Is Not Null

	/*	INSERT audit traces For [Impact]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST(NEW.[InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''Impact'',
			ORD.[Impact]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeApplication] ORD 
                    ON ORD.[InitiativeApplicationID]=NEW.[InitiativeApplicationID]		WHERE
			ORD.[Impact] Is Not Null

	/*	INSERT audit traces For [InvestmentStrategy]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeApplicationID]=N''''''+CAST(NEW.[InitiativeApplicationID] as nvarchar(4000))+'''''''',
        ''InvestmentStrategy'',
			ORD.[Impact]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeApplication] ORD 
                    ON ORD.[InitiativeApplicationID]=NEW.[InitiativeApplicationID]		WHERE
			ORD.[InvestmentStrategy] Is Not Null


	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End


' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeApplication]'))
EXEC dbo.sp_executesql @statement = N'


CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeApplication]
ON [dbo].[InitiativeApplication]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeApplication]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:56 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeApplicationID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeApplication]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeApplication]	*/
	/*	INSERT audit traces For [ApplicationID]	 column	*/
	If UPDATE([ApplicationID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeApplicationID]=N''''''+CAST(IsNull(OLD.[InitiativeApplicationID], NEW.[InitiativeApplicationID]) as nvarchar(4000))+'''''''',
                ''ApplicationID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ApplicationID]),
			CONVERT(nvarchar(4000),NEW.[ApplicationID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeApplicationID] = OLD.[InitiativeApplicationID])
			AND (
				(
					NEW.[ApplicationID] <>
					OLD.[ApplicationID]
				) Or
				(
					NEW.[ApplicationID] Is Null And
					OLD.[ApplicationID] Is Not Null
				) Or
				(
					NEW.[ApplicationID] Is Not Null And
					OLD.[ApplicationID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DecommisioningDate]	 column	*/
	If UPDATE([DecommisioningDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeApplicationID]=N''''''+CAST(IsNull(OLD.[InitiativeApplicationID], NEW.[InitiativeApplicationID]) as nvarchar(4000))+'''''''',
                ''DecommisioningDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[DecommisioningDate]),
			CONVERT(nvarchar(4000),NEW.[DecommisioningDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeApplicationID] = OLD.[InitiativeApplicationID])
			AND (
				(
					NEW.[DecommisioningDate] <>
					OLD.[DecommisioningDate]
				) Or
				(
					NEW.[DecommisioningDate] Is Null And
					OLD.[DecommisioningDate] Is Not Null
				) Or
				(
					NEW.[DecommisioningDate] Is Not Null And
					OLD.[DecommisioningDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Impact]	 column	*/
	If UPDATE([Impact])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeApplicationID]=N''''''+CAST(IsNull(ORD.[InitiativeApplicationID], NEW.[InitiativeApplicationID]) as nvarchar(4000))+'''''''',
                ''Impact'',
''ntext'', 
			ORD.[Impact]
		FROM inserted NEW JOIN [dbo].[InitiativeApplication] ORD 
                    ON ORD.[InitiativeApplicationID]=NEW.[InitiativeApplicationID]
				/*
			AND (
				(
					SUBSTRING(NEW.[Impact], 0, 1024) <>
					SUBSTRING(ORD.[Impact], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[Impact], 0, 1024) Is Null And
					SUBSTRING(ORD.[Impact], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[Impact], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[Impact], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[Impact] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [InvestmentStrategy]	 column	*/
	If UPDATE([InvestmentStrategy])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeApplicationID]=N''''''+CAST(IsNull(OLD.[InitiativeApplicationID], NEW.[InitiativeApplicationID]) as nvarchar(4000))+'''''''',
                ''InvestmentStrategy'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[InvestmentStrategy]),
			CONVERT(nvarchar(4000),NEW.[InvestmentStrategy])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeApplicationID] = OLD.[InitiativeApplicationID])
			AND (
				(
					NEW.[InvestmentStrategy] <>
					OLD.[InvestmentStrategy]
				) Or
				(
					NEW.[InvestmentStrategy] Is Null And
					OLD.[InvestmentStrategy] Is Not Null
				) Or
				(
					NEW.[InvestmentStrategy] Is Not Null And
					OLD.[InvestmentStrategy] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End


' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeFinancial]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeFinancial](
	[InitiativeFinancialID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[Category] [nvarchar](50) NULL,
	[CategoryID] [int] NULL,
	[Type] [nvarchar](50) NULL,
	[TypeID] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[DescriptionID] [int] NULL,
	[Comments] [nvarchar](255) NULL,
	[OwnerID] [int] NULL,
	[BusinessGTLevel5Name] [nvarchar](50) NULL,
	[BusinessGTLevel5Code] [nvarchar](10) NULL,
	[BusinessGTLevel6Name] [nvarchar](50) NULL,
	[BusinessGTLevel6Code] [nvarchar](10) NULL,
	[BusinessGTLevel7Name] [nvarchar](50) NULL,
	[BusinessGTLevel7Code] [nvarchar](10) NULL,
	[BusinessGTLevel8Name] [nvarchar](50) NULL,
	[BusinessGTLevel8Code] [nvarchar](10) NULL,
	[BusinessGTLevel9Name] [nvarchar](50) NULL,
	[BusinessGTLevel9Code] [nvarchar](10) NULL,
	[BusinessGTLevel10Name] [nvarchar](50) NULL,
	[BusinessGTLevel10Code] [nvarchar](10) NULL,
	[UBR_ID] [int] NULL,
	[StartDate] [datetime] NULL,
	[CustomGrouping] [nvarchar](50) NULL,
 CONSTRAINT [PK__InitiativeBenefit] PRIMARY KEY CLUSTERED 
(
	[InitiativeFinancialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeFinancial]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeFinancial]
ON [dbo].[InitiativeFinancial]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeFinancial]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:57 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeFinancial]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeFinancialID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeFinancial]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Category'',
		CONVERT(nvarchar(4000),OLD.[Category])
	FROM deleted OLD
	WHERE
		OLD.[Category] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''CategoryID'',
		CONVERT(nvarchar(4000),OLD.[CategoryID])
	FROM deleted OLD
	WHERE
		OLD.[CategoryID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Type'',
		CONVERT(nvarchar(4000),OLD.[Type])
	FROM deleted OLD
	WHERE
		OLD.[Type] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''TypeID'',
		CONVERT(nvarchar(4000),OLD.[TypeID])
	FROM deleted OLD
	WHERE
		OLD.[TypeID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Description'',
		CONVERT(nvarchar(4000),OLD.[Description])
	FROM deleted OLD
	WHERE
		OLD.[Description] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''DescriptionID'',
		CONVERT(nvarchar(4000),OLD.[DescriptionID])
	FROM deleted OLD
	WHERE
		OLD.[DescriptionID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Comments'',
		CONVERT(nvarchar(4000),OLD.[Comments])
	FROM deleted OLD
	WHERE
		OLD.[Comments] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''OwnerID'',
		CONVERT(nvarchar(4000),OLD.[OwnerID])
	FROM deleted OLD
	WHERE
		OLD.[OwnerID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel5Name'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel5Name])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel5Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel5Code'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel5Code])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel5Code] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel6Name'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel6Name])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel6Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel6Code'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel6Code])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel6Code] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel7Name'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel7Name])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel7Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel7Code'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel7Code])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel7Code] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel8Name'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel8Name])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel8Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel8Code'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel8Code])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel8Code] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel9Name'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel9Name])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel9Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel9Code'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel9Code])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel9Code] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel10Name'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel10Name])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel10Name] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel10Code'',
		CONVERT(nvarchar(4000),OLD.[BusinessGTLevel10Code])
	FROM deleted OLD
	WHERE
		OLD.[BusinessGTLevel10Code] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''UBR_ID'',
		CONVERT(nvarchar(4000),OLD.[UBR_ID])
	FROM deleted OLD
	WHERE
		OLD.[UBR_ID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''StartDate'',
		CONVERT(nvarchar(4000),OLD.[StartDate])
	FROM deleted OLD
	WHERE
		OLD.[StartDate] Is Not Null

	-- Added 2007-10-16, GMcF, for HW request to add column CustomGrouping to table InitiativeFinancial
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST(OLD.[InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''CustomGrouping'',
		CONVERT(nvarchar(4000),OLD.[CustomGrouping])
	FROM deleted OLD
	WHERE
		OLD.[CustomGrouping] Is Not Null



	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

END

' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeFinancial]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeFinancial]
ON [dbo].[InitiativeFinancial]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeFinancial]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:57 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY					nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeFinancialID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeFinancial]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeFinancial]	*/
	/*	INSERT audit traces For [Category]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Category'',
		convert(nvarchar(4000), [Category]) 
	FROM inserted
	WHERE [Category] Is Not Null

	/*	INSERT audit traces For [CategoryID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''CategoryID'',
		convert(nvarchar(4000), [CategoryID]) 
	FROM inserted
	WHERE [CategoryID] Is Not Null

	/*	INSERT audit traces For [Type]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Type'',
		convert(nvarchar(4000), [Type]) 
	FROM inserted
	WHERE [Type] Is Not Null

	/*	INSERT audit traces For [TypeID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''TypeID'',
		convert(nvarchar(4000), [TypeID]) 
	FROM inserted
	WHERE [TypeID] Is Not Null

	/*	INSERT audit traces For [Description]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Description'',
		convert(nvarchar(4000), [Description]) 
	FROM inserted
	WHERE [Description] Is Not Null

	/*	INSERT audit traces For [DescriptionID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''DescriptionID'',
		convert(nvarchar(4000), [DescriptionID]) 
	FROM inserted
	WHERE [DescriptionID] Is Not Null

	/*	INSERT audit traces For [Comments]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''Comments'',
		convert(nvarchar(4000), [Comments]) 
	FROM inserted
	WHERE [Comments] Is Not Null

	/*	INSERT audit traces For [OwnerID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''OwnerID'',
		convert(nvarchar(4000), [OwnerID]) 
	FROM inserted
	WHERE [OwnerID] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel5Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel5Name'',
		convert(nvarchar(4000), [BusinessGTLevel5Name]) 
	FROM inserted
	WHERE [BusinessGTLevel5Name] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel5Code]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel5Code'',
		convert(nvarchar(4000), [BusinessGTLevel5Code]) 
	FROM inserted
	WHERE [BusinessGTLevel5Code] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel6Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel6Name'',
		convert(nvarchar(4000), [BusinessGTLevel6Name]) 
	FROM inserted
	WHERE [BusinessGTLevel6Name] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel6Code]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel6Code'',
		convert(nvarchar(4000), [BusinessGTLevel6Code]) 
	FROM inserted
	WHERE [BusinessGTLevel6Code] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel7Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel7Name'',
		convert(nvarchar(4000), [BusinessGTLevel7Name]) 
	FROM inserted
	WHERE [BusinessGTLevel7Name] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel7Code]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel7Code'',
		convert(nvarchar(4000), [BusinessGTLevel7Code]) 
	FROM inserted
	WHERE [BusinessGTLevel7Code] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel8Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel8Name'',
		convert(nvarchar(4000), [BusinessGTLevel8Name]) 
	FROM inserted
	WHERE [BusinessGTLevel8Name] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel8Code]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel8Code'',
		convert(nvarchar(4000), [BusinessGTLevel8Code]) 
	FROM inserted
	WHERE [BusinessGTLevel8Code] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel9Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel9Name'',
		convert(nvarchar(4000), [BusinessGTLevel9Name]) 
	FROM inserted
	WHERE [BusinessGTLevel9Name] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel9Code]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel9Code'',
		convert(nvarchar(4000), [BusinessGTLevel9Code]) 
	FROM inserted
	WHERE [BusinessGTLevel9Code] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel10Name]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel10Name'',
		convert(nvarchar(4000), [BusinessGTLevel10Name]) 
	FROM inserted
	WHERE [BusinessGTLevel10Name] Is Not Null

	/*	INSERT audit traces For [BusinessGTLevel10Code]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''BusinessGTLevel10Code'',
		convert(nvarchar(4000), [BusinessGTLevel10Code]) 
	FROM inserted
	WHERE [BusinessGTLevel10Code] Is Not Null

	/*	INSERT audit traces For [UBR_ID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''UBR_ID'',
		convert(nvarchar(4000), [UBR_ID]) 
	FROM inserted
	WHERE [UBR_ID] Is Not Null

	/*	INSERT audit traces For [StartDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''StartDate'',
		convert(nvarchar(4000), [StartDate]) 
	FROM inserted
	WHERE [StartDate] Is Not Null

	/*	INSERT audit traces For [CustomGrouping]	 column	*/
	-- Added 2007-10-16. GMcF, for HW request to add column CustomGrouping to table InitiativeFinancial
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeFinancialID]=N''''''+CAST([InitiativeFinancialID] as nvarchar(4000))+'''''''',
        ''CustomGrouping'',
		convert(nvarchar(4000), [CustomGrouping]) 
	FROM inserted
	WHERE [CustomGrouping] Is Not Null

	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End

' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeFinancial]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeFinancial]
ON [dbo].[InitiativeFinancial]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeFinancial]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:43:57 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeFinancialID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeFinancial]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeFinancial]	*/
	/*	INSERT audit traces For [Category]	 column	*/
	If UPDATE([Category])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''Category'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Category]),
			CONVERT(nvarchar(4000),NEW.[Category])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[Category] <>
					OLD.[Category]
				) Or
				(
					NEW.[Category] Is Null And
					OLD.[Category] Is Not Null
				) Or
				(
					NEW.[Category] Is Not Null And
					OLD.[Category] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CategoryID]	 column	*/
	If UPDATE([CategoryID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''CategoryID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[CategoryID]),
			CONVERT(nvarchar(4000),NEW.[CategoryID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[CategoryID] <>
					OLD.[CategoryID]
				) Or
				(
					NEW.[CategoryID] Is Null And
					OLD.[CategoryID] Is Not Null
				) Or
				(
					NEW.[CategoryID] Is Not Null And
					OLD.[CategoryID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Type]	 column	*/
	If UPDATE([Type])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''Type'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Type]),
			CONVERT(nvarchar(4000),NEW.[Type])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[Type] <>
					OLD.[Type]
				) Or
				(
					NEW.[Type] Is Null And
					OLD.[Type] Is Not Null
				) Or
				(
					NEW.[Type] Is Not Null And
					OLD.[Type] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [TypeID]	 column	*/
	If UPDATE([TypeID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''TypeID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[TypeID]),
			CONVERT(nvarchar(4000),NEW.[TypeID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[TypeID] <>
					OLD.[TypeID]
				) Or
				(
					NEW.[TypeID] Is Null And
					OLD.[TypeID] Is Not Null
				) Or
				(
					NEW.[TypeID] Is Not Null And
					OLD.[TypeID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Description]	 column	*/
	If UPDATE([Description])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''Description'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Description]),
			CONVERT(nvarchar(4000),NEW.[Description])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[Description] <>
					OLD.[Description]
				) Or
				(
					NEW.[Description] Is Null And
					OLD.[Description] Is Not Null
				) Or
				(
					NEW.[Description] Is Not Null And
					OLD.[Description] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DescriptionID]	 column	*/
	If UPDATE([DescriptionID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''DescriptionID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[DescriptionID]),
			CONVERT(nvarchar(4000),NEW.[DescriptionID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[DescriptionID] <>
					OLD.[DescriptionID]
				) Or
				(
					NEW.[DescriptionID] Is Null And
					OLD.[DescriptionID] Is Not Null
				) Or
				(
					NEW.[DescriptionID] Is Not Null And
					OLD.[DescriptionID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Comments]	 column	*/
	If UPDATE([Comments])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''Comments'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[Comments]),
			CONVERT(nvarchar(4000),NEW.[Comments])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[Comments] <>
					OLD.[Comments]
				) Or
				(
					NEW.[Comments] Is Null And
					OLD.[Comments] Is Not Null
				) Or
				(
					NEW.[Comments] Is Not Null And
					OLD.[Comments] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [OwnerID]	 column	*/
	If UPDATE([OwnerID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''OwnerID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[OwnerID]),
			CONVERT(nvarchar(4000),NEW.[OwnerID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[OwnerID] <>
					OLD.[OwnerID]
				) Or
				(
					NEW.[OwnerID] Is Null And
					OLD.[OwnerID] Is Not Null
				) Or
				(
					NEW.[OwnerID] Is Not Null And
					OLD.[OwnerID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel5Name]	 column	*/
	If UPDATE([BusinessGTLevel5Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel5Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel5Name]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel5Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel5Name] <>
					OLD.[BusinessGTLevel5Name]
				) Or
				(
					NEW.[BusinessGTLevel5Name] Is Null And
					OLD.[BusinessGTLevel5Name] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel5Name] Is Not Null And
					OLD.[BusinessGTLevel5Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel5Code]	 column	*/
	If UPDATE([BusinessGTLevel5Code])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel5Code'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel5Code]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel5Code])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel5Code] <>
					OLD.[BusinessGTLevel5Code]
				) Or
				(
					NEW.[BusinessGTLevel5Code] Is Null And
					OLD.[BusinessGTLevel5Code] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel5Code] Is Not Null And
					OLD.[BusinessGTLevel5Code] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel6Name]	 column	*/
	If UPDATE([BusinessGTLevel6Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel6Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel6Name]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel6Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel6Name] <>
					OLD.[BusinessGTLevel6Name]
				) Or
				(
					NEW.[BusinessGTLevel6Name] Is Null And
					OLD.[BusinessGTLevel6Name] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel6Name] Is Not Null And
					OLD.[BusinessGTLevel6Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel6Code]	 column	*/
	If UPDATE([BusinessGTLevel6Code])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel6Code'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel6Code]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel6Code])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel6Code] <>
					OLD.[BusinessGTLevel6Code]
				) Or
				(
					NEW.[BusinessGTLevel6Code] Is Null And
					OLD.[BusinessGTLevel6Code] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel6Code] Is Not Null And
					OLD.[BusinessGTLevel6Code] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel7Name]	 column	*/
	If UPDATE([BusinessGTLevel7Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel7Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel7Name]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel7Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel7Name] <>
					OLD.[BusinessGTLevel7Name]
				) Or
				(
					NEW.[BusinessGTLevel7Name] Is Null And
					OLD.[BusinessGTLevel7Name] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel7Name] Is Not Null And
					OLD.[BusinessGTLevel7Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel7Code]	 column	*/
	If UPDATE([BusinessGTLevel7Code])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel7Code'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel7Code]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel7Code])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel7Code] <>
					OLD.[BusinessGTLevel7Code]
				) Or
				(
					NEW.[BusinessGTLevel7Code] Is Null And
					OLD.[BusinessGTLevel7Code] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel7Code] Is Not Null And
					OLD.[BusinessGTLevel7Code] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel8Name]	 column	*/
	If UPDATE([BusinessGTLevel8Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel8Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel8Name]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel8Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel8Name] <>
					OLD.[BusinessGTLevel8Name]
				) Or
				(
					NEW.[BusinessGTLevel8Name] Is Null And
					OLD.[BusinessGTLevel8Name] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel8Name] Is Not Null And
					OLD.[BusinessGTLevel8Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel8Code]	 column	*/
	If UPDATE([BusinessGTLevel8Code])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel8Code'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel8Code]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel8Code])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel8Code] <>
					OLD.[BusinessGTLevel8Code]
				) Or
				(
					NEW.[BusinessGTLevel8Code] Is Null And
					OLD.[BusinessGTLevel8Code] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel8Code] Is Not Null And
					OLD.[BusinessGTLevel8Code] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel9Name]	 column	*/
	If UPDATE([BusinessGTLevel9Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel9Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel9Name]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel9Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel9Name] <>
					OLD.[BusinessGTLevel9Name]
				) Or
				(
					NEW.[BusinessGTLevel9Name] Is Null And
					OLD.[BusinessGTLevel9Name] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel9Name] Is Not Null And
					OLD.[BusinessGTLevel9Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel9Code]	 column	*/
	If UPDATE([BusinessGTLevel9Code])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel9Code'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel9Code]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel9Code])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel9Code] <>
					OLD.[BusinessGTLevel9Code]
				) Or
				(
					NEW.[BusinessGTLevel9Code] Is Null And
					OLD.[BusinessGTLevel9Code] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel9Code] Is Not Null And
					OLD.[BusinessGTLevel9Code] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel10Name]	 column	*/
	If UPDATE([BusinessGTLevel10Name])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel10Name'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel10Name]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel10Name])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel10Name] <>
					OLD.[BusinessGTLevel10Name]
				) Or
				(
					NEW.[BusinessGTLevel10Name] Is Null And
					OLD.[BusinessGTLevel10Name] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel10Name] Is Not Null And
					OLD.[BusinessGTLevel10Name] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [BusinessGTLevel10Code]	 column	*/
	If UPDATE([BusinessGTLevel10Code])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''BusinessGTLevel10Code'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[BusinessGTLevel10Code]),
			CONVERT(nvarchar(4000),NEW.[BusinessGTLevel10Code])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[BusinessGTLevel10Code] <>
					OLD.[BusinessGTLevel10Code]
				) Or
				(
					NEW.[BusinessGTLevel10Code] Is Null And
					OLD.[BusinessGTLevel10Code] Is Not Null
				) Or
				(
					NEW.[BusinessGTLevel10Code] Is Not Null And
					OLD.[BusinessGTLevel10Code] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [UBR_ID]	 column	*/
	If UPDATE([UBR_ID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''UBR_ID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[UBR_ID]),
			CONVERT(nvarchar(4000),NEW.[UBR_ID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[UBR_ID] <>
					OLD.[UBR_ID]
				) Or
				(
					NEW.[UBR_ID] Is Null And
					OLD.[UBR_ID] Is Not Null
				) Or
				(
					NEW.[UBR_ID] Is Not Null And
					OLD.[UBR_ID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [StartDate]	 column	*/
	If UPDATE([StartDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''StartDate'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[StartDate]),
			CONVERT(nvarchar(4000),NEW.[StartDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[StartDate] <>
					OLD.[StartDate]
				) Or
				(
					NEW.[StartDate] Is Null And
					OLD.[StartDate] Is Not Null
				) Or
				(
					NEW.[StartDate] Is Not Null And
					OLD.[StartDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [CustomGrouping]	 column	*/
	-- Added 2007-10-16. GMcF, for HW request to add column CustomGrouping to table InitiativeFinancial
	If UPDATE([CustomGrouping])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeFinancialID]=N''''''+CAST(IsNull(OLD.[InitiativeFinancialID], NEW.[InitiativeFinancialID]) as nvarchar(4000))+'''''''',
                ''CustomGrouping'',
''nvarchar'', 
			CONVERT(nvarchar(4000),OLD.[CustomGrouping]),
			CONVERT(nvarchar(4000),NEW.[CustomGrouping])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeFinancialID] = OLD.[InitiativeFinancialID])
			AND (
				(
					NEW.[CustomGrouping] <>
					OLD.[CustomGrouping]
				) Or
				(
					NEW.[CustomGrouping] Is Null And
					OLD.[CustomGrouping] Is Not Null
				) Or
				(
					NEW.[CustomGrouping] Is Not Null And
					OLD.[CustomGrouping] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END

	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BENProject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BENProject](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNumber] [decimal](10, 0) NULL,
	[ProjectName] [nvarchar](150) NULL,
	[ProgrammeName] [nvarchar](150) NULL,
	[IGName] [nvarchar](150) NULL,
	[IGApprovalCommittee] [nvarchar](50) NULL,
	[IGApprovalStatus] [nvarchar](50) NULL,
	[IGIdentifier] [nvarchar](50) NULL,
	[BudgetOrigEuro] [money] NULL,
	[ProjectManager] [nvarchar](50) NULL,
 CONSTRAINT [PK_BENProject] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=6 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1350 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Format' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectID'))
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectID'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2085 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DecimalPlaces' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DisplayControl' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Format' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectNumber'))
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'General Number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectNumber'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1965 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProgrammeName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProgrammeName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProgrammeName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=5 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProgrammeName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProgrammeName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProgrammeName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=4 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGName'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1635 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGName'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGApprovalCommittee'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGApprovalCommittee'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGApprovalCommittee'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=7 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGApprovalCommittee'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGApprovalCommittee'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGApprovalCommittee'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGApprovalStatus'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGApprovalStatus'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGApprovalStatus'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=8 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGApprovalStatus'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGApprovalStatus'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGApprovalStatus'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=9 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'IGIdentifier'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'IGIdentifier'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'BudgetOrigEuro'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'BudgetOrigEuro'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'BudgetOrigEuro'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'BudgetOrigEuro'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'BudgetOrigEuro'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'BudgetOrigEuro'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnHidden' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnOrder' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_ColumnWidth' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', N'COLUMN',N'ProjectManager'))
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject', @level2type=N'COLUMN',@level2name=N'ProjectManager'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DefaultView' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Filter' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_OrderBy' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_OrderByOn' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=False , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Orientation' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_TableMaxRecords' , N'SCHEMA',N'dbo', N'TABLE',N'BENProject', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BENProject'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Template]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Template](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Body] [ntext] NULL,
	[Subject] [ntext] NULL,
	[IsHTML] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CommitteeContact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CommitteeContact](
	[CommitteeID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[RoleID] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InitiativeServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InitiativeServer](
	[InitiativeServerID] [int] IDENTITY(1,1) NOT NULL,
	[InitiativeID] [int] NULL,
	[ServerID] [int] NULL,
	[DecommissioningDate] [datetime] NULL,
	[Impact] [ntext] NULL,
 CONSTRAINT [PK_InitiativeServer] PRIMARY KEY CLUSTERED 
(
	[InitiativeServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_d_AUDIT_InitiativeServer]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_d_AUDIT_InitiativeServer]
ON [dbo].[InitiativeServer]
FOR DELETE
NOT FOR REPLICATION
AS

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	DELETE TRIGGER for Table:  [dbo].[InitiativeServer]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:01 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	Set NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	/*	INSERT audit transaction record For table [dbo].[InitiativeServer]	*/

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=deleted.InitiativeServerID
		FROM deleted JOIN Initiative ON deleted.InitiativeID = Initiative.InitiativeID

	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		3,	--	ACTION ID For DELETE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM DELETED),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeServer]	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeServerID]=N''''''+CAST(OLD.[InitiativeServerID] as nvarchar(4000))+'''''''',
        ''ServerID'',
		CONVERT(nvarchar(4000),OLD.[ServerID])
	FROM deleted OLD
	WHERE
		OLD.[ServerID] Is Not Null

	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeServerID]=N''''''+CAST(OLD.[InitiativeServerID] as nvarchar(4000))+'''''''',
        ''DecommissioningDate'',
		CONVERT(nvarchar(4000),OLD.[DecommissioningDate])
	FROM deleted OLD
	WHERE
		OLD.[DecommissioningDate] Is Not Null


	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
END
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_d_AUDIT_InitiativeServer]', @order=N'Last', @stmttype=N'DELETE'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_i_AUDIT_InitiativeServer]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_i_AUDIT_InitiativeServer]
ON [dbo].[InitiativeServer]
FOR INSERT
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	INSERT TRIGGER for Table:  [dbo].[InitiativeServer]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:01 PM
	   	------------------------------------------------------------ */
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000)

	SET NOCOUNT ON

	/*	Save @@IDENTITY For later restoration	*/
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeServerID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID


	/*	INSERT audit transaction record For table [dbo].[InitiativeServer]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT 
		QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		2,	--	ACTION ID For INSERT
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted), 
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	Set @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	/*	INSERT audit traces For table [dbo].[InitiativeServer]	*/
	/*	INSERT audit traces For [ServerID]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeServerID]=N''''''+CAST([InitiativeServerID] as nvarchar(4000))+'''''''',
        ''ServerID'',
		convert(nvarchar(4000), [ServerID]) 
	FROM inserted
	WHERE [ServerID] Is Not Null

	/*	INSERT audit traces For [DecommissioningDate]	 column	*/
	INSERT
	INTO dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeServerID]=N''''''+CAST([InitiativeServerID] as nvarchar(4000))+'''''''',
        ''DecommissioningDate'',
		convert(nvarchar(4000), [DecommissioningDate]) 
	FROM inserted
	WHERE [DecommissioningDate] Is Not Null

	/*	INSERT audit traces For [Impact]	 column	*/
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
        ''[InitiativeServerID]=N''''''+CAST(NEW.[InitiativeServerID] as nvarchar(4000))+'''''''',
        ''Impact'',
			ORD.[Impact]
		FROM inserted NEW
                INNER JOIN [dbo].[InitiativeServer] ORD 
                    ON ORD.[InitiativeServerID]=NEW.[InitiativeServerID]		WHERE
			ORD.[Impact] Is Not Null


	/* Restore @@IDENTITY Value  */

        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')

End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_i_AUDIT_InitiativeServer]', @order=N'Last', @stmttype=N'INSERT'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_u_AUDIT_InitiativeServer]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_u_AUDIT_InitiativeServer]
ON [dbo].[InitiativeServer]
FOR UPDATE
NOT FOR REPLICATION
As

-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"

	/* 	------------------------------------------------------------

	   	LEGAL:        	You may freely edit and modify this template and make copies of it.

	   	DESCRIPTION:  	UPDATE TRIGGER for Table:  [dbo].[InitiativeServer]

	   	AUTHOR:       	ApexSQL Software

	   	DATE:			1/26/2006 4:44:01 PM
	   	------------------------------------------------------------ */

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),   /* used For preservation of @@IDENTITY  */
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit

	SET NOCOUNT On

	/*	Save @@IDENTITY For later restoration	*/
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	DECLARE @ActiveUserID int, @InitiativeID int, @ReferenceID int
	SELECT @ActiveUserID=Initiative.ActiveUserID, @InitiativeID=Initiative.InitiativeID, 
			@ReferenceID=inserted.InitiativeServerID
		FROM inserted JOIN Initiative ON inserted.InitiativeID = Initiative.InitiativeID

	/*	INSERT audit transaction record For table [dbo].[InitiativeServer]	*/
	INSERT
	INTO dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		ACTIVE_USER_ID,
		INITIATIVE_ID,
		REFERENCE_ID
	)
	SELECT
                QUOTENAME(USER_NAME(OBJECTPROPERTY(parent_obj,''OwnerId'')))+''.''+QUOTENAME(OBJECT_NAME(parent_obj)),
		1,	--	ACTION ID For UPDATE
		HOST_NAME(),
		APP_NAME(),
		SUSER_SNAME(),
		GETDATE(),
		(SELECT COUNT(*) FROM inserted),
		@ActiveUserID,
		@InitiativeID,
		@ReferenceID
        FROM dbo.sysobjects
        WHERE xtype=''TR''
        AND id=@@PROCID   

	SET @AUDIT_LOG_TRANSACTION_ID = @@IDENTITY

	SET @Inserted = 0


	/*	INSERT audit traces For table [dbo].[InitiativeServer]	*/
	/*	INSERT audit traces For [ServerID]	 column	*/
	If UPDATE([ServerID])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeServerID]=N''''''+CAST(IsNull(OLD.[InitiativeServerID], NEW.[InitiativeServerID]) as nvarchar(4000))+'''''''',
                ''ServerID'',
''int'', 
			CONVERT(nvarchar(4000),OLD.[ServerID]),
			CONVERT(nvarchar(4000),NEW.[ServerID])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeServerID] = OLD.[InitiativeServerID])
			AND (
				(
					NEW.[ServerID] <>
					OLD.[ServerID]
				) Or
				(
					NEW.[ServerID] Is Null And
					OLD.[ServerID] Is Not Null
				) Or
				(
					NEW.[ServerID] Is Not Null And
					OLD.[ServerID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [DecommissioningDate]	 column	*/
	If UPDATE([DecommissioningDate])
	BEGIN
		INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			OLD_VALUE_LONG,
			NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeServerID]=N''''''+CAST(IsNull(OLD.[InitiativeServerID], NEW.[InitiativeServerID]) as nvarchar(4000))+'''''''',
                ''DecommissioningDate'',
''datetime'', 
			CONVERT(nvarchar(4000),OLD.[DecommissioningDate]),
			CONVERT(nvarchar(4000),NEW.[DecommissioningDate])
		FROM deleted OLD Join inserted NEW On
            (NEW.[InitiativeServerID] = OLD.[InitiativeServerID])
			AND (
				(
					NEW.[DecommissioningDate] <>
					OLD.[DecommissioningDate]
				) Or
				(
					NEW.[DecommissioningDate] Is Null And
					OLD.[DecommissioningDate] Is Not Null
				) Or
				(
					NEW.[DecommissioningDate] Is Not Null And
					OLD.[DecommissioningDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	/*	INSERT audit traces For [Impact]	 column	*/
	If UPDATE([Impact])
	BEGIN
	  	INSERT
		INTO dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			COL_TYPE, 
			  NEW_VALUE_LONG
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
            ''[InitiativeServerID]=N''''''+CAST(IsNull(ORD.[InitiativeServerID], NEW.[InitiativeServerID]) as nvarchar(4000))+'''''''',
                ''Impact'',
''ntext'', 
			ORD.[Impact]
		FROM inserted NEW JOIN [dbo].[InitiativeServer] ORD 
                    ON ORD.[InitiativeServerID]=NEW.[InitiativeServerID]
				/*
			AND (
				(
					SUBSTRING(NEW.[Impact], 0, 1024) <>
					SUBSTRING(ORD.[Impact], 0, 1024)
				) Or
				(
					SUBSTRING(NEW.[Impact], 0, 1024) Is Null And
					SUBSTRING(ORD.[Impact], 0, 1024) Is Not Null
				) Or
				(
					SUBSTRING(NEW.[Impact], 0, 1024) Is Not Null And
					SUBSTRING(ORD.[Impact], 0, 1024) Is Null
				)
				)	
				*/

		--WHERE
			--ORD.[Impact] Is Not Null

		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END

	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
	/* Restore @@IDENTITY Value  */
        DECLARE @maxprec AS varchar(2)
        SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
        EXEC(''SELECT IDENTITY(decimal(''+@maxprec+'',0),''+@IDENTITY_SAVE+'',1) id INTO #tmp'')
End
' 
GO

EXEC sp_settriggerorder @triggername=N'[dbo].[tr_u_AUDIT_InitiativeServer]', @order=N'Last', @stmttype=N'UPDATE'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Validation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Validation](
	[ControlID] [nvarchar](50) NOT NULL,
	[ValidationLevel] [int] NOT NULL,
	[ControlStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ControlID] ASC,
	[ValidationLevel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK__ReportFie__Field__174E50DA]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportFieldColour]'))
ALTER TABLE [dbo].[ReportFieldColour]  WITH CHECK ADD CHECK  (([FieldColour] like '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'))
