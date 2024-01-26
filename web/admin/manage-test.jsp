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
                            <div class="wc-title row">
                                <h4 class="col-10">${requestScope.test.name}</h4>
                                <div class="container col-2">
                                    <a href="#" data-toggle="modal" data-target="#updateTestModal"><i class="fa fa-edit">Update&nbsp;</i></a>
                                    <a href="#" onclick="removeTest(${lessonId})"><i class="fa fa-trash-o">Remove&nbsp;</i></a>
                                </div>
                            </div>
                            <div class="modal fade" id="updateTestModal" tabindex="-1"
                                 aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <form action="update-test" method="post" class="modal-content">
                                        <input type="text" class="form-control" name="testId" id="testId" value="${requestScope.test.id}" hidden readonly>
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addNewEventModalLabel">Update Test</h5>
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
                                                            <input type="number" min="0" max="180" step="1" class="form-control" name="testTime" id="testTime" value="${test.id}"
                                                                   placeholder="Enter time (minute)" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="quizAnswer" class="form-label">Passing Score (required):</label>
                                                        <div class="input-group">
                                                            <input type="number" min="0" max="10" step="0.1" class="form-control" name="testThreshold" id="testThreshold" value="${test.threshold}"
                                                                   placeholder="Enter the minimum passing score on scale of 10" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 mb-3 floating">
                                                        <label for="quizQuestion" class="form-label">Test Name (required):</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="testName" id="testName" value="${test.name}"
                                                                   placeholder="Enter test name" required>
                                                        </div>
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
                            <div class="widget-inner">
                                <nav class="ttr-sidebar-navi container-fluid">
                                    <ul>
                                        <c:if test="${requestScope.quizzes.size() == 0}">
                                            <li class="mt-1 mb-3">There's no question yet!</li>
                                        </c:if>
                                        <c:forEach items="${requestScope.quizzes}" var="q">
                                            <li>
                                                <a href="#" class="ttr-material-button" style="z-index: 10">
                                                    <span class="ttr-icon"><i class="ti-book"></i></span>
                                                    <span class="ttr-label">${q.order}. ${q.question}</span>
                                                    <span class="ttr-icon" style="z-index: 100" data-toggle="modal" data-target="#updateQuizModal_${q.id}"><i class="fa fa-edit">Update&nbsp;</i></span>
                                                    <span class="ttr-icon" style="z-index: 100" onclick="removeQuiz(${q.id})"><i class="fa fa-trash">Remove&nbsp;</i></span>
                                                    <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                                                </a>
                                                <ul class="col-11">
                                                    <li>
                                                        <a href="#" class="ttr-material-button">
                                                            <span class="ttr-label">A. ${q.answerA} &nbsp;<c:if test="${q.answer == 1}"><i class="fa fa-check"></i></c:if></span>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#" class="ttr-material-button">
                                                                <span class="ttr-label">B. ${q.answerB} &nbsp;<c:if test="${q.answer == 2}"><i class="fa fa-check"></i></c:if></span>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#" class="ttr-material-button">
                                                                <span class="ttr-label">C. ${q.answerC} &nbsp;<c:if test="${q.answer == 3}"><i class="fa fa-check"></i></c:if></span>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#" class="ttr-material-button">
                                                                <span class="ttr-label">D. ${q.answerD} &nbsp;<c:if test="${q.answer == 4}"><i class="fa fa-check"></i></c:if></span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <div class="modal fade" id="updateQuizModal_${q.id}" tabindex="-1"
                                                 aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <form action="update-quiz" method="post" class="modal-content">
                                                        <input type="text" class="form-control" name="lessonId" id="lessonId" value="${lessonId}" hidden readonly>
                                                        <input type="text" class="form-control" name="quizId" id="quizId" value="${q.id}" hidden readonly>
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="addNewEventModalLabel">Update Quiz</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <div class="col-md-6 mb-3 floating">
                                                                        <label for="lessonOrder" class="form-label">Order (required):</label>
                                                                        <div class="input-group">
                                                                            <input type="number" mix="0" step="1" class="form-control" name="quizOrder" id="lessonOrder" value="${q.order}"
                                                                                   placeholder="Enter lesson order" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3 floating">
                                                                        <label for="quizAnswer" class="form-label">Answer:</label>
                                                                        <div class="input-group">
                                                                            <input type="number" mix="1" max="4" step="1" class="form-control" name="quizAnswer" id="quizAnswer" value="${q.answer}"
                                                                                   placeholder="Enter answer (1 - 4)" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12 mb-3 floating">
                                                                        <label for="quizQuestion" class="form-label">Question:</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" name="quizQuestion" id="quizQuestion" value="${q.question}"
                                                                                   placeholder="Enter question" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3 floating">
                                                                        <label for="quizAnswerA" class="form-label">Answer 1:</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" name="quizAnswerA" id="quizAnswerA" value="${q.answerA}"
                                                                                   placeholder="Answer 1" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3 floating">
                                                                        <label for="quizAnswerB" class="form-label">Answer 2:</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" name="quizAnswerB" id="quizAnswerB" value="${q.answerB}"
                                                                                   placeholder="Answer 2" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3 floating">
                                                                        <label for="quizAnswerC" class="form-label">Answer 3:</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" name="quizAnswerC" id="quizAnswerC" value="${q.answerC}"
                                                                                   placeholder="Answer 3" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6 mb-3 floating">
                                                                        <label for="quizAnswerD" class="form-label">Answer 4:</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" name="quizAnswerD" id="quizAnswerD" value="${q.answerD}"
                                                                                   placeholder="Answer 4" required>
                                                                        </div>
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
                                        <li data-toggle="modal" data-target="#addQuizModal">
                                            <a href="#" class="ttr-material-button" style="z-index: 10">
                                                <span class="ttr-label"><i class="ti-plus"></i>&emsp;Add Question</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>

                            <div class="modal fade" id="addQuizModal" tabindex="-1"
                                 aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <form action="create-quiz" method="post" class="modal-content">
                                        <input type="text" class="form-control" name="lessonId" id="lessonId" value="${requestScope.lessonId}" hidden readonly>
                                        <input type="text" class="form-control" name="testId" id="testId" value="${requestScope.test.id}" hidden readonly>
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addNewEventModalLabel">Add Quiz</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="lessonOrder" class="form-label">Order (required):</label>
                                                        <div class="input-group">
                                                            <input type="number" mix="0" step="1" class="form-control" name="quizOrder" id="lessonOrder"
                                                                   placeholder="Enter lesson order" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="quizAnswer" class="form-label">Answer:</label>
                                                        <div class="input-group">
                                                            <input type="number" mix="1" max="4" step="1" class="form-control" name="quizAnswer" id="quizAnswer"
                                                                   placeholder="Enter answer (1 - 4)" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 mb-3 floating">
                                                        <label for="quizQuestion" class="form-label">Question:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="quizQuestion" id="quizQuestion"
                                                                   placeholder="Enter question" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="quizAnswerA" class="form-label">Answer 1:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="quizAnswerA" id="quizAnswerA"
                                                                   placeholder="Answer 1" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="quizAnswerB" class="form-label">Answer 2:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="quizAnswerB" id="quizAnswerB"
                                                                   placeholder="Answer 2" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="quizAnswerC" class="form-label">Answer 3:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="quizAnswerC" id="quizAnswerC"
                                                                   placeholder="Answer 3" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 mb-3 floating">
                                                        <label for="quizAnswerD" class="form-label">Answer 4:</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="quizAnswerD" id="quizAnswerD"
                                                                   placeholder="Answer 4" required>
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
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>
        <script>
            function removeTest(lessonId) {
                if (confirm("Are you sure you want to remove this test?")) {
                    window.location.href = "remove-test?lessonId=" + lessonId
                }
            }
        </script>
        <script type="text/javascript">
            function removeQuiz(quizId) {
                if (confirm("Are you sure you want to remove this chapter?")) {
                    window.location.href = "remove-quiz?lessonId=" + ${lessonId} + "&quizId=" + quizId;
                }
            }
            function addQuiz() {
                var form = document.getElementById("addLessonForm");
                var lessonId = form.querySelector('[name="lessonId"]').value;
                var testId = form.querySelector('[name="testId"]').value;
                var quizOrder = form.querySelector('[name="quizOrder"]').value;
                var quizQuestion = form.querySelector('[name="quizQuestion"]').value;
                var quizAnswer = form.querySelector('[name="quizAnswer"]').value;
                var quizAnswerA = form.querySelector('[name="quizAnswerA"]').value;
                var quizAnswerB = form.querySelector('[name="quizAnswerB"]').value;
                var quizAnswerC = form.querySelector('[name="quizAnswerC"]').value;
                var quizAnswerD = form.querySelector('[name="quizAnswerD"]').value;


                $.ajax({
                    type: 'POST',
                    url: 'create-quiz',
                    data: {
                        lessonId: lessonId,
                        testId: testId,
                        quizOrder: quizOrder,
                        quizQuestion: quizQuestion,
                        quizAnswer: quizAnswer,
                        quizAnswerA: quizAnswerA,
                        quizAnswerB: quizAnswerB,
                        quizAnswerC: quizAnswerC,
                        quizAnswerD: quizAnswerD,
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