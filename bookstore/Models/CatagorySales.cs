using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class CatagorySales
    {

        public string month { get; set; }
        public string category { get; set; }
        public decimal total_sale { get; set; }
        public int total_sales_quantity { get; set; }

        public CatagorySales()
        {

        }
        public CatagorySales(string month, string category, decimal sales, int quant)
        {
            this.month = month;
            this.category = category;
            this.total_sale = sales;
            this.total_sales_quantity = quant;
        }

    }
}