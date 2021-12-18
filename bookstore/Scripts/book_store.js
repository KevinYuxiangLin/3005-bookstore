var selectedBookId;
var loginId = 0;
var loginRole = "user"
var selectedOrderId;
var totalPrice = 0;
var totalItems = 0;
var shippingAddrChanged = 0;

function findUnique(value, index, self) {
    return self.indexOf(value) === index;
}

function createBookList(item) {
    var li = document.createElement("li");
    li.setAttribute("class", "book-list-item");
    li.setAttribute("id", item.book_id);
    li.onclick = selectBook;
    li.textContent = item.title;
    return li;
}

function selectBook(e) {
    selectedBookId = e.target.id;
    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveBookDetail',
        data: {book_id: selectedBookId},
        dataType: "json",
        cache: false,
        success: function (result) {
            
            $('#detail-title').val(result.title);
            $('#detail-author').val(result.author);
            $('#detail-publisher').val(result.publisher_name);
            $('#detail-pages').val(result.pages);
            $('#detail-isbn').val(result.isbn);
            $('#detail-price').val(result.price);
            $('#detail-category').val(result.category);
            $('#detail-year').val(result.year);
            $('#detail-stock').val(result.stock);
            $('#detail-percent').val(result.percent);
            $('#bookdetail').show();//document.getElementById("bookdetail").style.display = "block";
            if (loginRole == "owner") {
                $('#detail-stock').show();
                $('#detail-percent').show();
                $('#btn-add-to-cart').hide();
                $('#btn-rem-from-bookstore').show();
            }
            else {
                $('#detail-stock').hide();
                $('#detail-percent').hide();
                $('#btn-add-to-cart').show();
                $('#btn-rem-from-bookstore').hide();
            }
            $('#btn-rem-from-cart').hide();
        },
        error: function (result) {
            
        }
    });
}

$('#nav-logout').on("click", function () {

    loginId = 0;
    $('#login').show();
    $('#nav-logout').hide();  
    $('#owner-menu').hide();
    $('#customer-menu').hide();
})

$('#btn-login').on("click", function () {
    var loginName = $('#input-login-user').val();
    var loginPwd = $('#input-login-pwd').val();

    $('#login').hide();
    //$('#nav-logout').show();

    jQuery.ajax({
        type: "Post",
        url: '/Home/Login',
        data: { login_name: loginName, login_pwd: loginPwd },
        dataType: "json",
        cache: false,
        success: function (result) {
            if (!result || result.user_id == 0) {
                window.alert('login failed!');
            }
            else {
                window.alert('login successful! ' + result.user_name);
                loginId = result.user_id;
                if (result.role == "owner") {
                    loginRole = "owner";
                    $('#owner-menu').show();
                    $('#customer-menu').hide();
                }
                else {
                    loginRole = "user";
                    $('#customer-menu').show();
                    $('#owner-menu').hide();
                }
            }
        },
        error: function (result) {

        }
    });
})


$('#btn-signup').on("click", function () {
    var loginName = $('#input-sign-user').val();
    var loginPwd = $('#input-sign-pwd').val();
    var loginEmail = $('#email-input').val();
    var loginPhone = $('#phone-input').val();
    var loginFullName = $('#fullname-input').val();
    var loginStr = $('#str-input').val();
    var loginCity = $('#city-input').val();
    var loginProv = $('#prov-input').val();
    var loginPostCode = $('#postcode-input').val();
    var loginCountry = $('#country-input').val();

    jQuery.ajax({
        type: "Post",
        url: '/Home/Signup',
        data: { login_name: loginName, login_pwd: loginPwd, email: loginEmail, phone: loginPhone, fullname: loginFullName, street: loginStr, city: loginCity, prov: loginProv, postcode: loginPostCode, country: loginCountry },
        dataType: "json",
        cache: false,
        success: function (result) {
            $('#signup').hide();
            if (!result) {
                window.alert('Invalid Registration!');
            }
            else {
                loginId = result;
                loginRole = "customer"
                window.alert('Successful Registration!');
            }
        },
        error: function (result) {

        }
    });
})

