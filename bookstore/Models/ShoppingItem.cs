using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class ShoppingItem
    {
        //list of items store in shopping cart
        public int book_id { get; set; }
        public string title { get; set; }
        public decimal price { get; set; }
        public int quantity { get; set; }
        public int customer_id { get; set; }

        public ShoppingItem()
        {

        }
        public ShoppingItem(int book_id, string title, int customerId, decimal price, int quantity)
        {
            this.book_id = book_id;
            this.title = title;
            this.customer_id = customerId;
            this.price = price;
            this.quantity = quantity;
        }

    }
}