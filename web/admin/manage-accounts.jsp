<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />
        <title>Byte Scholar</title>

        <link rel="stylesheet" type="text/css" href="./admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/css/dashboard.css">
        <link rel="stylesheet" class="skin" type="text/css" href="./admin/assets/css/color/color-1.css">
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
                                <h4>Accounts listing</h4>
                            </div>
                            <div class="widget-inner">
                                <table id="accountsTable" class="display compact" style="width:100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Date Of Birth</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Country</th>
                                            <th>Wallet</th>
                                            <th>Created Date</th>
                                            <th>Roles</th>
                                            <th>Premium</th>
                                            <th>
                                                <a class="" href="create-course" role="button"><i class="ti-check"></i>Status</a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.accounts}" var="a">
                                            <tr>
                                                <td>${a.id}</td>
                                                <td>${a.firstName} ${a.lastName}</td>
                                                <td>${a.dob}</td>
                                                <td>${a.email}</td>
                                                <td>${a.phoneNumber}</td>
                                                <td>${a.country}</th>
                                                <td>$${a.wallet}</td>
                                                <td>${a.createdDate}</td>
                                                <td>
                                                    <a href="#" data-toggle="dropdown" class="dropdown-toggle">
                                                        <b class="caret"></b>
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="${a.id}">
                                                        <form action="manage-roles" method="post">
                                                            <input type="text" name="accountId" value="${a.id}" hidden>
                                                            <li>
                                                                <label class="checkbox">
                                                                    <input type="checkbox" name="roles" value="1">Admin
                                                                </label>
                                                            </li>
                                                            <li>
                                                                <label class="checkbox">
                                                                    <input type="checkbox" name="roles" value="2">Moderator
                                                                </label>
                                                            </li>
                                                            <li>
                                                                <label class="checkbox">
                                                                    <input type="checkbox" name="roles" value="3">Course Manager
                                                                </label>
                                                            </li>
                                                            <li>
                                                                <label class="checkbox">
                                                                    <input type="checkbox" name="roles" value="4">User
                                                                </label>
                                                            </li>
                                                            <li>
                                                                <input class="" type="submit" value="Save">
                                                            </li>
                                                        </form>
                                                    </ul>
                                                    <c:forEach items="${a.roles}" var="r">
                                                        <c:choose>
                                                            <c:when test="${r.id == 1}">
                                                                <span class="badge badge-danger badge-pill">${r.name}</span>
                                                            </c:when>
                                                            <c:when test="${r.id == 2}">
                                                                <span class="badge badge-success badge-pill">${r.name}</span>
                                                            </c:when>
                                                            <c:when test="${r.id == 3}">
                                                                <span class="badge badge-warning badge-pill">${r.name}</span>
                                                            </c:when>
                                                            <c:when test="${r.id == 4}">
                                                                <span class="badge badge-primary badge-pill">${r.name}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-primary badge-pill">${r.name}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </td>
                                                <td>${a.isPremium}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${a.isAvailable == true}">
                                                            <a class="" href="disable-account?id=${a.id}" role="button"><i class="ti-unlock"></i>Enable</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a class="" href="enable-account?id=${a.id}" role="button"><i class="ti-lock"></i>Disable</a>
                                                        </c:otherwise>
                                                    </c:choose>
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
        <!--Datatable-->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#accountsTable').DataTable();
            });
        </script>
    </body>
</html>