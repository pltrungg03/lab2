<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
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

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <!-- REVOLUTION SLIDER END -->	
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

            .edit-button, .remove-button, .reply-button, .update-button, .submit-reply{
                background-color: #e1ecf4;
                border-radius: 3px;
                border: 1px solid #7aa7c7;
                box-shadow: rgba(255, 255, 255, .7) 0 1px 0 0 inset;
                box-sizing: border-box;
                color: #39739d;
                cursor: pointer;
                display: inline-block;
                font-family: -apple-system,system-ui,"Segoe UI","Liberation Sans",sans-serif;
                font-size: 12px;
                font-weight: 400;
                line-height: 1.15385;
                margin: 0;
                outline: none;
                padding: 6px .6em;
                position: relative;
                text-align: center;
                text-decoration: none;
                user-select: none;
                -webkit-user-select: none;
                touch-action: manipulation;
                vertical-align: baseline;
                white-space: nowrap;

            }

            .edit-button-small, .remove-button-small{
                background-color: #e1ecf4;
                border-radius: 3px;
                border: 1px solid #7aa7c7;
                box-shadow: rgba(255, 255, 255, .7) 0 1px 0 0 inset;
                box-sizing: border-box;
                color: #39739d;
                cursor: pointer;
                display: inline-block;
                font-family: -apple-system,system-ui,"Segoe UI","Liberation Sans",sans-serif;
                font-size: 11px;
                font-weight: 400;
                line-height: 1.15385;
                margin: 0;
                outline: none;
                padding: 5px .5em;
                position: relative;
                text-align: center;
                text-decoration: none;
                user-select: none;
                -webkit-user-select: none;
                touch-action: manipulation;
                vertical-align: baseline;
                white-space: nowrap;
            }


            .reply-detail{
                position: relative;
            }

            .edit-button-small{
                position: absolute;
                top: 10px;
                right: 53px;
                cursor: pointer;
            }

            .remove-button-small{
                position: absolute;
                top: 10px;
                right: 0px;
                cursor: pointer;
            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <c:set value="${0}" var="numComments"/>
            <c:forEach items="${requestScope.listC}" var="nc">
                <c:if test="${nc.parentId == 0}">
                    <c:set value="${numComments + 1}" var="numComments"/>
                </c:if>
            </c:forEach>
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(https://wallpapers.com/images/hd/anime-landscape-background-12xkkc2cnstc3gp2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Blog Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Blog Details</li>
                            <button onclick="checkLoginAndSubmit2()" style="background: black; color: white; padding: 10px; border-radius: 8px;">Write a blog!</button>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <c:set value="${requestScope.blogInfo}" var="b"/>
                                <!-- Left part start -->
                                <div class="col-lg-8 col-xl-8">
                                    <!-- blog start -->
                                    <div class="recent-news blog-lg">
                                        <h5 style="color: red; font-style: italic">${param.noti}</h5>
                                        <div class="action-box blog-lg">
                                            <img src="${b.thumbnail}">
                                        </div>
                                        <div class="info-bx">
                                            <ul class="media-post">
                                                <li><a href="#"><i class="fa fa-calendar"></i>${b.createdDate}</a></li>
                                                <li><a href="#"><i class="fa fa-comments-o"></i>${numComments} Comment</a></li>
                                                <br/><a href="blog-user?id=${b.creator.id}"><i class="fa fa-user"></i>By ${b.creator.firstName} ${b.creator.lastName}</a>
                                            </ul>
                                            <h5 class="post-title"><a href="blog-details?id=${b.id}">${b.title}</a></h5>
                                                ${b.content}
                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                            <div class="widget_tag_cloud">
                                                <h6>TAG(S) OF THIS BLOG</h6>
                                                <div class="tagcloud"> 
                                                    <c:forEach items="${listT1}" var="t1">
                                                        <a style="padding: 15px" href="blog-list?tag=${t1.id}">${t1.name}</a> 
                                                    </c:forEach>


                                                </div>
                                            </div>
                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>

                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                        </div>
                                    </div>
                                    <div class="clear" id="comment-list">
                                        <div class="comments-area" id="comments">

                                            <h2 class="comments-title">${numComments} Comments</h2>
                                            <div class="clearfix m-b20">
                                                <!-- comment list END -->
                                                <ol class="comment-list">

                                                    <c:forEach items="${requestScope.listC}" var="cm">
                                                        <c:if test="${cm.parentId == 0}">
                                                            <li class="comment blog-entry">

                                                                <div class="blog-header">

                                                                    <c:if test="${sessionScope.user.id == cm.account.id}">
                                                                        <button class="edit-button">Edit</button>
                                                                        <div class="overlay">
                                                                            <form action="edit-comment-blog" method="post" class="edit-form">
                                                                                <h3 style="color: #0066ff">Your comment:</h3>
                                                                                <input type="hidden" name="cmId" value="${cm.id}"/>
                                                                                <input type="hidden" name="edit" value="1"/>
                                                                                <input type="hidden" name="blogId" value="${b.id}"/>
                                                                                <textarea  name="content" id="comment" required style="min-width: 600px">${cm.content}</textarea>
                                                                                <br/><button type="submit" class="update-button">Update</button>
                                                                            </form> 
                                                                        </div>
                                                                        <form action="edit-comment-blog" method="post" onsubmit="return confirmSubmit()" style="display: inline-block">
                                                                            <input type="hidden" name="cmId" value="${cm.id}"/>
                                                                            <input type="hidden" name="blogId" value="${b.id}"/>
                                                                            <input type="hidden" name="remove" value="1"/>    
                                                                            <button class="remove-button" id="removeButton">Remove</button>
                                                                        </form>
                                                                    </c:if>
                                                                    <c:if test="${sessionScope.user != null}">
                                                                        <button class="reply-button" onclick="myFunction(${cm.id})">Reply</button>
                                                                    </c:if>
                                                                </div>

                                                                <div class="" style="margin-left: 5%; border-bottom: 1px solid #cccccc">
                                                                    <div class="comment-author vcard"> <a href="blog-user?id=${cm.account.id}"><img style="width: 50px; border-radius: 50%" src ="${cm.account.avatar}"> <cite class="fn">${cm.account.firstName} ${cm.account.lastName}</cite></a>  </div>
                                                                    <div class="comment-meta"> <a>${cm.createdDate}</a> </div>
                                                                    <p style="margin-left: 3%">${cm.content}</p>
                                                                    <form action="comment-blog" method="post" id="myDIV${cm.id}" style="display: none">
                                                                        <textarea 
                                                                            style="width: 80%;
                                                                            height: 150px;
                                                                            padding: 12px 20px;
                                                                            box-sizing: border-box;
                                                                            border: 2px solid #ccc;
                                                                            border-radius: 4px;
                                                                            background-color: #f8f8f8;
                                                                            font-size: 16px;
                                                                            resize: none; display: block"
                                                                            name="content" id="reply_${c.id}"></textarea>
                                                                        <input type="hidden" name="parentId" value="${cm.id}"/>
                                                                        <input type="hidden" name="blogId" value="${b.id}"/>

                                                                        <button style="margin-bottom: 3%" type="submit" class="submit-reply">Submit</button>
                                                                    </form>
                                                                    <div class="display-reply"><!-- day la cho hien thi REPLY -->
                                                                        <c:forEach items="${requestScope.listC}" var="reply">
                                                                            <c:if test="${reply.parentId == cm.id}">
                                                                                <c:if test="${reply.account.id == sessionScope.user.id}">

                                                                                    <div class="overlay">

                                                                                        <form action="edit-comment-blog" method="post" class="edit-form">
                                                                                            <h3 style="color: #0066ff">Your reply:</h3>
                                                                                            <input type="hidden" name="cmId" value="${reply.id}"/>
                                                                                            <input type="hidden" name="edit" value="1"/>
                                                                                            <input type="hidden" name="blogId" value="${b.id}"/>
                                                                                            <textarea  name="content" id="comment" required style="min-width: 600px">${reply.content}</textarea>
                                                                                            <br/><button type="submit" class="update-button">Update</button>
                                                                                        </form> 
                                                                                    </div>
                                                                                </c:if>        

                                                                                <div class="reply-detail" style="margin-left: 10%;border-bottom: 1px solid #cccccc">
                                                                                    <div class="comment-author vcard"> <a href="blog-user?id=${reply.account.id}"><img style="width: 35px; border-radius: 50%" src ="${reply.account.avatar}"> <cite class="fn" style="font-size: smaller; color: #660033">${reply.account.firstName} ${reply.account.lastName}</cite></a>  </div>
                                                                                    <div class="comment-meta" > <a style="font-size: smaller">${reply.createdDate}</a> </div>
                                                                                    <p style="font-size: smaller; margin-left: 3%">${reply.content}</p>
                                                                                    <c:if test="${reply.account.id == sessionScope.user.id}">

                                                                                        <button class="edit-button-small edit-button">Edit</button>
                                                                                        <form action="edit-comment-blog" method="post" onsubmit="return confirmSubmit()">
                                                                                            <input type="hidden" name="cmId" value="${reply.id}"/>
                                                                                            <input type="hidden" name="blogId" value="${b.id}"/>
                                                                                            <input type="hidden" name="remove" value="1"/>    
                                                                                            <button  class="remove-button-small remove-button">Remove</button>
                                                                                        </form>

                                                                                    </c:if>
                                                                                </div>

                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>

                                                </ol>
                                                <!-- comment list END -->
                                                <!-- Form -->
                                                <div class="comment-respond" id="respond">
                                                    <h4 class="comment-reply-title" id="reply-title">Leave a Reply <small> <a style="display:none;" href="#" id="cancel-comment-reply-link" rel="nofollow">Cancel reply</a> </small> </h4>

                                                    <form action="comment-blog" class="comment-form" id="commentform" method="post">
                                                        <input type="hidden" value="${b.id}" name="blogId"/>
                                                        <p class="comment-form-comment">
                                                            <label for="comment">Comment</label>
                                                            <textarea rows="8" name="content" placeholder="Comment" id="comment" required=></textarea>
                                                        </p>
                                                        <p class="form-submit">
                                                            <input style="color: white;background: #990099; padding: 10px; border-radius: 8px; cursor: pointer;" onclick="checkLoginAndSubmit()"  type="submit" value="Submit Comment" class="submit" id="submit" name="submit"/>
                                                        </p>
                                                    </form>
                                                </div>
                                                <!-- Form -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- blog END -->
                                </div>
                                <!-- Left part END -->
                                <!-- Side bar start -->
                                <div class="col-lg-4 col-xl-4">
                                    <aside  class="side-bar sticky-top">
                                        <div class="widget">


                                        </div>
                                        <div class="widget recent-posts-entry">
                                            <h6 class="widget-title">Other Posts of ${b.creator.firstName} ${b.creator.lastName}</h6>
                                            <div class="widget-post-bx">
                                                <c:forEach items="${requestScope.listB}" var="lb" begin="${0}" end="${3}">
                                                    <div class="widget-post clearfix">
                                                        <div class="ttr-post-media"> <img src="${lb.thumbnail}" width="200" height="143" alt=""> </div>
                                                        <div class="ttr-post-info">
                                                            <div class="ttr-post-header">
                                                                <h6 class="post-title"><a href="blog-details?id=${lb.id}">${lb.title}</a></h6>
                                                            </div>
                                                            <ul class="media-post">
                                                                <li><a href="#"><i class="fa fa-calendar"></i>${lb.createdDate}</a></li>
                                                                <li><a href="#"></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>


                                        <div class="widget widget_tag_cloud">
                                            <h6 class="widget-title">
                                            </h6>
                                            <div class="tagcloud"> 
                                                <a href="blog-list?tag=0"> All </a>
                                                <c:forEach items="${requestScope.listT2}" var="t2">
                                                    <a href="blog-list?tag=${t2.id}">${t2.name}</a>
                                                </c:forEach> 

                                            </div>
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
            function checkLoginAndSubmit2() {
                var check2 = "<c:out value='${sessionScope.user}' />";

                if (check2 === "") {
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

        <script>
            function myFunction(n) {
                var x = document.getElementById("myDIV" + n);
                if (x.style.display === "none") {
                    x.style.display = "block";

                } else {
                    x.style.display = "none";
                }
            }
        </script>
    </body>

</html>