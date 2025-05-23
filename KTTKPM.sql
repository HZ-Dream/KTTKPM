USE [KTTKPM]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterDataKeys]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterDataKeys](
	[PartitionKey] [nvarchar](450) NOT NULL,
	[RowKey] [nvarchar](450) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_MasterDataKeys] PRIMARY KEY CLUSTERED 
(
	[PartitionKey] ASC,
	[RowKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterDataValues]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterDataValues](
	[PartitionKey] [nvarchar](450) NOT NULL,
	[RowKey] [nvarchar](450) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_MasterDataValues] PRIMARY KEY CLUSTERED 
(
	[PartitionKey] ASC,
	[RowKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceRequests]    Script Date: 5/20/2025 8:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceRequests](
	[PartitionKey] [nvarchar](450) NOT NULL,
	[RowKey] [nvarchar](450) NOT NULL,
	[VehicleName] [nvarchar](max) NOT NULL,
	[VehicleType] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[RequestedServices] [nvarchar](max) NOT NULL,
	[RequestedDate] [datetime2](7) NULL,
	[CompletedDate] [datetime2](7) NULL,
	[ServiceEngineer] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_ServiceRequests] PRIMARY KEY CLUSTERED 
(
	[PartitionKey] ASC,
	[RowKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'00000000000000_CreateIdentitySchema', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250226141515_initialCreate', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250304080107_AddBooks', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250305070533_AddBook2', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250305074117_AddBook2', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250422025534_updateBaseEntity', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250506151339_FixServiceRequest', N'8.0.11')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'8335d45c-77b9-494b-ae90-1f8754b37a70', N'User', N'USER', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'b1ce4b30-0efe-4979-b176-695d74ff7a9d', N'Engineer', N'ENGINEER', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'f6fa30c7-8638-458a-a52b-3168c9acf612', N'Admin', N'ADMIN', NULL)
GO
SET IDENTITY_INSERT [dbo].[AspNetUserClaims] ON 

