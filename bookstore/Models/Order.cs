using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class Order
    {
        public int order_id { get; set; }
        public string order_status { get; set; }
        public decimal total_price { get; set; }
        public int total_items { get; set; }
        public int customer_id { get; set; }
        public string order_date { get; set; }


        public Order()
        {

        }
        public Order(int id, string status, int customerId, decimal price, int quantity, string orderdate)
        {
            this.order_id = id;
            this.order_status = status;
            this.customer_id = customerId;
            this.total_price = price;
            this.total_items = quantity;
            this.order_date = orderdate;
        }

    }
}