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
                                <h4>Create Test</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" method="post" action="create-test">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>1. Test info</h3>
                                                <input class="form-control" type="text" name="lessonId" value="${requestScope.lessonId}" hidden>

                                            </div>
                                        </div>
                                        <div class="form-group col-1">
                                            <label class="col-form-label">Test Id</label>
                                            <div>
                                                <input class="form-control" type="number" name="testId" value="${requestScope.test.id}" readonly>
                                            </div>
                                        </div>
                                        <div class="form-group col-7">
                                            <label class="col-form-label">Test name</label>
                                            <div>
                                                <input class="form-control" type="text" name="testName" value="${requestScope.test.name}" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Time (Minutes)</label>
                                            <div>
                                                <input class="form-control" type="number" min="1" step="1" name="testTime" required>
                                            </div>
                                        </div>
                                        <div class="form-group col-2">
                                            <label class="col-form-label">Threshold (Pass score)</label>
                                            <div>
                                                <input class="form-control" type="number" min="0" step="any" name="testThreshold" value="${requestScope.test.threshold}" required>
                                            </div>
                                        </div>                                        
                                        <div class="seperator"></div>

                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>2. Quiz</h3>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <table id="item-add" style="width:100%;">
                                                <c:choose>
                                                    <c:when test="${requestScope.quizzes.size() == 0 || requestScope.quizzes == null}">
                                                        <tr class="list-item">
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-md-1">
                                                                        <label class="col-form-label">Order</label>
                                                                        <div>
                                                                            <input class="form-control" type="number" min="1" step="1" value="" name="quizzesOrder" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-9">
                                                                        <label class="col-form-label">Question</label>
                                                                        <div>
                                                                            <input class="form-control" type="text" value="" name="quizzesQuestion" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-1">
                                                                        <label class="col-form-label">Answer</label>
                                                                        <div>
                                                                            <input class="form-control" type="text" min="1" max="4" step="1" value="" name="quizzesAnswer" required>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-5">
                                                                        <label class="col-form-label">Answer 1</label>
                                                                        <div>
                                                                            <input class="form-control" type="text" value="" name="quizzesAnswerA" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-5">
                                                                        <label class="col-form-label">Answer 2</label>
                                                                        <div>
                                                                            <input class="form-control" type="text" value="" name="quizzesAnswerB" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-5">
                                                                        <label class="col-form-label">Answer 3</label>
                                                                        <div>
                                                                            <input class="form-control" type="text" value="" name="quizzesAnswerC" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-5">
                                                                        <label class="col-form-label">Answer 4</label>
                                                                        <div>
                                                                            <input class="form-control" type="text" value="" name="quizzesAnswerD" required>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${requestScope.quizzes}" var="q">
                                                            <tr class="list-item">
                                                                <td>
                                                                    <div class="row">
                                                                        <div class="col-md-1">
                                                                            <label class="col-form-label">Order</label>
                                                                            <div>
                                                                                <input class="form-control" type="number" min="1" step="1" name="quizzesOrder" value="${q.order}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-9">
                                                                            <label class="col-form-label">Question</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="quizzesQuestion" value="${q.question}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-1">
                                                                            <label class="col-form-label">Answer</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" min="1" max="4" step="1" name="quizzesAnswer" value="${q.answer}" required>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-5">
                                                                            <label class="col-form-label">Answer 1</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="quizzesAnswerA" value="${q.answerA}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <label class="col-form-label">Answer 2</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="quizzesAnswerB" value="${q.answerB}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <label class="col-form-label">Answer 3</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="quizzesAnswerC" value="${q.answerC}" required>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <label class="col-form-label">Answer 4</label>
                                                                            <div>
                                                                                <input class="form-control" type="text" name="quizzesAnswerD" value="${q.answerD}" required>
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
                                            <input type="submit" class="btn" value="Save Changes">
                                            <button type="button" class="btn-secondry add-item m-r5"><i class="fa fa-fw fa-plus"></i>Add Quiz</button>
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