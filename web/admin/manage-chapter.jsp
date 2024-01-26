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
                                <h4>Manage Chapter</h4>
                            </div>
                            <div class="widget-inner">
                                <form id="f" class="edit-profile m-b30" method="post" action="manage-chapter">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>1. Chapter info</h3>
                                            </div>
                                        </div>
                                        <div class="form-group col-1">
                                            <label class="col-form-label">Chapter Id</label>
                                            <div>
                                                <input class="form-control" type="text" name="chapterId" value="${requestScope.chapterId}" readonly>
                                            </div>
                                        </div>
                                        <div class="form-group col-1">
                                            <label class="col-form-label">Chapter Order</label>
                                            <div>
                                                <input class="form-control" type="text" name="chapterOrder" value="${requestScope.chapterOrder}" readonly>
                                            </div>
                                        </div>
                                        <div class="form-group col-10">
                                            <label class="col-form-label">Chapter Name</label>
                                            <div>
                                                <input class="form-control" type="text" name="chapterName" value="${requestScope.chapterName}" required>
                                            </div>
                                        </div>

                                        <div class="seperator"></div>

                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>2. Lessons info</h3>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <table id="item-add" style="width:100%;">
                                                <c:choose>
                                                    <c:when test="${requestScope.lessons.size() == 0}">
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
                                                        <c:forEach items="${requestScope.lessons}" var="l">
                                                            <tr class="list-item">
                                                                <td>
                                                                    <div class="row">
                                                                        <div class="col-md-1">
                                                                            <label class="col-form-label">Order</label>
                                                                            <div>
                                                                                <input value="${l.id}" name="lessonsId" hidden>
                                                                                <input class="form-control" type="text" min="0" step="1" name="lessonsOrder" value="${l.order}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <label class="col-form-label">Name</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="lessonsName" value="${l.name}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <label class="col-form-label">Test</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="lessonsTestId" value="${l.test.name == null ? "None" : l.test.id}" hidden>
                                                                                <input class="form-control" type="text" name="lessonsTestName" value="${l.test.name == null ? "None" : l.test.name}" readonly>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-1">
                                                                            <label class="col-form-label">Test Details</label>
                                                                            <div class="form-group">
                                                                                <c:choose>
                                                                                    <c:when test="${l.test == null}">
                                                                                        <a type="button" href="manage-test?lessonId=${l.id}" class="btn btn-primary" onclick="" href="#">Create</a>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <a type="button" href="manage-test?lessonId=${l.id}" class="btn-secondry" onclick="" href="#">Update</a>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-1">
                                                                            <label class="col-form-label">Remove</label>
                                                                            <div class="form-group">
                                                                                <a class="delete" onclick="removeLesson(${l.id})" href="#"><i class="fa fa-close"></i></a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <label class="col-form-label">Video Url</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="lessonsVideoUrl" value="${l.videoUrl}">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group col-12">
                                                                            <label class="col-form-label">Content</label>
                                                                            <div>
                                                                                <textarea class="summernote" name="lessonsContent" required>${l.content}</textarea>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </table>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="col-form-label"></label>
                                        </div>
                                        <div class="col-12">
                                            <button type="submit" class="btn m-r5" onclick="submitForm()">Save Changes</button>
                                            <button type="button" class="btn-secondry m-r5" data-toggle="modal" data-target="#addLessonModal">Add Lesson</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal fade" id="addLessonModal" tabindex="-1"
                                 aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <form action="create-lesson" method="post" class="modal-content">
                                        <input type="text" class="form-control" name="chapterId" id="chapterId" value="${requestScope.chapterId}" hidden readonly>
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addNewEventModalLabel">Add Chapter</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-md-3 mb-3 floating">
                                                        <label for="discount" class="form-label">Order (required):</label>
                                                        <div class="input-group">
                                                            <input type="number" class="form-control" name="lessonOrder" id="lessonOrder"
                                                                   placeholder="Enter lesson order">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-9 mb-3 floating">
                                                        <label for="discount" class="form-label">Name:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="lessonName" id="lessonName"
                                                                   placeholder="Enter lesson name" required="">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 mb-3 floating">
                                                        <label for="discount" class="form-label">Video Url:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="lessonVideoUrl" id="lessonVideoUrl"
                                                                   placeholder="Enter video url (optional)">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 mb-3 floating">
                                                        <label class="col-form-label">Content:</label>
                                                        <div>
                                                            <textarea class="summernote" name="lessonContent" required>${l.content}</textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="submit" class="btn mr-auto" value="Add" onclick="addLesson()">
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
            function submitForm() {
                var form = document.getElementById("f");
                form.action = "manage-chapter";
                form.method = "post";
                form.submit();
            }
            function removeLesson(lessonId) {
                if (confirm("Are you sure you want to remove this lesson?")) {
                    $.ajax({
                        type: 'POST',
                        url: 'remove-lesson',
                        data: {
                            chapterId: ${requestScope.chapterId},
                            lessonId: lessonId
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
            function addLesson() {
                var form = document.getElementById("addLessonForm");
                var chapterId = form.querySelector('[name="chapterId"]').value;
                var lessonOrder = form.querySelector('[name="lessonOrder"]').value;
                var lessonName = form.querySelector('[name="lessonName"]').value;
                var lessonVideoUrl = form.querySelector('[name="lessonVideoUrl"]').value;
                var lessonContent = form.querySelector('[name="lessonContent"]').value;


                $.ajax({
                    type: 'POST',
                    url: 'create-lesson',
                    data: {
                        chapterId: chapterId,
                        lessonOrder: lessonOrder,
                        lessonName: lessonName,
                        lessonVideoUrl: lessonVideoUrl,
                        lessonContent: lessonContent
                    },
                    success: function (response) {
                        console.log('Lesson added successfully.');
                        alert("Lesson added successfully!");
                        $('#addLessonModal').modal('hide');
                    },
                    error: function (error) {
                        console.error('Error adding lesson:', error);
                        alert("Error adding lesson!");
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
        <script>
            $(document).ready(function () {
                $('.summernote').summernote({
                    height: 300,
                    tabsize: 2
                });
            });
        </script>
    </body>
</html>
