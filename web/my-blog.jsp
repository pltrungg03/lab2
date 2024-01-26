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
    <title>My BLOG</title>

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
                        <h1 class="text-white">Blog - ${sessionScope.user.firstName} ${sessionScope.user.lastName}</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="breadcrumb-row">
                <div class="container">
                    <ul class="list-inline">
                        <li><a href="home">Home</a></li>
                        <li><a href="my-blog">My Blog</a></li>
                        <button onclick="checkLoginAndSubmit()" style="background: black; color: white; padding: 10px; border-radius: 8px;">Write a blog!</button>
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
                                <h4 style="color: #33cc00; font-style: italic;">${param.noti}</h4>
                                <p style="font-style: italic; color: brown">Found ${list.size()} result(s)!</p>
                                <c:forEach items="${requestScope.list}" var="p">
                                    <div class="blog-entry blog-post blog-md clearfix item-of-listblog" style="border-top: 1px solid #cccccc">
                                        <div class="blog-header">

                                            <form action="my-blog" method="post" style="display: inline-block">
                                                <input type="hidden" name="blogId" value="${p.id}"/>
                                                <input type="hidden" name="edit" value="1"/>
                                                <button class="edit-button">Edit</button>
                                            </form> 
                                            <form action="my-blog" method="post" onsubmit="return confirmSubmit()" style="display: inline-block">
                                                <input type="hidden" name="blogId" value="${p.id}"/>
                                                <input type="hidden" name="remove" value="1"/>    
                                                <button class="remove-button" id="removeButton">Remove</button>
                                            </form>
                                        </div>
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


                                <!-- Pagination start -->
                                <div class="pagination-bx rounded-sm gray clearfix">
                                    <ul class="pagination">
                                        <li class="previous"><button style="background: #990099; color: white; padding: 8px; border-radius: 7px" onclick="previousPage()"><i class="ti-arrow-left"></i> Prev</button></li>

                                        <li class="next"><button style="background: #990099; color: white; padding: 8px; border-radius: 7px" onclick="nextPage()">Next <i class="ti-arrow-right"></i></button></li>
                                    </ul>
                                </div>
                                <!-- Pagination END -->
                            </div>
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
    <script>
                                            var itemsPerPage = 4;
                                            var currentPage = 1;

                                            function displayItems() {
                                                var items = document.getElementsByClassName("item-of-listblog");
                                                var startingIndex = (currentPage - 1) * itemsPerPage;
                                                var endingIndex = startingIndex + itemsPerPage;

                                                for (var i = 0; i < items.length; i++) {
                                                    if (i >= startingIndex && i < endingIndex) {
                                                        items[i].style.display = "block";
                                                    } else {
                                                        items[i].style.display = "none";
                                                    }
                                                }
                                            }

                                            function previousPage() {
                                                if (currentPage > 1) {
                                                    currentPage--;
                                                    displayItems();
                                                }
                                            }

                                            function nextPage() {
                                                var totalItems = document.getElementsByClassName("item-of-listblog").length;
                                                var totalPages = Math.ceil(totalItems / itemsPerPage);

                                                if (currentPage < totalPages) {
                                                    currentPage++;
                                                    displayItems();
                                                }
                                            }

                                            // Initialize the page
                                            displayItems();


    </script>    
    <script>
        function checkLoginAndSubmit() {
            var check = "<c:out value='${sessionScope.user}' />";

            if (check === "") {
                alert("You need login to write blog!");
                window.location.href = "http://localhost:9999/SE1735_G5/login"; // Redirect to the login page
            } else {
                // Submit the comment form
                window.location.href = "http://localhost:9999/SE1735_G5/write-blog"; // Redirect to the login page

            }
        }
    </script>
    <script>
        function confirmSubmit() {
            var confirmed = confirm("Are you sure to delete this post, even can not undo?");

            if (!confirmed) {
                return false; // Prevent form submission
            }

            // Form is confirmed, continue with submission
            return true;
        }
    </script>
</body>

</html>