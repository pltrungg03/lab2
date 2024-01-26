<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />
        <title>Byte Scholar</title>


        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="./admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="./admin/assets/css/color/color-1.css">
        <style>
            .widget-card{
                min-height: 150px;
            }
            
            #myChart1{
                min-height: 700px;
                width: 100%;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <%@include file="admin-header.jsp" %>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <%@include file="sidebar.jsp" %>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Dashboard</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Dashboard</li>
                    </ul>
                </div>	
                <!-- Card -->
                <div class="row">
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg1">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Profit this Year
                                </h4>
                                <span class="wc-des">
                                    Value in: ${requestScope.cYear}: $${requestScope.cTotal} - ${requestScope.lYear}: $${requestScope.lTotal}
                                </span>
                                <span class="wc-stats">
                                    $<span class="counter">${requestScope.cTotal}</span>
                                </span>		
                                <div class="progress wc-progress">
                                    <c:set value="${(cTotal / lTotal) * 100 }" var="tPercent"/>
                                    <div class="progress-bar" role="progressbar" style="width: ${tPercent}%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">
                                        <c:if test="${tPercent >= 100}">
                                            Increase
                                        </c:if>
                                        <c:if test="${tPercent < 100}">
                                            Decrease
                                        </c:if>
                                    </span>
                                    <span class="wc-number ml-auto">
                                        ${tPercent}%
                                    </span>
                                </span>
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg2">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Numbers of course be Purchased this Year
                                </h4>
                                <span class="wc-des">
                                    Be Purchased in ${requestScope.cYear}
                                </span>
                                <span class="wc-stats counter">
                                    ${requestScope.nCourse}
                                </span>		


                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg3">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Average Rating: ${requestScope.rating} / 5⭐ 
                                </h4>
                                <span class="wc-des">
                                    Evaluate the overall quality of courses 
                                </span>

                                <div class="progress wc-progress">
                                    <div class="progress-bar" role="progressbar" style="width: ${requestScope.rating * 100 /5}%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">
                                        Quality:
                                    </span>
                                    <span class="wc-number ml-auto">
                                        ${requestScope.rating * 100 /5}%
                                    </span>
                                </span>
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg4">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    New Users 
                                </h4>
                                <span class="wc-des">
                                    Joined New User
                                </span>
                                <span class="wc-stats counter">
                                    ${requestScope.nUser}
                                </span>		


                            </div>				      
                        </div>
                    </div>
                </div>
                <!-- Card END -->
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-8 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Revenue in the last 5 months</h4>
                            </div>
                            <div class="widget-inner">
                                <canvas id="myChart4" width="100" height="45"></canvas>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                    <div class="col-lg-4 m-b30">
                        <div class="widget-box">
                         
                        </div>
                    </div>
                    <div class="col-lg-6 m-b30">
                        <h4>Top 5 seller Courses:</h4>
                        <canvas id="myChart1"></canvas>
                    </div>
                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">

                            </div>
                            <div class="widget-inner">
                                 <h4>Ratio of Majors (%)</h4>
                                <canvas id="myChart6"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                               
                            </div>
                            <div class="widget-inner">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
                                    <c:set var="numCourse" value="${0}"/>
                                    <c:forEach items="${requestScope.map4}" var="nb">
                                        <c:set var="numCourse" value="${numCourse + nb.value}"/>
                                    </c:forEach>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="./admin/assets/js/jquery.min.js"></script>
        <script src="./admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="./admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="./admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="./admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="./admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="./admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="./admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="./admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="./admin/assets/vendors/masonry/masonry.js"></script>
        <script src="./admin/assets/vendors/masonry/filter.js"></script>
        <script src="./admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='./admin/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="./admin/assets/js/functions.js"></script>

        <script src="./admin/assets/js/admin.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const ctx4 = document.getElementById('myChart4');
            new Chart(ctx4, {
            type: 'line',
                    data: {
                    labels: [
            <c:forEach items="${map}" var="c4">
                    "${c4.key}",
            </c:forEach>
                    ],
                            datasets: [{
                            label: '#$ of Revanue',
                                    data: [    <c:forEach items="${map}" var="c4">
                                    "${c4.value}",
            </c:forEach>],
                                    backgroundColor: '#34ebab',
                                    borderWidth: 15
                            }]
                    },
                    options: {
                    scales: {
                    y: {
                    beginAtZero: true
                    }
                    }
                    }
            });
            const ctx = document.getElementById('myChart1');
            new Chart(ctx, {
            type: 'bar',
                    data: {
                    labels: [
            <c:forEach items="${map2}" var="c1">
                    "${c1.key}",
            </c:forEach>
                    ],
                            datasets: [{
                            label: '# of Sell',
                                    data: [    <c:forEach items="${map2}" var="c1">
                                    "${c1.value}",
            </c:forEach>],
                                    backgroundColor: '#36A2EB',
                                    borderWidth: 1
                            }]
                    },
                    options: {
                    scales: {
                    y: {
                    beginAtZero: true
                    }
                    }
                    }
            });
            
            const ctx6 = document.getElementById('myChart6');
            new Chart(ctx6, {
            type: 'pie',
                    data: {
                    labels: [
            <c:forEach items="${map4}" var="c6">
                    "${c6.key}",
            </c:forEach>
                    ],
                            datasets: [{
                            label: '% of Majors',
                                    data: [    <c:forEach items="${map4}" var="c6">
                                    "${c6.value / numCourse * 100}",
            </c:forEach>],
                                    borderWidth: 1
                            }]
                    },
                    options: {
                    scales: {
                    y: {
                    beginAtZero: true
                    }
                    }
                    }
            });
        </script>
    </body>

</html>