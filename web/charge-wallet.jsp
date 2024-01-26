<%-- 
    Document   : my-courses.jsp
    Created on : Sep 25, 2023, 9:05:03 PM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:10:19 GMT -->
    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="Byte Scholar" />

        <!-- OG -->
        <meta property="og:title" content="Byte Scholar" />
        <meta property="og:description" content="Byte Scholar" />
        <meta property="og:image" content="" />


        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Byte Scholar </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->

        <%@include file="header.jsp" %>

        <!-- header end -->
        <!-- Content -->
        <div class="page-content bg-white">
            <!-- inner page banner -->
            <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white">Charge Wallet</h1>
                    </div>
                </div>
            </div>
           
            <!-- Breadcrumb row -->
            <div style="margin: 200px">
                 <%@include file="transaction-header.jsp" %>
                <h3>Total wallet: ${sessionScope.user.wallet}$</h3>
                <div>
                    <h2>1. Select amount of charge to your wallet</h2>
                    <table >
                        <tr style="border-bottom: 3px solid grey;">
                            <th>Select</th>
                            <th>Wallet Amount</th>
                            <th>Price</th>
                            <th>Total</th>
                        </tr>
                        <form id="payment-form" action="authorize-payment" method="post">
                            <tr style="border-bottom: 1px solid grey;">
                                <td><input class="select" type="radio" name="choose" value="pack100"></td>
                                <td>100$</td>
                                <td>$100</td>
                                <td>$100</td>
                            </tr>
                            <tr style="border-bottom: 1px solid grey;">
                                <td><input class="select" type="radio" name="choose" value="pack200"></td>
                                <td>200$</td>
                                <td>$200</td>
                                <td>$200</td>
                            </tr>
                            <tr style="border-bottom: 1px solid grey;">
                                <td><input class="select" type="radio" name="choose" value="pack500"></td>
                                <td>500$</td>
                                <td>$500</td>
                                <td>$500</td>
                            </tr>
                            <tr style="border-bottom: 1px solid grey;">
                                <td><input class="select" type="radio" name="choose" value="pack1000"></td>
                                <td>1000$</td>
                                <td>$1000</td>
                                <td>$1000</td>
                            </tr>
                            <tr style="border-bottom: 1px solid grey;">
                                <td><input class="select" type="radio" name="choose" value="pack2000"></td>
                                <td>2000$</td>
                                <td>$2000</td>
                                <td>$2000</td>
                            </tr>
                            <tr>
                                <td><input class="select" id="custom" type="radio" name="choose" value="packCustom"></td>
                                <td id="customAmount">$</td>
                                <td><input id="customeVal" type="number" min="100" max="2000"  name="price"  disabled=""></td>
                                <td id="customTotal">$</td>
                            </tr>
                        </form>
                    </table>

                </div>
                <h2>2. Select the payment method</h2>
                <div style="display: flex; justify-content: center">
                    <input type="radio" checked readonly>
                    <div style="height:100px; width: 200px">
                        <img src="https://tap2pay.me/wp-content/uploads/2018/12/PayPal-Header-720x480-1.jpg">
                    </div>

                </div>
                <div style="display: flex; justify-content: center; margin: 30px 0px;">
                    <button id="pay" style="
                            background: black;
                            color: white;
                            border-radius: 10px;
                            height: 50px;
                            width: 250px;

                            ">Payment</button>
                </div>

            </div>
            <!-- Breadcrumb row END -->
            <!-- inner page banner END -->

            <!-- contact area END -->
        </div>
        <!-- Content END-->
        <%@include file="footer.jsp" %>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="admin/assets/js/jquery.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="admin/assets/vendors/masonry/masonry.js"></script>
        <script src="admin/assets/vendors/masonry/filter.js"></script>
        <script src="admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='admin/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="admin/assets/js/functions.js"></script>
        <script src="admin/assets/vendors/chart/chart.min.js"></script>
        <script src="admin/assets/js/admin.js"></script>
        <script src='admin/assets/vendors/switcher/switcher.js'></script>
        <script>
            $('#customeVal').on('input', function () {
                document.getElementById('customAmount').innerHTML = $('#customeVal').val() + '$';
                document.getElementById('customTotal').innerHTML = '$' + $('#customeVal').val();
            });
            $('.select').on('click', function () {
                if ($('input[id="custom"]:checked').val() == null) {
                    $('#customeVal').prop('disabled', true);
                } else {
                    $('#customeVal').removeAttr('disabled');
                }

            });
            $('#pay').on('click', function () {

                if ($('input[name="choose"]:checked').val() != null) {
                    choose = $('input[name="choose"]:checked').val();
                    if (choose == 'pack100') {
                        var form = $('#payment-form');

                        var amount = document.createElement('input');
                        amount.value = '100$';
                        amount.type = 'hidden';
                        amount.name = 'amount';

                        form.prepend(amount);

                        var price = document.createElement('input');
                        price.value = '100';
                        price.type = 'hidden';
                        price.name = 'price';

                        form.prepend(price);



                        form.submit();
                    }
                    if (choose == 'pack200') {
                        var form = $('#payment-form');

                        var amount = document.createElement('input');
                        amount.value = '200$';
                        amount.type = 'hidden';
                        amount.name = 'amount';

                        form.prepend(amount);

                        var price = document.createElement('input');
                        price.value = '200';
                        price.type = 'hidden';
                        price.name = 'price';

                        form.prepend(price);



                        form.submit();
                    }
                    if (choose == 'pack500') {
                        var form = $('#payment-form');

                        var amount = document.createElement('input');
                        amount.value = '500$';
                        amount.type = 'hidden';
                        amount.name = 'amount';

                        form.prepend(amount);

                        var price = document.createElement('input');
                        price.value = '500';
                        price.type = 'hidden';
                        price.name = 'price';

                        form.prepend(price);



                        form.submit();
                    }
                    if (choose == 'pack1000') {
                        var form = $('#payment-form');

                        var amount = document.createElement('input');
                        amount.value = '1000$';
                        amount.type = 'hidden';
                        amount.name = 'amount';

                        form.prepend(amount);

                        var price = document.createElement('input');
                        price.value = '1000';
                        price.type = 'hidden';
                        price.name = 'price';

                        form.prepend(price);



                        form.submit();
                    }
                    if (choose == 'pack2000') {
                        var form = $('#payment-form');

                        var amount = document.createElement('input');
                        amount.value = '2000$';
                        amount.type = 'hidden';
                        amount.name = 'amount';

                        form.prepend(amount);

                        var price = document.createElement('input');
                        price.value = '2000';
                        price.type = 'hidden';
                        price.name = 'price';

                        form.prepend(price);



                        form.submit();
                    }
                    if (choose == 'packCustom') {
                        if ($('#customeVal').val() < 100 || $('#customeVal').val() > 2000) {
                            alert('Custom price must between 100$ and 2000$!!');
                        } else {
                            var form = $('#payment-form');

                            var amount = document.createElement('input');
                            amount.value = $('#customeVal').val() + '$';
                            amount.type = 'hidden';
                            amount.name = 'amount';

                            form.prepend(amount);
                            form.submit();
                        }







                    }
                } else {
                    alert('You need to choose a packet to pay');
                }

            });
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
