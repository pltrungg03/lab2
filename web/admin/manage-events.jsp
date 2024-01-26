<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="icon" href="assets/images/logo-clean.png" type="image/x-icon"/>
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo-clean.png"/>
    <title>Byte Scholar</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./admin/assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="./admin/assets/vendors/calendar/fullcalendar.css">
    <link rel="stylesheet" type="text/css" href="./admin/assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="./admin/assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="./admin/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="./admin/assets/css/dashboard.css">
    <link rel="stylesheet" class="skin" type="text/css" href="./admin/assets/css/color/color-1.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/css/pagination.css"/>
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
                    <div class="wc-title d-flex justify-content-between align-items-center">
                        <h4>Events listing</h4>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addNewEventModal">Add new event</button>
                        <div class="modal fade" id="addNewEventModal" tabindex="-1"
                             aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addNewEventModalLabel">Add new event</h5>
                                        <button type="button" class="btn-close" data-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="manage-events" method="post" id="addEventForm">
                                            <div>
                                                <div class="mb-3 floating">
                                                    <label for="content" class="form-label">Content</label>
                                                    <textarea  class="form-control" id="content" rows="3" name="content"
                                                              placeholder="Enter content"></textarea>
                                                </div>
                                                <div class="mb-3 floating">
                                                    <label for="discount" class="form-label">Discount</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">$</span>
                                                        <input type="text" class="form-control" id="discount" name="discount"
                                                               placeholder="Enter discount amount">
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="expiredDate" class="form-label">Expired Date</label>
                                                    <input type="date" class="form-control" name="expiredDate" id="expiredDate">
                                                </div>
                                                <input type="hidden" name="action" value="add" id="action">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" style="background-color: #6a6a6a;" data-dismiss="modal">Close
                                        </button>
                                        <button type="button" class="btn btn-primary" onclick="submitAddEvent()">Save changes</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="widget-inner">
                        <table id="eventsTable" class="display compact" style="width:100%" cellspacing="0">
                            <thead>
                            <tr>
                                
                                <th>Content</th>
                                <th>Discount</th>
                                <!--<th>Description</th>-->
                                <th>Created Date</th>
                                <th>Expired Date</th>
                                <th>Status</th>
                                <th>Creator</th>
                                <th>Number of courses</th>
                                <th>Manage</th>
                            </tr>
                            </thead>
                            <tbody>
                            <jsp:useBean id="util" class="util.Helpers"></jsp:useBean>
                            <c:set var="now" value="${util.getDateNow()}"></c:set>
                            <c:forEach items="${requestScope.events}" var="e">
                                <tr>
                                    
                                    <td>${e.content}</td>
                                    <td>${e.discount}</td>
                                    <td>${util.formatDate(e.createdDate)}</td>
                                    <td>${util.formatDate(e.expiredDate)}</td>
                                    <td>${e.expiredDate <= now ? "Out of date" : "Available"}</td>
                                    <td>${e.creator.firstName} ${e.creator.lastName}</td>
                                    <td>${e.courses.size()} <a href="#eventId=${e.id}" class="add-combo"><i class="ti-plus"></i>Add combo</a> </td>
                                    <td>
                                        <a class="" href="#id=${e.id}" role="button" onclick="updateEvent(${e.id})"><i
                                                class="ti-slice"></i>Update</a>
                                        <a class="mx-2" href="#" onclick="confirmAndRemoveEvent(${e.id})"><i
                                                class="ti-trash"></i>Remove</a>
                                    </td>
                                    <input type="hidden" id="event-${e.id}" value='${util.convertObjectToJson(e)}'/>
                                    <input type="hidden" id="listCourseOfEvent-${e.id}" value='${util.convertListToJson(e.courses)}'/>
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
<div class="modal fade" id="addCoursesForEvent" tabindex="-1"
     aria-labelledby="addNewEventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCoursesForEventTitle">Add course to event</h5>
                <button type="button" class="btn-close" data-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="my-2">
                    <label for="searchCourse">Search course:</label>
                    <input type="text" id="searchCourse" class="rounded-1 p-1">
                </div>
                <div class="d-flex flex-column justify-content-center align-items-center h-75">
                    <div class="flex-grow-1 w-100 d-flex flex-column justify-content-start align-items-start" id="checkbox-container"></div>
                    <div id="paging-container" class="mt-2 flex-shrink-1"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" style="background-color: #6a6a6a;" data-dismiss="modal">Close
                </button>
                <button type="button" class="btn btn-primary" id="saveInsertCourseToEvent">Save changes</button>
            </div>
        </div>
    </div>
