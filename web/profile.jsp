<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Profile </title>

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
        <script src="https://cdn.tiny.cloud/1/9sllubmtdnsbkg1fs68nmzqpbdxe0s33fsizdklnmjchptu3/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

    </head>
    <body id="bg">
        <div class="page-wraper">


            <!-- Header Top ==== -->
            <div style="background: black">
                <%@include file="header.jsp"%>
            </div>

            <div id="loading-icon-bx"></div>

            <!-- header END ==== -->
            <!-- Content -->
            <!-- Breadcrumb row -->
            <!-- Breadcrumb row END -->
            <!-- inner page banner END -->
            <div class="content-block">
                <div class="page-banner ovbl-dark" style="background-image:url(https://cdn.wallpapersafari.com/51/1/PL5YbE.jpg);">
                    <div class="container">
                    </div>
                </div>
                <!-- About Us -->
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                <div class="profile-bx text-center">
                                    <div class="user-profile-thumb">
                                        <img src="${requestScope.a.avatar}" style="  height: 100%;width: 100%; border-radius: 50%" id="full_avatar"/>                       
                                    </div>

                                    <form action="profile" method="post" id="sumbit-avatar">
                                        <div class="dropdown1"> 
                                            <p style="cursor: pointer; font-weight: bolder; margin-left: 5px">...</p>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <div class="dropdown-content">         
                                                <input type="file" id="changeProfile_button" style="width: 105px" >
                                                <a href="profile?deleteAvatar=null" style="color: black">Delete Image</a>
                                            </div>
                                        </div>
                                    </form>
                                    <input type="submit" class="btn" value="Clear" id="clear" onclick="nochange()">
                                    <div class="profile-info">
                                        <h4>${requestScope.a.firstName}${requestScope.a.lastName}</h4>
                                        <span>${requestScope.a.email}</span>
                                    </div>

                                    <div class="profile-tabnav">
                                        <ul class="nav nav-tabs">
                                            <li class="">
                                                <a class="nav-link active"  href="#edit-profile"><i class=""></i>Edit Profile</a>
                                            </li>
                                            <li class="">
                                                <a class="nav-link"  href="my-courses"><i class=""></i>My Courses</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-12 m-b30">
                                <div class="profile-content-bx">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="edit-profile">
                                            <div class="profile-head">
                                                <h1>${requestScope.base}</h1>
                                                <h3>Edit Profile</h3>                                           
                                            </div>                                            
                                            <div class="">
                                                <form class="profile" method="post" id="myForm">
                                                    <br/>
                                                    <h3 style="text-align: center">Personal Details</h3>                                      
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">&nbsp;&nbsp;&nbsp;First Name</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="text" id="fname" name="fname" value="${requestScope.a.firstName}" 
                                                                   pattern="[A-Z]{1}[A-Za-z]{1,12}"
                                                                   title="First name must capitalize the first character and not be contain number and space and not null"                                
                                                                   >
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">&nbsp;&nbsp;&nbsp;   Last Name</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="text" id="lname"   name="lname" value="${requestScope.a.lastName}" required
                                                                   pattern="[A-Z]{1}[A-Za-z]{1,12}"
                                                                   title="Last name must capitalize the first character and not be contain number and no space">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">&nbsp;&nbsp;&nbsp; Phone &nbsp;&nbsp;&nbsp;&nbsp;Number</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="text" id="phone" name="phone" value="${requestScope.a.phoneNumber}"
                                                                   pattern="[0][1-9][0-9]{8}"
                                                                   title="Please input 10 character number"
                                                                   required>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">&nbsp;&nbsp;&nbsp; Country</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" id="country" type="text" name="country" value="${requestScope.a.country}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">&nbsp;&nbsp;&nbsp; Email</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" id="email" type="email" name="email" value="${requestScope.a.email}" required readonly>
                                                        </div>
                                                    </div>


                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">&nbsp;&nbsp;&nbsp; Date of birth</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" id="dob" type="date" onchange="TDate()" name="dob" value="${requestScope.a.dob}" required
                                                                   title="">
                                                            ${requestScope.errorDob}
                                                        </div>
                                                    </div>


                                                    <div class="row">
                                                        <div class="col-12 col-sm-3 col-md-3 col-lg-2">
                                                        </div>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input id="save" class="btn" type="submit" value="SAVE">
                                                        </div>
                                                    </div>

                                                </form>
                                                <div class="row">
                                                    <div class="col-12 col-sm-3 col-md-3 col-lg-2">
                                                    </div>
                                                    <br/>
                                                    <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                        <input type="submit" class="btn-secondry" id="nochange"  onclick="nochange()"  value="Don't want to change">
                                                    </div>
                                                </div>

                                                <c:if test="${n > 0}">       
                                                    <div class="form-group row1" id="row1">
                                                        &nbsp;      <button class="btn" id="alert">List alert</button> <br/>
                                                        <c:forEach items="${alertList}" var="o">                                                  
                                                            <label class="test" id="contentAlert">${o.content}</label>
                                                        </c:forEach>                                                                      
                                                    </div>
                                                </c:if>
                                                <div class="seperator"></div>
                                                <div class="m-form__seperator m-form__seperator--dashed m-form__seperator--space-2x"></div>
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
        <!-- Footer ==== -->
        <!-- Footer END ==== -->
        <!-- External JavaScripts -->
        <script>

