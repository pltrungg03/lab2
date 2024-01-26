<%@ page import="model.JoinCourse" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Account" %>
<%@ page import="model.Course" %><%--
    Document   : course-details
    Created on : Sep 26, 2023, 1:22:48 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <meta name="description" content="Byte Scholar"/>

        <!-- OG -->
        <meta property="og:title" content="Byte Scholar"/>
        <meta property="og:description" content="Byte Scholar"/>
        <meta property="og:image" content=""/>

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon"/>
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png"/>

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
        <style>
            .blog-entry {
                position: relative;

                padding: 10px;
            }

            .blog-header {
                position: absolute;
                top: 0;
                right: 0;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 9999;
            }

            .edit-form {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
            }

            .edit-button {
                position: relative;
                z-index: 1;

            }
            #rating {
                border: none;
                float: left;
            }

            #rating > input {
                display: none;
            }

            /*ẩn input radio - vì chúng ta đã có label là GUI*/
            #rating > label:before {
                margin: 5px;
                font-size: 1.25em;
                font-family: FontAwesome;
                display: inline-block;
                content: "\f005";
            }

            /*1 ngôi sao*/
            #rating > .half:before {
                content: "\f089";
                position: absolute;
            }

            /*0.5 ngôi sao*/
            #rating > label {
                color: #ddd;
                float: right;
            }

            /*float:right để lật ngược các ngôi sao lại đúng theo thứ tự trong thực tế*/
            /*thêm màu cho sao đã chọn và các ngôi sao phía trước*/
            #rating > input:checked ~ label,
            #rating:not(:checked) > label:hover,
            #rating:not(:checked) > label:hover ~ label {
                color: #FFD700;
            }

            /* Hover vào các sao phía trước ngôi sao đã chọn*/
            #rating > input:checked + label:hover,
            #rating > input:checked ~ label:hover,
            #rating > label:hover ~ input:checked ~ label,
            #rating > input:checked ~ label:hover ~ label {
                color: #FFED85;
            }
        </style>
    </head>
    <body>
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- Header Top END ==== -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/onlinecoursebackground.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Courses Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Courses Details</li>
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
                                    <div class="course-detail-bx">
                                        <c:if test="${!checkJoinCourse}">
                                            <div class="course-price">
                                                <h4 class="price">${data.price}$</h4>
                                            </div>
                                        </c:if>

                                        <div class="course-buy-now text-center">
                                            <c:if test="${checkJoinCourse}">
                                                <a id="#" href="overview-curriculum?id=${data.id}" class="btn radius-xl text-uppercase">Join course</a> 

                                            </c:if>
                                            <c:if test="${!checkJoinCourse}">
                                                <a id="enrollCourse" class="btn radius-xl text-uppercase">Enroll Course</a> 

                                            </c:if>
                                        </div>
                                        <div class="teacher-bx">
                                            <div class="teacher-info">
                                                <div class="teacher-thumb">
                                                    <img src="${data.creator.avatar}" alt=""/>

                                                </div>
                                                <div class="teacher-name">
                                                    <%Account user = (Account) session.getAttribute("user");
                                                    Account creator = ((Course)request.getAttribute("data")).getCreator();
                                                    if(user != null && user.getId() == creator.getId()){
                                                    %>
                                                    <a href="profile"><h5>${data.creator.firstName} ${data.creator.lastName}</h5></a>
                                                    <%}
                                            else{%>
                                                    <a href="view-creator?id=${data.creator.id}"><h5>${data.creator.firstName} ${data.creator.lastName}</h5></a>
                                                    <%}%>
                                                    <span>Creator</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cours-more-info">
                                            <div class="review">
                                                <span>Rate: ${data.avgRating}/5⭐ </span>

                                            </div>
                                            <div class="price categories">
                                                <span>Major</span>
                                                <h5>${data.major.name}</h5>
                                            </div>
                                        </div>
                                        <div class="course-info-list scroll-page">
                                            <ul class="navbar">
                                                <li><a class="nav-link" href="#overview"><i class="ti-zip"></i>Overview</a></li>
                                                <li><a class="nav-link" href="#curriculum"><i class="ti-comments"></i>Curriculum</a>
                                                </li>
                                                <li><a class="nav-link" href="#instructor"><i class="ti-user"></i>Instructor</a>
                                                </li>
                                                <li><a class="nav-link" href="#reviews"><i class="ti-comments"></i>Reviews</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="carousel-item active">
                                            <img class="w-100 h-100" src="${data.image}">
                                        </div>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${data.name}</h2>
                                            </div>
                                        </div>
                                        <div class="course-buy-now text-center">
                                        </div>
                                    </div>
                                    <div class="courese-overview" id="overview">
                                        <h4>Overview</h4>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-4">
                                                <ul class="course-features">
                                                    <li><i class="ti-book"></i> <span class="label">Chapters </span> <span
                                                            class="value">${chapterList.size()}</span></li>
                                                    <li><i class="ti-stats-up"></i> <span class="label">Level </span> <span
                                                            class="value">${data.level.name}</span></li>
                                                    <li><i class="ti-smallcap"></i> <span class="label">Language</span> <span
                                                            class="value">English</span></li>
                                                    <li><i class="ti-user"></i> <span class="label">Students</span> <span
                                                            class="value">${stu}</span></li>

                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Course Description</h5>
                                                <p>${data.description}</p>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="" id="instructor">
                                        <div class="m-b30" id="curriculum">
                                            <h4>Curriculum</h4>
                                            <ul class="curriculum-list">
                                                <c:forEach items="${chapterList}" var="chapter" varStatus="loop">
                                                    <ul class="list-group">

                                                        <li class="list-group-item">
                                                            <h5>
                                                                <span>Chapter ${loop.index + 1} .</span>    ${chapter.name}
                                                            </h5>
                                                        </li>                                                       
                                                    </ul>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <h4>Instructor</h4>
                                        <div class="instructor-bx">
                                            <div class="instructor-author">
                                                <img src="${data.creator.avatar}" alt="">
                                            </div>
                                            <div class="instructor-info">
                                                <h6>${data.creator.firstName} ${data.creator.lastName}</h6>
                                                <ul class="list-inline m-tb10">
                                                    <li><a href="#" class="btn sharp-sm facebook"><i class="fa fa-facebook"></i></a>
                                                    </li>
                                                    <li><a href="#" class="btn sharp-sm twitter"><i
                                                                class="fa fa-twitter"></i></a></li>
                                                    <li><a href="#" class="btn sharp-sm linkedin"><i class="fa fa-linkedin"></i></a>
                                                    </li>
                                                    <li><a href="#" class="btn sharp-sm google-plus"><i
                                                                class="fa fa-google-plus"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="" id="reviews">
                                        <h4>Reviews</h4>

                                        <div class="review-bx">
                                            <div class="all-review d-flex flex-column align-items-center">
                                                <form method="post" action="course-details">
                                                    <div id="rating">
                                                        <input type="radio" id="star5" name="rating" value="5"/>
                                                        <label class="full" for="star5" title="Awesome - 5 stars"></label>

                                                        <input type="radio" id="star4" name="rating" value="4"/>
                                                        <label class="full" for="star4" title="Pretty good - 4 stars"></label>

                                                        <input type="radio" id="star3" name="rating" value="3"/>
                                                        <label class="full" for="star3" title="Meh - 3 stars"></label>

                                                        <input type="radio" id="star2" name="rating" value="2"/>
                                                        <label class="full" for="star2" title="Kinda bad - 2 stars"></label>

                                                        <input type="radio" id="star1" name="rating" value="1"/>
                                                        <label class="full" for="star1" title="Sucks big time - 1 star"></label>
                                                    </div>
                                                    <c:if test="${checkJoinCourse}">
                                                        <div>
                                                            <input type="hidden" value="${data.id}" name="courseId">
                                                            <input type="hidden"
                                                                   value="<%=((Account)session.getAttribute("user")).getId()%>"
                                                                   name="accountId">
                                                            <input onclick="checkLoginAndSubmit()" type="submit" value="Rating" class="btn radius-xl"/>
                                                        </div>
                                                    </c:if>
                                                </form>
                                                <div>${joinCourseList.size()} Rate</div>
                                            </div>
                                            <%
                                                List<JoinCourse> joinCourseList = (List) request.getAttribute("joinCourseList");
                                                int oneStar = 0, twoStar = 0, threeStar = 0, fourStar = 0, fiveStar = 0;
                                                for (JoinCourse joinCourse : joinCourseList) {
                                                    if (joinCourse.getStars() == 1) {
                                                        oneStar++;
                                                    }
                                                    if (joinCourse.getStars() == 2) {
                                                        twoStar++;
                                                    }
                                                    if (joinCourse.getStars() == 3) {
                                                        threeStar++;
                                                    }
                                                    if (joinCourse.getStars() == 4) {
                                                        fourStar++;
                                                    }
                                                    if (joinCourse.getStars() == 5) {
                                                        fiveStar++;
                                                    }
                                                }
                                            %>
                                            <div class="review-bar">
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>5 ⭐</div>
                                                    </div>
                                                    
                                                    <div class="side right">
                                                        <div><%=fiveStar%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>4 ⭐</div>
                                                    </div>
                                                    
                                                    <div class="side right">
                                                        <div><%=fourStar%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>3 ⭐</div>
                                                    </div>
                                                    
                                                    <div class="side right">
                                                        <div><%=threeStar%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>2 ⭐</div>
                                                    </div>
                                                    
                                                    <div class="side right">
                                                        <div><%=twoStar%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>1 ⭐</div>
                                                    </div>
                                                    
                                                    <div class="side right">
                                                        <div><%=oneStar%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clear" id="comment-list">
                                            <div class="comments-area" id="comments">
                                                <h2 class="comments-title">${listCM.size()} Comments</h2>
                                                <div class="clearfix m-b20">
                                                    <!-- comment list END -->
                                                    <ol class="comment-list">

                                                        <c:forEach items="${listCM}" var="c">

                                                            <li class="comment course-entry">
                                                                <c:if test="${sessionScope.user.id == c.account.id}">
                                                                    <div class="blog-header">
                                                                        <button class="edit-button">Edit</button>
                                                                        <div class="overlay">
                                                                            <form action="edit-comment-course" method="post" class="edit-form">
                                                                                <h3>Your comment:</h3>
                                                                                <input type="hidden" name="id" value="${c.id}"/>
                                                                                <input type="hidden" name="edit" value="0"/>
                                                                                <input type="hidden" name="courseId" value="${data.id}"/>
                                                                                <textarea  name="comment" id="comment" required style="min-width: 600px">${c.comment}</textarea>
                                                                                <br/><button type="submit">Update</button>
                                                                            </form> 
                                                                        </div>
                                                                        <form action="edit-comment-course" method="post" onsubmit="return confirmSubmit()" style="display: inline-block">
                                                                            <input type="hidden" name="id" value="${c.id}"/>
                                                                            <input type="hidden" name="courseId" value="${data.id}"/>
                                                                            <input type="hidden" name="remove" value="0"/>    
                                                                            <button class="remove-button" id="removeButton">Remove</button>
                                                                        </form>
                                                                    </div>
                                                                </c:if>
                                                                <div class="" style="margin-left: 5%; border-bottom: 1px solid #cccccc">
                                                                    <div class="comment-author vcard"> <img style="width: 50px; border-radius: 50%" src ="${c.account.avatar}"> <cite class="fn">${c.account.firstName} ${c.account.lastName}</cite>  </div>
                                                                    <div class="comment-meta"> <a>${c.createdDate}</a> </div>
                                                                    <p>${c.comment}</p>
                                                                    <div class="reply">  </div>
                                                                </div>
                                                            </li>
                                                        </c:forEach>

                                                    </ol>
                                                    <!-- comment list END -->
                                                    <!-- Form -->
                                                    <div class="comment-respond" id="respond">
                                                        <h4 class="comment-reply-title" id="reply-title">Leave a Reply <small> <a style="display:none;" href="#" id="cancel-comment-reply-link" rel="nofollow">Cancel reply</a> </small> </h4>
                                                        <h5 style="color: red; font-style: italic">${param.noti}</h5>
                                                        <form action="comment-course" class="comment-form" id="commentform" method="post">
                                                            <input type="hidden" value="${data.id}" name="courseId"/>
                                                            <p class="comment-form-comment">
                                                                <label for="comment">Comment</label>
                                                                <textarea rows="8" name="comment" placeholder="Comment" id="comment" required=></textarea>
                                                            </p>
                                                            <p class="form-submit" >
                                                                <input style="color: white;background: #990099; padding: 10px; border-radius: 8px; cursor: pointer;" onclick="checkLoginAndSubmit()" type="submit" value="Submit Comment" class="submit" id="submit" name="submit"/>
                                                            </p>

                                                        </form>
                                                    </div>

                                                    <!-- Form -->
                                                </div>
                                            </div>
                                        </div> 
                                    </div>                                                       
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer ==== -->
                <%@include file="footer.jsp" %>
                <!-- Footer END ==== -->
            </div>
            <!-- contact area END -->

        </div>
        <!-- External JavaScripts -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
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
            $('#enrollCourse').on('click', function () {
                console.log('get click!');
                var value = '<%=session.getAttribute("user")%>';
                if (value != 'null') {
                    $.ajax({
                        url: "/SE1735_G5/course-register",
                        type: "post",
                        data: {
                            courseId: ${data.id}
                        },
                        success: function (data) {
                            alert(data);
                            if (data == 'Join course succcess') {
                                location.reload();
                            }
                        },
                        error: function (xhr) {
                            //handle error
                        }
                    });
                } else {
                    if (window.confirm('You need login to enroll a course!'))
                    {
                        window.open('http://localhost:9999/SE1735_G5/login.jsp', '_blank');
                    }
                    ;
                }
            });
        </script> 
        <script>
            function checkLoginAndSubmit() {
                var check = "<c:out value='${sessionScope.user}' />";

                if (check === "") {
                    alert("Please log in to comment.");
                    window.location.href = "http://localhost:9999/SE1735_G5/login"; // Redirect to the login page
                } else {
                    // Submit the comment form
                    document.getElementById("commentform").submit();
                }
            }
        </script>
        <script>
            function confirmSubmit() {
                var confirmed = confirm("Are you sure to delete comment?");

                if (!confirmed) {
                    return false; // Prevent form submission
                }

                // Form is confirmed, continue with submission
                return true;
            }
        </script>
        <script>
            const editButtons = document.getElementsByClassName('edit-button');
            const overlays = document.getElementsByClassName('overlay');
            for (let i = 0; i < editButtons.length; i++) {
                const editButton = editButtons[i];
                const overlay = overlays[i];
                editButton.addEventListener('click', function () {
                    overlay.style.display = 'block';
                });
                overlay.addEventListener('click', function (event) {
                    if (event.target === this) {
                        this.style.display = 'none';
                    }
                });
            }
        </script>


    </body>
</html>
