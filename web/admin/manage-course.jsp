<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png" />
        <title>Byte Scholar</title>

        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/summernote/summernote.css">
        <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/file-upload/imageuploadify.min.css">
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
                            <div class="wc-title row">
                                <h4 class="col-10">${requestScope.course.name}</h4>
                                <div class="container col-2">
                                    <a href="update-course?id=${requestScope.course.id}"><i class="fa fa-edit">Update&nbsp;</i></a>
                                    <a href="#" onclick="confirmAndRemoveCourse(${requestScope.course.id})"><i class="fa fa-trash-o">Remove&nbsp;</i></a>
                                </div>
                            </div>
                            <div class="widget-inner">
                                <nav class="ttr-sidebar-navi container-fluid">
                                    <ul>
                                        <c:if test="${requestScope.course.chapters.size() == 0}">
                                            <li class="mt-1 mb-3">There's no chapter yet!</li>
                                            </c:if>
                                            <c:forEach items="${requestScope.course.chapters}" var="ch">
                                            <li>
                                                <a href="#" class="ttr-material-button" style="z-index: 10">
                                                    <span class="ttr-icon"><i class="ti-bookmark"></i></span>
                                                    <span class="ttr-label">Chapter ${ch.order}: ${ch.name}</span>
                                                    <span class="ttr-icon" style="z-index: 100" data-toggle="modal" data-target="#updateChapterModal_${ch.id}"><i class="fa fa-edit">Update&nbsp;</i></span>
                                                    <span class="ttr-icon" style="z-index: 100" onclick="removeChapter(${ch.id})"><i class="fa fa-trash">Remove&nbsp;</i></span>
                                                    <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>                                                
                                                </a>
                                                <ul>
                                                    <c:forEach items="${ch.lessons}" var="l">
                                                        <li>
                                                            <a href="#" class="ttr-material-button" style="z-index: 10">
                                                                <c:if test="${l.test == null}">
                                                                    <span class="ttr-label"><i class="ti-book"></i>&emsp;${l.name}</span>
                                                                    <span class="ttr-icon" style="z-index: 100" data-toggle="modal" data-target="#addTestModal_${l.id}"><i class="fa fa-plus-square-o">Add Test&nbsp;&nbsp;&nbsp;&nbsp;</i></span>
                                                                </c:if>
                                                                <c:if test="${l.test != null}">
                                                                    <span class="ttr-label"><i class="ti-pencil-alt"></i>&emsp;${l.name}</span>
                                                                    <span class="ttr-icon" style="z-index: 100" onclick="viewTest(${l.id})"><i class="fa fa-list">View Test&nbsp;&nbsp;</i></span>
                                                                    <span class="ttr-icon" style="z-index: 100" onclick="removeTest(${l.id})"><i class="fa fa-trash-o">Remove Test&nbsp;&nbsp;</i></span>
                                                                </c:if>
                                                                <span class="ttr-icon" style="z-index: 100" data-toggle="modal" data-target="#updateLessonModal_${l.id}"><i class="fa fa-edit">Update&nbsp;&nbsp;</i></span>
                                                                <span class="ttr-icon" style="z-index: 100" onclick="removeLesson(${l.id})"><i class="fa fa-trash">Remove&nbsp;&nbsp;</i></span>
                                                            </a>
                                                        </li>
                                                        <div class="modal fade" id="addTestModal_${l.id}" tabindex="-1"
                                                             aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-lg">
                                                                <form action="create-test" method="post" class="modal-content">
                                                                    <input type="text" class="form-control" name="lessonId" id="lessonId" value="${l.id}" hidden readonly>
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="addNewEventModalLabel">Add Test</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="container-fluid">
                                                                            <div class="row">
                                                                                <div class="col-md-6 mb-3 floating">
                                                                                    <label for="lessonOrder" class="form-label">Time (required):</label>
                                                                                    <div class="input-group">
                                                                                        <input type="number" min="0" max="180" step="1" class="form-control" name="testTime" id="testTime"
                                                                                               placeholder="Enter time (minute)" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-6 mb-3 floating">
                                                                                    <label for="quizAnswer" class="form-label">Passing Score (required):</label>
                                                                                    <div class="input-group">
                                                                                        <input type="number" min="0" max="10" step="0.1" class="form-control" name="testThreshold" id="testThreshold"
                                                                                               placeholder="Enter the minimum passing score on scale of 10" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-12 mb-3 floating">
                                                                                    <label for="quizQuestion" class="form-label">Test Name (required):</label>
                                                                                    <div class="input-group">
                                                                                        <input type="text" class="form-control" name="testName" id="testName"
                                                                                               placeholder="Enter test name" required>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <input type="submit" class="btn mr-auto" value="Add" onclick="addQuiz()">
                                                                        <button type="button" class="btn-secondry m-r5" data-dismiss="modal" aria-label="Close">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                        <div class="modal fade" id="updateLessonModal_${l.id}" tabindex="-1"
                                                             aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-lg">
                                                                <form action="update-lesson" id="updateLessonForm" method="post" class="modal-content">
                                                                    <input type="number" class="form-control" name="courseId" id="courseId" value="${requestScope.course.id}" hidden readonly>
                                                                    <input type="number" class="form-control" name="chapterId" id="chapterId" value="${ch.id}" hidden readonly>
                                                                    <input type="number" class="form-control" name="lessonId" id="lessonId" value="${l.id}" hidden readonly>
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="addNewEventModalLabel">Update Lesson</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="container-fluid">
                                                                            <div class="row">
                                                                                <div class="col-md-12 mb-3 floating" readonly hidden>
                                                                                    <label for="discount" class="form-label">Id:</label>
                                                                                    <div class="input-group">
                                                                                        <input type="number" class="form-control" name="lessonId" id="lessonId" value="${l.id}"
                                                                                               placeholder="Enter lesson order">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-3 mb-3 floating">
                                                                                    <label for="discount" class="form-label">Order (required):</label>
                                                                                    <div class="input-group">
                                                                                        <input type="number" min="0" step="1" class="form-control" name="lessonOrder" id="lessonOrder" value="${l.order}"
                                                                                               placeholder="Enter lesson order">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-9 mb-3 floating">
                                                                                    <label for="discount" class="form-label">Name:</label>
                                                                                    <div class="input-group">
                                                                                        <input type="text" class="form-control" name="lessonName" id="lessonName" value="${l.name}"
                                                                                               placeholder="Enter lesson name" required="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-12 mb-3 floating">
                                                                                    <label for="discount" class="form-label">Video Url:</label>
                                                                                    <div class="input-group">
                                                                                        <input type="text" class="form-control" name="lessonVideoUrl" id="lessonVideoUrl" value="${l.videoUrl}"
                                                                                               placeholder="Enter video url (optional)">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-12 mb-3 floating">
                                                                                    <label class="col-form-label">Content:</label>
                                                                                    <div>
                                                                                        <textarea class="summernote" name="lessonContent" required>${l.content}</textarea>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-12 mb-3 floating" hidden>
                                                                                    <label for="discount" class="form-label">Test Id:</label>
                                                                                    <div class="input-group">
                                                                                        <input type="number" class="form-control" name="lessonTestId" id="lessonTestId" value="${l.test.id == null ? -1 : l.test.id}"
                                                                                               placeholder="There is no test yet!">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <input type="submit" class="btn m-r5" value="Save Changes">
                                                                        <input type="button" class="btn m-r5" onclick="" value="Add Test">
                                                                        <button type="button" class="btn-secondry m-r5" data-dismiss="modal" aria-label="Close">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>  
                                                    </c:forEach>
                                                    <li data-toggle="modal" data-target="#addLessonModal_${ch.id}">
                                                        <a href="#" class="ttr-material-button" style="z-index: 10">
                                                            <span class="ttr-label">&emsp;&emsp;<i class="ti-plus"></i>&emsp;Add Lesson</span>
                                                        </a>
                                                    </li>
                                                    <div class="modal fade" id="addLessonModal_${ch.id}" tabindex="-1"
                                                         aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <form action="create-lesson" method="post" class="modal-content">
                                                                <input type="text" class="form-control" name="courseId" id="courseId" value="${course.id}" hidden readonly>
                                                                <input type="text" class="form-control" name="chapterId" id="chapterId" value="${ch.id}" hidden readonly>
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="addNewEventModalLabel">Add Lesson</h5>
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
                                                                                    <textarea class="summernote" name="lessonContent" required></textarea>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <input type="submit" class="btn mr-auto" value="Add">
                                                                    <button type="button" class="btn-secondry m-r5" data-dismiss="modal" aria-label="Close">Cancel</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div> 
                                                </ul>
                                            </li>
                                            <div class="modal fade" id="updateChapterModal_${ch.id}" tabindex="-1"
                                                 aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <form action="update-chapter" method="post" class="modal-content">
                                                        <input type="text" class="form-control" name="courseId" id="courseId" value="${requestScope.course.id}" hidden readonly>
                                                        <input type="text" class="form-control" name="chapterId" id="chapterId" value="${ch.id}" hidden readonly>
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="addNewEventModalLabel">Update Chapter</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div>
                                                                <div class="mb-3 floating">
                                                                    <label for="discount" class="form-label">Order:</label>
                                                                    <div class="input-group">
                                                                        <input type="number" min="0" step="1" class="form-control" name="chapterOrder" id="chapterOrder" value="${ch.order}"
                                                                               placeholder="Enter chapter order">
                                                                    </div>
                                                                </div>
                                                                <div class="mb-3 floating">
                                                                    <label for="discount" class="form-label">Name:</label>
                                                                    <div class="input-group">
                                                                        <input type="text" class="form-control" name="chapterName" id="chapterName" value="${ch.name}"
                                                                               placeholder="Enter chapter name">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <input type="submit" class="btn mr-auto" value="Update">
                                                            <button type="button" class="btn-secondry m-r5" data-dismiss="modal" aria-label="Close">Cancel</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <li data-toggle="modal" data-target="#addChapterModal">
                                            <a href="#" class="ttr-material-button" style="z-index: 10">
                                                <span class="ttr-icon"><i class="ti-plus"></i></span>
                                                <span class="ttr-label">Add Chapter</span>
                                            </a>  
                                        </li>
                                        <div class="modal fade" id="addChapterModal" tabindex="-1"
                                             aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <form action="create-chapter" method="post" class="modal-content">
                                                    <input type="text" class="form-control" name="courseId" id="courseId" value="${requestScope.course.id}" hidden readonly>
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="addNewEventModalLabel">Add Chapter</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div>
                                                            <div class="mb-3 floating">
                                                                <label for="discount" class="form-label">Order:</label>
                                                                <div class="input-group">
                                                                    <input type="number" min="0" step="1" class="form-control" name="chapterOrder" id="chapterOrder"
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
                                                        <input type="submit" class="btn mr-auto" value="Add">
                                                        <button type="button" class="btn-secondry m-r5" data-dismiss="modal" aria-label="Close">Cancel</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <script>
            function viewTest(lessonId) {
                window.location.href = "manage-test?lessonId=" + lessonId;
            }
            function removeTest(lessonId) {
                if (confirm("Are you sure you want to remove this test?")) {
                    $.ajax({
                        type: 'POST',
                        url: 'remove-test',
                        data: {
                            courseId: ${requestScope.course.id},
                            lessonId: lessonId
                        },
                        success: function (response) {
                            console.log('Test removed successfully.');
                            alert("Remove success!");
                            location.reload();
                        },
                        error: function (error) {
                            console.error('Error removing test:', error);
                            alert("Remove failed!");
                        }
                    });
                }
            }
        </script>
        <script type="text/javascript">
            function confirmAndRemoveCourse(courseId) {
                if (confirm("Are you sure you want to remove this course?")) {
                    removeCourse(courseId);
                }
            }
            function removeCourse(courseId) {
                $.ajax({
                    type: 'POST',
                    url: 'remove-course?id=' + courseId,
                    success: function (response) {
                        console.log('Course removed successfully.');
                    },
                    error: function (error) {
                        console.error('Error removing course:', error);
                    }
                });
            }

        </script>
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
                            courseId: ${requestScope.course.id},
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
        <script type="text/javascript">
            function removeLesson(lessonId) {
                if (confirm("Are you sure you want to remove this lesson?")) {
                    var courseId = ${requestScope.course.id};
                    window.location.href = "remove-lesson?lessonId=" + lessonId + "&courseId=" + courseId;
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
                        $('#updateLessonModal').modal('hide');
                    },
                    error: function (error) {
                        console.error('Error adding lesson:', error);
                        alert("Error adding lesson!");
                    }
                });
            }
            function updateLesson() {
                var form = document.getElementById("updateLessonForm");
                var chapterId = form.querySelector('[name="chapterId"]').value;
                var lessonId = form.querySelector('[name="lessonId"]').value;
                var lessonOrder = form.querySelector('[name="lessonOrder"]').value;
                var lessonName = form.querySelector('[name="lessonName"]').value;
                var lessonVideoUrl = form.querySelector('[name="lessonVideoUrl"]').value;
                var lessonContent = form.querySelector('[name="lessonContent"]').value;
                var lessonTestId = form.querySelector('[name="lessonTestId"]').value;


                $.ajax({
                    type: 'POST',
                    url: 'update-lesson',
                    data: {
                        chapterId: chapterId,
                        lessonId: lessonId,
                        lessonOrder: lessonOrder,
                        lessonName: lessonName,
                        lessonVideoUrl: lessonVideoUrl,
                        lessonContent: lessonContent,
                        lessonTestId: lessonTestId
                    },
                    success: function (response) {
                        console.log('Lesson updated successfully.');
                        alert("Lesson updated successfully!");
                        $('#updateLessonModal').modal('hide');
                    },
                    error: function (error) {
                        console.error('Error updating lesson:', error);
                        alert("Error updating lesson!");
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