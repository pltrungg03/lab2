

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
        <style>
            .button-css{
                background: #990099;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 12px;
            }

            .button-css:hover{
                border: 1px solid #990099;
                background: white;
                color: #990099;
                padding: 10px;
                border-radius: 12px;
            }

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
                            <li><a href="home">Home</a></li>
                            <li><a href="my-courses">My Courses</a></li>
                            <li>Chapter ${ch.order}</li>
                            <li><button id="backButton" style="border: none; background: none; font-size: larger">Back</button></li>
                        </ul>
                        <form action="move-chapter" method="get" style="margin-top: 3%">
                            <input type="hidden" name="chId" value="${ch.id}"/>
                            <button class="button-css"><i class="fa fa-angle-double-left" style="color: #fcfcfc;"></i> Back to Currciculum</button>
                        </form>
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
                                                            <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" style="color: #2597d0;"></i>${i.test.name}</li>
                                                            </c:if>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h4 style="color: red; font-style: italic">${param.msg!=null?'You must wait at least 30 minutes for the next test time!':''}</h4>
                                                <h4  style="text-align: center; margin-bottom: 5%" class="m-b5">Lesson ${l.order}. ${l.name}</h4>

                                                <iframe width="800" height="450"  src="${l.videoUrl}" 
                                                        title="YouTube video player" frameborder="0"
                                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; 
                                                        picture-in-picture; web-share" allowfullscreen>

                                                </iframe>
                                                <h4 class="m-b5" style="text-align: center;margin-top: 3%; margin-bottom: 3%">Lesson Content </h4>
                                                <p>${l.content}</p>


                                                <c:if test="${l.test == null}">
                                                    <form action="join-lesson" method="post" onsubmit="return confirmSubmit('form 1')" style="margin-top: 10%">
                                                        <input type="hidden" value="${sessionScope.user.id}" name="accId"/>
                                                        <input type="hidden" value="${l.id}" name="lId"/>
                                                        <input type="hidden" value="${ch.id}" name="chId"/>
                                                        <button style="padding: 8px;border-radius: 8px; background: #660066; color: white">Mark as Completed</button>
                                                    </form>
                                                </c:if> 
                                                <c:if test="${l.test != null}">
                                                    <div class="ttr-post-info">
                                                        <div class="ttr-post-title " style="margin-top: 15%">
                                                            <h5 style="color: #f54d4d"><i class="fa fa-exclamation" style="color: #f54d4d;"></i> Note: </h5>
                                                            <h6 class="post-title"><i class="fa fa-question-circle" style="color: #2597d0;"></i>${l.test.name}</h6>
                                                        </div>
                                                        <div class="ttr-post-text" style="border-bottom: 1px solid #999999">
                                                            <p>You can only pass this lesson if you pass the test below</p>
                                                            <p>This test contains: ${l.test.quizzes.size()} questions</p>
                                                            <p>Pass point: ${l.test.threshold}</p>
                                                            <c:if test="${requestScope.score != null && requestScope.score >= l.test.threshold}">
                                                                <h3>Your grade: <span style="color: #33cc00">${requestScope.score} (last time passed)</span></h3>
                                                            </c:if>
                                                            <c:if test="${requestScope.score != null && requestScope.score < l.test.threshold}">
                                                                <h3>Your grade: <span style="color: red">${requestScope.score} (not passed)</span></h3>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <form action="test-details" method="post">
                                                        <input type="hidden" value="${sessionScope.user.id}" name="accId"/>
                                                        <input type="hidden" value="${l.id}" name="lId"/>
                                                        <input type="hidden" value="${ch.id}" name="chId"/>
                                                        <button style="padding: 8px;border-radius: 8px; background: #660066; color: white">Take the Test</button>
                                                    </form>
                                                </c:if>

                                                <div class="clear" id="comment-list">
                                                    <div class="comments-area" id="comments">
                                                        <c:set value="${0}" var="numComments"/>
                                                        <c:forEach items="${requestScope.listC}" var="nc">
                                                            <c:if test="${nc.parentId == 0}">
                                                                <c:set value="${numComments + 1}" var="numComments"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        <h2 class="comments-title" style="color: #0066ff; font-style: italic; margin-top: 15%; border-top: 1px solid #cccccc">${numComments} Comments</h2>
                                                        <h5 style="font-style: italic; color: #ff0033">${param.cmt2 != null?'The length of characters must be less than or equal 4000!':''}</h5>
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
                                                                                        <form action="edit-comment-lesson" method="post" class="edit-form">
                                                                                            <h3 style="color: #0066ff">Your comment:</h3>
                                                                                            <input type="hidden" name="cmId" value="${cm.id}"/>
                                                                                            <input type="hidden" name="edit" value="1"/>
                                                                                            <input type="hidden" name="chId" value="${ch.id}"/>
                                                                                            <input type="hidden" name="lId" value="${l.id}"/>
                                                                                            <textarea  name="content" id="comment" required style="min-width: 600px">${cm.comment}</textarea>
                                                                                            <br/><button type="submit" class="update-button">Update</button>
                                                                                        </form> 
                                                                                    </div>
                                                                                    <form action="edit-comment-lesson" method="post" onsubmit="return confirmSubmit('form 2')" style="display: inline-block">
                                                                                        <input type="hidden" name="cmId" value="${cm.id}"/>
                                                                                        <input type="hidden" name="chId" value="${ch.id}"/>
                                                                                        <input type="hidden" name="lId" value="${l.id}"/>
                                                                                        <input type="hidden" name="remove" value="1"/>    
                                                                                        <button class="remove-button" id="removeButton">Remove</button>
                                                                                    </form>
                                                                                </c:if>

                                                                                <button class="reply-button" onclick="myFunction(${cm.id})">Reply</button>

                                                                            </div>

                                                                            <div class="" style="margin-left: 5%; border-bottom: 1px solid #cccccc">
                                                                                <div class="comment-author vcard"> <img style="width: 40px; border-radius: 50%" src ="${cm.account.avatar}"> <cite class="fn">${cm.account.firstName} ${cm.account.lastName}</cite> <span style="color: #0066ff; font-style: italic; font-size: smaller"> (Date: ${cm.createdDate})</span> </div>
                                                                                <div class="comment-meta"> </div>
                                                                                <p style="margin-left: 3%">${cm.comment}</p>
                                                                                <form action="lesson-comment" method="post" id="myDIV${cm.id}" style="display: none">
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
                                                                                    <input type="hidden" name="chId" value="${ch.id}"/>
                                                                                    <input type="hidden" name="lId" value="${l.id}"/>



                                                                                    <button style="margin-bottom: 3%" type="submit" class="submit-reply">Submit</button>
                                                                                </form>
                                                                                <div class="display-reply"><!-- day la cho hien thi REPLY -->
                                                                                    <c:forEach items="${requestScope.listC}" var="reply">
                                                                                        <c:if test="${reply.parentId == cm.id}">
                                                                                            <c:if test="${reply.account.id == sessionScope.user.id}">

                                                                                                <div class="overlay">

                                                                                                    <form action="edit-comment-lesson" method="post" class="edit-form">
                                                                                                        <h3 style="color: #0066ff">Your reply:</h3>
                                                                                                        <input type="hidden" name="cmId" value="${reply.id}"/>
                                                                                                        <input type="hidden" name="edit" value="1"/>
                                                                                                        <input type="hidden" name="chId" value="${ch.id}"/>
                                                                                                        <input type="hidden" name="lId" value="${l.id}"/>
                                                                                                        <textarea  name="content" id="comment" required style="min-width: 600px">${reply.comment}</textarea>
                                                                                                        <br/><button type="submit" class="update-button">Update</button>
                                                                                                    </form> 
                                                                                                </div>
                                                                                            </c:if>        

                                                                                            <div class="reply-detail" style="margin-left: 10%;border-bottom: 1px solid #cccccc">
                                                                                                <div class="comment-author vcard"> <img style="width: 35px; border-radius: 50%" src ="${reply.account.avatar}"> <cite class="fn" style="font-size: smaller; color: #660033">${reply.account.firstName} ${reply.account.lastName}</cite>  <span style="color: #0066ff; font-style: italic; font-size: smaller"> (Date: ${cm.createdDate})</span> </div>
                                                                                                <div class="comment-meta" >  </div>
                                                                                                <p style="font-size: smaller; margin-left: 3%">${reply.comment}</p>
                                                                                                <c:if test="${reply.account.id == sessionScope.user.id}">

                                                                                                    <button class="edit-button-small edit-button">Edit</button>
                                                                                                    <form action="edit-comment-lesson" method="post" onsubmit="return confirmSubmit('form 2')">
                                                                                                        <input type="hidden" name="cmId" value="${reply.id}"/>
                                                                                                        <input type="hidden" name="chId" value="${ch.id}"/>
                                                                                                        <input type="hidden" name="lId" value="${l.id}"/>
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

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row" style="margin-top: 10%">
                                                    <div class="comment-respond" id="respond" style="width: 100%">
                                                        <h4 class="comment-reply-title" id="reply-title">You don't understand? Ask a question! <small> <a style="display:none;" href="#" id="cancel-comment-reply-link" rel="nofollow">Cancel reply</a> </small> </h4>
                                                        <h5 style="font-style: italic; color: #ff0033">${param.cmt != null ?'The length of comments must be less or equal 4000 characters':''}</h5>
                                                        <form action="lesson-comment" class="comment-form" id="commentform" method="post">
                                                            <input type="hidden" value="${ch.id}" name="chId"/>
                                                            <input type="hidden" value="${l.id}" name="lId"/>
                                                            <p class="comment-form-comment">
                                                                <label for="comment">Comment</label>
                                                                <textarea style="width: 100%" name="content" placeholder="Comment" id="comment" required=></textarea>
                                                            </p>
                                                            <p class="form-submit">
                                                                <input style="color: white;background: #990099; padding: 10px; border-radius: 8px; cursor: pointer;" onclick="checkLoginAndSubmit()"  type="submit" value="Submit Question" class="submit" id="submit" name="submit"/>
                                                            </p>
                                                        </form>
                                                    </div>
                                                </div>
                                                <c:if test="${requestScope.pos != 'min'}">
                                                    <form action="move-chapter" method="post" style="margin-top: 15%; display: inline-block">
                                                        <input type="hidden" name="pre" value="0"/>
                                                        <input type="hidden" name="chId" value="${ch.id}"/>
                                                        <input type="hidden" name="lId" value="${l.id}"/>
                                                        <button style="padding: 6px;border-radius: 8px; background: #660066; color: white; width: 120px"><i class="fa fa-arrow-left"></i> Chapter</button>

                                                    </form>
                                                </c:if>
                                                <c:if test="${requestScope.pos != 'max'}">
                                                    <form action="move-chapter" method="post" style="margin-top: 15%; display: inline-block">
                                                        <input type="hidden" name="next" value="1"/>
                                                        <input type="hidden" name="chId" value="${ch.id}"/>
                                                        <input type="hidden" name="lId" value="${l.id}"/>
                                                        <button style="padding: 6px;border-radius: 8px; background: #660066; color: white; width: 120px">Chapter <i class="fa fa-arrow-right"></i></button>

                                                    </form>
                                                </c:if>
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
            function confirmSubmit(formName) {
                var confirmed;
                if (formName === 'form 1') {
                    confirmed = confirm("Make sure you actually complete this lesson!");
                }
                if (formName === 'form 2') {
                    confirmed = confirm("Are you sure to delete this comment!");
                }
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
