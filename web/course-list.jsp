<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- Header Top END ==== -->

            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Our Courses</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Our Courses</li>
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
                                <form class="col-lg-3 col-md-4 col-sm-12 m-b30" action="course-list" method="get" id="form">
                                    <div class="widget courses-search-bx placeani">
                                        <h5 class="widget-title style-1">Search By Name</h5>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <input name="keyword" type="text" class="form-control" value="${searchedKeyword}" placeholder="Enter keyword">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">Sort</h5>
                                        <a class="dropdown-item" onclick="updateSort(1)" style="cursor: pointer;">Name A-Z</a>
                                        <a class="dropdown-item" onclick="updateSort(2)" style="cursor: pointer;">Name Z-A</a>
                                        <a class="dropdown-item" onclick="updateSort(3)" style="cursor: pointer;">Price Low-High</a>
                                        <a class="dropdown-item" onclick="updateSort(4)" style="cursor: pointer;">Price High-Low</a>
                                        <a class="dropdown-item" onclick="updateSort(5)" style="cursor: pointer;">Release Date</a>
                                        <a class="dropdown-item" onclick="updateSort(6)" style="cursor: pointer;">Popularity</a>
                                    </div>
                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">All Majors</h5>
                                        <c:forEach items="${requestScope.majors}" var="m">
                                            <br/>
                                            <c:set var="isChecked" value="false" />
                                            <c:forEach items="${requestScope.selectedMajorIds}" var="selectedId">
                                                <c:if test="${m.id == selectedId}">
                                                    <c:set var="isChecked" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <input type="checkbox" name="majors" value="${m.id}" ${isChecked == 'true' ? 'checked' : ''}> ${m.name}
                                        </c:forEach>
                                    </div>
                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">All Levels</h5>
                                        <c:forEach items="${requestScope.levels}" var="l">
                                            <br/>
                                            <c:set var="isChecked" value="false" />
                                            <c:forEach items="${requestScope.selectedLevelIds}" var="selectedId">
                                                <c:if test="${l.id == selectedId}">
                                                    <c:set var="isChecked" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <input type="checkbox" name="levels" value="${l.id}" ${isChecked == 'true' ? 'checked' : ''}> ${l.name}
                                        </c:forEach>
                                    </div>
                                    <input class="btn" type="submit" value="Filter"/>
                                    <input class="btn" type="button" value="Clear" onclick="clearFilter()"/>
                                </form>
                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="row" id="content">
                                        <c:if test="${requestScope.courses.size() == 0}">
                                            <h3>There's no course ( ͡❛ ͜ʖ ͡❛)</h3>
                                        </c:if>

                                        <c:if test="${requestScope.courses.size() > 0}">
                                            <c:forEach items="${requestScope.courses}" var="c">
                                                <div class="col-md-6 col-lg-4 col-sm-6 m-b30">
                                                    <div class="cours-bx">
                                                        <div class="action-box">
                                                            <img src="${c.image}" alt="http://res.cloudinary.com/d3/image/upload/c_scale,q_auto:good,w_1110/trianglify-v1-cs85g_cc5d2i.jpg">
                                                            <a onclick="enrollMe(${c.id}, ${c.price})" class="btn">Enroll Me</a>
                                                        </div>
                                                        <div class="info-bx text-center">
                                                            <h5><a href="course-details?id=${c.id}">${c.name}</a></h5>
                                                            <span>${c.creator.firstName} ${c.creator.lastName}</span>
                                                        </div>
                                                        <div class="cours-more-info">
                                                            <div class="review">
                                                                <span>${c.studentNumber} student(s)</span>
                                                                <ul class="cours-star">
                                                                    <span>${c.avgRating}</span>
                                                                    <li class="active"><i class="fa fa-star"></i></li>
                                                                </ul>
                                                            </div>
                                                            <div class="price">
                                                                <del>$${c.price}</del>
                                                                <h5>$${c.price - c.price * c.discount}</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${requestScope.canLoadMore == true}">
                                            <div class="col-lg-12 m-b20" style="cursor: pointer;">
                                                <div class="pagination-bx rounded-sm gray clearfix">
                                                    <ul class="pagination">
                                                        <li>
                                                            <a onclick="updatePage(${requestScope.page})">Load More <i class="ti-arrow-down"></i></a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>

        <script>
                                                                function enrollMe(courseId, coursePrice) {
            <c:if test="${sessionScope.user == null}">
                                                                    if (window.confirm('You need login to enroll a course!'))
                                                                        window.open('http://localhost:9999/SE1735_G5/login.jsp', '_blank');
            </c:if>

            <c:if test="${sessionScope.user != null}">

                                                                    $.ajax({
                                                                        url: "/SE1735_G5/course-register",
                                                                        type: "post",
                                                                        data: {
                                                                            courseId: courseId
                                                                        },
                                                                        success: function (data) {
                                                                            alert(data);
                                                                        },
                                                                        error: function (xhr) {
                                                                            //handle error
                                                                        }
                                                                    });

            </c:if>

                                                                }
        </script>                                                        
        <script>

            var url = window.location.href;
            var currentPage = ${requestScope.page};
            window.addEventListener('load', function () {
                console.log('URL:', window.location.href);
            });
            function clearFilter()
            {
                var form = document.getElementById('form');
                var checkboxFields = form.querySelectorAll('input[type="checkbox"]');
                for (var i = 0; i < checkboxFields.length; i++)
                {
                    checkboxFields[i].checked = false;
                }

                var keywordInput = form.querySelector('input[name="keyword"]');
                keywordInput.value = '';

                currentPage = 1;
            }
            function updateContent(url)
            {
                $.ajax({
                    url: url,
                    type: 'POST',
                    success: function (responseText)
                    {
                        console.log(url);
                        document.getElementById("content").innerHTML = responseText;
                    }
                });
            }
            function updateSort(sort)
            {
                //                let url = window.location.href;
                url = url.replace(/([&?])sort=[^&]+/, '$1');

                if (url.includes('?'))
                    url += '&sort=' + sort;
                else
                    url += '?sort=' + sort;

                currentPage = 1;
                url = url.replace(/&{2,}/g, '&');
                //                window.location.href = url;
                updateContent(url);
            }
            function updatePage(page) //with ajax
            {
                currentPage++;
                //                let url = window.location.href;
                url = url.replace(/([&?])page=[^&]+/, '$1');

                if (url.includes('?'))
                    url += '&page=' + currentPage;
                else
                    url += '?page=' + currentPage;

                updateContent(url.replace(/&{2,}/g, '&'));
            }
        </script>
    </body>

</html>
