USE [Bookstore]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_book_sale_summary'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_book_sale_summary'
GO
/****** Object:  StoredProcedure [dbo].[VerifyUser]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[VerifyUser]
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[UpdateOrder]
GO
/****** Object:  StoredProcedure [dbo].[UpdateBookStockAfterSales]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[UpdateBookStockAfterSales]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveShoppingCart]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveShoppingCart]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveRestock]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveRestock]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReports]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveReports]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveOrdersByCustomer]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveOrdersByCustomer]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveOrderDetail]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveOrderDetail]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveOrderByCustomer]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveOrderByCustomer]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveBooksByCombinedSearch]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveBooksByCombinedSearch]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveBookDetail]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveBookDetail]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAllOrders]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveAllOrders]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAllBooks]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RetrieveAllBooks]
GO
/****** Object:  StoredProcedure [dbo].[RemoveItemFromCart]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RemoveItemFromCart]
GO
/****** Object:  StoredProcedure [dbo].[RegisterNewUser]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RegisterNewUser]
GO
/****** Object:  StoredProcedure [dbo].[RegisterNewAddress]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[RegisterNewAddress]
GO
/****** Object:  StoredProcedure [dbo].[InsertNewOrder]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[InsertNewOrder]
GO
/****** Object:  StoredProcedure [dbo].[InsertNewBook]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[InsertNewBook]
GO
/****** Object:  StoredProcedure [dbo].[InsertItemToCart]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[InsertItemToCart]
GO
/****** Object:  StoredProcedure [dbo].[GetDefaultAddress]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[GetDefaultAddress]
GO
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[DeleteBook]
GO
/****** Object:  StoredProcedure [dbo].[CategorySalesReports]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[CategorySalesReports]
GO
/****** Object:  StoredProcedure [dbo].[AuthorSalesReports]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP PROCEDURE [dbo].[AuthorSalesReports]
GO
ALTER TABLE [dbo].[user] DROP CONSTRAINT [FK_user_address_bill]
GO
ALTER TABLE [dbo].[user] DROP CONSTRAINT [FK_user_address]
GO
ALTER TABLE [dbo].[shoppingcart] DROP CONSTRAINT [FK_cart_user]
GO
ALTER TABLE [dbo].[shoppingcart] DROP CONSTRAINT [FK_cart_book]
GO
ALTER TABLE [dbo].[re_stock] DROP CONSTRAINT [FK_re_stock_book]
GO
ALTER TABLE [dbo].[publisher] DROP CONSTRAINT [FK_publisher_address]
GO
ALTER TABLE [dbo].[payment] DROP CONSTRAINT [FK_payment_order]
GO
ALTER TABLE [dbo].[order] DROP CONSTRAINT [FK_order_user]
GO
ALTER TABLE [dbo].[book_order] DROP CONSTRAINT [FK_book_order_order]
GO
ALTER TABLE [dbo].[book_order] DROP CONSTRAINT [FK_book_order_book]
GO
ALTER TABLE [dbo].[book] DROP CONSTRAINT [FK_book_publisher]
GO
/****** Object:  Table [dbo].[user]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user]') AND type in (N'U'))
DROP TABLE [dbo].[user]
GO
/****** Object:  Table [dbo].[store_report]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[store_report]') AND type in (N'U'))
DROP TABLE [dbo].[store_report]
GO
/****** Object:  Table [dbo].[shoppingcart]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[shoppingcart]') AND type in (N'U'))
DROP TABLE [dbo].[shoppingcart]
GO
/****** Object:  Table [dbo].[re_stock]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[re_stock]') AND type in (N'U'))
DROP TABLE [dbo].[re_stock]
GO
/****** Object:  Table [dbo].[payment]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[payment]') AND type in (N'U'))
DROP TABLE [dbo].[payment]
GO
/****** Object:  Table [dbo].[address]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[address]') AND type in (N'U'))
DROP TABLE [dbo].[address]
GO
/****** Object:  View [dbo].[vw_book_sale_summary]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP VIEW [dbo].[vw_book_sale_summary]
GO
/****** Object:  Table [dbo].[order]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[order]') AND type in (N'U'))
DROP TABLE [dbo].[order]
GO
/****** Object:  Table [dbo].[book_order]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[book_order]') AND type in (N'U'))
DROP TABLE [dbo].[book_order]
GO
/****** Object:  Table [dbo].[book]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[book]') AND type in (N'U'))
DROP TABLE [dbo].[book]
GO
/****** Object:  Table [dbo].[publisher]    Script Date: 2021-12-18 5:56:12 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[publisher]') AND type in (N'U'))
DROP TABLE [dbo].[publisher]
GO
USE [master]
GO
/****** Object:  Database [Bookstore]    Script Date: 2021-12-18 5:56:12 PM ******/
DROP DATABASE [Bookstore]
GO
/****** Object:  Database [Bookstore]    Script Date: 2021-12-18 5:56:12 PM ******/
CREATE DATABASE [Bookstore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bookstore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\Bookstore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bookstore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\Bookstore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Bookstore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bookstore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bookstore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bookstore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bookstore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bookstore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bookstore] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bookstore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bookstore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bookstore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bookstore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bookstore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bookstore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bookstore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bookstore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bookstore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bookstore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bookstore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bookstore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bookstore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bookstore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bookstore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bookstore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bookstore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bookstore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bookstore] SET  MULTI_USER 
GO
ALTER DATABASE [Bookstore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bookstore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bookstore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bookstore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bookstore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bookstore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bookstore] SET QUERY_STORE = OFF
GO
USE [Bookstore]
GO
/****** Object:  Table [dbo].[publisher]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[publisher](
	[publisher_id] [int] IDENTITY(1,1) NOT NULL,
	[bank_account] [int] NOT NULL,
	[email] [varchar](20) NULL,
	[address_id] [int] NOT NULL,
	[publisher_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_publisher] PRIMARY KEY CLUSTERED 
(
	[publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book](
	[book_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](100) NOT NULL,
	[publisher_id] [int] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[pages] [int] NOT NULL,
	[year] [int] NOT NULL,
	[category] [varchar](50) NOT NULL,
	[author] [varchar](20) NOT NULL,
	[ISBN] [varchar](20) NOT NULL,
	[stock] [int] NOT NULL,
	[percentage_to_publisher] [int] NOT NULL,
 CONSTRAINT [PK_book] PRIMARY KEY CLUSTERED 
(
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book_order]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book_order](
	[book_order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
	[number_of_thebook] [int] NOT NULL,
 CONSTRAINT [PK_book_order] PRIMARY KEY CLUSTERED 
(
	[book_order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_status] [varchar](20) NOT NULL,
	[total_items] [int] NOT NULL,
	[total_price] [decimal](10, 2) NOT NULL,
	[customer_id] [int] NOT NULL,
	[order_date] [date] NOT NULL,
	[shipping_address_id] [int] NULL,
 CONSTRAINT [PK_order] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_book_sale_summary]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_book_sale_summary]
AS
SELECT c.order_id, b.book_id, a.title, a.author, d.publisher_name, a.category,a.price as unit_price, 
	b.number_of_thebook as sale_quantity, a.price*b.number_of_thebook as sales_subtotal, 
	a.percentage_to_publisher, 
	convert(decimal(10,2), a.percentage_to_publisher*a.price/100) as unit_pay_publisher, 
	convert(decimal(10,2), a.price*b.number_of_thebook*a.percentage_to_publisher/100) as expenditure_sub_total,
	--e.restock_quantity,	
	c.order_date
FROM   dbo.book a INNER JOIN
       dbo.book_order b ON a.book_id = b.book_id INNER JOIN
       dbo.[order] c ON b.order_id = c.order_id INNER JOIN
	   dbo.[publisher] d ON a.publisher_id = d.publisher_id 
	   --INNER JOIN dbo.[re_stock] e ON a.book_id = e.book_id

GO
/****** Object:  Table [dbo].[address]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[street] [varchar](20) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[province] [varchar](20) NOT NULL,
	[postcode] [varchar](20) NOT NULL,
	[country] [varchar](20) NOT NULL,
 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[payee_name] [varchar](20) NOT NULL,
	[pay_amount] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_payment] PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[re_stock]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[re_stock](
	[re_stock_id] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NOT NULL,
	[restock_quantity] [int] NOT NULL,
	[restock_date] [date] NOT NULL,
 CONSTRAINT [PK_re_stock] PRIMARY KEY CLUSTERED 
(
	[re_stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shoppingcart]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shoppingcart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_shoppingcart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[store_report]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[store_report](
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[year] [nchar](10) NOT NULL,
	[month] [nchar](10) NOT NULL,
	[auto_purchase] [bit] NOT NULL,
	[sales] [varchar](20) NOT NULL,
	[expense] [varchar](20) NOT NULL,
 CONSTRAINT [PK_report] PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](20) NULL,
	[phone] [int] NULL,
	[email] [varchar](20) NULL,
	[address_id] [int] NULL,
	[bill_address_id] [int] NULL,
	[login_name] [varchar](20) NOT NULL,
	[login_pwd] [varchar](20) NOT NULL,
	[role] [varchar](20) NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[address] ON 

INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (1, N'1 Hello Str', N'Ottawa', N'ON', N'A1B 2C3', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (2, N'2 Alo Str', N'Nepean', N'ON', N'A2B 3C4', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (3, N'3 Alo Str', N'Nepean', N'ON', N'A2B 3C4', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (4, N'4 Alo Str', N'Nepean', N'ON', N'A2B 3C4', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (5, N'5 Alo Str', N'Nepean', N'ON', N'A2B 3C4', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (6, N'6 Alo Str', N'Nepean', N'ON', N'A2B 3C4', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (7, N'100 Publish Str', N'Toronto', N'ON', N'M7N 8P9', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (8, N'101 Publish Str', N'Toronto', N'ON', N'M7N 8P9', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (9, N'102 Publish Str', N'Toronto', N'ON', N'M7N 8P9', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (10, N'103 Publish Str', N'Toronto', N'ON', N'M7N 8P9', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (11, N'1 Mancuso', N'Ottawa', N'ON', N'k2t', N'Canada')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (12, N'1 Man', N'Ottawa', N'ON', N'k2', N'Ca')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (13, N'2 Man', N'Ottawa', N'ON', N'909', N'CA')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (14, N'3 Man', N'Ottawa', N'ON', N'k2t', N'CA')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (15, N'2 Hello', N'Ottawa', N'ON', N'k2t', N'CA')
INSERT [dbo].[address] ([address_id], [street], [city], [province], [postcode], [country]) VALUES (16, N'10 Matthew St', N'Ottawa', N'ON', N'K2R', N'JP')
SET IDENTITY_INSERT [dbo].[address] OFF
GO
SET IDENTITY_INSERT [dbo].[book] ON 

INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (1, N'The National Geography -1', 2, CAST(43.00 AS Decimal(10, 2)), 356, 2019, N'Geography', N'Sportsman', N'ISBN4978461', 9, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (2, N'Living in MetaVerse -2', 4, CAST(44.00 AS Decimal(10, 2)), 355, 2011, N'Fiction', N'Gabriel', N'ISBN5419953', 11, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (3, N'Sports World -3', 6, CAST(30.00 AS Decimal(10, 2)), 468, 2010, N'Sports', N'Traves', N'ISBN5033591', 2, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (4, N'The National Geography -4', 1, CAST(37.00 AS Decimal(10, 2)), 161, 2010, N'Geography', N'Historian', N'ISBN2559639', 14, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (5, N'The Fitness -5', 4, CAST(35.00 AS Decimal(10, 2)), 318, 2010, N'Health', N'Healther', N'ISBN2894260', 16, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (6, N'Biking Around The World -6', 5, CAST(21.00 AS Decimal(10, 2)), 487, 2016, N'Travel', N'Historian', N'ISBN5732089', 16, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (7, N'Happy Kids -7', 4, CAST(47.00 AS Decimal(10, 2)), 332, 2017, N'Kids', N'Traves', N'ISBN1552681', 17, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (8, N'Happy Kids -8', 5, CAST(19.00 AS Decimal(10, 2)), 334, 2014, N'Kids', N'Cooker', N'ISBN3763446', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (9, N'The	Amazing World of Science -9', 2, CAST(14.00 AS Decimal(10, 2)), 230, 2017, N'Science', N'Artie', N'ISBN3874603', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (10, N'The Art and Music Wonderland -10', 6, CAST(11.00 AS Decimal(10, 2)), 287, 2012, N'Arts&Music', N'Doe', N'ISBN1543555', 13, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (11, N'Happy Kids -11', 4, CAST(25.00 AS Decimal(10, 2)), 498, 2019, N'Kids', N'Kevin', N'ISBN3224624', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (12, N'The National Geography -12', 5, CAST(27.00 AS Decimal(10, 2)), 113, 2019, N'Geography', N'Healther', N'ISBN1564949', 9, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (13, N'Minecraft How To -13', 4, CAST(50.00 AS Decimal(10, 2)), 194, 2010, N'Gaming', N'John', N'ISBN1379067', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (14, N'The Art and Music Wonderland -14', 1, CAST(30.00 AS Decimal(10, 2)), 415, 2017, N'Arts&Music', N'Kevin', N'ISBN6507432', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (15, N'Happy Kids -15', 6, CAST(5.00 AS Decimal(10, 2)), 214, 2011, N'Kids', N'Healther', N'ISBN3207542', 11, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (16, N'Happy Kids -16', 2, CAST(42.00 AS Decimal(10, 2)), 213, 2018, N'Kids', N'Frank', N'ISBN6411508', 16, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (17, N'The	Amazing World of Science -17', 3, CAST(36.00 AS Decimal(10, 2)), 311, 2011, N'Science', N'Tee', N'ISBN4429210', 12, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (18, N'Happy Kids -18', 1, CAST(28.00 AS Decimal(10, 2)), 337, 2016, N'Kids', N'John', N'ISBN4371100', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (19, N'Minecraft How To -19', 2, CAST(37.00 AS Decimal(10, 2)), 332, 2011, N'Gaming', N'Historian', N'ISBN4184134', 14, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (20, N'The Canadian History -20', 2, CAST(29.00 AS Decimal(10, 2)), 167, 2016, N'History', N'Sportsman', N'ISBN6018251', 16, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (21, N'The	Amazing World of Science -21', 4, CAST(13.00 AS Decimal(10, 2)), 426, 2016, N'Science', N'Cooker', N'ISBN7430160', 10, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (22, N'The Reality of Business -22', 1, CAST(15.00 AS Decimal(10, 2)), 338, 2015, N'Business', N'Geogrey', N'ISBN2703447', 20, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (23, N'Happy Teen -23', 5, CAST(46.00 AS Decimal(10, 2)), 302, 2017, N'Teen', N'Busiman', N'ISBN1368913', 18, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (24, N'The Master Chef -24', 3, CAST(46.00 AS Decimal(10, 2)), 176, 2010, N'Cooking', N'Cooker', N'ISBN4089096', 16, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (25, N'Happy Teen -25', 2, CAST(43.00 AS Decimal(10, 2)), 105, 2016, N'Teen', N'Kevin', N'ISBN1573339', 15, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (26, N'Happy Teen -26', 6, CAST(6.00 AS Decimal(10, 2)), 308, 2017, N'Teen', N'Scientist', N'ISBN4388849', 10, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (27, N'Minecraft How To -27', 5, CAST(25.00 AS Decimal(10, 2)), 287, 2019, N'Gaming', N'John', N'ISBN5187843', 17, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (28, N'The Art and Music Wonderland -28', 4, CAST(35.00 AS Decimal(10, 2)), 342, 2013, N'Arts&Music', N'John', N'ISBN5743347', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (29, N'Happy Teen -29', 5, CAST(38.00 AS Decimal(10, 2)), 489, 2021, N'Teen', N'Cooker', N'ISBN2115416', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (30, N'The	Amazing World of Science -30', 2, CAST(40.00 AS Decimal(10, 2)), 261, 2012, N'Science', N'Traves', N'ISBN6746150', 11, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (31, N'Minecraft How To -31', 2, CAST(21.00 AS Decimal(10, 2)), 414, 2015, N'Gaming', N'Gabriel', N'ISBN6972324', 17, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (32, N'The National Geography -32', 1, CAST(27.00 AS Decimal(10, 2)), 165, 2012, N'Geography', N'Ryan', N'ISBN4009433', 14, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (33, N'Religion At The Beginning -33', 6, CAST(37.00 AS Decimal(10, 2)), 126, 2010, N'Religion', N'Artie', N'ISBN7614286', 14, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (34, N'Happy Teen -34', 4, CAST(14.00 AS Decimal(10, 2)), 309, 2018, N'Teen', N'Tee', N'ISBN2208558', 15, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (35, N'The National Geography -35', 2, CAST(13.00 AS Decimal(10, 2)), 198, 2012, N'Geography', N'Cooker', N'ISBN4868958', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (36, N'The Canadian History -36', 5, CAST(3.00 AS Decimal(10, 2)), 304, 2011, N'History', N'Sportsman', N'ISBN5409041', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (37, N'The Fitness -37', 6, CAST(26.00 AS Decimal(10, 2)), 194, 2015, N'Health', N'John', N'ISBN4056566', 20, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (38, N'Biking Around The World -38', 5, CAST(33.00 AS Decimal(10, 2)), 259, 2015, N'Travel', N'Sportsman', N'ISBN7296925', 19, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (39, N'Happy Teen -39', 4, CAST(22.00 AS Decimal(10, 2)), 175, 2015, N'Teen', N'Frank', N'ISBN2004904', 18, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (40, N'Minecraft How To -40', 4, CAST(12.00 AS Decimal(10, 2)), 281, 2016, N'Gaming', N'Cooker', N'ISBN1389578', 16, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (41, N'The Canadian History -41', 2, CAST(2.00 AS Decimal(10, 2)), 199, 2020, N'History', N'Historian', N'ISBN3851493', 18, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (42, N'The	Amazing World of Science -42', 2, CAST(47.00 AS Decimal(10, 2)), 378, 2012, N'Science', N'Doe', N'ISBN4562201', 19, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (43, N'Sports World -43', 6, CAST(14.00 AS Decimal(10, 2)), 441, 2015, N'Sports', N'Cooker', N'ISBN4973224', 20, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (44, N'Sports World -44', 4, CAST(5.00 AS Decimal(10, 2)), 261, 2013, N'Sports', N'John', N'ISBN3437493', 14, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (45, N'Happy Kids -45', 5, CAST(9.00 AS Decimal(10, 2)), 270, 2020, N'Kids', N'Doe', N'ISBN7431681', 14, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (46, N'The Canadian History -46', 2, CAST(7.00 AS Decimal(10, 2)), 463, 2015, N'History', N'John', N'ISBN2015224', 17, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (47, N'Sports World -47', 3, CAST(28.00 AS Decimal(10, 2)), 119, 2019, N'Sports', N'Doe', N'ISBN7164509', 20, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (48, N'Living in MetaVerse -48', 2, CAST(27.00 AS Decimal(10, 2)), 237, 2018, N'Fiction', N'Scientist', N'ISBN5183987', 16, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (49, N'The	Amazing World of Science -49', 2, CAST(11.00 AS Decimal(10, 2)), 175, 2021, N'Science', N'Traves', N'ISBN3698564', 19, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (50, N'The Master Chef -50', 5, CAST(28.00 AS Decimal(10, 2)), 193, 2017, N'Cooking', N'Scientist', N'ISBN2860976', 16, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (51, N'Happy Kids -51', 5, CAST(44.00 AS Decimal(10, 2)), 463, 2016, N'Kids', N'Scientist', N'ISBN5518604', 15, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (52, N'Minecraft How To -52', 4, CAST(47.00 AS Decimal(10, 2)), 263, 2014, N'Gaming', N'Frank', N'ISBN5670858', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (53, N'Biking Around The World -53', 1, CAST(45.00 AS Decimal(10, 2)), 390, 2012, N'Travel', N'Artie', N'ISBN6192608', 12, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (54, N'Religion At The Beginning -54', 1, CAST(41.00 AS Decimal(10, 2)), 281, 2010, N'Religion', N'Sportsman', N'ISBN1926380', 14, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (55, N'Biking Around The World -55', 6, CAST(38.00 AS Decimal(10, 2)), 343, 2015, N'Travel', N'Healther', N'ISBN5062743', 16, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (56, N'Happy Teen -56', 3, CAST(14.00 AS Decimal(10, 2)), 269, 2010, N'Teen', N'Traves', N'ISBN4124081', 14, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (57, N'The Reality of Business -57', 3, CAST(38.00 AS Decimal(10, 2)), 494, 2015, N'Business', N'Doe', N'ISBN5410081', 19, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (58, N'The Master Chef -58', 4, CAST(38.00 AS Decimal(10, 2)), 358, 2015, N'Cooking', N'Cooker', N'ISBN3338086', 16, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (59, N'Religion At The Beginning -59', 3, CAST(18.00 AS Decimal(10, 2)), 499, 2016, N'Religion', N'Scientist', N'ISBN5182128', 18, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (60, N'The	Amazing World of Science -60', 4, CAST(12.00 AS Decimal(10, 2)), 103, 2019, N'Science', N'Geogrey', N'ISBN1861643', 11, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (61, N'The Reality of Business -61', 2, CAST(4.00 AS Decimal(10, 2)), 308, 2012, N'Business', N'Historian', N'ISBN5506695', 16, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (62, N'Biking Around The World -62', 3, CAST(23.00 AS Decimal(10, 2)), 461, 2020, N'Travel', N'Busiman', N'ISBN7172311', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (63, N'Biking Around The World -63', 1, CAST(43.00 AS Decimal(10, 2)), 420, 2016, N'Travel', N'Gabriel', N'ISBN7166994', 12, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (64, N'The	Amazing World of Science -64', 6, CAST(41.00 AS Decimal(10, 2)), 264, 2018, N'Science', N'Ryan', N'ISBN3576510', 17, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (65, N'The Fitness -65', 1, CAST(1.00 AS Decimal(10, 2)), 140, 2014, N'Health', N'Tee', N'ISBN2443340', 13, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (66, N'Happy Kids -66', 6, CAST(28.00 AS Decimal(10, 2)), 355, 2019, N'Kids', N'Sportsman', N'ISBN1684952', 15, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (67, N'Happy Teen -67', 3, CAST(3.00 AS Decimal(10, 2)), 220, 2014, N'Teen', N'Frank', N'ISBN7612881', 18, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (68, N'The Canadian History -68', 1, CAST(6.00 AS Decimal(10, 2)), 307, 2013, N'History', N'Ryan', N'ISBN1816426', 15, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (69, N'The Reality of Business -69', 1, CAST(10.00 AS Decimal(10, 2)), 483, 2014, N'Business', N'Busiman', N'ISBN6028102', 19, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (70, N'The Fitness -70', 4, CAST(36.00 AS Decimal(10, 2)), 347, 2021, N'Health', N'Tee', N'ISBN3438220', 16, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (71, N'Minecraft How To -71', 6, CAST(31.00 AS Decimal(10, 2)), 193, 2016, N'Gaming', N'Scientist', N'ISBN3452966', 14, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (72, N'The Master Chef -72', 5, CAST(9.00 AS Decimal(10, 2)), 256, 2012, N'Cooking', N'Frank', N'ISBN3736116', 15, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (73, N'Minecraft How To -73', 2, CAST(2.00 AS Decimal(10, 2)), 481, 2019, N'Gaming', N'Cooker', N'ISBN2576296', 11, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (74, N'Sports World -74', 6, CAST(50.00 AS Decimal(10, 2)), 346, 2013, N'Sports', N'Traves', N'ISBN5066010', 18, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (75, N'The National Geography -75', 2, CAST(50.00 AS Decimal(10, 2)), 337, 2021, N'Geography', N'Traves', N'ISBN4102253', 13, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (76, N'The Master Chef -76', 6, CAST(22.00 AS Decimal(10, 2)), 460, 2020, N'Cooking', N'Sportsman', N'ISBN4274942', 17, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (77, N'Happy Kids -77', 1, CAST(20.00 AS Decimal(10, 2)), 385, 2016, N'Kids', N'Doe', N'ISBN7274606', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (78, N'Biking Around The World -78', 5, CAST(23.00 AS Decimal(10, 2)), 276, 2013, N'Travel', N'Historian', N'ISBN4422730', 14, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (79, N'Sports World -79', 2, CAST(15.00 AS Decimal(10, 2)), 447, 2019, N'Sports', N'Artie', N'ISBN5406359', 12, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (80, N'Living in MetaVerse -80', 2, CAST(33.00 AS Decimal(10, 2)), 269, 2018, N'Fiction', N'Artie', N'ISBN1454132', 19, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (81, N'Minecraft How To -81', 1, CAST(27.00 AS Decimal(10, 2)), 215, 2015, N'Gaming', N'Busiman', N'ISBN1707871', 10, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (82, N'Biking Around The World -82', 3, CAST(18.00 AS Decimal(10, 2)), 341, 2010, N'Travel', N'Doe', N'ISBN4603522', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (83, N'Happy Teen -83', 3, CAST(37.00 AS Decimal(10, 2)), 110, 2019, N'Teen', N'Scientist', N'ISBN6407530', 14, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (84, N'The Canadian History -84', 5, CAST(50.00 AS Decimal(10, 2)), 375, 2016, N'History', N'Tee', N'ISBN5484069', 15, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (85, N'The Canadian History -85', 4, CAST(40.00 AS Decimal(10, 2)), 132, 2011, N'History', N'Tee', N'ISBN1868316', 14, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (86, N'The Master Chef -86', 4, CAST(33.00 AS Decimal(10, 2)), 137, 2013, N'Cooking', N'Healther', N'ISBN2479991', 20, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (87, N'The Art and Music Wonderland -87', 6, CAST(43.00 AS Decimal(10, 2)), 315, 2017, N'Arts&Music', N'Cooker', N'ISBN5272329', 16, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (88, N'The Canadian History -88', 3, CAST(21.00 AS Decimal(10, 2)), 445, 2014, N'History', N'John', N'ISBN3138276', 16, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (89, N'The Master Chef -89', 6, CAST(1.00 AS Decimal(10, 2)), 178, 2012, N'Cooking', N'Historian', N'ISBN6960813', 15, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (90, N'The Master Chef -90', 1, CAST(14.00 AS Decimal(10, 2)), 465, 2012, N'Cooking', N'Sportsman', N'ISBN6872807', 13, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (91, N'Living in MetaVerse -91', 6, CAST(8.00 AS Decimal(10, 2)), 102, 2021, N'Fiction', N'Doe', N'ISBN6847842', 12, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (92, N'The	Amazing World of Science -92', 5, CAST(31.00 AS Decimal(10, 2)), 351, 2011, N'Science', N'Artie', N'ISBN2529260', 17, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (93, N'The Art and Music Wonderland -93', 6, CAST(44.00 AS Decimal(10, 2)), 271, 2014, N'Arts&Music', N'Historian', N'ISBN3078900', 18, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (94, N'The	Amazing World of Science -94', 2, CAST(10.00 AS Decimal(10, 2)), 240, 2021, N'Science', N'Artie', N'ISBN3096444', 13, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (95, N'The Master Chef -95', 3, CAST(37.00 AS Decimal(10, 2)), 326, 2016, N'Cooking', N'Ryan', N'ISBN1909938', 10, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (96, N'Happy Teen -96', 4, CAST(27.00 AS Decimal(10, 2)), 345, 2014, N'Teen', N'Artie', N'ISBN1754247', 18, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (97, N'Happy Kids -97', 6, CAST(4.00 AS Decimal(10, 2)), 179, 2011, N'Kids', N'Gabriel', N'ISBN1545589', 16, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (98, N'The Reality of Business -98', 2, CAST(11.00 AS Decimal(10, 2)), 359, 2016, N'Business', N'Geogrey', N'ISBN5480553', 10, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (99, N'The Fitness -99', 3, CAST(29.00 AS Decimal(10, 2)), 312, 2018, N'Health', N'Tee', N'ISBN6152103', 12, 60)
GO
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (100, N'Religion At The Beginning -100', 6, CAST(27.00 AS Decimal(10, 2)), 243, 2019, N'Religion', N'Tee', N'ISBN3495145', 10, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (101, N'The Reality of Business -101', 2, CAST(18.00 AS Decimal(10, 2)), 264, 2021, N'Business', N'Historian', N'ISBN5135016', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (102, N'Religion At The Beginning -102', 1, CAST(30.00 AS Decimal(10, 2)), 190, 2018, N'Religion', N'Frank', N'ISBN5908305', 12, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (103, N'The Master Chef -103', 2, CAST(17.00 AS Decimal(10, 2)), 396, 2018, N'Cooking', N'Artie', N'ISBN7027204', 19, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (104, N'The Canadian History -104', 4, CAST(35.00 AS Decimal(10, 2)), 271, 2014, N'History', N'Artie', N'ISBN5967281', 17, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (105, N'Minecraft How To -105', 6, CAST(46.00 AS Decimal(10, 2)), 100, 2020, N'Gaming', N'Historian', N'ISBN6705772', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (106, N'The Art and Music Wonderland -106', 6, CAST(43.00 AS Decimal(10, 2)), 346, 2020, N'Arts&Music', N'Scientist', N'ISBN4759714', 19, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (107, N'The Art and Music Wonderland -107', 1, CAST(31.00 AS Decimal(10, 2)), 260, 2021, N'Arts&Music', N'Historian', N'ISBN2615993', 20, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (108, N'The Fitness -108', 2, CAST(30.00 AS Decimal(10, 2)), 437, 2017, N'Health', N'Kevin', N'ISBN5504202', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (109, N'Religion At The Beginning -109', 2, CAST(35.00 AS Decimal(10, 2)), 117, 2019, N'Religion', N'Tee', N'ISBN1350073', 16, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (110, N'The Reality of Business -110', 4, CAST(4.00 AS Decimal(10, 2)), 234, 2021, N'Business', N'Sportsman', N'ISBN3638185', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (111, N'Living in MetaVerse -111', 5, CAST(25.00 AS Decimal(10, 2)), 169, 2012, N'Fiction', N'Tee', N'ISBN3113819', 15, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (112, N'The Master Chef -112', 4, CAST(1.00 AS Decimal(10, 2)), 108, 2019, N'Cooking', N'Historian', N'ISBN4279053', 16, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (113, N'Happy Kids -113', 6, CAST(22.00 AS Decimal(10, 2)), 308, 2015, N'Kids', N'Artie', N'ISBN7189938', 12, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (114, N'The Canadian History -114', 5, CAST(42.00 AS Decimal(10, 2)), 295, 2021, N'History', N'Doe', N'ISBN2940161', 20, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (115, N'Religion At The Beginning -115', 6, CAST(1.00 AS Decimal(10, 2)), 433, 2010, N'Religion', N'Frank', N'ISBN5966278', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (116, N'Biking Around The World -116', 5, CAST(7.00 AS Decimal(10, 2)), 105, 2020, N'Travel', N'Ryan', N'ISBN1846222', 15, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (117, N'The Art and Music Wonderland -117', 6, CAST(34.00 AS Decimal(10, 2)), 479, 2013, N'Arts&Music', N'Healther', N'ISBN4873997', 18, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (118, N'The National Geography -118', 5, CAST(30.00 AS Decimal(10, 2)), 197, 2012, N'Geography', N'Historian', N'ISBN4533147', 19, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (119, N'Happy Kids -119', 1, CAST(23.00 AS Decimal(10, 2)), 320, 2021, N'Kids', N'Historian', N'ISBN1344492', 10, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (120, N'The Fitness -120', 2, CAST(27.00 AS Decimal(10, 2)), 284, 2020, N'Health', N'Kevin', N'ISBN7425517', 17, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (121, N'Biking Around The World -121', 4, CAST(39.00 AS Decimal(10, 2)), 311, 2012, N'Travel', N'Geogrey', N'ISBN2789895', 15, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (122, N'The	Amazing World of Science -122', 4, CAST(9.00 AS Decimal(10, 2)), 342, 2014, N'Science', N'Geogrey', N'ISBN3588199', 11, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (123, N'The Fitness -123', 3, CAST(38.00 AS Decimal(10, 2)), 430, 2013, N'Health', N'Scientist', N'ISBN1900578', 10, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (124, N'The Art and Music Wonderland -124', 2, CAST(32.00 AS Decimal(10, 2)), 312, 2013, N'Arts&Music', N'Scientist', N'ISBN6017701', 11, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (125, N'Religion At The Beginning -125', 4, CAST(23.00 AS Decimal(10, 2)), 224, 2014, N'Religion', N'Sportsman', N'ISBN5412325', 17, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (126, N'Biking Around The World -126', 5, CAST(42.00 AS Decimal(10, 2)), 391, 2010, N'Travel', N'Busiman', N'ISBN7194200', 13, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (127, N'The	Amazing World of Science -127', 1, CAST(44.00 AS Decimal(10, 2)), 263, 2013, N'Science', N'Gabriel', N'ISBN5194570', 13, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (128, N'The National Geography -128', 4, CAST(20.00 AS Decimal(10, 2)), 152, 2011, N'Geography', N'Artie', N'ISBN6359537', 17, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (129, N'The Canadian History -129', 6, CAST(6.00 AS Decimal(10, 2)), 424, 2015, N'History', N'Ryan', N'ISBN3918599', 14, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (130, N'The Canadian History -130', 3, CAST(29.00 AS Decimal(10, 2)), 225, 2012, N'History', N'Gabriel', N'ISBN6710343', 16, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (131, N'The Art and Music Wonderland -131', 6, CAST(3.00 AS Decimal(10, 2)), 121, 2017, N'Arts&Music', N'Historian', N'ISBN6724689', 13, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (132, N'Biking Around The World -132', 4, CAST(50.00 AS Decimal(10, 2)), 493, 2014, N'Travel', N'Gabriel', N'ISBN2831730', 11, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (133, N'Happy Teen -133', 5, CAST(3.00 AS Decimal(10, 2)), 480, 2012, N'Teen', N'Cooker', N'ISBN7089242', 12, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (134, N'Happy Kids -134', 5, CAST(11.00 AS Decimal(10, 2)), 100, 2019, N'Kids', N'Artie', N'ISBN6926498', 11, 60)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (135, N'Happy Teen -135', 2, CAST(12.00 AS Decimal(10, 2)), 349, 2011, N'Teen', N'Sportsman', N'ISBN1904391', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (136, N'The Canadian History -136', 5, CAST(42.00 AS Decimal(10, 2)), 346, 2016, N'History', N'Geogrey', N'ISBN5411115', 15, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (137, N'The Master Chef -137', 6, CAST(31.00 AS Decimal(10, 2)), 148, 2015, N'Cooking', N'Sportsman', N'ISBN6212982', 16, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (138, N'The Canadian History -138', 1, CAST(16.00 AS Decimal(10, 2)), 277, 2021, N'History', N'Frank', N'ISBN5640245', 11, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (139, N'Happy Kids -139', 6, CAST(43.00 AS Decimal(10, 2)), 228, 2013, N'Kids', N'Ryan', N'ISBN4266501', 13, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (140, N'The Reality of Business -140', 5, CAST(43.00 AS Decimal(10, 2)), 147, 2018, N'Business', N'Ryan', N'ISBN1251480', 20, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (141, N'Minecraft How To -141', 2, CAST(48.00 AS Decimal(10, 2)), 192, 2011, N'Gaming', N'John', N'ISBN1903608', 20, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (142, N'The	Amazing World of Science -142', 6, CAST(37.00 AS Decimal(10, 2)), 134, 2010, N'Science', N'Geogrey', N'ISBN4868329', 15, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (143, N'The Master Chef -143', 5, CAST(27.00 AS Decimal(10, 2)), 158, 2015, N'Cooking', N'Cooker', N'ISBN4144770', 10, 90)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (144, N'The Fitness -144', 4, CAST(26.00 AS Decimal(10, 2)), 442, 2021, N'Health', N'Historian', N'ISBN5028468', 12, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (145, N'Biking Around The World -145', 1, CAST(13.00 AS Decimal(10, 2)), 108, 2012, N'Travel', N'Scientist', N'ISBN4710849', 15, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (146, N'Happy Teen -146', 6, CAST(46.00 AS Decimal(10, 2)), 151, 2013, N'Teen', N'Geogrey', N'ISBN3431741', 11, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (147, N'The	Amazing World of Science -147', 3, CAST(24.00 AS Decimal(10, 2)), 232, 2011, N'Science', N'Gabriel', N'ISBN4412385', 19, 70)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (148, N'The Art and Music Wonderland -148', 2, CAST(3.00 AS Decimal(10, 2)), 312, 2016, N'Arts&Music', N'Traves', N'ISBN2637440', 11, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (149, N'The Reality of Business -149', 4, CAST(49.00 AS Decimal(10, 2)), 180, 2014, N'Business', N'Busiman', N'ISBN4163439', 15, 50)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (150, N'The Fitness -150', 5, CAST(2.00 AS Decimal(10, 2)), 437, 2017, N'Health', N'Tee', N'ISBN1548457', 10, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (152, N'Matthew and Isaac', NULL, CAST(60.00 AS Decimal(10, 2)), 17, 2000, N'Gaming', N'Kevin', N'ISBN1010', 11, 80)
INSERT [dbo].[book] ([book_id], [title], [publisher_id], [price], [pages], [year], [category], [author], [ISBN], [stock], [percentage_to_publisher]) VALUES (153, N'Matthew and Isaac', 2, CAST(60.00 AS Decimal(10, 2)), 17, 2000, N'Gaming', N'Heather', N'ISBN1010', 9, 80)
SET IDENTITY_INSERT [dbo].[book] OFF
GO
SET IDENTITY_INSERT [dbo].[book_order] ON 

INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (1, 1, 4, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (2, 1, 5, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (3, 1, 6, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (4, 4, 7, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (7, 4, 8, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (8, 6, 9, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (9, 6, 10, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (10, 7, 11, 2)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (11, 8, 12, 3)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (12, 9, 13, 4)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (13, 10, 14, 2)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (14, 11, 15, 10)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (15, 12, 10, 2)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (16, 12, 11, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (17, 12, 12, 2)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (18, 13, 3, 7)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (19, 13, 12, 3)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (20, 14, 12, 5)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (21, 14, 3, 5)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (22, 15, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (23, 15, 2, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (24, 15, 3, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (25, 15, 4, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (26, 16, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (27, 17, 1, 2)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (28, 17, 2, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (29, 17, 3, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (30, 17, 1, 2)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (31, 17, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (32, 18, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (33, 19, 3, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (34, 20, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (35, 20, 2, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (36, 20, 3, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (37, 21, 12, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (38, 23, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (39, 23, 3, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (40, 24, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (41, 24, 17, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (42, 24, 4, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (43, 25, 2, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (44, 25, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (45, 26, 1, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (46, 27, 12, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (47, 27, 14, 1)
INSERT [dbo].[book_order] ([book_order_id], [order_id], [book_id], [number_of_thebook]) VALUES (48, 28, 153, 2)
SET IDENTITY_INSERT [dbo].[book_order] OFF
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (1, N'order processing', 3, CAST(93.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-01' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (4, N'order processing', 2, CAST(66.00 AS Decimal(10, 2)), 3, CAST(N'2021-12-02' AS Date), 2)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (6, N'order shipped', 2, CAST(25.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-01' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (7, N'order received', 2, CAST(50.00 AS Decimal(10, 2)), 4, CAST(N'2021-11-20' AS Date), 3)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (8, N'order received', 3, CAST(81.00 AS Decimal(10, 2)), 4, CAST(N'2021-11-22' AS Date), 3)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (9, N'order received', 4, CAST(200.00 AS Decimal(10, 2)), 3, CAST(N'2021-11-10' AS Date), 2)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (10, N'order received', 2, CAST(60.00 AS Decimal(10, 2)), 2, CAST(N'2021-10-12' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (11, N'order shipped', 10, CAST(50.00 AS Decimal(10, 2)), 4, CAST(N'2021-10-18' AS Date), 3)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (12, N'order received', 5, CAST(101.00 AS Decimal(10, 2)), 7, CAST(N'2021-12-16' AS Date), 6)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (13, N'order received', 10, CAST(291.00 AS Decimal(10, 2)), 7, CAST(N'2021-12-16' AS Date), 6)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (14, N'order received', 10, CAST(285.00 AS Decimal(10, 2)), 7, CAST(N'2021-12-16' AS Date), 6)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (15, N'order received', 4, CAST(154.00 AS Decimal(10, 2)), 7, CAST(N'2021-12-16' AS Date), 6)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (16, N'order received', 1, CAST(43.00 AS Decimal(10, 2)), 1002, CAST(N'2021-12-16' AS Date), 12)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (17, N'order received', 7, CAST(289.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-16' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (18, N'order received', 1, CAST(43.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-16' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (19, N'order received', 1, CAST(30.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-16' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (20, N'order received', 3, CAST(117.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-16' AS Date), 14)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (21, N'order received', 1, CAST(27.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-16' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (22, N'order received', 0, CAST(0.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-17' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (23, N'order received', 2, CAST(73.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-17' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (24, N'order received', 3, CAST(116.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-17' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (25, N'order received', 2, CAST(87.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-17' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (26, N'order received', 1, CAST(43.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-17' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (27, N'order received', 2, CAST(57.00 AS Decimal(10, 2)), 2, CAST(N'2021-12-18' AS Date), 1)
INSERT [dbo].[order] ([order_id], [order_status], [total_items], [total_price], [customer_id], [order_date], [shipping_address_id]) VALUES (28, N'order received', 2, CAST(120.00 AS Decimal(10, 2)), 1004, CAST(N'2021-12-18' AS Date), 16)
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[payment] ON 

INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (1, 13, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (2, 13, N'Oreily', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (3, 14, N'Oreily', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (4, 14, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (5, 15, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (6, 15, N'CBA', CAST(39.60 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (7, 15, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (8, 15, N'Cambridge', CAST(25.90 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (9, 16, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (10, 17, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (11, 17, N'CBA', CAST(39.60 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (12, 17, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (13, 18, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (14, 19, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (15, 20, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (16, 20, N'CBA', CAST(39.60 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (17, 20, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (18, 21, N'Oreily', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (19, 23, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (20, 23, N'Oxford', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (21, 24, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (22, 24, N'DoPublish', CAST(28.80 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (23, 24, N'Cambridge', CAST(25.90 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (24, 25, N'CBA', CAST(39.60 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (25, 25, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (26, 26, N'ABC', CAST(38.70 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (27, 27, N'Oreily', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (28, 27, N'Cambridge', CAST(21.00 AS Decimal(10, 2)))
INSERT [dbo].[payment] ([payment_id], [order_id], [payee_name], [pay_amount]) VALUES (29, 28, N'ABC', CAST(48.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[payment] OFF
GO
SET IDENTITY_INSERT [dbo].[publisher] ON 

INSERT [dbo].[publisher] ([publisher_id], [bank_account], [email], [address_id], [publisher_name]) VALUES (1, 56789, N'cam@cam.com', 8, N'Cambridge')
INSERT [dbo].[publisher] ([publisher_id], [bank_account], [email], [address_id], [publisher_name]) VALUES (2, 123456, N'abc@gmail.com', 7, N'ABC')
INSERT [dbo].[publisher] ([publisher_id], [bank_account], [email], [address_id], [publisher_name]) VALUES (3, 56789012, N'JP@jp.com', 9, N'DoPublish')
INSERT [dbo].[publisher] ([publisher_id], [bank_account], [email], [address_id], [publisher_name]) VALUES (4, 654321, N'cba@gmail.com', 8, N'CBA')
INSERT [dbo].[publisher] ([publisher_id], [bank_account], [email], [address_id], [publisher_name]) VALUES (5, 20202021, N'Oreily@gmail.com', 9, N'Oreily')
INSERT [dbo].[publisher] ([publisher_id], [bank_account], [email], [address_id], [publisher_name]) VALUES (6, 250250, N'oxford@gmail.com', 10, N'Oxford')
SET IDENTITY_INSERT [dbo].[publisher] OFF
GO
SET IDENTITY_INSERT [dbo].[re_stock] ON 

INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (1, 3, 5, CAST(N'2021-09-09' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (2, 10, 4, CAST(N'2021-09-15' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (3, 12, 2, CAST(N'2021-09-20' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (4, 12, 3, CAST(N'2021-12-16' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (7, 3, 0, CAST(N'2021-12-16' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (8, 3, 0, CAST(N'2021-12-16' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (9, 12, 3, CAST(N'2021-12-16' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (10, 3, 0, CAST(N'2021-12-17' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (11, 1, 0, CAST(N'2021-12-17' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (12, 12, 3, CAST(N'2021-12-18' AS Date))
INSERT [dbo].[re_stock] ([re_stock_id], [book_id], [restock_quantity], [restock_date]) VALUES (13, 153, 0, CAST(N'2021-12-18' AS Date))
SET IDENTITY_INSERT [dbo].[re_stock] OFF
GO
SET IDENTITY_INSERT [dbo].[shoppingcart] ON 

INSERT [dbo].[shoppingcart] ([cart_id], [customer_id], [book_id], [quantity]) VALUES (5, 3, 5, 1)
INSERT [dbo].[shoppingcart] ([cart_id], [customer_id], [book_id], [quantity]) VALUES (7, 3, 6, 2)
INSERT [dbo].[shoppingcart] ([cart_id], [customer_id], [book_id], [quantity]) VALUES (17, 5, 1, 1)
SET IDENTITY_INSERT [dbo].[shoppingcart] OFF
GO
SET IDENTITY_INSERT [dbo].[store_report] ON 

INSERT [dbo].[store_report] ([report_id], [year], [month], [auto_purchase], [sales], [expense]) VALUES (1, N'2021      ', N'07        ', 0, N'1000', N'800')
INSERT [dbo].[store_report] ([report_id], [year], [month], [auto_purchase], [sales], [expense]) VALUES (2, N'2021      ', N'08        ', 0, N'1200', N'800')
INSERT [dbo].[store_report] ([report_id], [year], [month], [auto_purchase], [sales], [expense]) VALUES (3, N'2021      ', N'09        ', 0, N'1300', N'850')
INSERT [dbo].[store_report] ([report_id], [year], [month], [auto_purchase], [sales], [expense]) VALUES (4, N'2021      ', N'10        ', 0, N'1100', N'800')
INSERT [dbo].[store_report] ([report_id], [year], [month], [auto_purchase], [sales], [expense]) VALUES (5, N'2021      ', N'11        ', 0, N'1500', N'900')
SET IDENTITY_INSERT [dbo].[store_report] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (1, N'test5     ', 9234567, N'test5@hi.com', 3, 3, N'test5', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (2, N'test1     ', 1234567, N'test1@hi.com', 1, 1, N'test1', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (3, N'test2     ', 1234567, N'test2@hi.com', 2, 2, N'test2', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (4, N'test3     ', 1234567, N'test3@hi.com', 3, 3, N'test3', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (5, N'owner1    ', 7654321, N'o1@hello.com', 4, 4, N'owner1', N'T1234', N'owner')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (6, N'owner2    ', 7654321, N'o2@hello.com', 5, 5, N'owner2', N'T1234', N'owner')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (7, N'test4     ', 7654321, N'test4@hello.com', 6, 6, N'test4', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (1000, N'visitor     ', 9999999, N'visitor@fake.com', 3, 3, N'visitor', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (1001, N'Kevin Lin', 1234567890, N'kevin@hello.com', 11, 11, N'', N'', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (1002, N'Kev Kev', 1234, N'kev@hel.com', 12, 12, N'kev', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (1003, N'fay fay', 4321, N'fay@hel.com', 13, 13, N'fay', N'T1234', N'user')
INSERT [dbo].[user] ([user_id], [username], [phone], [email], [address_id], [bill_address_id], [login_name], [login_pwd], [role]) VALUES (1004, N'Isaac Le', 1234, N'isaac@hello.com', 15, 15, N'isaac1', N'T1234', N'user')
SET IDENTITY_INSERT [dbo].[user] OFF
GO
ALTER TABLE [dbo].[book]  WITH CHECK ADD  CONSTRAINT [FK_book_publisher] FOREIGN KEY([publisher_id])
REFERENCES [dbo].[publisher] ([publisher_id])
GO
ALTER TABLE [dbo].[book] CHECK CONSTRAINT [FK_book_publisher]
GO
ALTER TABLE [dbo].[book_order]  WITH CHECK ADD  CONSTRAINT [FK_book_order_book] FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([book_id])
GO
ALTER TABLE [dbo].[book_order] CHECK CONSTRAINT [FK_book_order_book]
GO
ALTER TABLE [dbo].[book_order]  WITH CHECK ADD  CONSTRAINT [FK_book_order_order] FOREIGN KEY([order_id])
REFERENCES [dbo].[order] ([order_id])
GO
ALTER TABLE [dbo].[book_order] CHECK CONSTRAINT [FK_book_order_order]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_user] FOREIGN KEY([customer_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_user]
GO
ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK_payment_order] FOREIGN KEY([order_id])
REFERENCES [dbo].[order] ([order_id])
GO
ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK_payment_order]
GO
ALTER TABLE [dbo].[publisher]  WITH CHECK ADD  CONSTRAINT [FK_publisher_address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([address_id])
GO
ALTER TABLE [dbo].[publisher] CHECK CONSTRAINT [FK_publisher_address]
GO
ALTER TABLE [dbo].[re_stock]  WITH CHECK ADD  CONSTRAINT [FK_re_stock_book] FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([book_id])
GO
ALTER TABLE [dbo].[re_stock] CHECK CONSTRAINT [FK_re_stock_book]
GO
ALTER TABLE [dbo].[shoppingcart]  WITH CHECK ADD  CONSTRAINT [FK_cart_book] FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([book_id])
GO
ALTER TABLE [dbo].[shoppingcart] CHECK CONSTRAINT [FK_cart_book]
GO
ALTER TABLE [dbo].[shoppingcart]  WITH CHECK ADD  CONSTRAINT [FK_cart_user] FOREIGN KEY([customer_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[shoppingcart] CHECK CONSTRAINT [FK_cart_user]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([address_id])
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_address]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_address_bill] FOREIGN KEY([bill_address_id])
REFERENCES [dbo].[address] ([address_id])
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_address_bill]
GO
/****** Object:  StoredProcedure [dbo].[AuthorSalesReports]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Name>
-- Create date: <Create Date,,>
-- Description: retrieve information from the view
-- =============================================
CREATE PROCEDURE [dbo].[AuthorSalesReports]
-- Add the parameters for the stored procedure here

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

SELECT month(order_date) as [month],
author,
sum(sales_subtotal) as sales_per_author,
sum(sale_quantity) as sales_quantity_per_author
--sum(expenditure_sub_total) as total_expense_per_author
FROM [dbo].[vw_book_sale_summary]
group by  month(order_date), author
order by month(order_date)
END
GO
/****** Object:  StoredProcedure [dbo].[CategorySalesReports]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Name>
-- Create date: <Create Date,,>
-- Description: retrieve information from the view
-- =============================================
CREATE PROCEDURE [dbo].[CategorySalesReports]
-- Add the parameters for the stored procedure here

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

SELECT month(order_date) as [month]
,category
,sum(sales_subtotal) as sales_per_genre
,sum(sale_quantity) as sales_quantity_per_genre
--,sum(expenditure_sub_total) as expense_per_genre
FROM [dbo].[vw_book_sale_summary]
group by  month(order_date), category
order by month(order_date)

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 delete a book
-- =============================================
CREATE PROCEDURE [dbo].[DeleteBook] 
	-- Add the parameters for the stored procedure here
	@book_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM [dbo].[book]
    WHERE book_id = @book_id

END
GO
/****** Object:  StoredProcedure [dbo].[GetDefaultAddress]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 get address, used during order
-- =============================================
CREATE PROCEDURE [dbo].[GetDefaultAddress] 
	-- Add the parameters for the stored procedure here
	@customerId int
    ,@address_id int output

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @address_id = (
		SELECT [address_id]
		FROM [dbo].[user]
		WHERE user_id = @customerId)
 
END
GO
/****** Object:  StoredProcedure [dbo].[InsertItemToCart]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 "add cart" click, will invoke this procedure
--				Handle "visitor" situation
-- =============================================
CREATE PROCEDURE [dbo].[InsertItemToCart] 
	-- Add the parameters for the stored procedure here
    @customer_id int
	,@book_id int
	--,@quantity int = 1
    
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @customerId as INT
	IF @customer_id = 0 SET @customerId = 1000
	ELSE SET @customerId = @customer_id

	DECLARE @quantity INT 
	IF (SELECT quantity FROM [dbo].[shoppingcart] WHERE book_id = @book_id and customer_id = @customerId) IS NULL
	BEGIN
		SET @quantity = 1
		INSERT INTO [dbo].[shoppingcart]
			   ([customer_id]
			   ,[book_id]
			   ,[quantity]
			   )
		 VALUES
			   (@customerId
			   ,@book_id
			   ,@quantity
				)
	END
	ELSE
		SET @quantity = (SELECT quantity FROM [dbo].[shoppingcart] WHERE book_id = @book_id and customer_id = @customerId) + 1 
		UPDATE [dbo].[shoppingcart]
		SET quantity = @quantity
		WHERE book_id = @book_id and customer_id = @customerId
END
GO
/****** Object:  StoredProcedure [dbo].[InsertNewBook]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	owner can add new book(s), UI give the selections for existing publishers only
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewBook] 
	-- Add the parameters for the stored procedure here
	@title varchar(100)
    ,@publisher_name varchar(20)
    ,@price decimal(10,2)
    ,@pages int
    ,@year int
    ,@category varchar(50)
    ,@author varchar(20)
    ,@ISBN varchar(20)
    ,@stock int
	,@percent int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @publisher_id INT
	SET @publisher_id = (SELECT publisher_id FROM [dbo].publisher WHERE publisher_name = @publisher_name) 

	INSERT INTO [dbo].[book]
           ([title]
           ,[publisher_id]
           ,[price]
           ,[pages]
           ,[year]
           ,[category]
           ,[author]
           ,[ISBN]
           ,[stock]
		   ,[percentage_to_publisher])
     VALUES
           (@title
           ,@publisher_id
           ,@price
           ,@pages
           ,@year
           ,@category
           ,@author
           ,@ISBN
           ,@stock
		   ,@percent
		   )  
END
GO
/****** Object:  StoredProcedure [dbo].[InsertNewOrder]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 "check out" will invoke this procedure, 
--				1. insert new order 
--				2. copy info from shoppingcart to book_order 
--				3. remove info from shoppingcart 
--				4. update book stock for each book
--				5. insert into payment with amount paid to the publiser
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewOrder] 
	-- Add the parameters for the stored procedure here   
	@order_status varchar(20) = "order received"
    ,@total_items int
    ,@total_price decimal(10,2)
    ,@customer_id int
	,@shipping_address_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @order_date DATE
	SET @order_date = CONVERT(date, getdate())

	-- create new record for the order list
	INSERT INTO [dbo].[order]
           (
           [order_status]
           ,[total_items]
           ,[total_price]
           ,[customer_id]
		   ,[order_date]
		   ,[shipping_address_id]
		   )
     VALUES
           (
           @order_status
           ,@total_items
           ,@total_price
           ,@customer_id
		   ,@order_date
		   ,@shipping_address_id
		   )  

	DECLARE @order_id INT
	SET @order_id = (SELECT SCOPE_IDENTITY())

	-- create new records connect to books, it is like copy the shopping cart over
	INSERT INTO [dbo].[book_order] ([order_id],[book_id],[number_of_thebook])
	SELECT @order_id, book_id, quantity
	FROM [dbo].[shoppingcart]
	WHERE [customer_id] = @customer_id

	-- empty the shopping cart for this customer
	DELETE FROM [dbo].[shoppingcart]
	WHERE customer_id = @customer_id

	DECLARE @bookSold INT
	DECLARE @bookID INT
	DECLARE @bookPrice decimal(10,2)
	DECLARE @payEachBook decimal(10,2)
	DECLARE @percentage int
	DECLARE @payAmnt decimal(10,2)
	DECLARE @payee_name varchar(20)

	SELECT * INTO #tempBooks FROM [dbo].[book_order] WHERE order_id = @order_id
	WHILE (SELECT COUNT(*) FROM #tempBooks) > 0
	BEGIN
		-- update the book stock for each book
		SET @bookID = (SELECT TOP(1) book_id FROM #tempBooks) 
		SET @bookSold = (SELECT TOP(1) number_of_thebook FROM #tempBooks)
		-- call procedure to update the book stock
		EXEC [dbo].[UpdateBookStockAfterSales] @bookID, @bookSold, @order_date

		-- retrieve the payee and payment for each book
		SET @percentage = (SELECT percentage_to_publisher FROM [dbo].[book] WHERE book_id = @bookID)
		SET @bookPrice = (SELECT price FROM [dbo].[book] WHERE book_id = @bookID)
		SET @payEachBook = @bookPrice*@percentage/100

		SET @payee_name = (
		SELECT b.publisher_name FROM [dbo].[book] a
		INNER JOIN [dbo].[publisher] b ON a.publisher_id = b.publisher_id
		WHERE book_id = @bookID)

		-- if the payee for this order does not exits, create new record
		-- otherwise, update the pay amount for the same payee within the same order
		IF (SELECT distinct payee_name FROM [dbo].[payment] WHERE order_id = @order_id AND payee_name = @payee_name) IS NULL
		BEGIN
			INSERT INTO [dbo].[payment]
           ([order_id]
           ,[payee_name]
           ,[pay_amount])
			VALUES
           (@order_id
           ,@payee_name
           ,@payEachBook)
		END
		ELSE
		BEGIN
			UPDATE [dbo].[payment]
			SET pay_amount = pay_amount + @payEachBook
			WHERE order_id = @order_id AND payee_name = @payee_name
		END

		DELETE FROM #tempBooks WHERE book_id = @bookID
	END

END
GO
/****** Object:  StoredProcedure [dbo].[RegisterNewAddress]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 register new address, used during order
-- =============================================
CREATE PROCEDURE [dbo].[RegisterNewAddress] 
	-- Add the parameters for the stored procedure here
	@str varchar(20)
	,@city varchar(20)
	,@prov varchar(20) 
	,@pcode varchar(20)
	,@country varchar(20)
    ,@address_id int output

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[address]
           ([street]
           ,[city]
           ,[province]
           ,[postcode]
           ,[country])
     VALUES
           (@str
           ,@city
           ,@prov
           ,@pcode
           ,@country)

	-- newly added id
	SET @address_id = (SELECT SCOPE_IDENTITY());
 
END
GO
/****** Object:  StoredProcedure [dbo].[RegisterNewUser]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 register new user, login name and password are mandory, other fields can be updated afterwards
-- =============================================
CREATE PROCEDURE [dbo].[RegisterNewUser] 
	-- Add the parameters for the stored procedure here
	 @login_name varchar(20)
    ,@login_pwd varchar(20)
	,@name varchar(20)
    ,@phone varchar(20) = null
    ,@email varchar(20) = null
	,@str varchar(20)
	,@city varchar(20)
	,@prov varchar(20) 
	,@pcode varchar(20)
	,@country varchar(20)
	,@user_id int output
    --,@address_id int = null
    --,@bill_address_id int = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @phoneNumber int
	SET @phoneNumber = CONVERT(int, @phone);

	INSERT INTO [dbo].[address]
           ([street]
           ,[city]
           ,[province]
           ,[postcode]
           ,[country])
     VALUES
           (@str
           ,@city
           ,@prov
           ,@pcode
           ,@country)

	DECLARE @address_id int
	-- newly added id
	SET @address_id = (SELECT SCOPE_IDENTITY());

	DECLARE @bill_address_id int
	SET @bill_address_id = @address_id;

	INSERT INTO [dbo].[user]
           ([username]
           ,[phone]
           ,[email]
           ,[address_id]
           ,[bill_address_id]
           ,[login_name]
           ,[login_pwd]
           ,[role])
     -- assume billing address same as address, default role to user
	 VALUES
           (@name
           ,@phone
           ,@email
           ,@address_id
           ,@bill_address_id
           ,@login_name
           ,@login_pwd
           ,'user')

	SET @user_id = (SELECT SCOPE_IDENTITY());
 
END
GO
/****** Object:  StoredProcedure [dbo].[RemoveItemFromCart]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 in "shopping cart" view, "remove item" click, will invoke this procedure
--				handle "visitor" situation
-- =============================================
CREATE PROCEDURE [dbo].[RemoveItemFromCart] 
	-- Add the parameters for the stored procedure here
    @customer_id int
	,@book_id int
    
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @customerId as INT
	IF @customer_id = 0 SET @customerId = 1000
	ELSE SET @customerId = @customer_id

	IF (SELECT quantity FROM [dbo].[shoppingcart] WHERE book_id = @book_id and customer_id = @customerId) > 1
	BEGIN	
		UPDATE [dbo].[shoppingcart]
		SET quantity = quantity - 1
		WHERE customer_id = @customerId and book_id = @book_id
	END
	ELSE
	BEGIN
		DELETE FROM [dbo].[shoppingcart]
		WHERE customer_id = @customerId and book_id = @book_id
	END
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAllBooks]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	to include publisher_name instead of id
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveAllBooks] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [book_id]
      ,[title]
      ,[publisher_name]
      ,[price]
      ,[pages]
      ,[year]
      ,[category]
      ,[author]
      ,[ISBN]
      ,[stock]
	  ,[percentage_to_publisher]
	FROM [dbo].[book] a
	INNER JOIN [dbo].[publisher] b ON a.publisher_id = b.publisher_id
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAllOrders]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	list of orders, used by owner and customer
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveAllOrders] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [order_id]
		  ,[order_status]
		  ,[total_items]
		  ,[total_price]
		  ,[customer_id]
		  ,[order_date]
	FROM [dbo].[order]
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveBookDetail]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	In UI, click each book title link, will invoke this procedure
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveBookDetail] 
	-- Add the parameters for the stored procedure here
	@book_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [book_id]
		  ,[title]
		  ,b.[publisher_name]
		  ,[price]
		  ,[pages]
		  ,[year]
		  ,[category]
		  ,[author]
		  ,[ISBN]
		  ,[stock]
	FROM [dbo].[book] a
	INNER JOIN [dbo].[publisher] b ON a.publisher_id = b.publisher_id
	WHERE book_id = @book_id
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveBooksByCombinedSearch]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	User can choose any combination of fields to do a search
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveBooksByCombinedSearch] 
	-- Add the parameters for the stored procedure here
	@category varchar(50) = ''
	,@title varchar(100) = ''
	,@isbn varchar(20) = ''
	,@year int = ''
	--,@price decimal(10,2) = null
	,@author varchar(20) = ''
	,@publisher varchar(20) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--declare @year as int
	--SET @year = CONVERT(INT, @year_c)
	
	DECLARE @publisher_id INT
	IF (@publisher IS NOT NULL)
		set @publisher_id = (SELECT publisher_id FROM [dbo].[publisher] WHERE publisher_name = @publisher)

	SELECT [book_id]
      ,[title]
      ,[publisher_name]
      ,[price]
      ,[pages]
      ,[year]
      ,[category]
      ,[author]
      ,[ISBN]
      ,[stock]
	  ,[percentage_to_publisher]
	FROM [dbo].[book] a INNER JOIN [dbo].[publisher] b ON a.publisher_id = b.publisher_id
	WHERE (@category = '' OR category = @category)
	AND (@title = '' OR title like '%' + @title + '%')
	AND (@isbn = '' OR isbn like '%' + @isbn + '%')
	AND (@year = '' OR [year] = @year)
	--AND (@price is null OR price = @price)
	AND (@author = '' OR author = @author)
	AND (@publisher = '' OR a.publisher_id = @publisher_id)
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveOrderByCustomer]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	list of orders by a specific customer
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveOrderByCustomer] 
	-- Add the parameters for the stored procedure here
	@customer_id int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [order_id]
		  ,[order_status]
		  ,[total_items]
		  ,[total_price]
		  ,[customer_id]
		  ,[order_date]
	FROM [dbo].[order]
	WHERE [customer_id] = @customer_id
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveOrderDetail]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	purpose is to display in the UI, customer click each item in order list will show the book detail
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveOrderDetail] 
	-- Add the parameters for the stored procedure here
	@order_id int
	,@customer_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- order_status: not checkecout (shopping cart); in warehouse; delivered
	SELECT a.[order_id]
		  --,[order_status]
		  --,[total_items]
		  --,[total_price]
		  ,[customer_id]
		  ,c.book_id
		  ,c.title
		  ,c.price
		  ,b.number_of_thebook as quantity
	FROM [dbo].[order] a
	INNER JOIN [dbo].[book_order] b ON a.order_id = b.order_id
	INNER JOIN [dbo].[book] c ON b.book_id = c.book_id
	WHERE a.order_id = @order_id
	AND customer_id = @customer_id
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveOrdersByCustomer]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	list of orders not delivered yet, this is for customer order view
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveOrdersByCustomer] 
	-- Add the parameters for the stored procedure here
	@customer_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [order_id]
		  ,[order_status]
		  ,[total_items]
		  ,[total_price]
		  ,[customer_id]
		  ,[order_date]
	FROM [dbo].[order]
	WHERE customer_id = @customer_id
	--AND order_status != 'order received'
  
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReports]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	retrieve information from the view
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveReports] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	year(order_date) as [year], 
			month(order_date) as [month], 
			sum(sales_subtotal) as total_sale, 
			sum(sale_quantity) as total_sales_quantity, 
			sum(expenditure_sub_total) as total_expense
	FROM [dbo].[vw_book_sale_summary]
	--where book_id = 4 --month(order_date) = 10 
	group by year(order_date), month(order_date)
	order by year(order_date), month(order_date) 
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveRestock]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Name>
-- Create date: <Create Date,,>
-- Description: restock history
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveRestock]
-- Add the parameters for the stored procedure here

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
SELECT [re_stock_id]
    ,a.[book_id]
	,b.title
    ,c.publisher_name
    ,[restock_quantity]
    ,[restock_date]
FROM [dbo].[re_stock] a
INNER JOIN [dbo].[book] b ON a.book_id = b.book_id
INNER JOIN [dbo].[publisher] c ON b.publisher_id = c.publisher_id
 
END
GO
/****** Object:  StoredProcedure [dbo].[RetrieveShoppingCart]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	display book_id, book_title, quantity, total price in shopping cart 
--				in the UI, click each item will show the book detail
--				Handle "visitor" situation
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveShoppingCart] 
	-- Add the parameters for the stored procedure here
	@customer_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @customerId as INT
	IF @customer_id = 0 SET @customerId = 1000
	ELSE SET @customerId = @customer_id

	SELECT [cart_id]
      ,[customer_id]
      ,a.[book_id]
	  ,b.title
	  ,b.price
      ,[quantity]
	FROM [dbo].[shoppingcart] a
	INNER JOIN [dbo].[book] b ON a.book_id = b.book_id
	WHERE customer_id = @customerId
  
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBookStockAfterSales]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	
--				1. To update the stock of the book, this will be called within "InsertNewOrder" procedure 
--				2. IF the stock of the book is lower than the threshold (10), find the number of the book 
--					sold last month, insert into re_stock table for the UI display
-- =============================================
CREATE PROCEDURE [dbo].[UpdateBookStockAfterSales] 
	-- Add the parameters for the stored procedure here
	@book_id int
    ,@bookSold int
	,@order_date date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	UPDATE [dbo].[book]
	   SET [stock] = [stock] - @bookSold
	WHERE book_id = @book_id

	DECLARE @stock INT
	DECLARE @reStockQuantity INT
	DECLARE @month INT

	SET @stock = (SELECT stock FROM [dbo].[book] WHERE book_id = @book_id)
	-- set threshold for restocking
	IF @stock < 10
	BEGIN
		SET @month = month(@order_date)
		SET @reStockQuantity = (SELECT sale_quantity FROM [dbo].[vw_book_sale_summary]
								WHERE month(order_date) = @month - 1
								AND book_id = @book_id)
		 
		IF @reStockQuantity is NULL
		SET @reStockQuantity = 0
		
		INSERT INTO [dbo].[re_stock]
				   ([book_id]
				   ,[restock_quantity]
				   ,[restock_date])
		VALUES
				   (@book_id
				   ,@reStockQuantity
				   ,@order_date)

		UPDATE [dbo].[book] 
		SET stock = stock + @reStockQuantity
		WHERE book_id = @book_id

	END
 
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	For check out order, update status (in warehouse/delivered) 
-- =============================================
CREATE PROCEDURE [dbo].[UpdateOrder] 
	-- Add the parameters for the stored procedure here
	@order_id int
    ,@order_status varchar(20)
    --,@total_items int
    --,@total_price int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	UPDATE [dbo].[order]
	   SET 
		   [order_status] = @order_status
		  --,[total_items] = @total_items
		  --,[total_price] = @total_price
	WHERE order_id = @order_id
 
END
GO
/****** Object:  StoredProcedure [dbo].[VerifyUser]    Script Date: 2021-12-18 5:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	 Verify the user with the login_name and login_pwd
--				return 
--				Handle "visitor"
-- =============================================
CREATE PROCEDURE [dbo].[VerifyUser] 
	-- Add the parameters for the stored procedure here
    @login_name varchar(20)
    ,@login_pwd varchar(20)
	,@user_id int OUTPUT
    ,@role varchar(20) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- handle "visitor" situation here
	-- if there are records in "shoppingcart" for customer 1000 (visitor),
	--	that means, the current customer was the "visitor"
	--	need to copy all "shoppingcart" records from customer 1000 to current customer, 
	--	then clear "customer 1000" records
	-- else
	--	the current customer was "login" user.

	DECLARE @customer_id INT
	SET @customer_id =  (SELECT [user_id] FROM [dbo].[user]
							WHERE login_name = @login_name
							AND login_pwd = @login_pwd)
	IF @customer_id IS NOT NULL
	BEGIN
		IF (SELECT DISTINCT customer_id FROM [dbo].[shoppingcart] WHERE customer_id = 1000) IS NOT NULL
		BEGIN
			INSERT INTO [dbo].[shoppingcart] 
			SELECT @customer_id, [book_id], [quantity] FROM [dbo].[shoppingcart] WHERE customer_id = 1000
		
			DELETE FROM [dbo].[shoppingcart] WHERE customer_id = 1000
		END
	END

	--DECLARE @role AS VARCHAR(20)
	SELECT @user_id= [user_id], @role = [role] FROM [dbo].[user]
	WHERE login_name = @login_name
	AND login_pwd = @login_pwd

 

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "book"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 353
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "book_order"
            Begin Extent = 
               Top = 9
               Left = 410
               Bottom = 206
               Right = 674
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "order"
            Begin Extent = 
               Top = 9
               Left = 731
               Bottom = 206
               Right = 953
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_book_sale_summary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_book_sale_summary'
GO
USE [master]
GO
ALTER DATABASE [Bookstore] SET  READ_WRITE 
GO
