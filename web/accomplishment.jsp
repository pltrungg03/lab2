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
    <title>Accomplishment</title>

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
    <style>
        .blog-entry {
            position: relative;
            border: 1px solid #ddd;
            padding: 10px;
        }

        .blog-header {
            position: absolute;
            top: 0;
            right: 0;
        }

        .edit-button, .remove-button {
            margin-right: 1px; /* Reduce the margin to bring the buttons closer */
        }


        .edit-button, .remove-button {
            align-self: center;
            background-color: #fff;
            background-image: none;
            background-position: 0 90%;
            background-repeat: repeat no-repeat;
            background-size: 4px 3px;
            border-radius: 15px 225px 255px 15px 15px 255px 225px 15px;
            border-style: solid;
            border-width: 2px;
            box-shadow: rgba(0, 0, 0, .2) 15px 28px 25px -18px;
            box-sizing: border-box;
            color: #41403e;
            cursor: pointer;
            display: inline-block;
            font-family: Neucha, sans-serif;
            font-size: 1rem;
            line-height: 23px;
            outline: none;
            padding: .2rem;
            text-decoration: none;
            transition: all 235ms ease-in-out;
            border-bottom-left-radius: 15px 255px;
            border-bottom-right-radius: 225px 15px;
            border-top-left-radius: 255px 15px;
            border-top-right-radius: 15px 225px;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
        }

        .edit-button:hover,.remove-button:hover {
            box-shadow: rgba(0, 0, 0, .3) 2px 8px 8px -5px;
            transform: translate3d(0, 2px, 0);
        }

        .edit-button, .remove-button:focus {
            box-shadow: rgba(0, 0, 0, .3) 2px 8px 4px -6px;
        }


    </style>
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
                        <h1 class="text-white">Accomplishment</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="breadcrumb-row">
                <div class="container">
                    <ul class="list-inline">
                        <li><a href="home">Home</a></li>
                        <li><a href="accomplishment">Accomplishment</a></li>
                       
                    </ul>
                </div>
            </div>
            <!-- Breadcrumb row END -->
            <!-- contact area -->
            <div class="content-block">
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <!-- Left part start -->
                            <div class="col-lg-8" style="margin: 0 auto;">
                                <h3 style="font-style: italic; color: #666666">Your certification(s):</h3>
                                
                                <c:forEach items="${requestScope.map}" var="m">
                                    <div class="blog-entry blog-post blog-md clearfix item-of-listblog" style="border-top: 1px solid #cccccc">
                                       
                                        <div class="ttr-post-media"> 
                                            <a target="_blank" href="certificate?${m.key}">${m.value}
                                                <br/><span style="font-size: 15px; font-style: italic; text-decoration: underline; color: #0099ff">View link</span>
                                            </a> 
                                            
                                        </div>
                                        
                                    </div>
                                </c:forEach>

                            </div>
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
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