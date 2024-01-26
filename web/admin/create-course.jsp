<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />
        <title>Byte Scholar</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/summernote/summernote.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/file-upload/imageuploadify.min.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="./admin/assets/css/color/color-1.css">

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
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Create Course</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" method="post" action="create-course">
                                    <div class="row">
<!--                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>1. Course info</h3>
                                            </div>
                                        </div>-->
                                        <div class="form-group col-1">
                                            <label class="col-form-label">Course Id</label>
                                            <div>
                                                <select class="form-select" name="id" type="number" disabled>
                                                    <option value="">Default</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-5">
                                            <label class="col-form-label">Course name</label>
                                            <div>
                                                <input class="form-control" type="text" name="name" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Course image (url only)</label>
                                            <div>
                                                <input class="form-control" type="text" name="image" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Price ($)</label>
                                            <div>
                                                <input class="form-control" type="number" min="1" step="any" name="price" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Discount (0-1)</label>
                                            <div>
                                                <input class="form-control" type="number" min="0" max="1" step="any" name="discount" required>
                                            </div>
                                        </div>                                        
                                        <div class="form-group col-4">
                                            <label class="col-form-label">Major</label>
                                            <div>
                                                <select class="form-select" name="major">
                                                    <c:forEach items="${requestScope.majors}" var="m">
                                                        <option value="${m.id}">${m.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-4">
                                            <label class="col-form-label">Level</label>
                                            <div>
                                                <select class="form-select" name="level">
                                                    <c:forEach items="${requestScope.levels}" var="l">
                                                        <option value="${l.id}">${l.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>                                        

                                        <div class="form-group col-12">
                                            <label class="col-form-label">Course description</label>
                                            <div>
                                                <textarea class="summernote" name="description" required></textarea>
                                            </div>
                                        </div>

                                        <div class="seperator"></div>

<!--                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>2. Chapter info</h3>
                                            </div>
                                        </div>-->
<!--                                        <div class="col-12">
                                            <table id="item-add" style="width:100%;">
                                                <tr class="list-item">
                                                    <td>
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <label class="col-form-label">Index</label>
                                                                <div>
                                                                    <input class="form-control" type="number" min="0" step="1" value="" name="chaptersOrder" required>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="col-form-label">Name</label>
                                                                <div>
                                                                    <input class="form-control" type="text" value="" name="chaptersName" required>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <label class="col-form-label">Details</label>
                                                                <div class="form-group">
                                                                    <a class="btn-secondry" href="#">View</a>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <label class="col-form-label">Remove</label>
                                                                <div class="form-group">
                                                                    <a class="delete" href="#"><i class="fa fa-close"></i></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>-->
                                        <div class="col-12">
                                            <input type="submit" class="btn" value="Save Changes">
                                            <!--<button type="button" class="btn-secondry add-item m-r5"><i class="fa fa-fw fa-plus"></i>Add Chapter</button>-->
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>


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
        <script src="./admin/assets/vendors/chart/chart.min.js"></script>
        <script src="./admin/assets/js/admin.js"></script>
        <script src="./admin/assets/vendors/summernote/summernote.js"></script>
        <script>
            $(document).ready(function () {
                $('.summernote').summernote({
                    height: 300,
                    tabsize: 2
                });
            });
            $(document).on("click", "#item-add .delete", function (e) {
                e.preventDefault();
                $(this).parent().parent().parent().parent().remove();
            });
            // Pricing add
            function newMenuItem() {
                var newElem = $('tr.list-item').first().clone();
                newElem.find('input').val('');
                newElem.appendTo('table#item-add');
            }
            if ($("table#item-add").is('*')) {
                $('.add-item').on('click', function (e) {
                    e.preventDefault();
                    newMenuItem();
                });

            }
        </script>
    </body>
</html>