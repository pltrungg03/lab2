<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <c:set value="${requestScope.t}" var="t"/>
            <div class="page-content bg-white">

                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a style="padding: 3px 6px; border-radius: 5px; border: 1px solid black" href="lesson-details?chId=${requestScope.chId}&lId=${requestScope.lId}"><i class="fa fa-arrow-left"></i> Back to Lesson</a></li>

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

                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${t.name}</h2>
                                                <c:if test="${t.score >= t.threshold}">
                                                    <h3>Your grade: <span style="color: #33cc00; font-style: italic">${t.score}</span></h3>
                                                    </c:if>
                                                    <c:if test="${t.score < t.threshold}">
                                                    <h3>Your grade: <span style="color: #ff0000; font-style: italic">${t.score}</span></h3>
                                                    </c:if>
                                            </div>
                                            <div class="ttr-post-text" style="border-bottom: 1px solid #999999">
                                                <p>This test contains: ${t.quizzes.size()} questions</p>
                                                <p>Pass point: ${t.threshold}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="courese-overview" id="overview">

                                        <div class="row">


                                        </div>
                                    </div>
                                    <div class="m-b30" id="curriculum" style="margin-top: 15%">

                                        <ul class="curriculum-list">
                                            <c:set var="count" value="${1}"/>
                                            <c:forEach items="${t.quizzes}" var="q">
                                                <li>
                                                    <h5>Question ${count}: ${q.question}</h5>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <input disabled type="radio" name="q${q.id}" value="${q.id}-1" style="margin-left: 5%; margin-right: 1%; font-size: 16px;  transform: scale(1.5);" ${q.selectedAnswer==1?'checked':''}/>${q.answerA} ${(q.selectedAnswer==1 && q.selectedAnswer == q.answer)?'<i class="fa fa-check" style="color: #65e641;"></i>':''} ${(q.selectedAnswer==1 && q.selectedAnswer != q.answer)?'<i class="fa fa-remove" style="color:red"></i>':''}<br/>                                                                                                                
                                                    <input disabled type="radio" name="q${q.id}" value="${q.id}-2" style="margin-left: 5%; margin-right: 1%; font-size: 16px;  transform: scale(1.5);" ${q.selectedAnswer==2?'checked':''}/>${q.answerB} ${(q.selectedAnswer==2 && q.selectedAnswer == q.answer)?'<i class="fa fa-check" style="color: #65e641;"></i>':''} ${(q.selectedAnswer==2 && q.selectedAnswer != q.answer)?'<i class="fa fa-remove" style="color:red"></i>':''}<br/>                                                     
                                                    <input disabled type="radio" name="q${q.id}" value="${q.id}-3" style="margin-left: 5%; margin-right: 1%; font-size: 16px;  transform: scale(1.5);" ${q.selectedAnswer==3?'checked':''}/>${q.answerC} ${(q.selectedAnswer==3 && q.selectedAnswer == q.answer)?'<i class="fa fa-check" style="color: #65e641;"></i>':''} ${(q.selectedAnswer==3 && q.selectedAnswer != q.answer)?'<i class="fa fa-remove" style="color:red"></i>':''}<br/>                                                      
                                                    <input disabled type="radio" name="q${q.id}" value="${q.id}-4" style="margin-left: 5%; margin-right: 1%; font-size: 16px;  transform: scale(1.5);" ${q.selectedAnswer==4?'checked':''}/>${q.answerD} ${(q.selectedAnswer==4 && q.selectedAnswer == q.answer)?'<i class="fa fa-check" style="color: #65e641;"></i>':''} ${(q.selectedAnswer==4 && q.selectedAnswer != q.answer)?'<i class="fa fa-remove" style="color:red"></i>':''}<br/>
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
