
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

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
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <!-- REVOLUTION SLIDER END -->
        <style>
            .view-certi {
                padding: 8px 13px;
                background: #990099;
                color: white;
                border-radius: 12px;
            }

            .view-certi:hover {
                padding: 8px 13px;
                background: white;
                color:  #990099;
                border-radius: 12px;
            }

            .congratulations-container {
                border: 2px solid #3498db; /* Border color */
                padding: 20px; /* Add padding for content */
                text-align: center; /* Center the content */
                border-radius: 10px; /* Rounded corners for the border */
                background-color: #f2f2f2; /* Background color */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Box shadow for a subtle 3D effect */
            }

            /* Style for the text */
            .congratulations-text {
                font-size: 18px;
                color: #333;
                font-weight: bold;
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
            <c:set value="${requestScope.c}" var="c"/>
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(https://darvideo.tv/wp-content/uploads/2021/05/E-learning-animation-video.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Curriculum</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li><a href="course-details?id=${c.id}">Course Details</a></li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row d-flex flex-row-reverse">

                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">

                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <c:if test="${c.isPassed == true}">
                                            <div class="congratulations-container">
                                                <h2 style="font-style: italic;">Congratulations On Completing Your course! 🎓</h2>
                                                <p>You've reached a significant milestone in your learning journey, and we couldn't be prouder of your dedication and hard work. Your commitment to learning and self-improvement is truly commendable.</p>
                                                <p>We are honored to receive your trust. Below is your certificate. We wish you success with the knowledge and efforts you have achieved!</p>
                                                <form action="certificate" method="get">
                                                    <input type="hidden" name="cId" value="${c.id}"/>
                                                    <input type="hidden" name="accId" value="${sessionScope.user.id}">
                                                    <button class="view-certi" id="openNewTabButton">View your Certificate 🏅</button>
                                                </form>
                                            </div>
                                        </c:if>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${c.name}</h2>
                                            </div>
                                            <div class="ttr-post-text">
                                                <p>${c.description}</p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="courese-overview" id="overview">
                                        <c:set value="${0}" var="countDone"/>
                                        <c:forEach items="${c.chapters}" var="item">
                                            <c:if test="${item.isPassed == true}">
                                                <c:set value="${countDone + 1}" var="countDone"/>
                                            </c:if>
                                        </c:forEach>
                                        <h4>Overview</h4>
                                        <h5><i class="fa fa-bar-chart-o"></i> Progress:</h5>
                                        <div class="progress" style="margin-top: 3%; margin-bottom: 3%;">
                                            <div class="progress-bar" role="progressbar" aria-valuenow="${countDone*100/c.chapters.size()}" aria-valuemin="0" aria-valuemax="100" style="width:${countDone*100/c.chapters.size()}%; background: #00cc00;">

                                                ${fn:substring(countDone*100/c.chapters.size(), 0, 5)}%
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-4">
                                                <ul class="course-features">
                                                    <c:set var="numTest" value="${0}"/>
                                                    <c:forEach items="${c.chapters}" var="list1">
                                                        <c:forEach items="${list1.lessons}" var="list2">
                                                            <c:if test="${list2.test != null}">
                                                                <c:set var="testNum" value="${testNum + 1}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:forEach>
                                                    <li><i class="ti-book"></i> <span class="label">Chapters</span> <span class="value">${c.chapters.size()}</span></li>
                                                    <li><i class="ti-help-alt"></i> <span class="label">Tests</span> <span class="value">${testNum}</span></li>
                                                    <li><i class="ti-stats-up"></i> <span class="label">Level</span> <span class="value">${c.level.name}</span></li>

                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <img src="${c.image}" alt="alt" style="max-width: 510px;"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="m-b30" id="curriculum">
                                        <h4>${c.isPassed == true?'<i class="fa fa-bookmark" style="color: #2bcb20;"></i>':'<i class="fa fa-bookmark" style="color: #3ca0ec;"></i>'}Curriculum</h4>

                                        <ul class="curriculum-list">
                                            <c:forEach  items="${c.chapters}" var="ch">
                                                <li>
                                                    <h5>${ch.isPassed==true?'<i class="fa fa-check fa-2x" style="color: #2dcf2a;"></i>':'<i class="fa fa-pencil-square-o fa-2x" style="color: #2597d0;"></i>'}Chapter ${ch.order}. ${ch.name}</h5>
                                                    <ul>
                                                        <c:forEach items="${ch.lessons}" var="l">
                                                            <li>
                                                                <div class="curriculum-list-box">
                                                                    <span>${l.isPassed==true?'<i class="fa fa-check fa-x" style="color: #2dcf2a;"></i>':'<i class="fa fa-pencil-square-o fa-x" style="color: #2597d0;"></i>'}<a href="lesson-details?chId=${ch.id}&lId=${l.id}">Lesson ${l.order}. ${l.name}</a></span> 
                                                                    <br/>
                                                                    <c:if test="${l.test != null}">
                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" style="color: #2597d0;"></i> ${l.test.name}</span>
                                                                    </c:if>
                                                                </div>

                                                            </li>
                                                        </c:forEach>

                                                    </ul>
                                                </li>
                                            </c:forEach>


                                        </ul>
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
        <script src="assets/js/jquery.scroller.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src="assets/vendors/switcher/switcher.js"></script>
    
    </body>
</html>
