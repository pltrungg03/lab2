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
                                <h4>Update Course</h4>
                            </div>
                            <div class="widget-inner">
                                <form id="f" class="edit-profile m-b30" method="get" action="update-course">
                                    <div class="row">
<!--                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>1. Course info</h3>
                                            </div>
                                        </div>-->
                                        <div class="form-group col-1">
                                            <label class="col-form-label">Course Id</label>
                                            <div>
                                                <select id="courseSelect" class="form-select" name="id" onchange="getCourse()">
                                                    <option value="0"></option>
                                                    <c:forEach items="${requestScope.courses}" var="c">
                                                        <option value="${c.id}" ${c.id == id ? "selected" : ""}>${c.id}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-5">
                                            <label class="col-form-label">Course name</label>
                                            <div>
                                                <input class="form-control" type="text" name="name" value="${requestScope.name}" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Course image (url only)</label>
                                            <div>
                                                <input class="form-control" type="text" name="image" value="${requestScope.image}" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Price ($)</label>
                                            <div>
                                                <input class="form-control" type="number" min="0" step="any" name="price" value="${requestScope.price}" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Discount</label>
                                            <div>
                                                <input class="form-control" type="number" min="0" max="1" step="0.01" name="discount" value="${requestScope.discount}" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Created date (YYYY-MM-DD)</label>
                                            <div>
                                                <input class="form-control" type="text" name="createdDate" value="${requestScope.createdDate}" disabled>
                                            </div>
                                        </div>
                                        <div class="form-group col-3">
                                            <label class="col-form-label">Major</label>
                                            <div>
                                                <select class="form-select" name="major">
                                                    <c:forEach items="${requestScope.majors}" var="m">
                                                        <option value="${m.id}" ${m.id == majorId ? "selected" : ""}>${m.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-3">
                                            <label class="col-form-label">Level</label>
                                            <div>
                                                <select class="form-select" name="level">
                                                    <c:forEach items="${requestScope.levels}" var="l">
                                                        <option value="${l.id}" ${l.id == levelId ? "selected" : ""}>${l.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>                                        

                                        <div class="form-group col-12">
                                            <label class="col-form-label">Course description</label>
                                            <div>
                                                <textarea class="summernote" name="description" required>${requestScope.description}</textarea>
                                            </div>
                                        </div>

                                        <div class="seperator"></div>
<!--
                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>2. Chapter info</h3>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <table id="item-add" style="width:100%;">
                                                <c:choose>
                                                    <c:when test="${requestScope.chapters.size() == 0}">
                                                        <tr class="list-item">
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <label class="col-form-label">There is no lesson yet!</label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${requestScope.chapters}" var="ch">
                                                            <tr class="list-item">
                                                                <td>
                                                                    <div class="row">
                                                                        <div class="col-md-2">
                                                                            <label class="col-form-label">Index</label>
                                                                            <div>
                                                                                <input value="${ch.id}" name="chaptersId" hidden>
                                                                                <input class="form-control" type="number" min="0" step="1" value="${ch.order}" name="chaptersOrder" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label class="col-form-label">Name</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" value="${ch.name}" name="chaptersName" required>
                                                                            </div>
                                                                        </div>
                                                                        <c:if test="${ch.id != null}">
                                                                            <div class="col-md-2">
                                                                                <label class="col-form-label">Details</label>
                                                                                <div class="form-group">
                                                                                    <a class="btn-secondry" href="manage-chapter?id=${ch.id}">View</a>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                        <div class="col-md-2">
                                                                            <label class="col-form-label">Remove</label>
                                                                            <div class="form-group">
                                                                                <a class="delete" onclick="removeChapter(${ch.id})" href="#"><i class="fa fa-close"></i></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </table>
                                        </div>-->
                                        <div class="col-md-12">
                                            <label class="col-form-label"></label>
                                        </div>
                                        <div class="col-12">
                                            <input type="submit" class="btn m-r5" value="Save Changes" onclick="updateCourse()">
                                            <a href="manage-course?courseId=${id}" type="button" class="btn-secondry">View Chapters</a>
                                            <!--<button type="button" class="btn-secondry m-r5" data-toggle="modal" data-target="#addChapterModal">Add Chapter</button>-->
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal fade" id="addChapterModal" tabindex="-1"
                                 aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <form action="create-chapter" method="post" class="modal-content">
                                        <input type="text" class="form-control" name="courseId" id="courseId" value="${requestScope.id}" hidden readonly>
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addNewEventModalLabel">Add Chapter</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div>
                                                <div class="mb-3 floating">
                                                    <label for="discount" class="form-label">Index:</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" name="chapterOrder" id="chapterOrder"
                                                               placeholder="Enter chapter order">
                                                    </div>
                                                </div>
                                                <div class="mb-3 floating">
                                                    <label for="discount" class="form-label">Name:</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" name="chapterName" id="chapterName"
                                                               placeholder="Enter chapter name">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="submit" class="btn mr-auto" value="Add" onclick="addChapter()">
                                            <button type="button" class="btn-secondry m-r5" data-dismiss="modal" aria-label="Close">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>
        <script type="text/javascript">
            function getCourse() {
                var form = document.getElementById("f");
                form.action = "update-course";
                form.method = "get";
                form.submit();
            }
            function updateCourse() {
                var form = document.getElementById("f");

                // check default course
                var courseId = document.getElementById("courseSelect").value;
                if (courseId === "0") {
                    alert("Please select a valid course.");
                    return;
                }

                // check duplicate order & empty name input
                var chaptersOrderElements = document.getElementsByName("chaptersOrder");
                var chaptersNameElements = document.getElementsByName("chaptersName");
                var orderSet = new Set();

                for (var i = 0; i < chaptersOrderElements.length; i++) {
                    var order = chaptersOrderElements[i].value;
                    var name = chaptersNameElements[i].value;

                    // Kiểm tra xem order đã tồn tại hay chưa
                    if (orderSet.has(order)) {
                        alert("Duplicate chapter order: " + order);
                        return;
                    }

                    orderSet.add(order);

                    // check order & empty name field
                    if (!order || !name) {
                        alert("Please fill in both Index and Name fields in the Chapter info section.");
                        return;
                    }
                }

                form.action = "update-course";
                form.method = "post";
                form.submit();
            }
        </script>
        <script type="text/javascript">
            function removeChapter(chapterId) {
                if (confirm("Are you sure you want to remove this chapter?")) {
                    $.ajax({
                        type: 'POST',
                        url: 'remove-chapter',
                        data: {
                            courseId: ${requestScope.id},
                            chapterId: chapterId
                        },
                        success: function (response) {
                            console.log('Chapter removed successfully.');
                            alert("Remove success!");
                            location.reload();
                        },
                        error: function (error) {
                            console.error('Error removing chapter:', error);
                            alert("Remove failed!");
                        }
                    });
                }
            }
            function addChapter() {
                var form = document.getElementById("addChapterForm");
                var courseId = form.querySelector('[name="courseId"]').value;
                var chapterOrder = form.querySelector('[name="chapterOrder"]').value;
                var chapterName = form.querySelector('[name="chapterName"]').value;

                $.ajax({
                    type: 'POST',
                    url: 'create-chapter',
                    data: {
                        courseId: courseId,
                        chapterOrder: chapterOrder,
                        chapterName: chapterName
                    },
                    success: function (response) {
                        console.log('Chapter added successfully.');
                        alert("Chapter added successfully!");
                        $('#addChapterModal').modal('hide');
                    },
                    error: function (error) {
                        console.error('Error adding chapter:', error);
                        alert("Error adding chapter!");
                    }
                });
            }
        </script>
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
        <script src="./admin/assets/vendors/file-upload/imageuploadify.min.js"></script>
        <script>
            $(document).ready(function () {
                $('.summernote').summernote({
                    height: 200,
                    tabsize: 2
                });
            });
        </script>
    </body>
</html>