function SelectCartItem(id) {
    selectedBookId = id;
    $('#cart').hide();
    $('#cart-table-content').html("");
    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveBookDetail',
        data: { book_id: selectedBookId },
        dataType: "json",
        cache: false,
        success: function (result) {

            $('#detail-title').val(result.title);
            $('#detail-author').val(result.author);
            $('#detail-publisher').val(result.publisher_name);
            $('#detail-pages').val(result.pages);
            $('#detail-isbn').val(result.isbn);
            $('#detail-price').val(result.price);
            $('#detail-category').val(result.category);
            $('#detail-year').val(result.year);
            $('#bookdetail').show();//document.getElementById("bookdetail").style.display = "block";
            $('#btn-add-to-cart').hide();
            $('#btn-rem-from-cart').show();
        },
        error: function (result) {

        }
    });
}

$('#cart-close').on("click", function () {
    // clear the content of the shopping cart display
    $('#cart-table-content').html("");
})

// view shopping cart from nav-bar
$('#nav-cart').on("click", function () {
    // open cart modal
    $('#cart').show();
    $('#cart-table-content').html("");
    totalPrice = 0;
    totalItems = 0;

    jQuery.ajax({
        type: "Post",
        url: '/Home/ViewShoppingCart',
        data: { customer_id: loginId },
        dataType: "json",
        cache: false,
        success: function (result) {
            var tbody = $('#cart-table-content');

            $.each(result, function (index, value) {
                totalPrice = totalPrice + value.price * value.quantity;
                totalItems = totalItems + value.quantity;

                $tr = $('<tr id="' + value.book_id + '"></tr>');
                $tr.append('<td id="' + value.book_id + '" class="cart-item" onclick="SelectCartItem(this.id)" value="' + value.title + '">' + value.title + '</td>');
                $tr.append('<td value="' + value.price + '">' + value.price + '</td>');
                $tr.append('<td value="' + value.quantity + '">' + value.quantity + '</td>');

                tbody.append($tr);
            });
            $('#cart-subtotal').val(totalPrice);
            $('#cart-quantity').val(totalItems);
        },
        error: function (result) {

        }
    });
})

// proceed to checkout 
$('#btn-checkout').on("click", function () {
    // hide cart modal
    $('#cart').hide();
    // if there is no login user, pop window to sing up or login
    if (loginId == 0) {
        $('#login-sign').show();
        return;
    }

    $('#checkout').show();

})

// submits the order
$('#btn-submit').on("click", function () {
    var checkoutStr = $('#str-checkout').val();
    var checkoutCity = $('#city-checkout').val();
    var checkoutProv = $('#prov-checkout').val();
    var checkoutPostCode = $('#postcode-checkout').val();
    var checkoutCountry = $('#country-checkout').val();

    if (checkoutStr == "") {
        // user enters nothing, defaults to registered address
        jQuery.ajax({
            type: "Post",
            url: '/Home/GetDefaultAddress',
            data: { customer_id: loginId },
            dataType: "json",
            cache: false,
            success: function (result) {
                var shipping_address_id = result;
                jQuery.ajax({
                    type: "Post",
                    url: '/Home/AddNewOrder',
                    data: { customer_id: loginId, quantity: totalItems, price: totalPrice, shippingAddr: shipping_address_id },
                    dataType: "json",
                    cache: false,
                    success: function (result) {
                        $('#checkout').hide();
                        window.alert('Successfully placed order.');
                    },
                    error: function (result) {

                    }
                });
            },
            error: function (result) {

            }
        });
    }
    else {
        //user enters new address, will be used in order
        jQuery.ajax({
            type: "Post",
            url: '/Home/InsertNewAddress',
            data: { street: checkoutStr, city: checkoutCity, prov: checkoutProv, postcode: checkoutPostCode, country: checkoutCountry },
            dataType: "json",
            cache: false,
            success: function (result) {
                var shipping_address_id = result;
                jQuery.ajax({
                    type: "Post",
                    url: '/Home/AddNewOrder',
                    data: { customer_id: loginId, quantity: totalItems, price: totalPrice, shippingAddr: shipping_address_id },
                    dataType: "json",
                    cache: false,
                    success: function (result) {
                        $('#checkout').hide();
                        window.alert('Successfully placed order.');
                    },
                    error: function (result) {

                    }
                });
            },
            error: function (result) {

            }
        });
    }

    
})


$('#btn-to-login').on("click", function () {
    $('#login').show();
    $('#login-sign').hide();
})

$('#btn-to-signup').on("click", function () {
    $('#signup').show();
    $('#login-sign').hide();
})

