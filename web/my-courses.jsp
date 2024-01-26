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
                        <h1 class="text-white">Profile</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="breadcrumb-row">
                <div class="container">
                    <ul class="list-inline">
                        <li><a href="#">Home</a></li>
                        <li>Profile</li>
                    </ul>
                </div>
            </div>
            <!-- Breadcrumb row END -->
            <!-- inner page banner END -->
            <div class="content-block">
                <!-- About Us -->
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                <div class="profile-bx">
                                    <div class="user-profile-thumb">
                                        <img src="${sessionScope.user.avatar}" id="avatar"/>
                                    </div>
                                    <div class="profile-info text-center">
                                        <h4>${sessionScope.user.firstName}${sessionScope.user.lastName}</h4>
                                        <span>${sessionScope.user.email}</span>
                                    </div>
                                    
                                    <div class="profile-tabnav text-center">
                                        <ul class="nav nav-tabs">
                                            <li class="nav-item">
                                                <a class="nav-link active"  href="#courses"><i class="ti-book"></i>Courses</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="profile"><i class="ti-pencil-alt"></i>Profile</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="border-bottom text-primary" >
                                        <form action="my-courses" method="post">
                                            <h3 class="border-bottom border-top text-center" style="margin:10px 0px; padding:10px 0px;">Major</h3> 
                                            <c:forEach items="${listM}" var="o">
                                                &nbsp;
                                                <input class="filter-button"
                                                       <c:forEach items="${major}" var="check">
                                                           <c:if test="${check == o.id}">checked</c:if>
                                                       </c:forEach>
                                                       type="checkbox" value="${o.id}" id="${o.name}" name="major">
                                                <label for="${o.name}">${o.name}</label><br/>

                                            </c:forEach>



                                            <h3 class="border-bottom border-top text-center" style="margin:10px 0px; padding:10px 0px;">Level</h3> 
                                            <c:forEach items="${listL}" var="o">
                                                &nbsp;
                                                <input class="filter-button"
                                                       <c:forEach items="${level}" var="check">
                                                           <c:if test="${check == o.id}">checked</c:if>
                                                       </c:forEach>
                                                       type="checkbox" value="${o.id}" id="${o.name}" name="level">
                                                <label for="${o.name}">${o.name}</label><br/>
                                            </c:forEach>

                                            <h3 class="border-bottom border-top text-center" style="margin:10px 0px; padding:10px 0px;">Search</h3> 
                                            <input style="width: 100%" id="search-my-courses" class="filter-button" type="text" name="searchMyCourse" value="${searchMyCourse}">
                                            <h3 class="border-bottom border-top text-center" style="margin:10px 0px; padding:10px 0px;">Sort by</h3> 
                                            &nbsp;<input class="filter-button" type="radio" <c:if test="${op eq 'name asc'}">checked</c:if> value="name asc" id="op1" name="op"/>
                                                <label for = "op1" > A to Z </label> <br/>
                                                &nbsp;<input class="filter-button" type="radio" <c:if test="${op eq 'name desc'}">checked</c:if> value="name desc" id="op2" name="op"/>
                                                <label  for = "op2" > Z to A </label> <br/>
                                                &nbsp;<input class="filter-button" type="radio" <c:if test="${op eq 'price asc'}">checked</c:if> value="price asc" id="op3" name="op"/>
                                                <label for = "op3" > Min to Max </label> <br/>
                                                &nbsp;<input class="filter-button" type="radio" <c:if test="${op eq 'price desc'}">checked</c:if> value="price desc" id="op4" name="op"/>
                                                <label for = "op4" > Max to Min </label> <br/>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--                                                <input style="
                                                       background: black;
                                                       color: white;
                                                       border-radius: 10px;
                                                       height: 30px;
                                                       width: 125px;
                                                       justify-content: center;
                                                       margin: 10px 0px;
                                                       " type="submit" value="filter">-->
                                            </form>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12 m-b30">
                                    <div class="profile-content-bx">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="courses">
                                                <div class="profile-head">
                                                    <h3>My Courses</h3>

                                                </div>
                                                <div class="courses-filter">
                                                    <div class="clearfix">
                                                        <ul id="masonry" class="ttr-gallery-listing magnific-image row" style="list-style: none">

                                                        <c:forEach items="${listC}" var="o">
                                                            <li class="action-card col-xl-4 col-lg-6 col-md-12 col-sm-6 ${o.isPassed?'done':'onGoing'}">
                                                                <div class="cours-bx">
                                                                    <div class="action-box">
                                                                        <img src="${o.image}" alt="">
                                                                        <a href="course-details?id=${o.id}" class="btn">Read More</a>
                                                                    </div>
                                                                    <div class="info-bx text-center">
                                                                        <h5><a href="course-details?id=${o.id}">${o.name}</a></h5>
                                                                        <span>${o.major.name}</span>
                                                                    </div>
                                                                    <div class="cours-more-info">
                                                                        <div class="review">
                                                                            <span>Level</span>
                                                                            <ul class="cours-star">
                                                                                <h5>${o.level.name}</h5>
                                                                            </ul>
                                                                        </div>  
                                                                        <div class="price">
                                                                            <h5>${o.price}</h5>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- contact area END -->
        </div>
        <!-- Content END-->

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
            $('.filter-button').on('click input', function () {
                var major = '';
                $('input[name="major"]:checked').each(function () {
                    console.log(this.value);
                    major += this.value + ',';
                });
                console.log(major.substring(0, major.length - 1));

                major = major.substring(0, major.length - 1);

                var level = '';
                $('input[name="level"]:checked').each(function () {
                    console.log(this.value);
                    level += this.value + ',';
                });
                console.log(level.substring(0, level.length - 1));

                level = level.substring(0, level.length - 1);

                var search = $('#search-my-courses').val();
                console.log(search);

                var sort = $('input[name="op"]:checked').val();



                if (sort === undefined) {
                    sort = null;
                }
                console.log(sort);
                $.ajax({
                    url: "/SE1735_G5/my-courses",
                    type: "post",
                    data: {
                        major: major,
                        level: level,
                        searchMyCourse: search,
                        op: sort
                    },
                    success: function (data) {
                        var out = document.getElementById('masonry');
                        out.innerHTML = data;

                    },
                    error: function (xhr) {
                        //handle error
                    }
                });

            });
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
