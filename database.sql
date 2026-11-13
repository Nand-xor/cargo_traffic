-- Схема и демо-данные базы cargo_traffic_v4
-- Откройте в SQL Server Management Studio и выполните целиком (F5)
CREATE DATABASE cargo_traffic_v4;
GO
USE cargo_traffic_v4;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[водители](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ФИО] [varchar](60) NOT NULL,
	[стаж_работы_в_годах] [int] NOT NULL,
	[номер_водительского_удостоверения] [varchar](12) NOT NULL,
	[телефон] [varchar](16) NOT NULL,
 CONSTRAINT [PK__водители__3213E83FB6350086] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[доходы](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[заказ_id] [int] NOT NULL,
	[оплата] [decimal](10, 2) NOT NULL,
	[дата_оплаты] [datetime] NOT NULL,
 CONSTRAINT [PK__доходы__3213E83F6BDFF0FB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[журнал_тех_обслуживания](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[грузовой_автомобиль_id] [int] NOT NULL,
	[дата_обслуживания] [date] NOT NULL,
	[описание] [varchar](255) NOT NULL,
	[стоимость_обслуживания] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK__журнал_т__3213E83FDAE14B2D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[заказы](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[дата_заказа] [datetime] NOT NULL,
	[клиент_заказчик_id] [int] NOT NULL,
	[тариф_id] [int] NOT NULL,
	[сумма_заказа] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK__заказы__3213E83F1EA7B55B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[заказы_грузы](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[название] [varchar](50) NOT NULL,
	[вес_в_кг] [decimal](10, 2) NOT NULL,
	[количество] [int] NOT NULL,
	[заказ_id] [int] NOT NULL,
 CONSTRAINT [PK__заказы_г__3213E83F3239AE58] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[закупка_ТС](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[грузовой_автомобиль_id] [int] NOT NULL,
	[дата_приобретения] [date] NOT NULL,
	[стоимость] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK__закупка___3213E83F6A791F56] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[использование_ТС_сейчас](
	[грузовой_автомобиль_id] [int] NOT NULL,
	[в_перевозке] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[грузовой_автомобиль_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[клиенты](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[название_компании] [varchar](50) NOT NULL,
	[адрес] [varchar](100) NOT NULL,
	[контактное_лицо] [varchar](60) NOT NULL,
	[телефон] [varchar](16) NOT NULL,
	[email] [varchar](60) NOT NULL,
 CONSTRAINT [PK__клиенты__3213E83F4A9094BC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[маршруты](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[точка_погрузки_id] [int] NOT NULL,
	[точка_разгрузки_id] [int] NOT NULL,
	[описание] [text] NOT NULL,
	[длина_в_км] [decimal](10, 2) NOT NULL,
	[ожидаемое_время_пути] [int] NOT NULL,
 CONSTRAINT [PK__маршруты__3213E83F4B40707D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[остатки_ТС](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[марка] [varchar](100) NOT NULL,
	[модель] [varchar](100) NOT NULL,
	[количество_незадействованных] [int] NOT NULL,
 CONSTRAINT [PK__остатки___3213E83F20F6A16B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[перевозки](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[заказ_id] [int] NOT NULL,
	[грузовой_автомобиль_id] [int] NOT NULL,
	[водитель_id] [int] NOT NULL,
	[маршрут_id] [int] NOT NULL,
	[время_начала] [datetime] NOT NULL,
	[предполагаемое_время_доставки] [datetime] NOT NULL,
 CONSTRAINT [PK__перевозк__3213E83FE2B45A21] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[пользователи](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[логин] [varchar](40) NOT NULL,
	[пароль] [varchar](20) NOT NULL,
	[роль] [varchar](13) NOT NULL,
 CONSTRAINT [PK__пользова__3213E83F829F0A59] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[статусы_заказов](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[заказ_id] [int] NOT NULL,
	[статус] [varchar](10) NOT NULL,
	[фактическая_дата_начала] [datetime] NULL,
	[фактическая_дата_окончания] [datetime] NULL,
 CONSTRAINT [PK__статусы___3213E83F6AA2D830] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[тарифы](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[название] [varchar](50) NOT NULL,
	[плата_за_кг_в_рублях] [decimal](10, 2) NOT NULL,
	[плата_за_км_в_рублях] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK__тарифы__3213E83FC369076B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[точки_погрузки](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[адрес] [varchar](100) NOT NULL,
	[название] [varchar](50) NOT NULL,
 CONSTRAINT [PK__точки_по__3213E83F2B904293] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[точки_разгрузки](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[адрес] [varchar](100) NOT NULL,
	[название] [varchar](50) NOT NULL,
 CONSTRAINT [PK__точки_ра__3213E83F35487330] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[транспортные_средства](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[марка] [varchar](50) NOT NULL,
	[модель] [varchar](30) NOT NULL,
	[регистрационный_номер] [varchar](50) NOT NULL,
	[грузоподъёмность_в_тоннах] [decimal](4, 1) NOT NULL,
 CONSTRAINT [PK__транспор__3213E83F98971694] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[водители] ON 

GO
INSERT [dbo].[водители] ([id], [ФИО], [стаж_работы_в_годах], [номер_водительского_удостоверения], [телефон]) VALUES (1, N'Иванов Иван Иванович', 5, N'56 04 491942', N'+7(900)111-11-11')
GO
INSERT [dbo].[водители] ([id], [ФИО], [стаж_работы_в_годах], [номер_водительского_удостоверения], [телефон]) VALUES (2, N'Петров Петр Петрович', 8, N'50 08 189924', N'+7(900)222-22-22')
GO
INSERT [dbo].[водители] ([id], [ФИО], [стаж_работы_в_годах], [номер_водительского_удостоверения], [телефон]) VALUES (3, N'Сидоров Сидор Сидорович', 3, N'74 14 292010', N'+7(900)333-33-33')
GO
SET IDENTITY_INSERT [dbo].[водители] OFF
GO
SET IDENTITY_INSERT [dbo].[доходы] ON 

GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (1, 1, CAST(30070.00 AS Decimal(10, 2)), CAST(N'2024-05-15T10:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (2, 2, CAST(11850.00 AS Decimal(10, 2)), CAST(N'2024-05-10T06:10:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (3, 3, CAST(24416.00 AS Decimal(10, 2)), CAST(N'2024-04-30T05:50:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (4, 8, CAST(10000.00 AS Decimal(10, 2)), CAST(N'2024-05-27T22:32:48.830' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (23, 1027, CAST(900000.00 AS Decimal(10, 2)), CAST(N'2023-11-12T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (24, 1028, CAST(600000.00 AS Decimal(10, 2)), CAST(N'2023-11-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (25, 1029, CAST(480000.00 AS Decimal(10, 2)), CAST(N'2023-12-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (26, 1030, CAST(937500.00 AS Decimal(10, 2)), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (27, 1031, CAST(945000.00 AS Decimal(10, 2)), CAST(N'2024-01-15T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (28, 1032, CAST(600000.00 AS Decimal(10, 2)), CAST(N'2024-01-27T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (29, 1033, CAST(480000.00 AS Decimal(10, 2)), CAST(N'2024-02-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (30, 1034, CAST(900000.00 AS Decimal(10, 2)), CAST(N'2024-02-20T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (31, 1035, CAST(360000.00 AS Decimal(10, 2)), CAST(N'2024-03-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (32, 1036, CAST(720000.00 AS Decimal(10, 2)), CAST(N'2024-03-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (33, 1037, CAST(990000.00 AS Decimal(10, 2)), CAST(N'2024-03-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (34, 1038, CAST(360000.00 AS Decimal(10, 2)), CAST(N'2024-04-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (35, 1039, CAST(840000.00 AS Decimal(10, 2)), CAST(N'2024-04-16T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (36, 1040, CAST(714000.00 AS Decimal(10, 2)), CAST(N'2024-04-24T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (37, 1041, CAST(520000.00 AS Decimal(10, 2)), CAST(N'2024-05-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (38, 1042, CAST(741000.00 AS Decimal(10, 2)), CAST(N'2024-05-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (39, 1043, CAST(1056000.00 AS Decimal(10, 2)), CAST(N'2024-05-20T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[доходы] ([id], [заказ_id], [оплата], [дата_оплаты]) VALUES (40, 1044, CAST(270000.00 AS Decimal(10, 2)), CAST(N'2024-05-26T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[доходы] OFF
GO
SET IDENTITY_INSERT [dbo].[журнал_тех_обслуживания] ON 

GO
INSERT [dbo].[журнал_тех_обслуживания] ([id], [грузовой_автомобиль_id], [дата_обслуживания], [описание], [стоимость_обслуживания]) VALUES (1, 2, CAST(N'2024-02-25' AS Date), N'Проверка системы', CAST(12000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[журнал_тех_обслуживания] ([id], [грузовой_автомобиль_id], [дата_обслуживания], [описание], [стоимость_обслуживания]) VALUES (2, 3, CAST(N'2024-03-10' AS Date), N'Замена выхлопной системы', CAST(25000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[журнал_тех_обслуживания] ([id], [грузовой_автомобиль_id], [дата_обслуживания], [описание], [стоимость_обслуживания]) VALUES (3, 1, CAST(N'2024-04-01' AS Date), N'Замена фильтров', CAST(6000.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[журнал_тех_обслуживания] OFF
GO
SET IDENTITY_INSERT [dbo].[заказы] ON 

GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1, CAST(N'2024-05-15T09:15:20.000' AS DateTime), 1, 2, CAST(30070.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (2, CAST(N'2024-05-10T05:10:24.000' AS DateTime), 3, 3, CAST(11850.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (3, CAST(N'2024-04-30T04:30:04.000' AS DateTime), 1, 3, CAST(24416.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (8, CAST(N'2024-05-27T22:32:21.087' AS DateTime), 2, 1, CAST(10000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (11, CAST(N'2024-05-28T07:55:17.727' AS DateTime), 2, 1, CAST(10000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1027, CAST(N'2023-11-12T00:00:00.000' AS DateTime), 1, 2, CAST(900000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1028, CAST(N'2023-11-25T00:00:00.000' AS DateTime), 2, 1, CAST(600000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1029, CAST(N'2023-12-05T00:00:00.000' AS DateTime), 3, 3, CAST(480000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1030, CAST(N'2023-12-18T00:00:00.000' AS DateTime), 1, 2, CAST(937500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1031, CAST(N'2024-01-15T00:00:00.000' AS DateTime), 4, 2, CAST(945000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1032, CAST(N'2024-01-27T00:00:00.000' AS DateTime), 2, 1, CAST(600000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1033, CAST(N'2024-02-08T00:00:00.000' AS DateTime), 3, 3, CAST(480000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1034, CAST(N'2024-02-20T00:00:00.000' AS DateTime), 1, 2, CAST(900000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1035, CAST(N'2024-03-03T00:00:00.000' AS DateTime), 5, 3, CAST(360000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1036, CAST(N'2024-03-14T00:00:00.000' AS DateTime), 2, 1, CAST(720000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1037, CAST(N'2024-03-25T00:00:00.000' AS DateTime), 4, 2, CAST(990000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1038, CAST(N'2024-04-05T00:00:00.000' AS DateTime), 3, 3, CAST(360000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1039, CAST(N'2024-04-16T00:00:00.000' AS DateTime), 1, 2, CAST(840000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1040, CAST(N'2024-04-24T00:00:00.000' AS DateTime), 2, 1, CAST(714000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1041, CAST(N'2024-05-06T00:00:00.000' AS DateTime), 5, 3, CAST(520000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1042, CAST(N'2024-05-13T00:00:00.000' AS DateTime), 4, 2, CAST(741000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1043, CAST(N'2024-05-20T00:00:00.000' AS DateTime), 1, 2, CAST(1056000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[заказы] ([id], [дата_заказа], [клиент_заказчик_id], [тариф_id], [сумма_заказа]) VALUES (1044, CAST(N'2024-05-26T00:00:00.000' AS DateTime), 3, 3, CAST(270000.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[заказы] OFF
GO
SET IDENTITY_INSERT [dbo].[заказы_грузы] ON 

GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1, N'кирпич', CAST(4.00 AS Decimal(10, 2)), 500, 1)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (2, N'телевизор, 75 дюймов', CAST(39.00 AS Decimal(10, 2)), 15, 2)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (3, N'окно', CAST(60.00 AS Decimal(10, 2)), 20, 3)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (6, N'мука', CAST(5.00 AS Decimal(10, 2)), 100, 8)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (9, N'мука', CAST(10.00 AS Decimal(10, 2)), 100, 11)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1014, N'арматура', CAST(3000.00 AS Decimal(10, 2)), 20, 11)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1025, N'кирпич', CAST(2000.00 AS Decimal(10, 2)), 30, 1027)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1026, N'мука', CAST(1500.00 AS Decimal(10, 2)), 40, 1028)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1027, N'телевизор, 65 дюймов', CAST(30.00 AS Decimal(10, 2)), 800, 1029)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1028, N'цемент', CAST(2500.00 AS Decimal(10, 2)), 25, 1030)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1029, N'доски', CAST(1800.00 AS Decimal(10, 2)), 35, 1031)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1030, N'сахар', CAST(1200.00 AS Decimal(10, 2)), 50, 1032)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1031, N'холодильник', CAST(80.00 AS Decimal(10, 2)), 300, 1033)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1032, N'арматура', CAST(3000.00 AS Decimal(10, 2)), 20, 1034)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1033, N'монитор', CAST(12.00 AS Decimal(10, 2)), 1500, 1035)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1034, N'рис', CAST(1600.00 AS Decimal(10, 2)), 45, 1036)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1035, N'плитка', CAST(2200.00 AS Decimal(10, 2)), 30, 1037)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1036, N'ноутбук', CAST(3.00 AS Decimal(10, 2)), 6000, 1038)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1037, N'краска', CAST(1400.00 AS Decimal(10, 2)), 40, 1039)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1038, N'гречка', CAST(1700.00 AS Decimal(10, 2)), 42, 1040)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1039, N'стиральная машина', CAST(65.00 AS Decimal(10, 2)), 400, 1041)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1040, N'утеплитель', CAST(1300.00 AS Decimal(10, 2)), 38, 1042)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1041, N'щебень', CAST(3200.00 AS Decimal(10, 2)), 22, 1043)
GO
INSERT [dbo].[заказы_грузы] ([id], [название], [вес_в_кг], [количество], [заказ_id]) VALUES (1042, N'микроволновая печь', CAST(15.00 AS Decimal(10, 2)), 900, 1044)
GO
SET IDENTITY_INSERT [dbo].[заказы_грузы] OFF
GO
SET IDENTITY_INSERT [dbo].[закупка_ТС] ON 

GO
INSERT [dbo].[закупка_ТС] ([id], [грузовой_автомобиль_id], [дата_приобретения], [стоимость]) VALUES (1, 1, CAST(N'2024-01-30' AS Date), CAST(2880000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[закупка_ТС] ([id], [грузовой_автомобиль_id], [дата_приобретения], [стоимость]) VALUES (2, 2, CAST(N'2023-11-10' AS Date), CAST(2330000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[закупка_ТС] ([id], [грузовой_автомобиль_id], [дата_приобретения], [стоимость]) VALUES (3, 3, CAST(N'2023-12-25' AS Date), CAST(2260000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[закупка_ТС] ([id], [грузовой_автомобиль_id], [дата_приобретения], [стоимость]) VALUES (4, 4, CAST(N'2024-05-28' AS Date), CAST(3265000.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[закупка_ТС] OFF
GO
INSERT [dbo].[использование_ТС_сейчас] ([грузовой_автомобиль_id], [в_перевозке]) VALUES (1, 0)
GO
INSERT [dbo].[использование_ТС_сейчас] ([грузовой_автомобиль_id], [в_перевозке]) VALUES (2, 1)
GO
INSERT [dbo].[использование_ТС_сейчас] ([грузовой_автомобиль_id], [в_перевозке]) VALUES (3, 0)
GO
INSERT [dbo].[использование_ТС_сейчас] ([грузовой_автомобиль_id], [в_перевозке]) VALUES (4, 0)
GO
SET IDENTITY_INSERT [dbo].[клиенты] ON 

GO
INSERT [dbo].[клиенты] ([id], [название_компании], [адрес], [контактное_лицо], [телефон], [email]) VALUES (1, N'ООО "СтройМатериалы"', N' г. Москва, ул. Сибирь 12', N'Смирнов Дмитрий', N'+7(945)113-12-21', N'dmitry.stroy@mail.ru')
GO
INSERT [dbo].[клиенты] ([id], [название_компании], [адрес], [контактное_лицо], [телефон], [email]) VALUES (2, N'ЗАО "Продукты"', N'г. Москва, ул. Невский 28', N'Петрова Алина', N'+7(911)838-47-93', N' alina.products@mail.ru')
GO
INSERT [dbo].[клиенты] ([id], [название_компании], [адрес], [контактное_лицо], [телефон], [email]) VALUES (3, N'ООО "Электрон"', N'г. Казань, ул. Волга 33', N'Кузнецов Антон', N'+7(985)457-41-22', N'anton.electron@mail.ru')
GO
INSERT [dbo].[клиенты] ([id], [название_компании], [адрес], [контактное_лицо], [телефон], [email]) VALUES (4, N'ООО "ПостройДом"', N'г. Москва, ул. Победы, д. 10', N'Сергеев Андрей', N'+7(937)811-22-84', N'andrey_postroy@mail.ru')
GO
INSERT [dbo].[клиенты] ([id], [название_компании], [адрес], [контактное_лицо], [телефон], [email]) VALUES (5, N'ООО "DNS"', N'г. Москва, просп. Мира, д. 25', N'Колобок Ян', N'+7(928)451-73-23', N'colobok_dns@mail.ru')
GO
SET IDENTITY_INSERT [dbo].[клиенты] OFF
GO
SET IDENTITY_INSERT [dbo].[маршруты] ON 

GO
INSERT [dbo].[маршруты] ([id], [точка_погрузки_id], [точка_разгрузки_id], [описание], [длина_в_км], [ожидаемое_время_пути]) VALUES (1, 1, 1, N'Доставка товаров из Склад 1 в Магазин Пушкинский', CAST(10.00 AS Decimal(10, 2)), 30)
GO
INSERT [dbo].[маршруты] ([id], [точка_погрузки_id], [точка_разгрузки_id], [описание], [длина_в_км], [ожидаемое_время_пути]) VALUES (2, 2, 3, N'Доставка товаров из Склад 2 в Склад Люберцы', CAST(15.00 AS Decimal(10, 2)), 40)
GO
INSERT [dbo].[маршруты] ([id], [точка_погрузки_id], [точка_разгрузки_id], [описание], [длина_в_км], [ожидаемое_время_пути]) VALUES (3, 1, 3, N'Доставка товаров из склада 1 в склад Люберцы', CAST(41.60 AS Decimal(10, 2)), 53)
GO
SET IDENTITY_INSERT [dbo].[маршруты] OFF
GO
SET IDENTITY_INSERT [dbo].[остатки_ТС] ON 

GO
INSERT [dbo].[остатки_ТС] ([id], [марка], [модель], [количество_незадействованных]) VALUES (1, N'ГАЗ', N'Next', 1)
GO
INSERT [dbo].[остатки_ТС] ([id], [марка], [модель], [количество_незадействованных]) VALUES (2, N'ГАЗ', N'Business', 1)
GO
INSERT [dbo].[остатки_ТС] ([id], [марка], [модель], [количество_незадействованных]) VALUES (3, N'ГАЗ', N'Соболь', 1)
GO
SET IDENTITY_INSERT [dbo].[остатки_ТС] OFF
GO
SET IDENTITY_INSERT [dbo].[перевозки] ON 

GO
INSERT [dbo].[перевозки] ([id], [заказ_id], [грузовой_автомобиль_id], [водитель_id], [маршрут_id], [время_начала], [предполагаемое_время_доставки]) VALUES (1, 1, 1, 1, 1, CAST(N'2024-05-15T09:20:20.000' AS DateTime), CAST(N'2024-05-15T10:00:00.000' AS DateTime))
GO
INSERT [dbo].[перевозки] ([id], [заказ_id], [грузовой_автомобиль_id], [водитель_id], [маршрут_id], [время_начала], [предполагаемое_время_доставки]) VALUES (2, 2, 3, 2, 2, CAST(N'2024-05-10T05:20:24.000' AS DateTime), CAST(N'2024-05-10T06:20:00.000' AS DateTime))
GO
INSERT [dbo].[перевозки] ([id], [заказ_id], [грузовой_автомобиль_id], [водитель_id], [маршрут_id], [время_начала], [предполагаемое_время_доставки]) VALUES (3, 3, 2, 3, 3, CAST(N'2024-04-30T04:45:04.000' AS DateTime), CAST(N'2024-04-30T05:45:00.000' AS DateTime))
GO
INSERT [dbo].[перевозки] ([id], [заказ_id], [грузовой_автомобиль_id], [водитель_id], [маршрут_id], [время_начала], [предполагаемое_время_доставки]) VALUES (6, 8, 3, 2, 2, CAST(N'2024-05-27T22:32:38.377' AS DateTime), CAST(N'2024-05-27T23:12:38.377' AS DateTime))
GO
INSERT [dbo].[перевозки] ([id], [заказ_id], [грузовой_автомобиль_id], [водитель_id], [маршрут_id], [время_начала], [предполагаемое_время_доставки]) VALUES (7, 11, 2, 1, 3, CAST(N'2024-05-28T07:55:51.817' AS DateTime), CAST(N'2024-05-28T08:48:51.817' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[перевозки] OFF
GO
SET IDENTITY_INSERT [dbo].[пользователи] ON 

GO
INSERT [dbo].[пользователи] ([id], [логин], [пароль], [роль]) VALUES (1, N'nand', N'nand_password', N'администратор')
GO
INSERT [dbo].[пользователи] ([id], [логин], [пароль], [роль]) VALUES (5, N'some fodder', N'123', N'сотрудник')
GO
SET IDENTITY_INSERT [dbo].[пользователи] OFF
GO
SET IDENTITY_INSERT [dbo].[статусы_заказов] ON 

GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1, 1, N'выполнен', CAST(N'2024-05-15T09:20:20.000' AS DateTime), CAST(N'2024-05-15T09:52:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (2, 2, N'выполнен', CAST(N'2024-05-10T05:20:24.000' AS DateTime), CAST(N'2024-05-10T06:05:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (3, 3, N'выполнен', CAST(N'2024-04-30T04:45:04.000' AS DateTime), CAST(N'2024-04-30T05:43:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (5, 8, N'выполнен', CAST(N'2024-05-27T22:32:38.413' AS DateTime), CAST(N'2024-05-27T22:32:48.830' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (8, 11, N'в процессе', CAST(N'2024-05-28T07:55:51.853' AS DateTime), NULL)
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1024, 1027, N'выполнен', CAST(N'2023-11-12T00:00:00.000' AS DateTime), CAST(N'2023-11-12T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1025, 1028, N'выполнен', CAST(N'2023-11-25T00:00:00.000' AS DateTime), CAST(N'2023-11-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1026, 1029, N'выполнен', CAST(N'2023-12-05T00:00:00.000' AS DateTime), CAST(N'2023-12-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1027, 1030, N'выполнен', CAST(N'2023-12-18T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1028, 1031, N'выполнен', CAST(N'2024-01-15T00:00:00.000' AS DateTime), CAST(N'2024-01-15T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1029, 1032, N'выполнен', CAST(N'2024-01-27T00:00:00.000' AS DateTime), CAST(N'2024-01-27T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1030, 1033, N'выполнен', CAST(N'2024-02-08T00:00:00.000' AS DateTime), CAST(N'2024-02-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1031, 1034, N'выполнен', CAST(N'2024-02-20T00:00:00.000' AS DateTime), CAST(N'2024-02-20T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1032, 1035, N'выполнен', CAST(N'2024-03-03T00:00:00.000' AS DateTime), CAST(N'2024-03-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1033, 1036, N'выполнен', CAST(N'2024-03-14T00:00:00.000' AS DateTime), CAST(N'2024-03-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1034, 1037, N'выполнен', CAST(N'2024-03-25T00:00:00.000' AS DateTime), CAST(N'2024-03-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1035, 1038, N'выполнен', CAST(N'2024-04-05T00:00:00.000' AS DateTime), CAST(N'2024-04-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1036, 1039, N'выполнен', CAST(N'2024-04-16T00:00:00.000' AS DateTime), CAST(N'2024-04-16T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1037, 1040, N'выполнен', CAST(N'2024-04-24T00:00:00.000' AS DateTime), CAST(N'2024-04-24T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1038, 1041, N'выполнен', CAST(N'2024-05-06T00:00:00.000' AS DateTime), CAST(N'2024-05-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1039, 1042, N'выполнен', CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1040, 1043, N'выполнен', CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-05-20T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[статусы_заказов] ([id], [заказ_id], [статус], [фактическая_дата_начала], [фактическая_дата_окончания]) VALUES (1041, 1044, N'выполнен', CAST(N'2024-05-26T00:00:00.000' AS DateTime), CAST(N'2024-05-26T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[статусы_заказов] OFF
GO
SET IDENTITY_INSERT [dbo].[тарифы] ON 

GO
INSERT [dbo].[тарифы] ([id], [название], [плата_за_кг_в_рублях], [плата_за_км_в_рублях]) VALUES (1, N'Эконом', CAST(10.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[тарифы] ([id], [название], [плата_за_кг_в_рублях], [плата_за_км_в_рублях]) VALUES (2, N'Стандарт', CAST(15.00 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[тарифы] ([id], [название], [плата_за_кг_в_рублях], [плата_за_км_в_рублях]) VALUES (3, N'Премиум', CAST(20.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[тарифы] OFF
GO
SET IDENTITY_INSERT [dbo].[точки_погрузки] ON 

GO
INSERT [dbo].[точки_погрузки] ([id], [адрес], [название]) VALUES (1, N'г. Москва, ул. Ленина, д. 15', N'Склад 1')
GO
INSERT [dbo].[точки_погрузки] ([id], [адрес], [название]) VALUES (2, N'г. Москва, ул. Тверская, д. 12', N'Склад 2')
GO
INSERT [dbo].[точки_погрузки] ([id], [адрес], [название]) VALUES (3, N'ул. Советская, д. 5, Балашиха', N'Логистический центр Балашиха')
GO
SET IDENTITY_INSERT [dbo].[точки_погрузки] OFF
GO
SET IDENTITY_INSERT [dbo].[точки_разгрузки] ON 

GO
INSERT [dbo].[точки_разгрузки] ([id], [адрес], [название]) VALUES (1, N'г. Москва, ул. Пушкина, д. 7', N'Магазин Пушкинский')
GO
INSERT [dbo].[точки_разгрузки] ([id], [адрес], [название]) VALUES (2, N'ул. Гагарина, д. 13', N'Гипермаркет Московский')
GO
INSERT [dbo].[точки_разгрузки] ([id], [адрес], [название]) VALUES (3, N'г. Санкт-Петербург, ул. Мира, д. 89', N'Пункт Разгрузки 2')
GO
SET IDENTITY_INSERT [dbo].[точки_разгрузки] OFF
GO
SET IDENTITY_INSERT [dbo].[транспортные_средства] ON 

GO
INSERT [dbo].[транспортные_средства] ([id], [марка], [модель], [регистрационный_номер], [грузоподъёмность_в_тоннах]) VALUES (1, N'ГАЗ', N'Next', N'х325уа196', CAST(6.2 AS Decimal(4, 1)))
GO
INSERT [dbo].[транспортные_средства] ([id], [марка], [модель], [регистрационный_номер], [грузоподъёмность_в_тоннах]) VALUES (2, N'ГАЗ', N'Business', N'е437кр156', CAST(1.6 AS Decimal(4, 1)))
GO
INSERT [dbo].[транспортные_средства] ([id], [марка], [модель], [регистрационный_номер], [грузоподъёмность_в_тоннах]) VALUES (3, N'ГАЗ', N'Соболь', N'о666мн122', CAST(0.9 AS Decimal(4, 1)))
GO
INSERT [dbo].[транспортные_средства] ([id], [марка], [модель], [регистрационный_номер], [грузоподъёмность_в_тоннах]) VALUES (4, N'ГАЗ', N'NN', N'с065мк78', CAST(4.6 AS Decimal(4, 1)))
GO
SET IDENTITY_INSERT [dbo].[транспортные_средства] OFF
GO
ALTER TABLE [dbo].[доходы]  WITH CHECK ADD  CONSTRAINT [FK_доходы_заказы] FOREIGN KEY([заказ_id])
REFERENCES [dbo].[заказы] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[доходы] CHECK CONSTRAINT [FK_доходы_заказы]
GO
ALTER TABLE [dbo].[журнал_тех_обслуживания]  WITH CHECK ADD  CONSTRAINT [FK__журнал_те__грузо__5441852A] FOREIGN KEY([грузовой_автомобиль_id])
REFERENCES [dbo].[транспортные_средства] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[журнал_тех_обслуживания] CHECK CONSTRAINT [FK__журнал_те__грузо__5441852A]
GO
ALTER TABLE [dbo].[заказы]  WITH CHECK ADD  CONSTRAINT [FK__заказы__тариф_id__59063A47] FOREIGN KEY([тариф_id])
REFERENCES [dbo].[тарифы] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[заказы] CHECK CONSTRAINT [FK__заказы__тариф_id__59063A47]
GO
ALTER TABLE [dbo].[заказы]  WITH CHECK ADD  CONSTRAINT [FK_заказы_клиенты] FOREIGN KEY([клиент_заказчик_id])
REFERENCES [dbo].[клиенты] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[заказы] CHECK CONSTRAINT [FK_заказы_клиенты]
GO
ALTER TABLE [dbo].[заказы_грузы]  WITH CHECK ADD  CONSTRAINT [FK__заказы_гр__заказ__5AEE82B9] FOREIGN KEY([заказ_id])
REFERENCES [dbo].[заказы] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[заказы_грузы] CHECK CONSTRAINT [FK__заказы_гр__заказ__5AEE82B9]
GO
ALTER TABLE [dbo].[закупка_ТС]  WITH CHECK ADD  CONSTRAINT [FK__закупка_Т__грузо__5AEE82B9] FOREIGN KEY([грузовой_автомобиль_id])
REFERENCES [dbo].[транспортные_средства] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[закупка_ТС] CHECK CONSTRAINT [FK__закупка_Т__грузо__5AEE82B9]
GO
ALTER TABLE [dbo].[использование_ТС_сейчас]  WITH CHECK ADD  CONSTRAINT [FK__использов__грузо__5BE2A6F2] FOREIGN KEY([грузовой_автомобиль_id])
REFERENCES [dbo].[транспортные_средства] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[использование_ТС_сейчас] CHECK CONSTRAINT [FK__использов__грузо__5BE2A6F2]
GO
ALTER TABLE [dbo].[маршруты]  WITH CHECK ADD  CONSTRAINT [FK__маршруты__точка___5CD6CB2B] FOREIGN KEY([точка_погрузки_id])
REFERENCES [dbo].[точки_погрузки] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[маршруты] CHECK CONSTRAINT [FK__маршруты__точка___5CD6CB2B]
GO
ALTER TABLE [dbo].[маршруты]  WITH CHECK ADD  CONSTRAINT [FK__маршруты__точка___5DCAEF64] FOREIGN KEY([точка_разгрузки_id])
REFERENCES [dbo].[точки_разгрузки] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[маршруты] CHECK CONSTRAINT [FK__маршруты__точка___5DCAEF64]
GO
ALTER TABLE [dbo].[перевозки]  WITH CHECK ADD  CONSTRAINT [FK__перевозки__водит__60A75C0F] FOREIGN KEY([водитель_id])
REFERENCES [dbo].[водители] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[перевозки] CHECK CONSTRAINT [FK__перевозки__водит__60A75C0F]
GO
ALTER TABLE [dbo].[перевозки]  WITH CHECK ADD  CONSTRAINT [FK__перевозки__грузо__5FB337D6] FOREIGN KEY([грузовой_автомобиль_id])
REFERENCES [dbo].[транспортные_средства] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[перевозки] CHECK CONSTRAINT [FK__перевозки__грузо__5FB337D6]
GO
ALTER TABLE [dbo].[перевозки]  WITH CHECK ADD  CONSTRAINT [FK__перевозки__заказ__5FB337D6] FOREIGN KEY([заказ_id])
REFERENCES [dbo].[заказы] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[перевозки] CHECK CONSTRAINT [FK__перевозки__заказ__5FB337D6]
GO
ALTER TABLE [dbo].[перевозки]  WITH CHECK ADD  CONSTRAINT [FK__перевозки__маршр__619B8048] FOREIGN KEY([маршрут_id])
REFERENCES [dbo].[маршруты] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[перевозки] CHECK CONSTRAINT [FK__перевозки__маршр__619B8048]
GO
ALTER TABLE [dbo].[статусы_заказов]  WITH CHECK ADD  CONSTRAINT [FK__статусы_з__заказ__6383C8BA] FOREIGN KEY([заказ_id])
REFERENCES [dbo].[заказы] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[статусы_заказов] CHECK CONSTRAINT [FK__статусы_з__заказ__6383C8BA]
GO
ALTER TABLE [dbo].[водители]  WITH CHECK ADD  CONSTRAINT [CK__водители__телефо__6383C8BA] CHECK  (([телефон] like '+7(9[0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
ALTER TABLE [dbo].[водители] CHECK CONSTRAINT [CK__водители__телефо__6383C8BA]
GO
ALTER TABLE [dbo].[клиенты]  WITH CHECK ADD  CONSTRAINT [CK__клиенты__телефон__6477ECF3] CHECK  (([телефон] like '+7(9[0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
ALTER TABLE [dbo].[клиенты] CHECK CONSTRAINT [CK__клиенты__телефон__6477ECF3]
GO
ALTER TABLE [dbo].[пользователи]  WITH CHECK ADD  CONSTRAINT [CK__пользовате__роль__6B24EA82] CHECK  (([роль]='администратор' OR [роль]='сотрудник'))
GO
ALTER TABLE [dbo].[пользователи] CHECK CONSTRAINT [CK__пользовате__роль__6B24EA82]
GO
ALTER TABLE [dbo].[статусы_заказов]  WITH CHECK ADD  CONSTRAINT [CK__статусы_з__стату__66603565] CHECK  (([статус]='в очереди' OR [статус]='в процессе' OR [статус]='отменён' OR [статус]='выполнен'))
GO
ALTER TABLE [dbo].[статусы_заказов] CHECK CONSTRAINT [CK__статусы_з__стату__66603565]
