USE [Bookstore]
GO
/****** Object:  StoredProcedure [dbo].[AuthorSalesReports]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CategorySalesReports]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetDefaultAddress]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertItemToCart]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertNewBook]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertNewOrder]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RegisterNewAddress]    Script Date: 2021-12-18 6:03:11 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RegisterNewUser]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveItemFromCart]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveAllBooks]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveAllOrders]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveBookDetail]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveBooksByCombinedSearch]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveOrderByCustomer]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveOrderDetail]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveOrdersByCustomer]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveReports]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveRestock]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RetrieveShoppingCart]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateBookStockAfterSales]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 2021-12-18 6:03:12 PM ******/
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
/****** Object:  StoredProcedure [dbo].[VerifyUser]    Script Date: 2021-12-18 6:03:12 PM ******/
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
