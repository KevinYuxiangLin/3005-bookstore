using bookstore.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace bookstore.Data
{
    public class BookStoreDataAccess
    {
        private string connectionString = @"Data Source=DESKTOP-M7EHOHI\SQLEXPRESS01;Initial Catalog=Bookstore;Integrated Security=True";
       
        //get all books
        public List<Book> GetBookList()
        {
            List<Book> BookList = new List<Book>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveAllBooks]";

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                BookList.Add(new Book()
                                {
                                    book_id = int.Parse(reader["book_id"].ToString()),
                                    title = reader["title"].ToString(),
                                    publisher_name = reader["publisher_name"].ToString(),
                                    price = decimal.Parse(reader["price"].ToString()),
                                    pages = int.Parse(reader["pages"].ToString()),
                                    year = int.Parse(reader["year"].ToString()),
                                    category = reader["category"].ToString(),
                                    author = reader["author"].ToString(),
                                    isbn = reader["isbn"].ToString(),
                                    stock = int.Parse(reader["stock"].ToString()),
                                    percent = int.Parse(reader["percentage_to_publisher"].ToString())
                                });
                            }
                        }

                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            return BookList;
        }
        // retrive books by combinded search
        public List<Book> GetBookListByCombinedSearch(string category, string title, string publisher_name, string author, string year, string isbn)
        {
            List<Book> BookList = new List<Book>();
            int publish_year = 0;
            if (year != "") publish_year = int.Parse(year);
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveBooksByCombinedSearch]";
                        command.Parameters.Add("@year", SqlDbType.Int).Value = publish_year;
                        command.Parameters.Add("@category", SqlDbType.NVarChar).Value = category;
                        command.Parameters.Add("@title", SqlDbType.NVarChar).Value = title;
                        command.Parameters.Add("@isbn", SqlDbType.NVarChar).Value = isbn;
                        command.Parameters.Add("@author", SqlDbType.NVarChar).Value = author;
                        command.Parameters.Add("@publisher", SqlDbType.NVarChar).Value = publisher_name;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                BookList.Add(new Book()
                                {
                                    book_id = int.Parse(reader["book_id"].ToString()),
                                    title = reader["title"].ToString(),
                                    publisher_name = reader["publisher_name"].ToString(),
                                    price = decimal.Parse(reader["price"].ToString()),
                                    pages = int.Parse(reader["pages"].ToString()),
                                    year = int.Parse(reader["year"].ToString()),
                                    category = reader["category"].ToString(),
                                    author = reader["author"].ToString(),
                                    isbn = reader["isbn"].ToString(),
                                    stock = int.Parse(reader["stock"].ToString()),
                                    percent = int.Parse(reader["percentage_to_publisher"].ToString())
                                });
                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            return BookList;
        }
        // add a new book to bookstore by owner 
        public string AddBook(string category, string title, string publisher_name, string author, int year, decimal price, int stock, int percent, string isbn, int pages)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string commandString = string.Empty;
                connection.Open();
                commandString = "InsertNewBook";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@price", SqlDbType.Decimal).Value = price;
                        command.Parameters.Add("@percent", SqlDbType.Int).Value = percent;
                        command.Parameters.Add("@year", SqlDbType.Int).Value = year;
                        command.Parameters.Add("@stock", SqlDbType.Int).Value = stock;
                        command.Parameters.Add("@category", SqlDbType.NVarChar).Value = category;
                        command.Parameters.Add("@title", SqlDbType.NVarChar).Value = title;
                        command.Parameters.Add("@author", SqlDbType.NVarChar).Value = author;
                        command.Parameters.Add("@publisher_name", SqlDbType.NVarChar).Value = publisher_name;
                        command.Parameters.Add("@isbn", SqlDbType.NVarChar).Value = isbn;
                        command.Parameters.Add("@pages", SqlDbType.Int).Value = pages;

                        command.ExecuteNonQuery();
                        connection.Close();
                   
                    }
                }
                catch (Exception ex)
                {
                    return "Error to add the Book: " + ex.Message;
                }
                return string.Empty;
            }
        }
        // remove a book from bookstore by owner
        public string DeleteBook(int id)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string commandString = string.Empty;

                commandString = "DeleteBook";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@book_id", SqlDbType.Int).Value = id;
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    return "Error to delete the Book: " + ex.Message;
                }
                return string.Empty;
            }

        }
        // retrieve book detail - done
        public Book GetBookById(int bookId)
        {
            Book result = new Book();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveBookDetail]";
                        command.Parameters.Add("@book_id", SqlDbType.Int).Value = bookId;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.book_id = int.Parse(reader["Book_Id"].ToString());
                                result.title = reader["title"].ToString();
                                result.publisher_name = reader["publisher_name"].ToString();
                                result.price = decimal.Parse(reader["price"].ToString());
                                result.pages = int.Parse(reader["pages"].ToString());
                                result.year = int.Parse(reader["year"].ToString());
                                result.category = reader["category"].ToString();
                                result.author = reader["author"].ToString();
                                result.isbn = reader["isbn"].ToString();

                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            finally
            {

            }
            return result;
        }

        // retrieve shopping cart detail
        public List<ShoppingItem> ViewShoppingCart(int customerId)
        {
            List<ShoppingItem> itemList = new List<ShoppingItem>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveShoppingCart]";
                        command.Parameters.Add("@customer_id", SqlDbType.Int).Value = customerId;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemList.Add(new ShoppingItem()
                                {
                                    customer_id = int.Parse(reader["customer_id"].ToString()),
                                    book_id = int.Parse(reader["book_id"].ToString()),
                                    title = reader["title"].ToString(),
                                    price = decimal.Parse(reader["price"].ToString()),
                                    quantity = int.Parse(reader["quantity"].ToString())
                                });
                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            finally
            {

            }
            return itemList;
        }

        // remove item from shopping cart
        public string RemoveItem(int customerId, int bookId)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string commandString = string.Empty;

                commandString = "RemoveItemFromCart";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@book_id", SqlDbType.Int).Value = bookId;
                        command.Parameters.Add("@customer_id", SqlDbType.Int).Value = customerId;
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    return "Error to delete item: " + ex.Message;
                }
                return string.Empty;
            }

        }

        // add item to shopping cart
        public string AddItem(int customerId, int bookId)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string commandString = string.Empty;

                commandString = "InsertItemToCart";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@book_id", SqlDbType.Int).Value = bookId;
                        command.Parameters.Add("@customer_id", SqlDbType.Int).Value = customerId;
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    return "Error to add item: " + ex.Message;
                }
                return string.Empty;
            }

        }
        public User Login(string loginName, string loginPwd)
        {
            User login_user = new User();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string commandString = string.Empty;
                connection.Open();
                commandString = "VerifyUser";
                
                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@login_name", SqlDbType.NVarChar).Value = loginName;
                        command.Parameters.Add("@login_pwd", SqlDbType.NVarChar).Value = loginPwd;

                        command.Parameters.Add("@user_id", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@role", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;

                        command.ExecuteNonQuery();
                        connection.Close();

                        login_user.user_id = Convert.ToInt32(command.Parameters["@user_id"].Value);
                        login_user.role = Convert.ToString(command.Parameters["@role"].Value);
                        login_user.user_name = loginName;

                    }
                }
                catch (Exception ex)
                {
                    
                }
                return login_user;
            }
        }
         //return user_id, to finish
        public int AddUser(string login_name, string login_pwd, string email, string phone, string fullname, string street, string city, string prov, string postcode, string country)
        {
            int userId = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string commandString = string.Empty;
                connection.Open();
                commandString = "RegisterNewUser";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@login_name", SqlDbType.NVarChar).Value = login_name;
                        command.Parameters.Add("@login_pwd", SqlDbType.NVarChar).Value = login_pwd;
                        command.Parameters.Add("@name", SqlDbType.NVarChar).Value = fullname;
                        command.Parameters.Add("@phone", SqlDbType.NVarChar).Value = phone;
                        command.Parameters.Add("@email", SqlDbType.NVarChar).Value = email;
                        command.Parameters.Add("@str", SqlDbType.NVarChar).Value = street;
                        command.Parameters.Add("@city", SqlDbType.NVarChar).Value = city;
                        command.Parameters.Add("@prov", SqlDbType.NVarChar).Value = prov;
                        command.Parameters.Add("@pcode", SqlDbType.NVarChar).Value = postcode;
                        command.Parameters.Add("@country", SqlDbType.NVarChar).Value = country;

                        command.Parameters.Add("@user_id", SqlDbType.Int).Direction = ParameterDirection.Output;

                        command.ExecuteNonQuery();

                        connection.Close();

                        userId = Convert.ToInt32(command.Parameters["@user_id"].Value);
                    }
                }
                catch (Exception ex)
                {

                }
                return userId;
            }
        }

        public List<Order> GetOrderList()
        {
            List<Order> OrderList = new List<Order>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveAllOrders]";

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                OrderList.Add(new Order()
                                {
                                    order_id = int.Parse(reader["order_id"].ToString()),
                                    order_status = reader["order_status"].ToString(),
                                    order_date = reader["order_date"].ToString(),
                                    total_price = decimal.Parse(reader["total_price"].ToString()),
                                    total_items = int.Parse(reader["total_items"].ToString()),
                                    customer_id = int.Parse(reader["customer_id"].ToString()),
                                });
                            }
                        }

                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            return OrderList;
        }

        public List<Order> RetrieveOrderByCustomer(int customer_id)
        {
            List<Order> OrderList = new List<Order>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveOrderByCustomer]";
                        command.Parameters.Add("@customer_id", SqlDbType.Int).Value = customer_id;

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                OrderList.Add(new Order()
                                {
                                    order_id = int.Parse(reader["order_id"].ToString()),
                                    order_status = reader["order_status"].ToString(),
                                    order_date = reader["order_date"].ToString(),
                                    total_price = decimal.Parse(reader["total_price"].ToString()),
                                    total_items = int.Parse(reader["total_items"].ToString()),
                                    customer_id = int.Parse(reader["customer_id"].ToString()),
                                });
                            }
                        }

                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            return OrderList;
        }

        public List<OrderDetail> RetrieveOrderDetail(int orderId, int customerId)
        {
            List<OrderDetail> itemList = new List<OrderDetail>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveOrderDetail]";
                        command.Parameters.Add("@order_id", SqlDbType.Int).Value = orderId;
                        command.Parameters.Add("@customer_id", SqlDbType.Int).Value = customerId;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemList.Add(new OrderDetail()
                                {
                                    order_id = int.Parse(reader["order_id"].ToString()),
                                    customer_id = int.Parse(reader["customer_id"].ToString()),
                                    book_id = int.Parse(reader["book_id"].ToString()),
                                    book_name = reader["title"].ToString(),
                                    price = decimal.Parse(reader["price"].ToString()),
                                    quantity = int.Parse(reader["quantity"].ToString())
                                });
                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            finally
            {

            }
            return itemList;
        }

        public List<Restock> RetrieveRestockHistory()
        {
            List<Restock> itemList = new List<Restock>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveRestock]";

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemList.Add(new Restock()
                                {
                                    book_name = reader["title"].ToString(),
                                    publisher_name = reader["publisher_name"].ToString(),
                                    restock_quantity = int.Parse(reader["restock_quantity"].ToString()),
                                    restock_date = reader["restock_date"].ToString()
                                });
                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            finally
            {

            }
            return itemList;
        }

        public List<Summary> RetrieveReports()
        {
            List<Summary> itemList = new List<Summary>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[RetrieveReports]";

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemList.Add(new Summary()
                                {
                                    month = reader["month"].ToString(),
                                    total_sale = decimal.Parse(reader["total_sale"].ToString()),
                                    total_sales_quantity = int.Parse(reader["total_sales_quantity"].ToString()),
                                    total_expense = decimal.Parse(reader["total_expense"].ToString())
                                });
                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            finally
            {

            }
            return itemList;
        }

        public List<CatagorySales> RetrieveCategorySales()
        {
            List<CatagorySales> itemList = new List<CatagorySales>();
            try
            {
                using (System.Data.SqlClient.SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        connection.Open();
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandText = "[CategorySalesReports]";

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemList.Add(new CatagorySales()
                                {
                                    month = reader["month"].ToString(),
                                    category = reader["category"].ToString(),
                                    total_sale = decimal.Parse(reader["sales_per_genre"].ToString()),
                                    total_sales_quantity = int.Parse(reader["sales_quantity_per_genre"].ToString()),
                                });
                            }
                        }
                        connection.Close();
                    }
                }
            }
            catch (Exception e)
            {

            }
            finally
            {

            }
            return itemList;
        }

        public string AddOrder(int customerId, int quantity, decimal totalPrice, int shippingAddr)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string commandString = string.Empty;

                commandString = "InsertNewOrder";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@total_price", SqlDbType.Decimal).Value = totalPrice;
                        command.Parameters.Add("@total_items", SqlDbType.Int).Value = quantity;
                        command.Parameters.Add("@customer_id", SqlDbType.Int).Value = customerId;
                        command.Parameters.Add("@shipping_address_id", SqlDbType.Int).Value = shippingAddr;
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    return "Error to add item: " + ex.Message;
                }
                return string.Empty;
            }

        }
        public string UpdateOrder(int orderId, string status)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string commandString = string.Empty;

                commandString = "UpdateOrder";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@order_id", SqlDbType.Int).Value = orderId;
                        command.Parameters.Add("@order_status", SqlDbType.NVarChar).Value = status;
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    return "Error to update item: " + ex.Message;
                }
                return string.Empty;
            }

        }

        //return address id of new address
        public int AddAddress(string street, string city, string prov, string postcode, string country)
        {
            int addressId = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string commandString = string.Empty;
                connection.Open();
                commandString = "RegisterNewAddress";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@str", SqlDbType.NVarChar).Value = street;
                        command.Parameters.Add("@city", SqlDbType.NVarChar).Value = city;
                        command.Parameters.Add("@prov", SqlDbType.NVarChar).Value = prov;
                        command.Parameters.Add("@pcode", SqlDbType.NVarChar).Value = postcode;
                        command.Parameters.Add("@country", SqlDbType.NVarChar).Value = country;

                        command.Parameters.Add("@address_id", SqlDbType.Int).Direction = ParameterDirection.Output;

                        command.ExecuteNonQuery();

                        connection.Close();

                        addressId = Convert.ToInt32(command.Parameters["@address_id"].Value);
                    }
                }
                catch (Exception ex)
                {

                }
                return addressId;
            }
        }

        //return address id of existing address
        public int GetAddress(int customer_id)
        {
            int addressId = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string commandString = string.Empty;
                connection.Open();
                commandString = "GetDefaultAddress";

                try
                {
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@customerId", SqlDbType.Int).Value = customer_id;

                        command.Parameters.Add("@address_id", SqlDbType.Int).Direction = ParameterDirection.Output;

                        command.ExecuteNonQuery();

                        connection.Close();

                        addressId = Convert.ToInt32(command.Parameters["@address_id"].Value);
                    }
                }
                catch (Exception ex)
                {

                }
                return addressId;
            }
        }

    }
}