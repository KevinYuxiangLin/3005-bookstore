using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace bookstore.Models
{
    public class User
    {
        public int user_id { get; set; }
        public string user_name { get; set; }
        public string role { get; set; }
 
        public User()
        {

        }
        public User(int user_id, string user_name, string role)
        {
            this.user_id = user_id;
            this.user_name = user_name;
            this.role = role;
        }
    }
}