document.getElementById('clear').style.display='none';
            var fileInput = document.getElementById('changeProfile_button');
            var base64Data;
            fileInput.addEventListener("change", e => {
                const file = fileInput.files[0];
                const reader = new FileReader();

                reader.onload = function (event) {
                    if(file.size > 1000 * 1024){
                        alert('Image must be < 1MB');
                        return;
                    }else {
                    // Set the value of the hidden input
                    $('#inputImage').attr('src', reader.result);
                    base64Data = reader.result;
                    if (fileInput) {
                        $('#full_avatar').attr('src', reader.result);
                    }
                    var form = $('#sumbit-avatar');
                form.attr('action', 'profile');
                form.attr('method', 'post');            
                
                var file123 = document.createElement("input");                   
                file123.value =  reader.result;
                file123.name = "avatar";
                file123.type = "hidden";
                form.prepend(file123);
                
                var submit = document.createElement("input");
                submit.type = "submit";
                submit.className = "btn";
                submit.value = "Save";
                document.getElementById('clear').style.display='block';
                form.prepend(submit);
            }

                };
                reader.readAsDataURL(file);
            });
        </script>

        <script>


        </script>         
        <script type="text/javascript">
            var x = document.getElementById('contentAlert');
            var b = document.getElementsByClassName("test");
            for (var i = 0; i < b.length; i++) {
                b[i].style.display = 'none';
            }
            var display = 0;
            $('#alert').on('click input', function () {
                event.preventDefault();
                if (display === 1) {
                    for (var i = 0; i < b.length; i++) {
                        b[i].style.display = 'block';
                        display = 0;
                    }
                } else {
                    for (var i = 0; i < b.length; i++) {
                        b[i].style.display = 'none';
                        display = 1;
                    }
                }
            });

        </script>
        <script type="text/javascript">
            function TDate() {
                var UserDate = document.getElementById("dob").value;
                var ToDate = new Date(UserDate);
                if (ToDate.getFullYear() > 2017) {
                    alert("The age of user must be > 6");
                    document.getElementById("dob").value = null;
                    return false;
                }
                if (ToDate.getFullYear() >= 1000 && ToDate.getFullYear() <= 1945) {
                    alert("The age of user must be < 100");
                    document.getElementById("dob").value = null;
                    return false;
                }

            }
        </script>
        <script type="text/javascript">
            const hideBtn = document.querySelector('#save');
            hideBtn.style.display = 'none';
            var x = document.querySelector('#nochange');
            x.style.display = 'none';
            var fname = document.querySelector('#fname');
            var lname = document.querySelector('#lname');
            var phone = document.querySelector('#phone');
            var country = document.querySelector('#country');
            var dob = document.querySelector('#dob');
            fname.addEventListener('click', () => {
                hideBtn.style.display = 'block';
                x.style.display = 'block';
                document.getElementById('alert').style.display = 'none';
                var b = document.getElementsByClassName("test");
                for (var i = 0; i < b.length; i++) {
                    b[i].style.display = 'none';
                }
            });

            country.addEventListener('click', () => {
                hideBtn.style.display = 'block';
                x.style.display = 'block';
                document.getElementById('alert').style.display = 'none';
                var b = document.getElementsByClassName("test");
                for (var i = 0; i < b.length; i++) {
                    b[i].style.display = 'none';
                }
            });

            lname.addEventListener('click', () => {
                hideBtn.style.display = 'block';
                x.style.display = 'block';
                document.getElementById('alert').style.display = 'none';
                var b = document.getElementsByClassName("test");
                for (var i = 0; i < b.length; i++) {
                    b[i].style.display = 'none';
                }
            });
            phone.addEventListener('click', () => {
                hideBtn.style.display = 'block';
                x.style.display = 'block';
                document.getElementById('alert').style.display = 'none';
                var b = document.getElementsByClassName("test");
                for (var i = 0; i < b.length; i++) {
                    b[i].style.display = 'none';
                }
            });

            dob.addEventListener('click', () => {
                hideBtn.style.display = 'block';
                x.style.display = 'block';
                document.getElementById('alert').style.display = 'none';
                var b = document.getElementsByClassName("test");
                for (var i = 0; i < b.length; i++) {
                    b[i].style.display = 'none';
                }
            });
            function nochange() {
                var nochange = document.querySelector('#nochange');
                window.location.href = "http://localhost:9999/SE1735_G5/profile";
            }
        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
    </body>
</html>
