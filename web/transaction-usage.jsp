<%-- 
    Document   : my-courses.jsp
    Created on : Sep 25, 2023, 9:05:03 PM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link href="assets/css/stylePaging.css" rel="stylesheet">

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
                        <h1 class="text-white">Usage Transaction</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->

            <div style="margin: 200px">
                <%@include file="transaction-header.jsp" %>
                <h3>Total wallet: ${sessionScope.user.wallet}$</h3>
                <div>
                    <div style="margin: 10px 0px;">
                        <form action="usage-transaction" method="post">
                            From <input type="date" name="from" value="${from}"> &nbsp;
                            To <input type="date" name="to" value="${to}"> &nbsp;
                            <input style="color: white; background: #121921; border-radius: 5px; " type="submit" value="FILTER"/>
                        </form> 
                    </div>
                    <table class="list">
                        <thead >
                            <tr style="border-bottom: 3px solid grey;">
                                <th>Note</th>
                                <th>Price</th>
                                <th>Date</th>
                                <th>Order Number</th>
                            </tr>
                        </thead>

                        <c:forEach items="${listTU}" var="o">
                            <tr class="item" style="border-bottom: 1px solid grey;">
                                <td>${o.note}</td>
                                <td>${o.price}</td>
                                <td>${o.date}</td>
                                <td>${o.id}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="col-12 pb-1 ">
                        <nav aria-label="Page navigation">
                            <ul class="listPage">

                            </ul>
                        </nav>
                    </div>
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
            window.onload = function () {//from ww  w . j  a  va2s. c  o  m
                var today = new Date().toISOString().split('T')[0];
                document.getElementsByName("from")[0].setAttribute('max', today);
                document.getElementsByName("to")[0].setAttribute('max', today);
            }
            let thisPage = 1;
            let limit = 4;
            let list = document.querySelectorAll('.list .item');
            function loadItem() {
                let beginGet = limit * (thisPage - 1);
                let endGet = limit * thisPage - 1;
                list.forEach((item, key) => {
                    if (key >= beginGet && key <= endGet) {
                        item.style.display = 'table-row';
                    } else {
                        item.style.display = 'none';
                    }
                });
                listPage();
            }
            loadItem();
            function listPage() {
                let count = Math.ceil(list.length / limit);
                document.querySelector('.listPage').innerHTML = '';
                if (list.length == 0) {
                    let notFound = document.createElement('h1');
                    notFound.innerHTML = 'Not found any items';
                    notFound.style = 'text-align: center;align-items: center;color: #6F6F6F;';
                    notFound.classList.add('page-item');
                    document.querySelector('.right').appendChild(notFound);
                }
                if (thisPage != 1 && list.length != 0) {
                    let prev = document.createElement('li');
                    prev.innerHTML = '<<';
                    prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
                    prev.classList.add('page-item');
                    document.querySelector('.listPage').appendChild(prev);
                }

                for (i = 1; i <= count; i++) {
                    let newPage = document.createElement('li');
                    newPage.innerText = i;
                    if (i == thisPage) {
                        newPage.classList.add('active');
                    }
                    newPage.classList.add('page-item');
                    newPage.setAttribute('onclick', "changePage(" + i + ")");
                    document.querySelector('.listPage').appendChild(newPage);
                }

                if (thisPage != count && list.length != 0) {
                    let next = document.createElement('li');
                    next.innerText = '>>';
                    next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
                    next.classList.add('page-item');
                    document.querySelector('.listPage').appendChild(next);
                }

            }

            function changePage(i) {
                thisPage = i;
                loadItem();
            }
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