// view orders as owner
$('#btn-order-status').on("click", function () {
    // open order modal
    $('#order').show();

    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveOrders',
        data: {},
        dataType: "json",
        cache: false,
        success: function (result) {
            var tbody = $('#order-tablecontent');

            $.each(result, function (index, value) {
                $tr = $('<tr></tr>');
                $tr.append('<td id="' + value.order_id + '" class="cart-item" onclick="SelectOrderItem(this.id)" value="' + value.order_id + '">' + value.order_id + '</td>');
                $tr.append('<td value="' + value.total_price + '">' + value.total_price + '</td>');
                $tr.append('<td value="' + value.total_items + '">' + value.total_items + '</td>');
                $tr.append('<td >' + value.order_status + '</td>');
                $tr.append('<td >' + value.order_date + '</td>');

                tbody.append($tr);
            });
        },
        error: function (result) {

        }
    });
})

$('#order-close').on("click", function () {
    // clear the content of the shopping cart display
    $('#order-tablecontent').html("");
})

// view orders as a user (will be user specific)
$('#btn-view-order').on("click", function () {
    // open order modal
    $('#order').show();

    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveOrderByCustomer',
        data: { customer_id: loginId },
        dataType: "json",
        cache: false,
        success: function (result) {
            var tbody = $('#order-tablecontent');

            $.each(result, function (index, value) {
                $tr = $('<tr></tr>');
                $tr.append('<td id="' + value.order_id + '" class="cart-item" onclick="SelectOrderItem(this.id)" value="' + value.order_id + '">' + value.order_id + '</td>');
                $tr.append('<td value="' + value.total_price + '">' + value.total_price + '</td>');
                $tr.append('<td value="' + value.total_items + '">' + value.total_items + '</td>');
                $tr.append('<td >' + value.order_status + '</td>');
                $tr.append('<td >' + value.order_date + '</td>');

                tbody.append($tr);
            });
        },
        error: function (result) {

        }
    });
})

$('#restock-close').on("click", function () {
    // clear the content
    $('#restock-tablecontent').html("");
})

// view restock history (only owners can view)
$('#btn-view-restock').on("click", function () {
    // open restock modal
    $('#restock').show();

    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveRestockHistory',
        data: { },
        dataType: "json",
        cache: false,
        success: function (result) {
            var tbody = $('#restock-tablecontent');

            $.each(result, function (index, value) {
                $tr = $('<tr></tr>');
                $tr.append('<td>' + value.book_name + '</td>');
                $tr.append('<td>' + value.publisher_name + '</td>');
                $tr.append('<td>' + value.restock_quantity + '</td>');
                $tr.append('<td>' + value.restock_date + '</td>');

                tbody.append($tr);
            });
        },
        error: function (result) {

        }
    });
})

$('#summary-close').on("click", function () {
    // clear the content
    $('#summary-tablecontent').html("");
})

// view summary (only owners can view)
$('#btn-view-summary').on("click", function () {
    // open summary modal
    $('#summary').show();

    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveReports',
        data: {},
        dataType: "json",
        cache: false,
        success: function (result) {
            var tbody = $('#summary-tablecontent');

            $.each(result, function (index, value) {
                $tr = $('<tr></tr>');
                $tr.append('<td>' + value.month + '</td>');
                $tr.append('<td>' + value.total_sale + '</td>');
                $tr.append('<td>' + value.total_sales_quantity + '</td>');
                $tr.append('<td>' + value.total_expense + '</td>');

                tbody.append($tr);
            });
        },
        error: function (result) {

        }
    });
})

$('#summary-catagory-close').on("click", function () {
    // clear the content
    $('#summary-catagory-tablecontent').html("");
})

// view summary catagory (only owners can view)
$('#btn-view-catagory').on("click", function () {
    // open summary catagory modal
    $('#summary-catagory').show();

    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveCategorySales',
        data: {},
        dataType: "json",
        cache: false,
        success: function (result) {
            var month = [];
            var category = [];

            var tbody = $('#summary-catagory-tablecontent');

            $.each(result, function (index, item) {
                month.push(item.month);
                category.push(item.category);

                $tr = $('<tr></tr>');
                $tr.append('<td>' + item.month + '</td>');
                $tr.append('<td>' + item.category + '</td>');
                $tr.append('<td>' + item.total_sale + '</td>');
                $tr.append('<td>' + item.total_sales_quantity + '</td>');

                tbody.append($tr);
            });

            // fill up the search criteria dropdowns
            var uniqueMonth = month.filter(findUnique).sort();
            $('#month-selection').append($('<option></option>', { text: "" }));
            $.each(uniqueMonth, function (index, item) {
                $('#month-selection').append($('<option></option>', { text: item }));
            });

            var uniqueCategory = category.filter(findUnique).sort();
            $('#catSum-selection').append($('<option></option>', { text: "" }));
            $.each(uniqueCategory, function (index, item) {
                $('#catSum-selection').append($('<option></option>', { text: item }));
            });
        },
        error: function (result) {

        }
    });
})

