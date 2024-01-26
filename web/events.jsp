<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Byte Scholar</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- Header Top END ==== -->
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Events</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Events</li>
                        </ul>
                    </div>
                </div>           
                <!-- Breadcrumb row END -->
                <!-- contact area -->
                <div class="content-block">
                    <!-- Portfolio  -->
                    <div class="section-area section-sp1 gallery-bx">
                        <div class="container">
                            <div class="clearfix">
                                <ul id="masonry" class="ttr-gallery-listing magnific-image row" style="list-style: none">
                                    <jsp:useBean id="util" class="util.Helpers"></jsp:useBean>
                                    <c:if test="${requestScope.events.size() <= 0}">
                                        <h4>There's no events at the moment.</h4>
                                    </c:if>
                                    <c:forEach items="${events}" var="e">
                                        <li class="action-card col-lg-6 col-md-6 col-sm-12 happening">
                                            <div class="event-bx m-b30">
                                                <div class="action-box">
                                                    <div id="carouselExampleControls-${e.id}" class="carousel slide" data-ride="carousel">
                                                        <div class="carousel-inner" style="height: 300px;">
                                                            <c:forEach items="${e.courses}" var="c" varStatus="loop">
                                                                <c:if test="${loop.index eq 0 }">
                                                                    <div class="carousel-item active">
                                                                        <img class="d-block w-100" src="${c.image}" alt="First slide">
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${loop.index ne 0}">
                                                                    <div class="carousel-item">
                                                                        <img class="d-block w-100" src="${c.image}" alt="First slide">
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                        <a class="carousel-control-prev" href="#carouselExampleControls-${e.id}" role="button" data-slide="prev">
                                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                            <span class="sr-only">Previous</span>
                                                        </a>
                                                        <a class="carousel-control-next" href="#carouselExampleControls-${e.id}" role="button" data-slide="next">
                                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                            <span class="sr-only">Next</span>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="info-bx d-flex position-relative" onclick="window.location.href = 'event-detail?eventId=${e.id}'" style="cursor: pointer";>
                                                    <div>
                                                        <div class="event-time">
                                                            <div class="event-date">${util.timeLeft(e.expiredDate)}</div>
                                                            <div class="event-month">Lefts</div>
                                                        </div>
                                                    </div>
                                                    <div class="event-info">
                                                        <h4 class="event-title"><a href="event-detail?eventId=${e.id}">${e.content}</a></h4>
                                                        <p></p>
                                                        <p style="font-size: 1rem; text-align: start;color: red">Sale: ${e.calculateDiscountPercentage()}%</p>

                                                    </div>
                                                    <div class="event-discount">

                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- contact area END -->
            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <%@include file="footer.jsp" %>
            <!-- Footer END ==== -->
            <button class="back-to-top fa fa-chevron-up" ></button>
        </div>
        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>
    </body>
    <script>
                                                                                        $('.carousel').carousel({
                                                                                            interval: 3000
                                                                                        })
    </script>
</html>
