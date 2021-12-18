using bookstore.Models;
using bookstore.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//using Newtonsoft.Json;

namespace bookstore.Controllers
{
    public class HomeController : Controller
    {
        public static List<Book> bookList = new List<Book>();
        public static List<Order> orderList = new List<Order>();
        public static List<CatagorySales> categorySalesList = new List<CatagorySales>();
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult RetrieveBooks()
        {
            //List<Book> bookList = new List<Book>();
            BookStoreDataAccess da = new BookStoreDataAccess();
            bookList = da.GetBookList();
            bookList = bookList.OrderBy(x => x.book_id).ToList();
            return Json(bookList);
        }
        [HttpPost]
        public JsonResult RetrieveBookDetail(int book_id)
        {
            var book = bookList.FirstOrDefault(x => x.book_id == book_id);

            return Json(book);
        }
        [HttpPost]
        public JsonResult AddBook (string category, string title, string publisher_name, string author, int year, decimal price, int stock, int percent, string isbn, int pages)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var rt = da.AddBook(category, title, publisher_name, author, year, price, stock, percent, isbn, pages);
            return Json(rt);
        }
        [HttpPost]
        public JsonResult DeleteBook(int book_id)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var rt = da.DeleteBook(book_id);
            return Json(rt);
        }
        [HttpPost]
        public JsonResult RetrieveBooksByCombinedSearch(string category, string title, string publisher_name, string author, string year, string isbn)
        {
            //List<Book> bookList = new List<Book>();
            BookStoreDataAccess da = new BookStoreDataAccess();
            bookList = da.GetBookListByCombinedSearch(category, title, publisher_name, author, year, isbn);
            bookList = bookList.OrderBy(x => x.book_id).ToList();
            return Json(bookList);
        }
        [HttpPost]
        public JsonResult InsertItemToShoppingCart(int customer_id, int book_id)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var rt = da.AddItem(customer_id, book_id);
            return Json(rt);
        }
        [HttpPost]
        public JsonResult ViewShoppingCart(int customer_id)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            List<ShoppingItem> shoppingItems = da.ViewShoppingCart(customer_id);
            return Json(shoppingItems);
        }
        [HttpPost]
        public JsonResult RemoveItemFromShoppingCart(int customer_id, int book_id)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var rt = da.RemoveItem(customer_id, book_id);
            return Json(rt);
        }
        [HttpPost]
        public JsonResult AddNewOrder(int customer_id, int quantity, decimal price, int shippingAddr)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var rt = da.AddOrder(customer_id, quantity, price, shippingAddr);
            return Json(rt);
        }
        [HttpPost]
        public JsonResult RetrieveOrders()
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            orderList = da.GetOrderList();
            orderList = orderList.OrderBy(x => x.order_id).ToList();
            return Json(orderList);
        }
        [HttpPost]
        public JsonResult RetrieveOrderById(int order_id)
        {
            Order orderById = new Order();
            orderById = orderList.FirstOrDefault(item => item.order_id == order_id);

            return Json(orderById);
        }
        [HttpPost]
        public JsonResult RetrieveOrderByCustomer(int customer_id)
        {
            List<Order> orderByCustomerList = new List<Order>();
            BookStoreDataAccess da = new BookStoreDataAccess();
            //orderByCustomerList = orderList.Where(item => item.customer_id == customer_id).ToList();
            orderByCustomerList = da.RetrieveOrderByCustomer(customer_id);

            return Json(orderByCustomerList);
        }
        [HttpPost]
        public JsonResult RetrieveOrderDetail(int order_id, int customer_id)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            List<OrderDetail> orderDetailList = new List<OrderDetail>();
            orderDetailList = da.RetrieveOrderDetail(order_id, customer_id);
            return Json(orderDetailList);
        }
        [HttpPost]
        public JsonResult UpdateOrder(int order_id, string status)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var rt = da.UpdateOrder(order_id, status);
            return Json(rt);
        }
        [HttpPost]
        public JsonResult RetrieveRestockHistory()
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            List<Restock> restockHistoryList = new List<Restock>();
            restockHistoryList = da.RetrieveRestockHistory();
            return Json(restockHistoryList);
        }
        [HttpPost]
        public JsonResult RetrieveReports()
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            List<Summary> reportList = new List<Summary>();
            reportList = da.RetrieveReports();
            return Json(reportList);
        }
        [HttpPost]
        public JsonResult RetrieveCategorySales()
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            categorySalesList = da.RetrieveCategorySales();
            return Json(categorySalesList);
        }
        [HttpPost]
        public JsonResult ReportMonth(string month, string category)
        {
            List<CatagorySales> salesByMonthList = new List<CatagorySales>();
            if ((category == "") && (month == ""))
            {
                salesByMonthList = categorySalesList.ToList();                
            }
            else if(category == null || category == "")
            {
                salesByMonthList = categorySalesList.Where(item => item.month == month).ToList();
            }
            else if (month == null || month == "")
            {

                salesByMonthList = categorySalesList.Where(item => item.category == category).ToList();
            }
            else
            {
                salesByMonthList = categorySalesList.Where(item => item.category == category && item.month == month).ToList();
            }
            //salesByMonthList = categorySalesList.Where(item => item.month == month).ToList();

            return Json(salesByMonthList);
        }
        [HttpPost]
        public JsonResult ReportCategory(string category)
        {
            List<CatagorySales> salesByCategoryList = new List<CatagorySales>();
            salesByCategoryList = categorySalesList.Where(item => item.category == category).ToList();

            return Json(salesByCategoryList);
        }
        [HttpPost]
        public JsonResult Login(string login_name, string login_pwd)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var user = da.Login(login_name, login_pwd);
            return Json(user);
        }

        [HttpPost]
        public JsonResult Signup(string login_name, string login_pwd, string email, string phone, string fullname, string street, string city, string prov, string postcode, string country)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var user = da.AddUser(login_name, login_pwd, email, phone, fullname, street, city, prov, postcode, country);
            return Json(user);
        }

        [HttpPost]
        public JsonResult InsertNewAddress(string street, string city, string prov, string postcode, string country)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var user = da.AddAddress(street, city, prov, postcode, country);
            return Json(user);
        }

        [HttpPost]
        public JsonResult GetDefaultAddress(int customer_id)
        {
            BookStoreDataAccess da = new BookStoreDataAccess();
            var user = da.GetAddress(customer_id);
            return Json(user);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}