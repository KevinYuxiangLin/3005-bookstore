using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class OrderDetail
    {
        public int order_id { get; set; }
        public int book_id { get; set; }
        public string book_name { get; set; }
        public decimal price { get; set; }
        public int quantity { get; set; }
        public int customer_id { get; set; }

        public OrderDetail()
        {

        }
        public OrderDetail(int id, string name, int customerId, decimal price, int quantity, int bookId)
        {
            this.order_id = id;
            this.book_name = name;
            this.customer_id = customerId;
            this.price = price;
            this.quantity = quantity;
            this.book_id = bookId;
        }

    }
}
