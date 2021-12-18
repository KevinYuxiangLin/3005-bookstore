using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class Restock
    {
        public string book_name { get; set; }
        public string publisher_name { get; set; }
        public int restock_quantity { get; set; }
        public string restock_date { get; set; }

        public Restock()
        {

        }
        public Restock(string bName, string pName, int quant, string date)
        {
            this.book_name = bName;
            this.publisher_name = pName;
            this.restock_quantity = quant;
            this.restock_date = date;
        }
    }
}