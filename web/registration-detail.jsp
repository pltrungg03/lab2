<%-- 
    Document   : registration-detail
    Created on : Oct 6, 2023, 11:09:56 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <meta name="description" content="Byte Scholar" />

        <!-- OG -->
        <meta property="og:title" content="Byte Scholar" />
        <meta property="og:description" content="Byte Scholar" />
        <meta property="og:image" content="" />

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Byte SCholar </title>

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
    <body id="bg">
        <%@include file="/admin/admin-header.jsp" %>
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->

            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->

                <!-- Breadcrumb row -->



                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->

                    <div class="section-area section-sp1">
                        <div class="container">
                            <ul class="list-inline">
                                <li><a href="registration-list" style="color: blue; font-size: 20px" >Registration List</a></li>
                                <li>-> Registration Details</li>
                            </ul>
                            <div class="row d-flex flex-row-reverse">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="course-detail-bx">
                                        <div class="course-price">
                                            <span>Discount: ${course.discount}%</span> <br/>
                                            <c:if test="${course.discount == 0}">
                                                <span style="padding-left: 2px">Price: ${course.price}$</span>
                                            </c:if>
                                            <c:if test="${course.discount != 0}">
                                                <del> ${course.price}$</del>  <span style="padding-left: 2px">Price: ${course.price - course.price*course.discount/100}$</span>
                                            </c:if>
                                        </div>	
                                        <div class="teacher-bx">
                                            <div class="teacher-info">
                                                <div class="teacher-thumb">
                                                    <img src="${course.creator.avatar}" alt=""/>
                                                </div>
                                                <div class="teacher-name">
                                                    <h5>${course.creator.firstName}${course.creator.lastName}</h5>
                                                    <span>Science Teacher</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cours-more-info">
                                            <div class="review">
                                                <span>Rating: ${course.avgRating}/5⭐</span>                                              
                                                <span>Level</span>
                                                <h5 class="text-primary" style="font: 12px">${course.level.name}</h5>
                                            </div>
                                            <div class="price categories">
                                                <span>Major</span>
                                                <h5 class="text-primary">${course.major.name}</h5>
                                            </div>
                                        </div>
                                        <div class="course-info-list scroll-page">
                                            <ul class="navbar">
                                                <li><a class="nav-link" href="#overview"><i class="ti-zip"></i>Overview</a></li>
                                                <li><a class="nav-link" href="#curriculum"><i class="ti-bookmark-alt"></i>Curriculum</a></li>
                                                <li><a class="nav-link" href="#instructor"><i class="ti-user"></i>Instructor</a></li>
                                                <li><a class="nav-link" href="#student"><i class="ti-user"></i>Student</a></li>
                                                <li><a class="nav-link" href="#reviews"><i class="ti-comments"></i>Reviews</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-media media-effect">
                                            <a href="#"><img src="${course.image}" alt=""></a>
                                        </div>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${course.name}</h2>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="courese-overview" id="overview">
                                        <h4>Overview</h4>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-4">
                                                <ul class="course-features">
                                                    <li><i class="ti-book"></i> <span class="label">Lectures</span> <span class="value">${course.creator.firstName}${course.creator.lastName}</span></li>
                                                    <li><i class="ti-help-alt"></i> <span class="label">Chapter</span> <span class="value">${n}</span></li>
                                                    <li><i class="ti-time"></i> <span class="label">Major</span> <span class="value">${course.major.name}</span></li>
                                                    <li><i class="ti-stats-up"></i> <span class="label">Skill level</span> <span class="value">${course.level.name}</span></li>
                                                        <c:forEach items="${course.students}" var="o">
                                                        <li><i class="ti-user"></i> <span class="label">Students</span> <span class="value">${o.firstName} ${o.lastName}</span></li>

                                                    </c:forEach>
                                                    <li><i class="ti-smallcap"></i> <span class="label">Language</span> <span class="value">English</span></li>
                                                    <li><i class="ti-check-box"></i> <span class="label">Created Date</span> <span class="value">${course.createdDate}</span></li>                                                   
                                                    <li><i class="ti-check-box"></i> <span class="label">Updated Date</span> <span class="value" style="font: 10px">${course.updateDate}</span></li>

                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Course Description</h5>
                                                <p>${course.description}</p>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-b30" id="curriculum">
                                        <h4>Curriculum</h4>


                                        <h5>Total: ${n} Chapters</h5>
                                        <c:forEach items="${course.chapters}" var="o" >
                                            <ul class="curriculum-list">
                                                <li>

                                                    <ul>

                                                        <li>

                                                            <div class="curriculum-list-box">

                                                                <span>Chapter: ${o.order} </span>${o.name}
                                                            </div>

                                                        </li>


                                                    </ul>
                                                </li>


                                            </ul>

                                        </c:forEach>
                                    </div>
                                    <div class="" id="instructor">
                                        <h4>Instructor</h4>
                                        <div class="instructor-bx">
                                            <div class="instructor-author">
                                                <img src="${course.creator.avatar}" alt="">
                                            </div>
                                            <div class="instructor-info">
                                                <h6>${course.creator.firstName}&nbsp;${course.creator.lastName} </h6>
                                                <span>Professor</span>
                                                <h6 class="">Email: ${course.creator.email}</h6>
                                                <h6 class="">Date of birth: ${course.creator.dob}</h6>
                                                <h6 class="">Country: ${course.creator.country}</h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="" id="student">
                                        <h4>Student</h4>
                                        <div class="instructor-bx">
                                            <c:forEach items="${course.students}" var="o">
                                                <div class="instructor-author">
                                                    <img src="${o.avatar}" alt="">
                                                </div>
                                                <div class="instructor-info">

                                                    <h5>${o.firstName}&nbsp;${o.lastName} </h5>

                                                    <h6 class="text-primary">Email: ${o.email}</h6>
                                                    <h6 class="text-primary">Date of birth: ${o.dob}</h6>
                                                    <h6 class="">Country: ${o.country}</h6>
                                                    <h6 class="">JoinDate: ${course.joinedDate}</h6>
                                                    <h6 class="">Status: ${course.isPassed ? 'Passed': 'OnGoing'}</h6>
                                                </div>
                                            </c:forEach>
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
            <!-- Footer ==== -->

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
        <script src="assets/js/jquery.scroller.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src="assets/vendors/switcher/switcher.js"></script>
    </body>

</html>

