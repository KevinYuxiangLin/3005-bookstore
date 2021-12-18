# COMP3005 Bookstore

Kevin Lin, Matthew Siu, Isaac Leung


# Instructions to Set Up
Recommended to install Microsoft SSMS (SQL Server Management Studio) and Microsoft Visual Studio 2022. 
In the SQL directory in the git repo, execute the everythingScript.sql file in SSMS to generate all tables, views, and stored procedures. They are also viewable as separate files, named respectively. Stored procedures have been commented appropriately to describe their functionality. 

For Microsoft Visual Studio 2022, ensure ASP.NET and webdevelopment workload is installed. Ensure project uses  ASP.NET Web Application Template (.NET Framework). Once everything is installed, open solution. 

Go to Data>BookStoreDataAccess.cs and change line 13 (connection string line) to appropriate connectionString. Should look something like this: @"Data Source=DESKTOP-NAME\SQLEXPRESS01;InitialCatalog=Bookstore;Integrated Security=True";
Project can be ran through Visual Studio. 

# Key Files
The following files contain most of :meat_on_bone:MEAT:meat_on_bone: of the project. They are well commented throughout. 

- Front end:
Views>Home>Index.cshtml
- Back end:
Scripts>book_store.js
- Controller:
Controllers>HomeController.cs
- Data Access:
Data>BookStoreDataAccess.cs
