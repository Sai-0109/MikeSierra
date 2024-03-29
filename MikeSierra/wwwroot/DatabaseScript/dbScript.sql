USE [master]
GO
/****** Object:  Database [MikeSierra]    Script Date: 17-02-2024 01:12:38 ******/
CREATE DATABASE [MikeSierra]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MikeSierra', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\MikeSierra.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MikeSierra_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\MikeSierra_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MikeSierra] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MikeSierra].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MikeSierra] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MikeSierra] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MikeSierra] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MikeSierra] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MikeSierra] SET ARITHABORT OFF 
GO
ALTER DATABASE [MikeSierra] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MikeSierra] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MikeSierra] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MikeSierra] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MikeSierra] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MikeSierra] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MikeSierra] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MikeSierra] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MikeSierra] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MikeSierra] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MikeSierra] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MikeSierra] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MikeSierra] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MikeSierra] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MikeSierra] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MikeSierra] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MikeSierra] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MikeSierra] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MikeSierra] SET  MULTI_USER 
GO
ALTER DATABASE [MikeSierra] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MikeSierra] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MikeSierra] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MikeSierra] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MikeSierra] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MikeSierra] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MikeSierra] SET QUERY_STORE = OFF
GO
USE [MikeSierra]
GO
/****** Object:  Table [dbo].[Hobbies]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hobbies](
	[name] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Password] [nvarchar](50) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Gender] [nvarchar](10) NULL,
	[Hobbies] [nvarchar](100) NULL,
	[OTP] [nvarchar](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Registration] ON 

INSERT [dbo].[Registration] ([UserID], [FirstName], [LastName], [Email], [Password], [Mobile], [Gender], [Hobbies], [OTP]) VALUES (23, N'Sayali ', N'Walse', N'walsesayali1997@gmail.com', N'Sai@123', N'963852741', N'Female', N'', NULL)
SET IDENTITY_INSERT [dbo].[Registration] OFF
GO
/****** Object:  StoredProcedure [dbo].[GetUserByEmail]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByEmail]
    @Email NVARCHAR(100)
AS
BEGIN
    SELECT top 1 * FROM Registration WHERE Email = @Email;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUser]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Gender NVARCHAR(10),
    @Hobbies NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Users (FirstName, LastName, Email, Password, Mobile, Gender, Hobbies)
    VALUES (@FirstName, @LastName, @Email, @Password, @Mobile, @Gender, @Hobbies);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStoredOTP]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create stored procedure to retrieve stored OTP
CREATE PROCEDURE [dbo].[sp_GetStoredOTP]
    @Email NVARCHAR(100)
AS
BEGIN
    SELECT OTP FROM Users WHERE Email = @Email
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveOTP]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create stored procedure to save OTP
CREATE PROCEDURE [dbo].[sp_SaveOTP]
    @Email NVARCHAR(100),
    @OTP NVARCHAR(6)
AS
BEGIN
    UPDATE Users SET OTP = @OTP WHERE Email = @Email
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUserData]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveUserData]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Gender NVARCHAR(10)
AS
BEGIN
    INSERT INTO Users (FirstName, LastName, Email, Password, Mobile, Gender)
    VALUES (@FirstName, @LastName, @Email, @Password, @Mobile, @Gender)
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUser]    Script Date: 17-02-2024 01:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertUser]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Gender NVARCHAR(10),
    @Hobbies NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Registration (FirstName, LastName, Email, Password, Mobile, Gender, Hobbies)
    VALUES (@FirstName, @LastName, @Email, @Password, @Mobile, @Gender, @Hobbies);
END;
GO
USE [master]
GO
ALTER DATABASE [MikeSierra] SET  READ_WRITE 
GO
