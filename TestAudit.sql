-- TestAudit. Script db creation
-- June 10, 2014

USE [TestAudit]
GO
/****** Object:  Table [dbo].[Environment]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Environment](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [varchar](50) NULL,
 CONSTRAINT [PK_Environment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Application]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Application](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Application] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User_](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Version]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Version](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Number] [varchar](50) NOT NULL,
	[ApplicationID] [bigint] NOT NULL,
 CONSTRAINT [PK_Version] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestSuite]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestSuite](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [bigint] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TestSuite] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestCase]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestCase](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TestSuiteID] [bigint] NOT NULL,
	[Area] [varchar](50) NOT NULL,
	[StepNumber] [numeric](18, 0) NOT NULL,
	[Action] [text] NOT NULL,
	[ExpectedResult] [text] NOT NULL,
	[EstimatedDuration] [time](7) NULL,
	[Priority] [varchar](50) NULL,
 CONSTRAINT [PK_TestCase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UpdateTestSuite]    Script Date: 06/10/2014 21:28:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateTestSuite](@ID BIGINT, @Name VARCHAR(50), @ApplicationID BIGINT)
AS
BEGIN

	SET NOCOUNT ON

	IF @ID = 0
		INSERT INTO dbo.TestSuite(Name, ApplicationID)
		VALUES(@Name, @ApplicationID)
	ELSE
		UPDATE dbo.TestSuite
		SET Name = @Name, ApplicationID = @ApplicationID
		WHERE ID = @ID
		
END
GO
/****** Object:  Table [dbo].[TestExecution]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestExecution](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Passed] [bit] NOT NULL,
	[Note] [text] NULL,
	[TestCaseID] [bigint] NOT NULL,
	[VersionID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ExecutedAt] [datetime] NOT NULL,
	[EnvironmentID] [bigint] NOT NULL,
	[Duration] [time](7) NULL,
 CONSTRAINT [PK_TestExecution] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestBasis]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestBasis](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SpecReference] [varchar](50) NULL,
	[TestCaseID] [bigint] NOT NULL,
 CONSTRAINT [PK_TestBasis] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Issue]    Script Date: 06/05/2014 15:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Issue](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[LogNumber] [int] NULL,
	[Description] [varchar](255) NULL,
	[Severity] [varchar](50) NULL,
	[TestExecutionID] [bigint] NULL,
 CONSTRAINT [PK_Issue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [fk_application_applicationId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[Version]  WITH CHECK ADD  CONSTRAINT [fk_application_applicationId] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Application] ([ID])
GO
ALTER TABLE [dbo].[Version] CHECK CONSTRAINT [fk_application_applicationId]
GO
/****** Object:  ForeignKey [fk_testsuite_applicationId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestSuite]  WITH CHECK ADD  CONSTRAINT [fk_testsuite_applicationId] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Application] ([ID])
GO
ALTER TABLE [dbo].[TestSuite] CHECK CONSTRAINT [fk_testsuite_applicationId]
GO
/****** Object:  ForeignKey [fk_testcase_testsuiteId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestCase]  WITH CHECK ADD  CONSTRAINT [fk_testcase_testsuiteId] FOREIGN KEY([TestSuiteID])
REFERENCES [dbo].[TestSuite] ([ID])
GO
ALTER TABLE [dbo].[TestCase] CHECK CONSTRAINT [fk_testcase_testsuiteId]
GO
/****** Object:  ForeignKey [fk_testexecution_environmentId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestExecution]  WITH CHECK ADD  CONSTRAINT [fk_testexecution_environmentId] FOREIGN KEY([EnvironmentID])
REFERENCES [dbo].[Environment] ([ID])
GO
ALTER TABLE [dbo].[TestExecution] CHECK CONSTRAINT [fk_testexecution_environmentId]
GO
/****** Object:  ForeignKey [fk_testexecution_testcaseId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestExecution]  WITH CHECK ADD  CONSTRAINT [fk_testexecution_testcaseId] FOREIGN KEY([TestCaseID])
REFERENCES [dbo].[TestCase] ([ID])
GO
ALTER TABLE [dbo].[TestExecution] CHECK CONSTRAINT [fk_testexecution_testcaseId]
GO
/****** Object:  ForeignKey [fk_testexecution_userId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestExecution]  WITH CHECK ADD  CONSTRAINT [fk_testexecution_userId] FOREIGN KEY([UserID])
REFERENCES [dbo].[User_] ([ID])
GO
ALTER TABLE [dbo].[TestExecution] CHECK CONSTRAINT [fk_testexecution_userId]
GO
/****** Object:  ForeignKey [fk_testexecution_versionId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestExecution]  WITH CHECK ADD  CONSTRAINT [fk_testexecution_versionId] FOREIGN KEY([VersionID])
REFERENCES [dbo].[Version] ([ID])
GO
ALTER TABLE [dbo].[TestExecution] CHECK CONSTRAINT [fk_testexecution_versionId]
GO
/****** Object:  ForeignKey [fk_testbasisn_testcaseId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[TestBasis]  WITH CHECK ADD  CONSTRAINT [fk_testbasisn_testcaseId] FOREIGN KEY([TestCaseID])
REFERENCES [dbo].[TestCase] ([ID])
GO
ALTER TABLE [dbo].[TestBasis] CHECK CONSTRAINT [fk_testbasisn_testcaseId]
GO
/****** Object:  ForeignKey [fk_issue_testexecutionId]    Script Date: 06/05/2014 15:50:15 ******/
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD  CONSTRAINT [fk_issue_testexecutionId] FOREIGN KEY([TestExecutionID])
REFERENCES [dbo].[TestExecution] ([ID])
GO
ALTER TABLE [dbo].[Issue] CHECK CONSTRAINT [fk_issue_testexecutionId]
GO
