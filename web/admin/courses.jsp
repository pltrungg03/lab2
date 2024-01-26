<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />

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
                                <h4>Courses listing</h4>
                            </div>
                            <div class="widget-inner">
                                <table id="coursesTable" class="display compact" style="width:100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Discount</th>
                                            <!--<th>Description</th>-->
                                            <th>Created Date</th>
                                            <th>Updated Date</th>
                                            <th>Major</th>
                                            <th>Level</th>
                                            <th>Creator</th>
                                            <th>
                                                <a class="" href="create-course" role="button"><i class="ti-check"></i>Status</a>
                                            </th>
                                            <th>
                                                <a class="" href="create-course" role="button"><i class="ti-plus"></i>Manage</a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.courses}" var="c">
                                            <tr>
                                                <td>${c.id}</td>
                                                <td>${c.name}</td>
                                                <td>${c.price}</td>
                                                <td>${c.discount}</td>
                                                <!--<td>${c.description}</td>-->
                                                <td>${c.createdDate}</td>
                                                <td>${c.updatedDate}</td>
                                                <td>
                                                    <span class="badge badge-info badge-pill">${c.major.name}</span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${c.level.id == 1}">
                                                            <span class="badge badge-secondary badge-pill">${c.level.name}</span>
                                                        </c:when>
                                                        <c:when test="${c.level.id == 2}">
                                                            <span class="badge badge-primary badge-pill">${c.level.name}</span>
                                                        </c:when>
                                                        <c:when test="${c.level.id == 3}">
                                                            <span class="badge badge-success badge-pill">${c.level.name}</span>
                                                        </c:when>
                                                        <c:when test="${c.level.id == 4}">
                                                            <span class="badge badge-warning badge-pill">${c.level.name}</span>
                                                        </c:when>
                                                        <c:when test="${c.level.id == 5}">
                                                            <span class="badge badge-danger badge-pill">${c.level.name}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-primary badge-pill">${c.level.name}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${c.creator.firstName} ${c.creator.lastName}</td>
                                                <td>
                                                    <a class="" href="#" role="button"><i class="ti-lock"></i>Disable</a>
                                                    <a class="" href="#" role="button"><i class="ti-unlock"></i>Enable</a>
                                                </td>
                                                <td>
                                                    <a class="" href="update-course?id=${c.id}" role="button"><i class="ti-slice"></i>Update</a>
                                                    <a class="" href="delete-course?id=${c.id}" onclick=""><i class="ti-trash"></i>Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
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
        <script src="./admin/assets/vendors/chart/chart.min.js"></script>
        <script src="./admin/assets/js/admin.js"></script>
        <script src='./admin/assets/vendors/calendar/moment.min.js'></script>
        <script src='./admin/assets/vendors/calendar/fullcalendar.js'></script>
        <!--Datatable-->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#coursesTable').DataTable();
            });
        </script>
    </body>

</html>