// to finish the display the selected order, to update the status
function SelectOrderItem(id) {
    selectedOrderId = id;
    if (loginRole == "owner") {
        jQuery.ajax({
            type: "Post",
            url: '/Home/RetrieveOrderById',
            data: { order_id: selectedOrderId },
            dataType: "json",
            cache: false,
            success: function (result) {

                    $('#orderstatus').show();
                    $('#order-id').val(result.order_id);
                    var status = result.order_status;
                    $('#status-selection option').filter(function (index) {
                        return $(this).text() === status;
                    }).prop('selected', true);
          
            },
            error: function (result) {

            }
        });
    }
    else {
        jQuery.ajax({
            type: "Post",
            url: '/Home/RetrieveOrderDetail',
            data: { order_id: selectedOrderId, customer_id: loginId },
            dataType: "json",
            cache: false,
            success: function (result) {
                var tbody = $('#order-detail-tablecontent');

                $.each(result, function (index, value) {

                    $tr = $('<tr> </tr>');
                    $tr.append('<td value="' + value.book_name + '">' + value.book_name + '</td>');
                    $tr.append('<td value="' + value.price + '">' + value.price + '</td>');
                    $tr.append('<td value="' + value.quantity + '">' + value.quantity + '</td>');

                    tbody.append($tr);
                });
                $('#orderdetail').show();
            },
            error: function (result) {

            }
        });
    }
}

$('#status-selection').change(function () {
    var status = $('#status-selection').val();
    $('#order').hide()
    jQuery.ajax({
        type: "Post",
        url: '/Home/UpdateOrder',
        data: { order_id: selectedOrderId, status: status },
        dataType: "json",
        cache: false,
        success: function (result) {
 
        },
        error: function (result) {

        }
    }); 
})

$('#month-selection').change(function () {
    var month = $('#month-selection').val();
    var catSum = $('#catSum-selection').val();
    jQuery.ajax({
        type: "Post",
        url: '/Home/ReportMonth',
        data: { month: month, category: catSum},
        dataType: "json",
        cache: false,
        success: function (result) {
            $('#summary-catagory-tablecontent').html("");
            var tbody = $('#summary-catagory-tablecontent');

            $.each(result, function (index, item) {

                $tr = $('<tr></tr>');
                $tr.append('<td>' + item.month + '</td>');
                $tr.append('<td>' + item.category + '</td>');
                $tr.append('<td>' + item.total_sale + '</td>');
                $tr.append('<td>' + item.total_sales_quantity + '</td>');

                tbody.append($tr);
            });
        },
        error: function (result) {

        }
    });
})

$('#catSum-selection').change(function () {
    var month = $('#month-selection').val();
    var catSum = $('#catSum-selection').val();
    jQuery.ajax({
        type: "Post",
        url: '/Home/ReportMonth',
        data: { month: month, category: catSum },
        dataType: "json",
        cache: false,
        success: function (result) {
            $('#summary-catagory-tablecontent').html("");
            var tbody = $('#summary-catagory-tablecontent');

            $.each(result, function (index, item) {

                $tr = $('<tr></tr>');
                $tr.append('<td>' + item.month + '</td>');
                $tr.append('<td>' + item.category + '</td>');
                $tr.append('<td>' + item.total_sale + '</td>');
                $tr.append('<td>' + item.total_sales_quantity + '</td>');

                tbody.append($tr);
            });
        },
        error: function (result) {

        }
    });
})

$('#btn-search').on("click", function () {
    var category = $('#category-selection').val();
    var author = $('#author-selection').val();
    var year = $('#year-selection').val();
    var title = $('#search-title').val();
    var isbn = $('#search-ISBN').val();
    var publisher = $('#publisher-selection').val();

    $('#booklist').html("");

    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveBooksByCombinedSearch',
        data: {category: category, title: title, publisher_name: publisher, author: author, year: year, isbn: isbn },
        dataType: "json",
        cache: false,
        success: function (result) {
            var bookContainer = document.getElementById("booklist");
 
            $.each(result, function (index, item) {
                var bookListItem = createBookList(item);
                bookContainer.appendChild(bookListItem);
            });
        },
        error: function (result) {
            
        }
    });
})