INSERT [dbo].[AspNetUserClaims] ([Id], [UserId], [ClaimType], [ClaimValue]) VALUES (15, N'36ff566a-943f-4e29-8605-01b5e27fe503', N'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress', N'ngochoai5813@gmail.com')
INSERT [dbo].[AspNetUserClaims] ([Id], [UserId], [ClaimType], [ClaimValue]) VALUES (16, N'36ff566a-943f-4e29-8605-01b5e27fe503', N'IsActive', N'True')
INSERT [dbo].[AspNetUserClaims] ([Id], [UserId], [ClaimType], [ClaimValue]) VALUES (17, N'05b91e29-7a3b-4a35-8785-5f3bbf1d4f4a', N'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress', N'mancitysgp@gmail.com')
INSERT [dbo].[AspNetUserClaims] ([Id], [UserId], [ClaimType], [ClaimValue]) VALUES (1024, N'05b91e29-7a3b-4a35-8785-5f3bbf1d4f4a', N'IsActive', N'True')
INSERT [dbo].[AspNetUserClaims] ([Id], [UserId], [ClaimType], [ClaimValue]) VALUES (2041, N'5738362d-3650-42fc-a6b6-25b74f5eff46', N'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress', N'huynhthaitoan090804@gmail.com')
INSERT [dbo].[AspNetUserClaims] ([Id], [UserId], [ClaimType], [ClaimValue]) VALUES (2042, N'5738362d-3650-42fc-a6b6-25b74f5eff46', N'IsActive', N'True')
SET IDENTITY_INSERT [dbo].[AspNetUserClaims] OFF
GO
INSERT [dbo].[AspNetUserLogins] ([LoginProvider], [ProviderKey], [ProviderDisplayName], [UserId]) VALUES (N'Google', N'116242293261836562242', N'Google', N'5738362d-3650-42fc-a6b6-25b74f5eff46')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5738362d-3650-42fc-a6b6-25b74f5eff46', N'8335d45c-77b9-494b-ae90-1f8754b37a70')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'05b91e29-7a3b-4a35-8785-5f3bbf1d4f4a', N'b1ce4b30-0efe-4979-b176-695d74ff7a9d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'36ff566a-943f-4e29-8605-01b5e27fe503', N'f6fa30c7-8638-458a-a52b-3168c9acf612')
GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'05b91e29-7a3b-4a35-8785-5f3bbf1d4f4a', N'HoaiEngin', N'HOAIENGIN', N'mancitysgp@gmail.com', N'MANCITYSGP@GMAIL.COM', 1, N'AQAAAAIAAYagAAAAECotlK/K4GOYCVT16cw64d0Yjy5gIaJJPOZFPeZ/zxzTwPyeCnJbKH9v13l55ELtBA==', N'2CFQH5FQYX2RAET6HJVDYY25YUVTFJBV', N'7a283f63-fcb1-4afc-93dd-dccfb7149742', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'36ff566a-943f-4e29-8605-01b5e27fe503', N'Hoai', N'HOAI', N'ngochoai5813@gmail.com', N'NGOCHOAI5813@GMAIL.COM', 1, N'AQAAAAIAAYagAAAAEH7N604XdWZM/nL8jIQLyKkepZeVbU/cgjqmcTn1rlzx7aJlDc0yDAsfl3+2g2uZDQ==', N'WKKYDE5BMPFYAYGDGXXSFXEPYDXXGVDB', N'1497efc6-7a64-4749-a611-fcb82b82c9f0', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5738362d-3650-42fc-a6b6-25b74f5eff46', N'huynhthaitoan090804@gmail.com', N'HUYNHTHAITOAN090804@GMAIL.COM', N'huynhthaitoan090804@gmail.com', N'HUYNHTHAITOAN090804@GMAIL.COM', 1, NULL, N'PM7MRJULFXLGBYAITBUWWWEJG3TXU2GF', N'670ce1a2-3551-42b2-a907-21be293af03e', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[MasterDataKeys] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'County', N'6a8511f0-173e-43d6-a8cb-7812cb272abd', 1, N'County', 0, CAST(N'2025-05-06T14:18:00.7479745' AS DateTime2), CAST(N'2025-05-06T14:18:00.7480822' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataKeys] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'LoaiXe', N'73177d15-388e-4633-9d35-b40ed40f981c', 0, N'LoaiXe', 0, CAST(N'2025-04-25T07:55:14.3436209' AS DateTime2), CAST(N'2025-04-30T13:17:43.5287505' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataKeys] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'Status', N'0214fcd9-6170-450c-84a4-1228a7f0a844', 1, N'Status', 0, CAST(N'2025-05-06T14:18:00.7828439' AS DateTime2), CAST(N'2025-05-06T14:18:00.7828445' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataKeys] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'VehicleManufacturer', N'78a1c988-f492-4379-a241-f3bd9ce4d1bb', 1, N'VehicleManufacturer', 0, CAST(N'2025-05-06T14:18:00.7834456' AS DateTime2), CAST(N'2025-05-06T14:18:00.7834457' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataKeys] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'VehicleName', N'c20dc04f-b161-4b7e-8dba-1b8bd3488272', 1, N'VehicleName', 0, CAST(N'2025-05-06T14:18:00.7833831' AS DateTime2), CAST(N'2025-05-06T14:18:00.7833833' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataKeys] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'VehicleType', N'09e8e3c8-e3b6-4833-92e2-8d6ee2939dc0', 1, N'VehicleType', 0, CAST(N'2025-05-06T14:18:00.7833093' AS DateTime2), CAST(N'2025-05-06T14:18:00.7833096' AS DateTime2), N'Hoai', NULL)
GO
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'0214fcd9-6170-450c-84a4-1228a7f0a844', N'45420184-eeed-43fd-84c1-b48ef2f7520f', 1, N'OnHold', 0, CAST(N'2025-05-06T14:18:01.1774657' AS DateTime2), CAST(N'2025-05-06T14:18:01.1774657' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'0214fcd9-6170-450c-84a4-1228a7f0a844', N'889649ba-116c-4048-a2fb-9f991411dc03', 1, N'Completed', 0, CAST(N'2025-05-06T14:18:01.1774401' AS DateTime2), CAST(N'2025-05-06T14:18:01.1774402' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'0214fcd9-6170-450c-84a4-1228a7f0a844', N'c96cd6f9-4265-4ce8-9bd8-32267b835529', 1, N'InProgess', 0, CAST(N'2025-05-06T14:18:01.1774055' AS DateTime2), CAST(N'2025-05-06T14:18:01.1774056' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'09e8e3c8-e3b6-4833-92e2-8d6ee2939dc0', N'15ede3f7-03e8-4f6f-bad5-568a15cf6bb3', 1, N'Car', 0, CAST(N'2025-05-06T14:18:01.1774917' AS DateTime2), CAST(N'2025-05-06T14:18:01.1774918' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'09e8e3c8-e3b6-4833-92e2-8d6ee2939dc0', N'6585b0f7-66eb-4513-9d05-3c65530c20dc', 1, N'Truck', 0, CAST(N'2025-05-06T14:18:01.1775190' AS DateTime2), CAST(N'2025-05-06T14:18:01.1775191' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'09e8e3c8-e3b6-4833-92e2-8d6ee2939dc0', N'8f777b30-a967-4c04-a08c-a56243fca1b6', 1, N'Camper', 0, CAST(N'2025-05-06T14:18:01.1775443' AS DateTime2), CAST(N'2025-05-06T14:18:01.1775444' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'6a8511f0-173e-43d6-a8cb-7812cb272abd', N'33df5078-93d9-4d2e-94ce-670d79d9169f', 1, N'Sacramento', 0, CAST(N'2025-05-06T14:18:01.1773711' AS DateTime2), CAST(N'2025-05-06T14:18:01.1773712' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'6a8511f0-173e-43d6-a8cb-7812cb272abd', N'7481b8d5-25e8-49a8-a8f1-92b1d48d862a', 1, N'Orange', 0, CAST(N'2025-05-06T14:18:01.1771198' AS DateTime2), CAST(N'2025-05-06T14:18:01.1771200' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'6a8511f0-173e-43d6-a8cb-7812cb272abd', N'7f932e8b-0afd-4317-ba2c-6d539e97e6f4', 1, N'San Diego', 0, CAST(N'2025-05-06T14:18:01.1773253' AS DateTime2), CAST(N'2025-05-06T14:18:01.1773254' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'73177d15-388e-4633-9d35-b40ed40f981c', N'be8fdd93-2eff-4787-8286-2e4507efeb62', 1, N'Vinfast', 0, CAST(N'2025-04-26T03:11:32.2029315' AS DateTime2), CAST(N'2025-04-26T03:11:32.2030799' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'73177d15-388e-4633-9d35-b40ed40f981c', N'f318a6c1-5a1e-4984-a8cb-37b3782f0d78', 1, N'BMW', 0, CAST(N'2025-04-25T13:16:01.5912077' AS DateTime2), CAST(N'2025-04-25T13:16:01.5914520' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'78a1c988-f492-4379-a241-f3bd9ce4d1bb', N'0758da5f-5c67-41aa-99d7-d2c13c782156', 1, N'Ford', 0, CAST(N'2025-05-06T14:18:01.1777079' AS DateTime2), CAST(N'2025-05-06T14:18:01.1777080' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'78a1c988-f492-4379-a241-f3bd9ce4d1bb', N'3bd9bbde-0609-4e4e-8d9d-66b559aa5f7b', 1, N'General Motors', 0, CAST(N'2025-05-06T14:18:01.1776842' AS DateTime2), CAST(N'2025-05-06T14:18:01.1776843' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'78a1c988-f492-4379-a241-f3bd9ce4d1bb', N'6ca45155-8c39-4799-99a1-6a8a1fffe078', 1, N'Honda', 0, CAST(N'2025-05-06T14:18:01.1776601' AS DateTime2), CAST(N'2025-05-06T14:18:01.1776601' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'c20dc04f-b161-4b7e-8dba-1b8bd3488272', N'a0411604-23bf-4ac0-8d46-96735b5cf550', 1, N'Honda Brio', 0, CAST(N'2025-05-06T14:18:01.1775716' AS DateTime2), CAST(N'2025-05-06T14:18:01.1775717' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'c20dc04f-b161-4b7e-8dba-1b8bd3488272', N'a5941ca0-998d-43bf-8c84-ab8c7aab1a05', 1, N'Honda CR-V', 0, CAST(N'2025-05-06T14:18:01.1776028' AS DateTime2), CAST(N'2025-05-06T14:18:01.1776028' AS DateTime2), N'Hoai', NULL)
INSERT [dbo].[MasterDataValues] ([PartitionKey], [RowKey], [IsActive], [Name], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'c20dc04f-b161-4b7e-8dba-1b8bd3488272', N'b2b6ead4-fb8d-492c-9049-b00c97f4c42e', 1, N'Honda Accord', 0, CAST(N'2025-05-06T14:18:01.1776305' AS DateTime2), CAST(N'2025-05-06T14:18:01.1776305' AS DateTime2), N'Hoai', NULL)
GO
INSERT [dbo].[ServiceRequests] ([PartitionKey], [RowKey], [VehicleName], [VehicleType], [Status], [RequestedServices], [RequestedDate], [CompletedDate], [ServiceEngineer], [IsDeleted], [CreatedDate], [UpdatedDate], [CreatedBy], [UpdatedBy]) VALUES (N'huynhthaitoan090804@gmail.com', N'e60a0d5b-c1c2-46da-8816-5c6159faaa92', N'a5941ca0-998d-43bf-8c84-ab8c7aab1a05', N'15ede3f7-03e8-4f6f-bad5-568a15cf6bb3', N'New', N'Hello', CAST(N'2025-08-05T00:00:00.0000000' AS DateTime2), NULL, NULL, 0, CAST(N'2025-05-06T15:15:18.0327147' AS DateTime2), CAST(N'2025-05-06T15:15:18.0327158' AS DateTime2), NULL, NULL)
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
