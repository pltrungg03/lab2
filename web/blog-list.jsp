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
    <title>Scholar BLOG</title>

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
                        <h1 class="text-white">Blog List</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="breadcrumb-row">
                <div class="container">
                    <ul class="list-inline">
                        <li><a href="home">Home</a></li>
                        <li><a href="blog-list?tag=0">Blog List</a></li>
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
                            <c:if test="${param.tag == 0}">
                                <h3 style="width: 60%;font-style: italic; color: #663300; text-align: center">All</h3>
                            </c:if>
                            <c:forEach items="${requestScope.listT}" var="tag">
                                <c:if test="${tag.id == param.tag}">
                                    <h3 style="width: 60%;font-style: italic; color: #663300; text-align: center">${tag.name}</h3>
                                </c:if>

                            </c:forEach>
                        </div>
                        <div class="row">

                            <!-- Left part start -->
                            <div class="col-lg-8">
                                <p style="font-style: italic; color: brown">Found ${list.size()} result(s)!</p>
                                <c:forEach items="${requestScope.list}" var="p">
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

                                <c:if test="${requestScope.list.size() > 5}">
                                    <!-- Pagination start -->
                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination">
                                            <li class="previous"><button style="background: #990099; color: white; padding: 8px; border-radius: 7px" onclick="previousPage()"><i class="ti-arrow-left"></i> Prev</button></li>

                                            <li class="next"><button style="background: #990099; color: white; padding: 8px; border-radius: 7px" onclick="nextPage()">Next <i class="ti-arrow-right"></i></button></li>
                                        </ul>
                                    </div>
                                </c:if>
                                <!-- Pagination END -->
                            </div>
                            <!-- Left part END -->
                            <!-- Side bar start -->
                            <div class="col-lg-4 sticky-top">
                                <aside class="side-bar sticky-top">
                                    <div class="widget">
                                        <h6 class="widget-title">Search</h6>
                                        <div class="search-bx style-1" >
                                            <form action="blog-list" method="get">
                                                <select name="choice">
                                                    <option value="0" style="color: black">Newest Post</option>
                                                    <option value="1" style="color: black">Author</option>
                                                    <option value="2" style="color: black">Most Interactive</option>
                                                </select>
                                                <div class="input-group" style="margin-top: 2%">

                                                    <input name="keyword" class="form-control" placeholder="Enter your keywords..." type="text">
                                                    <span class="input-group-btn">
                                                        <button type="submit" class="fa fa-search text-primary"></button>
                                                    </span> 
                                                </div>
                                            </form>
                                        </div>
                                    </div>



                                    <div class="widget widget_tag_cloud">
                                        <h6 class="widget-title">Tags</h6>
                                        <div class="tagcloud"> 
                                            <a href="blog-list?tag=0"> All </a>    
                                            <c:forEach items="${requestScope.listT}" var="tag">
                                                <a href="blog-list?tag=${tag.id}">${tag.name}</a> 
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="widget recent-posts-entry">
                                        <c:if test="${requestScope.listA != null}">
                                            <h6 class="widget-title">Related Blogger(s)</h6>
                                            <c:forEach items="${requestScope.listA}" var="a">
                                                <a href="blog-user?id=${a.id}" style="display: block; margin-top: 2%; margin-bottom: 2%; margin-left: 5%">
                                                    <img src="${a.avatar}" alt="alt" style="width: 60px;height: 60px; border-radius: 50%;overflow: hidden; border: 1px solid black"/> &nbsp; ${a.firstName} ${a.lastName}<br/>
                                                </a>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </aside>
                            </div>
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
                                                var itemsPerPage = 5;
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
</body>

</html>