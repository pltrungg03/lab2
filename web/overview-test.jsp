

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
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- header END ==== -->
            <!-- Content -->
            <c:set value="${requestScope.chap}" var="ch"/>
            <c:set value="${requestScope.lesson}" var="l"/>
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(https://www.shutterstock.com/shutterstock/photos/2182453181/display_1500/stock-photo-a-gray-cat-works-on-a-laptop-looks-at-the-monitor-paws-on-the-keyboard-next-to-a-credit-card-and-2182453181.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Lesson Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li>Curriculum</li>
                            <li>Chapter ${ch.order}</li>
                            <li><button id="backButton" style="border: none; background: none; font-size: larger">Back</button></li>
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


                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-media media-effect">

                                        </div>
                                        <div class="ttr-post-info">

                                        </div>
                                    </div>
                                    <div class="courese-overview" id="overview">

                                        <div class="row">
                                            <div class="col-md-12 col-lg-4">
                                                <h4>${ch.isPassed==true?'<i class="fa fa-check fa-2x" style="color: #2dcf2a;"></i>':'<i class="fa fa-pencil-square-o fa-2x" style="color: #2597d0;"></i>'}Chapter ${ch.order}. ${ch.name}</h4>
                                                <ul class="course-features">
                                                    <c:forEach items="${ch.lessons}" var="i">
                                                        <li>${i.isPassed==true?'<i class="fa fa-check" style="color: #2dcf2a;"></i>':'<i class="fa fa-pencil-square-o" style="color: #2597d0;"></i>'}<a href="lesson-details?chId=${ch.id}&lId=${i.id}">${i.order}. ${i.name}</a></li>
                                                            <c:if test="${i.test != null}">
                                                            <li><i class="fa fa-question-circle" style="color: #2597d0;"></i><a href="overview-test?lId=${l.id}">${i.test.name}</a></li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Lession ${l.order}. ${l.name}</h5>

                                                <iframe width="800" height="450"  src="${l.videoUrl}" 
                                                        title="YouTube video player" frameborder="0"
                                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; 
                                                        picture-in-picture; web-share" allowfullscreen>

                                                </iframe>
                                                <h5 class="m-b5">Lesson Content </h5>
                                                <p>${l.content}</p>
                                                <form action="join-lesson" method="post" onsubmit="return confirmSubmit()">
                                                    <input type="hidden" value="${sessionScope.user.id}" name="accId"/>
                                                    <input type="hidden" value="${l.id}" name="lId"/>
                                                    <input type="hidden" value="${ch.id}" name="chId"/>
                                                    <button style="padding: 8px;border-radius: 8px; background: #660066; color: white">Mark as Completed</button>
                                                </form>

                                                <form action="join-lession" method="get" style="margin-top: 15%">
                                                    <button style="padding: 6px;border-radius: 8px; background: #660066; color: white; width: 80px;"><i class="fa fa-arrow-left"></i></button>
                                                    <button style="padding: 6px;border-radius: 8px; background: #660066; color: white; width: 80px"><i class="fa fa-arrow-right"></i></button>

                                                </form>
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
        <script>
                                                    document.getElementById('backButton').addEventListener('click', function () {
                                                        window.history.go(-1); // This goes back one step in the history
                                                    });

        </script>

        <script>
            function confirmSubmit() {
                var confirmed = confirm("Make sure you actually complete this lesson!");

                if (!confirmed) {
                    return false; // Prevent form submission
                }

                // Form is confirmed, continue with submission
                return true;
            }
        </script>
    </body>
</html>
