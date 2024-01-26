<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<head>

    <!-- META ============================================= -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content="" />
    <meta name="author" content="" />
    <meta name="robots" content="" />

    <meta name="description" content="Byte Scholar" />

    <!-- OG -->
    <meta property="og:title" content="Byte Scholar" />
    <meta property="og:description" content="Byte Scholar" />
    <meta property="og:image" content="" />


    <!-- FAVICONS ICON ============================================= -->
    <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />

    <!-- PAGE TITLE HERE ============================================= -->
    <title>Sholar BLOGGER</title>

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
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

</head>
<body id="bg">
    <div class="page-wraper">
        <div id="loading-icon-bx"></div>

        <!-- Header Top ==== -->
        <%@include file="header.jsp" %>
        <!-- header END ==== -->
        <!-- Content -->
        <div class="page-content bg-white">
            <!-- inner page banner -->
            <div class="page-banner ovbl-dark" style="background-image:url(https://cdn.wallpapersafari.com/51/1/PL5YbE.jpg);">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white">Blog of ${requestScope.a.firstName} ${requestScope.a.lastName}</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="breadcrumb-row">
                <div class="container">
                    <ul class="list-inline">
                        <li><a href="home">Home</a></li>
                        <li><a href="blog-list?tag=0">Blog List</a></li>
                      
                    </ul>
                </div>
            </div>
            <!-- Breadcrumb row END -->
            <!-- contact area -->
            <div class="content-block">
                <div class="section-area section-sp1">
                    <div class="container" style="margin-bottom: 5%">
                        <div class="row" style="background: linear-gradient(135deg, #ff6b6b, #0073e6); padding: 20px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); color: #fff; text-align: center;">

                            <h3 style="margin: 0; padding: 0; font-size: 24px;width: 100%">Blogger Information</h3>

                            <c:set value="${requestScope.a}" var="a"/>

                            <a href="blog-user?id=${a.id}" style="text-decoration: none; color: #fff; margin-top: 2%; margin-left: 40%">
                                <img src="${a.avatar}" alt="alt" style="width: 80px; height: 80px; border-radius: 50%; border: 4px solid #fff; box-shadow: 0 0 10px rgba(255, 255, 255, 0.6);"/>
                                <span style="font-weight: bold; font-size: 1.5em; margin: 10px 0;">${a.firstName} ${a.lastName}</span>
                            </a>

                           

                            <p style="margin: 10px 35%;width: 100%; text-align: left">Joined: ${a.createdDate}</p>

                           

                            <p style="margin: 10px 35%;width: 100%; text-align: left">Has: ${requestScope.listB.size()} blog(s)</p>
                        </div>

                    </div>
                    <div class="container">

                        <div class="row">
                            <c:if test="${requestScope.listB.size() == 0}">
                                <div class="col-lg-8">

                                    <h3 style="  font-size: 24px; /* Adjust the font size to your preference */
                                        color: #333; /* Text color */
                                        background-color: #f7f7f7; /* Background color */
                                        padding: 10px 20px; /* Padding for better readability */
                                        border-radius: 10px; /* Rounded corners */
                                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Subtle box shadow */
                                        text-align: center; font-style: italic">There are no blogs yet!</h3>
                                </div>
                            </c:if>
                            <!-- Left part start -->
                            <c:if test="${requestScope.listB.size() > 0}">

                                <div class="col-lg-8">
                                    <h3 style="  font-size: 24px; /* Adjust the font size to your preference */
                                        color: #333; /* Text color */
                                        background-color: #f7f7f7; /* Background color */
                                        padding: 10px 20px; /* Padding for better readability */
                                        border-radius: 10px; /* Rounded corners */
                                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Subtle box shadow */
                                        text-align: center; font-style: italic">Here are all blogs of <span style="  font-weight: bold;
                                                                  font-size: 1.2em;
                                                                  margin: 10px 0;
                                                                  color: #FF5733; /* Change the text color to a colorful value */

                                                                  padding: 5px 10px;
                                                                  border-radius: 5px;">${a.firstName} ${a.lastName}</span></h3>
                                    <p style="font-style: italic; color: #cc9900">Sort by: Created Date</p>
                                    <c:forEach items="${requestScope.listB}" var="p">
                                        <div class="blog-post blog-md clearfix item-of-listblog" style="border-top: 1px solid #cccccc">
                                            <div class="ttr-post-media"> 
                                                <a href="blog-details?id=${p.id}"><img src="${p.thumbnail}"></a> 
                                            </div>
                                            <div class="ttr-post-info">
                                                <ul class="media-post">
                                                    <li><a href="blog-details?id=${p.id}"><i class="fa fa-calendar"></i>${p.createdDate}</a></li>
                                                    <li><a href="blog-details?id=${p.id}"><i class="fa fa-user"></i>By ${p.creator.firstName} ${p.creator.lastName}</a></li>
                                                </ul>
                                                <h5 class="post-title"><a href="blog-details?id=${p.id}">${p.title}</a></h5>
                                                <p></p>
                                                <div class="post-extra">
                                                    <a href="blog-details?id=${p.id}" class="btn-link">READ MORE</a>
                                                    <a href="blog-details?id=${p.id}" class="comments-bx"><i class="fa fa-comments-o"></i>
                                                        <c:forEach items="${requestScope.map}" var="map">
                                                            <c:if test="${map.key == p.id}">
                                                                ${map.value}
                                                            </c:if>
                                                        </c:forEach>
                                                        Comment</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>




                                </div>
                            </c:if>
                            <!-- Left part END -->
                            <!-- Side bar start -->

                            <!-- Side bar END -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content END-->
        <!-- Footer ==== -->
        <%@include file="footer.jsp" %>
        <!-- Footer END ==== -->
        <!-- scroll top button -->
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

</html>