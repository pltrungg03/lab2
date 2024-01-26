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
                        <h1 class="text-white">Upgrade Premium</h1>
                    </div>
                </div>
            </div>
           
            <!-- Breadcrumb row -->
            <div style="margin: 200px">
                 <%@include file="transaction-header.jsp" %>
                <h3>Total wallet: ${sessionScope.user.wallet}$</h3>
                <c:if test="${expiredVIP != null}">
                    <h3>Expired date: ${expiredVIP}</h3>
                </c:if>
                <div>
                    <h2>1. Select Premium package you want to purchase </h2>
                    <table >
                        <tr style="border-bottom: 3px solid grey;">
                            <th>Select</th>
                            <th>Package</th>
                            <th>Price</th>
                            <th>Total</th>
                        </tr>
                        <form id="payment-form" action="upgrade-premium" method="post">
                            <c:forEach items="${listPack}" var="o">
                                <tr style="border-bottom: 1px solid grey;">
                                <td><input class="select" type="radio" name="choose" value="${o.name}"></td>
                                <td>${o.name}</td>
                                <td>${o.price}$</td>
                                <td>$${o.price}</td>
                            </tr>
                            </c:forEach>
                            
                            
                            
                        </form>
                    </table>

                </div>
                <c:if test="${err != null}">
                    <h3 style="color: red; text-align: center"> ${err}</h3>
                </c:if>
                    <c:if test="${message != null}">
                    <h3 style="color: green; text-align: center"> ${message}</h3>
                </c:if>
                <div style="display: flex; justify-content: center; margin: 30px 0px;">
                    <button id="pay" style="
                            background: black;
                            color: white;
                            border-radius: 10px;
                            height: 50px;
                            width: 250px;

                            ">Purchase</button>
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
            
            
            $('#pay').on('click', function () {

                if ($('input[name="choose"]:checked').val() != null) {
                    choose = $('input[name="choose"]:checked').val();
                    <c:forEach items="${listPack}" var="o">
                        if (choose == '${o.name}') {
                        var form = $('#payment-form');

                        var days = document.createElement('input');
                        days.value = '${o.value}';
                        days.type = 'hidden';
                        days.name = 'days';

                        form.prepend(days);

                        var price = document.createElement('input');
                        price.value = '${o.price}';
                        price.type = 'hidden';
                        price.name = 'price';

                        form.prepend(price);



                        form.submit();
                    }        
                    </c:forEach>
                    
                    
                    
                } else {
                    alert('You need to choose a packet to purchase');
                }

            });
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
