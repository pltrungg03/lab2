<%-- 
    Document   : commentCourse-list
    Created on : Oct 21, 2023, 1:51:45 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <style>
        .btn{
            margin-bottom: 60px;
            padding: 0 15px;
            text-align: center;
        }
        .button-56 {
            align-items: center;
            background-color: #fee6e3;
            border: 2px solid #111;
            border-radius: 8px;
            box-sizing: border-box;
            color: #111;
            cursor: pointer;
            margin-bottom: 50px;
            margin-right: 20px;
            display: flex;
            font-family: Inter,sans-serif;
            font-size: 16px;
            height: 40px;
            justify-content: center;
            line-height: 24px;
            max-width: 100%;
            padding: 0 15px;
            position: relative;
            text-align: center;
            text-decoration: none;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
        }

        .button-56:hover:after {
            transform: translate(0, 0);
        }

        .button-56:active {
            background-color: #ffdeda;
            outline: 0;
        }

        .button-56:hover {
            outline: 0;
        }

        @media (min-width: 768px) {
            .button-56 {
                padding: 0 40px;
            }
        }

        .content-table {
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            min-width: 400px;
            border-radius: 5px 5px 0 0;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        }

        .content-table thead tr {
            background-color: #009879;
            color: #ffffff;
            text-align: left;
            font-weight: bold;
        }

        .content-table th,
        .content-table td {
            padding: 12px 15px;
        }

        .content-table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .content-table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .content-table tbody tr:last-of-type {
            border-bottom: 2px solid #009879;
        }

        .content-table tbody tr.active-row {
            font-weight: bold;
            color: #009879;
        }
        .my-button {
            background-color: #4CAF50; /* Green background color */
            color: white; /* Text color */
            padding: 5px; /* Padding around the text */
            border: none; /* No border */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Cursor on hover */
        }

        .my-button:hover {
            background-color: #45a049; /* Darker green color on hover */
        }
    </style>
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
        <title>ByteScholar </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />
        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css"/>
        <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css"/>
        <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css"/>
    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- header start -->


        <%@include file="moderator-header.jsp" %>
        <%@include file="moderator-sidebar.jsp" %>

        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">

            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Lesson Comments</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="home"><i class="fa fa-home"></i>Home
                            </a></li>
                    </ul>
                </div>	
                <div class="row">

                    <!-- Your Profile Views Chart -->
                    <h6 class="ttr-material-button">

                        &nbsp;Date Comment  From: 
                        <input  class="filter-button" id="datefrom"   type="date" name="datefrom" > 
                        &nbsp;  To <input  class="filter-button" type="date"  id="dateto" name="dateto"> 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    </h6> 
                    &nbsp;&nbsp;&nbsp; <label><input  class="filter-button" id="check"  type="checkbox" value="check" name="check"> Scan bad words </label> <br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" class="button-56" id="add-button" value="Add the characters you want to check" >
                    &nbsp;&nbsp;&nbsp;   <input class="filter-button" type="text" id="textcheck" style="height: 30px; margin-top: 5px" >
                    <div class="col-lg-12 m-b30">
                        <div class="widget-inner" id="widget-inner">
                            <table id="coursesTable" class="content-table" style="width:100%" cellspacing="0">                         
                                <thead>
                                    <tr>
                                        <th>Email</th>
                                        <th>Name</th>
                                        <th style="width: 130px">Date</th>
                                        <th>Lesson Name</th>
                                        <th>Content</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody> </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Your Profile Views Chart END-->

        </main>

        <div class="ttr-overlay"></div>
        <!-- External JavaScripts -->

        <script src="admin/assets/js/jquery.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="admin/assets/vendors/masonry/masonry.js"></script>
        <script src="admin/assets/vendors/masonry/filter.js"></script>
        <script src="admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='admin/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="admin/assets/js/functions.js"></script>
        <script src="admin/assets/vendors/chart/chart.min.js"></script>
        <script src="admin/assets/js/admin.js"></script>
        <script src='admin/assets/vendors/calendar/moment.min.js'></script>
        <script src='admin/assets/vendors/calendar/fullcalendar.js'></script>
        <script src='admin/assets/vendors/switcher/switcher.js'></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <script type="text/javascript">
            document.getElementById('textcheck').style.display = 'none';
            document.getElementById('add-button').style.display = 'none';
            var display = 0;
            $('#add-button').on('click input', function () {
                if (display === 1) {
                    document.getElementById('textcheck').style.display = 'block';
                    display = 0;
                } else {
                    document.getElementById('textcheck').value = null;
                    document.getElementById('textcheck').style.display = 'none';
                    display = 1;
                }
            });
            $(document).ready(function () {
                var currentPage;
                var dataTableInstance;
                dataTableInstance = $('#coursesTable').DataTable({
                    ajax: {
                        url: '/SE1735_G5/manage-commentlesson',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            var listCmtLesson = JSON.parse(response.listCmtLesson);
                            console.log(listCmtLesson);
                            dataTableInstance.clear().rows.add(listCmtLesson).draw();
                        }
                    },
                    columns: [
                        {data: 'account.email',
                            sortable: false,
                            searchable: false
                        },
                        {
                            data: null,
                            sortable: false,
                            searchable: false,
                            render: function (data, type, row) {
                                if (type === 'display') {
                                    return data.account.firstName + ' ' + data.account.lastName;
                                }
                                // Return data for sorting, filtering, etc.
                                return data.account.firstName + ' ' + data.account.lastName;
                            }
                        },
                        {data: 'createdDate',
                            searchable: false
                        },
                        {data: 'lesson.name',
                            sortable: false
                        },
                        {data: 'comment',
                            sortable: false
                        },
                        {
                            // Thêm cột action
                            data: null,
                            sortable: false,
                            searchable: false,
                            render: function (data, type, row) {
                                return '<div class="dropdown">' +
                                        '  <button class="btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                        + '...'
                                        + ' </button>'
                                        + '       <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">'
                                        + '  <button id="alert" data-id="' + row.id + "-" + row.account.id + '" class="dropdown-item">Alert</button>'
                                        + '    <button id="button-56" data-id="' + row.id + '" class="dropdown-item">Remove</button>'
                                        + '  </div>'
                                        + '</div>';
                            }
                        }
                    ]
                });
                function filterButtonClickHandler() {
                    var from = $('#datefrom').val();
                    console.log(from);
                    var to = document.getElementById('dateto').value;
                    console.log(to);
                    var search = $('#searchname').val();
                    var check = '';
                    var textcheck = document.getElementById('textcheck').value;
                    $('input[name="check"]:checked').each(function () {
                        console.log(this.value);
                        check += this.value + ',';
                    });
                    if (check === 'check,') {
                        document.getElementById('add-button').style.display = 'block';
                    } else {
                        document.getElementById('add-button').style.display = 'none';
                        document.getElementById('textcheck').style.display = 'none';
                    }
                    $.ajax({
                        url: '/SE1735_G5/manage-commentlesson',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            from: from,
                            to: to,
                            search: search,
                            check: check,
                            textcheck: textcheck
                        },
                        success: function (response) {
                            var listCmtLesson = JSON.parse(response.listCmtLesson);
                            console.log(listCmtLesson);
                            dataTableInstance.clear().rows.add(listCmtLesson).draw();
                        }
                    });
                }
                $('.filter-button').on('click input', filterButtonClickHandler);

                dataTableInstance.on('click', '#alert', function () {
                    var dataId = $(this).attr('data-id');
                    const parameters = dataId.split('-');
                    const cmtLessonid = parameters[0];
                    const aid = parameters[1];
                    currentPage = dataTableInstance.page();
                    filterButtonClickHandler();
                    console.log(currentPage);
                    console.log(cmtLessonid);
                    console.log(aid);
                    var confirmed = confirm("Are you sure to alert this comment?");
                    if (!confirmed) {
                        return false;
                    } else {
                        showSuccessMessage('Alert comment succesfully', 'Sucess');
                        $.ajax({
                            url: "/SE1735_G5/add-alert",
                            type: "get",
                            data: {
                                cmtLessonid: cmtLessonid,
                                aid: aid
                            },
                            success: function (response) {
                                filterButtonClickHandler();

                                dataTableInstance.ajax.reload(function () {
                                    dataTableInstance.page(currentPage).draw('page');
                                });
                            },
                            error: function (error) {
                            }
                        });
                    }
                });

                dataTableInstance.on('click', '#button-56', function () {
                    var id = $(this).attr('data-id');
                    currentPage = dataTableInstance.page();
                    filterButtonClickHandler();
                    console.log(currentPage);
                    console.log(id);
                    var confirmed = confirm("Are you sure to delete comment?");
                    if (!confirmed) {
                        return false;
                    } else {
                        $.ajax({
                            url: "/SE1735_G5/manage-commentlesson?cmID=" + id,
                            type: "delete",
                            success: function (response) {
                                filterButtonClickHandler();
                                showSuccessMessage('Remove comment succesfully', 'Sucess');
                                dataTableInstance.ajax.reload(function () {
                                    dataTableInstance.page(currentPage).draw('page');
                                });
                            },
                            error: function (error) {
                            }
                        });
                    }

                });
                function showSuccessMessage(message, title) {
                    toastr.success(message, title, {showMethod: 'slideDown',
                        hideMethod: 'slideUp'});
                }

                // Hàm hiển thị thông báo lỗi
                function showErrorMessage(message, title) {
                    toastr.error(message, title, {showMethod: 'slideDown',
                        hideMethod: 'slideUp'});
                }
                function showWarningMessage(message, title) {
                    toastr.warning(message, title, {showMethod: 'slideDown',
                        hideMethod: 'slideUp'});
                }
                // Đặt tùy chọn cho Toastr
                toastr.options = {
                    preventDuplicates: true,
                    closeButton: true, // Hiển thị nút đóng thông báo
                    progressBar: true, // Hiển thị thanh tiến trình
                    positionClass: "toast-top-right", // Vị trí hiển thị thông báo
                    timeOut: 2500 // Thời gian tự động ẩn thông báo (2.5 giây)
                };
            });
        </script>
    </body>

</html>

