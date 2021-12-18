using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class Book
    {
        public int book_id { get; set; }
        public string title { get; set; }
        public string publisher_name { get; set; }
        public string category { get; set; }
        public string author { get; set; }
        public int year { get; set; }
        public int pages { get; set; }
        public decimal price { get; set; }
        public string isbn { get; set; }
        public int stock { get; set; }
        public int percent { get; set; }

        public Book()
        {

        }
        public Book(int book_id, string title, string publisher_name, string category, string author, int year, int pages, decimal price, string isbn, int stock, int percent )
        {
            this.book_id = book_id;
            this.title = title;
            this.publisher_name = publisher_name;
            this.category = category;
            this.author = author;
            this.year = year;
            this.pages = pages;
            this.price = price;
            this.isbn = isbn;
            this.stock = stock;
            this.percent = percent;
        }

    }
}