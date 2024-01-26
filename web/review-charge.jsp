
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
        <div class="">
            <!-- inner page banner -->
            <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white">Charge Wallet</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="" style="margin: 100px;">
                <h1 style="text-align: center;">Please Review Before Paying</h1>
                <form action="execute-payment" method="post">
                    <div >
                        <table class="center">
                            <tr style="border-bottom: 3px gray solid">
                                <td ><b>Transaction Details:</b></td>
                                <td>
                                    <input type="hidden" name="paymentId" value="${param.paymentId}" />
                                    <input type="hidden" name="PayerID" value="${param.PayerID}" />
                                </td>
                            </tr>
                            <tr>
                                <td>Description:</td>
                                <td>${transaction.description}</td>
                            </tr>
                            <tr>
                                <td>Subtotal:</td>
                                <td>${transaction.amount.details.subtotal} USD</td>
                            </tr>

                            
                            <tr>
                                <td>Total:</td>
                                <td>${transaction.amount.total} USD</td>
                            </tr>	
                            <tr><td><br/></td></tr>
                            <tr style="border-bottom: 3px gray solid">
                                <td ><b>Payer Information:</b></td>
                            </tr>
                            <tr>
                                <td>First Name:</td>
                                <td>${payer.firstName}</td>
                            </tr>
                            <tr>
                                <td>Last Name:</td>
                                <td>${payer.lastName}</td>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td>${payer.email}</td>
                            </tr>
                            <tr><td><br/></td></tr>		
                        </table>

                    </div>
                    <div style="display: flex; justify-content: center">
                        <input style="
                               background: black;
                               color: white;
                               border-radius: 10px;
                               height: 50px;
                               width: 125px;
                               margin: 0px auto;
                               cursor: pointer;
                               " type="submit" value="Pay Now" />
                    </div>

                </form>

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

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
