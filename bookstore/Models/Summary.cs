using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class Summary
    {
        public string month { get; set; }
        public decimal total_sale { get; set; }
        public int total_sales_quantity { get; set; }
        public decimal total_expense { get; set; }

        public Summary()
        {

        }
        public Summary(string month, decimal sales, int quant, decimal expense)
        {
            this.month = month;
            this.total_sale = sales;
            this.total_sales_quantity = quant;
            this.total_expense = expense;
        }

    }
}