$('#btn-add-to-cart').on("click", function () {
    jQuery.ajax({
        type: "Post",
        url: '/Home/InsertItemToShoppingCart',
        data: { customer_id: loginId, book_id: selectedBookId },
        dataType: "json",
        cache: false,
        success: function (result) {
            window.alert('Added book to shopping cart.');
        },
        error: function (result) {

        }
    });
})

$('#btn-rem-from-cart').on("click", function () {
    jQuery.ajax({
        type: "Post",
        url: '/Home/RemoveItemFromShoppingCart',
        data: { customer_id: loginId, book_id: selectedBookId },
        dataType: "json",
        cache: false,
        success: function (result) {
            window.alert('Removed book from cart.');
        },
        error: function (result) {

        }
    });
})

$('#btn-add-book').on("click", function () {
    $('#addbook').show();
})
$('#btn-add').on("click", function () {
    var title = $('#add-title').val();
    var author = $('#add-author').val();
    var publisher = $('#add-publisher').val();
    var pages = $('#add-pages').val();
    var isbn = $('#add-isbn').val();
    var price = $('#add-price').val();
    var category = $('#add-category').val();
    var year = $('#add-year').val()
    var stock = $('#add-stock').val()
    var percent = $('#add-percent').val()

    jQuery.ajax({
        type: "Post",
        url: '/Home/AddBook',
        data: { category: category, title: title, publisher_name: publisher, author: author, year: year, price: price, stock: stock, percent: percent, isbn: isbn, pages: pages },
        dataType: "json",
        cache: false,
        success: function (result) {
            $('#bookdetail').hide();
            window.alert('Added book to store.');
        },
        error: function (result) {

        }
    });
})

$('#btn-rem-from-bookstore').on("click", function () {
    jQuery.ajax({
        type: "Post",
        url: '/Home/DeleteBook',
        data: { book_id: selectedBookId },
        dataType: "json",
        cache: false,
        success: function (result) {
            $('#bookdetail').hide();
            window.alert('Removed book from store.');
        },
        error: function (result) {

        }
    });
})

$(document).ready(function () {
    //test
    //window.alert("the page is on -- testing");
    jQuery.ajax({
        type: "Post",
        url: '/Home/RetrieveBooks',
        data: {},
        dataType: "json",
        cache: false,
        success: function (result) {
            //test
            //window.alert("retrieve books successful -- testing");
            var category = [];
            var author = [];
            var publisher = [];
            var year = [];

            var bookContainer = document.getElementById("booklist");
            //load books 
            $.each(result, function (index, item) {
                //var title_content = '<li>' + '<a href="#">' + item.title + '</a></li>';
                //$('#booklist').append(title_content);
                
                var bookListItem = createBookList(item);
                bookContainer.appendChild(bookListItem);

                category.push(item.category);
                author.push(item.author);
                publisher.push(item.publisher_name);
                year.push(item.year);
            });

            // fill up the search criteria dropdowns
            var uniqueCategory = category.filter(findUnique).sort();
            $('#category-selection').append($('<option></option>', { text: "" }));
            $.each(uniqueCategory, function (index, item) {               
                $('#category-selection').append($('<option></option>', { text: item }));
            });

            var uniqueAuthor = author.filter(findUnique).sort();
            $('#author-selection').append($('<option></option>', { text: "" }));
            $.each(uniqueAuthor, function (index, item) {
                $('#author-selection').append($('<option></option>', { text: item }));
            });

            var uniquePublisher = publisher.filter(findUnique).sort();
            $('#publisher-selection').append($('<option></option>', { text: "" }));
            $.each(uniquePublisher, function (index, item) {
                $('#publisher-selection').append($('<option></option>', { text: item }));
            });

            var uniqueYear = year.filter(findUnique).sort();
            $('#year-selection').append($('<option></option>', { text: "" }));
            $.each(uniqueYear, function (index, item) {
                $('#year-selection').append($('<option></option>', { text: item }));
            });
        },
        error: function (result) {
            window.alert("retrieve books fail -- testing");
        }
    });
});