</div>
<c:if test="${param.status ne null}">
    <div class="modal" tabindex="-1" role="dialog" id="statusModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="fs-5 fw-bold">${param.status} successfully</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</c:if>
<script src="<%=request.getContextPath()%>/admin/assets/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/waypoints-min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/counterup.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/masonry.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/filter.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
<script src='<%=request.getContextPath()%>/admin/assets/vendors/scroll/scrollbar.min.js'></script>
<script src="<%=request.getContextPath()%>/admin/assets/js/functions.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/chart/chart.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/js/admin.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/pagination.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/handlebars.min.js"></script>
<!--Datatable-->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
<script type="text/template" id="checkbox-template">
    {{#each data}}
    <div class="custom-control custom-checkbox mt-2 d-flex flex-column justify-content-start align-items-start">
        <input type="checkbox" class="custom-control-input course-checkbox" id="course-{{id}}" value="{{id}}">
        <label class="custom-control-label" for="course-{{id}}">{{name}}</label>
    </div>
    {{/each}}
</script>
<script type="text/javascript">
    var checkboxState = {};
    $(document).ready(function () {
        $('#eventsTable').DataTable();

        <c:if test="${param.status ne null}">
            $('#statusModal').modal('show');
        </c:if>
        $('.add-combo').on('click', function (){
            var link = $(this).attr('href');
            var eventId = link.replace("#eventId=", "");
            var courses = $('#listCourseOfEvent-'+eventId).val();
            if(!isValidJSON(courses)){
                return;
            }
            var listCourseOfEvent = JSON.parse(courses);
            callPagingCourses(listCourseOfEvent);
            $('#searchCourse').on('keyup', function(){
                callPagingCourses(listCourseOfEvent); // you need to ensure listCourseOfEvent is available here
            });

            $('#saveInsertCourseToEvent').on('click', function () {
                // Create the form dynamically
                var form = $('<form>').attr({
                    'method': 'POST',
                    'action': '<%=request.getContextPath()%>/manage-events'
                });

                // Append hidden fields based on checkboxState
                for (var courseId in checkboxState) {
                    var input = $('<input>').attr({
                        'type': 'hidden',
                        'name': 'courseMap[' + courseId + ']',
                        'value': checkboxState[courseId]
                    });
                    form.append(input);
                }

                // Add eventId
                var eventIdInput = $('<input>').attr({
                    'type': 'hidden',
                    'name': 'eventId',
                    'value': eventId  // You need to get this value from your logic
                });
                form.append(eventIdInput);

                // Add action
                var actionInput = $('<input>').attr({
                    'type': 'hidden',
                    'name': 'action',
                    'value': 'addCombo'
                });
                form.append(actionInput);

                // Append the form to the body and submit it
                $('body').append(form);
                form.submit();
            });
        })
    });

    function callPagingCourses(listCourseOfEvent){
        var dataJson = JSON.parse('${courses}');
        var courseIdsOfEvent = listCourseOfEvent.map(course => course.id);
        var searchTerm = $('#searchCourse').val().toLowerCase();
        dataJson = dataJson.filter(course => course.name.toLowerCase().includes(searchTerm));

        dataJson.sort((a, b) => {
            return courseIdsOfEvent.includes(b.id) - courseIdsOfEvent.includes(a.id);
        });
        $('#paging-container').pagination({
            dataSource: dataJson,
            autoHidePrevious: true,
            autoHideNext: true,
            pageSize: 10,
            showPageNumbers: true,
            showSizeChanger: true,
            callback: function (data) {
                var template = Handlebars.compile($('#checkbox-template').html());
                var html = template({data: data});
                $('#checkbox-container').html(html);
                checkCoursesInEvent(listCourseOfEvent);
                $('.course-checkbox').on('change', function(){
                    var courseId = parseInt(this.id.replace('course-', ''));
                    checkboxState[courseId] = $(this).prop('checked');
                });
            }
        });
    }

    function checkCoursesInEvent(listCourseOfEvent){
        var courseIdsOfEvent = listCourseOfEvent.map(course => course.id);
        var listCourseAvailable =  $('.course-checkbox');
        listCourseAvailable.each(function(){
            // Extract course ID from the checkbox's ID attribute
            var courseId = parseInt(this.id.replace('course-', ''));
            // Check if this courseId exists in the courseIds array
            if(checkboxState.hasOwnProperty(courseId)){
                $(this).prop('checked', checkboxState[courseId]);
            } else if(courseIdsOfEvent.includes(courseId)) {
                $(this).prop('checked', true);
                checkboxState[courseId] = true;
            } else {
                $(this).prop('checked', false);
                checkboxState[courseId] = false;
            }
        });
        $('#addCoursesForEvent').modal('show');
    }

    function isValidJSON(obj) {
        if (typeof obj !== 'string') {
            obj = JSON.stringify(obj);
        }

        try {
            JSON.parse(obj);
            return true;
        } catch (e) {
            return false;
        }
    }
    document.addEventListener("DOMContentLoaded", function() {
        // Get the current date
        let currentDate = new Date();

        // Set the date to tomorrow
        currentDate.setDate(currentDate.getDate() + 1);

        // Format the date to "YYYY-MM-DD" format
        let year = currentDate.getFullYear();
        let month = String(currentDate.getMonth() + 1).padStart(2, '0');
        let day = String(currentDate.getDate()).padStart(2, '0');

        // Set the min attribute
        document.getElementById('expiredDate').min = `${year}-${month}-${day}T00:00`;
    });
    function confirmAndRemoveEvent(eventId) {
        if (confirm("Are you sure you want to remove this event?")) {
            removeEvent(eventId);
        }
    }

    function removeEvent(eventId) {
        var form = $('<form>').attr({
            'method': 'POST',
            'action': '<%=request.getContextPath()%>/manage-events'
        });
        // Add eventId
        var eventIdInput = $('<input>').attr({
            'type': 'hidden',
            'name': 'eventId',
            'value': eventId  // You need to get this value from your logic
        });
        form.append(eventIdInput);

        // Add action
        var actionInput = $('<input>').attr({
            'type': 'hidden',
            'name': 'action',
            'value': 'delete'
        });
        form.append(actionInput);

        // Append the form to the body and submit it
        $('body').append(form);
        form.submit();
    }

    function updateEvent(id){
        console.log(id);
        var event = $('#event-'+id).val();
        if(!isValidJSON(event)){
            return;
        }
        var form =  $("#addEventForm");
        var eventObj = JSON.parse(event);
        $('#content').val(eventObj.content);
        $('#discount').val(eventObj.discount);
        $('#expiredDate').val(formatDate(eventObj.expiredDate));
        console.log(eventObj.expiredDate);
        $('#action').val('edit');
        var eventIdInput = $('<input>').attr({
            'type': 'hidden',
            'name': 'eventId',
            'value': eventObj.id  // You need to get this value from your logic
        });
        form.append(eventIdInput);
        $('#addNewEventModalLabel').html('Edit event');
        $('#addNewEventModal').modal('show');
    }

    function submitAddEvent(){
        var form =  document.getElementById("addEventForm");
        if(!validateForm()){
            return;
        }
        form.submit();
    }

    function formatDate(date){
        var dateObj = new Date(date);

        var year = dateObj.getFullYear();
        var month = dateObj.getMonth() + 1;  // JavaScript months are 0-indexed
        var date = dateObj.getDate();

        month = month < 10 ? '0' + month : month;
        date = date < 10 ? '0' + date : date;

        return year + '-' + month + '-' + date;
    }
    function validateForm() {
        // Get form values
        let content = document.getElementById('content').value;
        let discount = document.getElementById('discount').value;
        let expiredDate = new Date(document.getElementById('expiredDate').value);
        let currentDate = new Date();

        // Remove hours, minutes, seconds, and milliseconds for accurate date comparison
        expiredDate.setHours(0, 0, 0, 0);
        currentDate.setHours(0, 0, 0, 0);

        // Validate content
        if (!content) {
            alert('Content must not be null.');
            return false;
        }

        // Validate discount
        if (isNaN(discount) || discount === '') {
            alert('Discount must be a number.');
            return false;
        }

        // Validate expiredDate
        if (!(expiredDate > currentDate)) {
            alert('Expired Date must be later than today.');
            return false;
        }

        return true;
    }
</script>
</body>
</html>