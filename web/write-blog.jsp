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
        <script src="https://cdn.tiny.cloud/1/9sllubmtdnsbkg1fs68nmzqpbdxe0s33fsizdklnmjchptu3/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            .checkbox-btn {
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                width: 16px;
                height: 16px;
                border: 2px solid #333;
                border-radius: 3px;
                outline: none;
                transition: background-color 0.3s ease;
                position: relative;
                
            }

            .checkbox-btn:checked::before {
                content: "\2713";
                display: block;
                position: absolute;
                top: 2px;
                left: 4px;
                color: white;
            }

            .checkbox-btn:checked {
                background-color: #ff0000;
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
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(https://wallpapers.com/images/hd/best-linkedin-background-wqwuzycn1gry742a.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white"><i class="fa fa-weixin"></i> Write your blog here!</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Write Blog</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->

                <!-- inner page banner -->
                <div class="page-banner contact-page section-sp2">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3 col-md-3 m-b30">

                            </div>
                            <div class="col-lg-9 col-md-9">
                                <form class="contact-bx " action="write-blog" method="post">

                                    <div class="heading-bx left">
                                        <h2 class="title-head">Tell us <span>What are you thinking?</span></h2>
                                        
                                        <p>Hello ${sessionScope.user.firstName}</p>
                                        <h4 style="color: ${requestScope.color}; font-style: italic">${requestScope.noti}</h4>
                                    </div>
                                    <div class="row placeani">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label>Title</label>
                                                    <input name="title" type="text" required class="form-control ">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <div class="input-group"> 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-10">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <h5>Thumbnail</h5>(It's just receive the last picture)
                                                    <textarea id="file-picker2" name="edit2"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">

                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <h5>Content</h5>
                                                    <textarea id="file-picker" name="edit"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-9">
                                            <h5>Tag(s)</h5>
                                            <c:forEach items="${requestScope.listT}" var="t">
                                                <input class="checkbox-btn" type="checkbox" name="tag" value="${t.id}"><label style="margin-right: 2%">${t.name}</label>
                                                </c:forEach>    


                                        </div>
                                        <div class="col-lg-12">
                                            <input name="submit" type="submit" value="Post" class="btn button-md">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- inner page banner END -->
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
        <script src='../../www.google.com/recaptcha/api.js'></script>

        <script>

            tinymce.init({
                selector: 'textarea#file-picker',
                plugins: 'link image code',
                toolbar: 'undo redo | link image | code',
                /* enable title field in the Image dialog*/
                image_title: true,
                /* enable automatic uploads of images represented by blob or data URIs*/
                automatic_uploads: true,
                /*
                 URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
                 images_upload_url: 'postAcceptor.php',
                 here we add custom filepicker only to Image dialog
                 */
                file_picker_types: 'image',
                /* and here's our custom image picker*/
                file_picker_callback: function (cb, value, meta) {
                    var input = document.createElement('input');
                    input.setAttribute('type', 'file');
                    input.setAttribute('accept', 'image/*');

                    /*
                     Note: In modern browsers input[type="file"] is functional without
                     even adding it to the DOM, but that might not be the case in some older
                     or quirky browsers like IE, so you might want to add it to the DOM
                     just in case, and visually hide it. And do not forget do remove it
                     once you do not need it anymore.
                     */

                    input.onchange = function () {
                        var file = this.files[0];

                        var reader = new FileReader();
                        reader.onload = function () {
                            /*
                             Note: Now we need to register the blob in TinyMCEs image blob
                             registry. In the next release this part hopefully won't be
                             necessary, as we are looking to handle it internally.
                             */
                            var id = 'blobid' + (new Date()).getTime();
                            var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                            var base64 = reader.result.split(',')[1];
                            var blobInfo = blobCache.create(id, file, base64);
                            blobCache.add(blobInfo);

                            /* call the callback and populate the Title field with the file name */
                            cb(blobInfo.blobUri(), {title: file.name});
                        };
                        reader.readAsDataURL(file);
                    };

                    input.click();
                },
                content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
            });

        </script>

        <script>

            tinymce.init({
                selector: 'textarea#file-picker2',
                plugins: 'image',
                toolbar: 'image',
                menubar: false,
                forced_root_block: '',
                force_br_newlines: false, // Do not use <br> for line breaks
                force_p_newlines: false,
                content_style: 'body { font-family: Helvetica, Arial, sans-serif; font-size: 14px; }',
                setup: function (editor) {
                    editor.on('keydown', function (e) {
                        e.preventDefault();
                    });
                },
                file_picker_types: 'image',
                file_picker_callback: function (cb) {
                    var input = document.createElement('input');
                    input.setAttribute('type', 'file');
                    input.setAttribute('accept', 'image/*');

                    input.onchange = function () {
                        var file = this.files[0];

                        var reader = new FileReader();
                        reader.onload = function () {
                            var id = 'blobid' + (new Date()).getTime();
                            var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                            var base64 = reader.result.split(',')[1];
                            var blobInfo = blobCache.create(id, file, base64);
                            blobCache.add(blobInfo);

                            cb(blobInfo.blobUri(), {title: file.name});
                        };
                        reader.readAsDataURL(file);
                    };

                    input.click();
                }
            });


        </script>
    </body>



</html>
