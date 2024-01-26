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
                    <div class="wc-title  d-flex justify-content-between align-items-center">
                        <h4>Premium Pack listing</h4>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addNewEventModal">Add
                            new pack
                        </button>
                        <div class="modal fade" id="addNewEventModal" tabindex="-1"
                             aria-labelledby="addNewEventModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addNewEventModalLabel">Add new premium pack</h5>
                                        <button type="button" class="btn-close" data-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="manage-packs" method="post" id="addPackForm">
                                            <div>
                                                <div class="mb-3 floating">
                                                    <label for="name" class="form-label">Pack Name:</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" id="name" name="name"
                                                               placeholder="Enter pack name">
                                                    </div>
                                                </div>
                                                <div class="mb-3 floating">
                                                    <label for="price" class="form-label">Price:</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" id="price" name="price"
                                                               placeholder="Enter price">
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="value" class="form-label">Days:</label>
                                                    <input type="text" class="form-control" name="value" id="value" placeholder="Enter number of premium days before end">
                                                </div>
                                                <input type="hidden" name="action" value="add" id="action">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" style="background-color: #6a6a6a;" data-dismiss="modal">Close
                                        </button>
                                        <button type="button" class="btn btn-primary" onclick="submitAddEvent()">Save Pack</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="widget-inner">
                        <table id="eventsTable" class="display compact" style="width:100%" cellspacing="0">
                            <thead>
                            <tr>
                                
                                <th>Pack Name</th>
                                <!--<th>Description</th>-->
                                <th>Price</th>
                                <th>Value</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listPack}" var="o">
                                <tr>
                                    
                                    <td>${o.name}</td>
                                    <td>${o.price}</td>
                                    <td>${o.value}</td>
                                    <td>
                                        <a class="" href="#id=${o.id}" role="button" onclick="updateEvent(${o.id})"><i
                                                class="ti-slice"></i>Update</a>
                                        <a class="mx-2" href="#" onclick="confirmAndRemoveEvent(${o.id})"><i
                                                class="ti-trash"></i>Remove</a>
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
    
   
    function confirmAndRemoveEvent(eventId) {
        if (confirm("Are you sure you want to remove this pack?")) {
            removeEvent(eventId);
        }
    }

    function removeEvent(eventId) {
        var form = $('<form>').attr({
            'method': 'POST',
            'action': '<%=request.getContextPath()%>/manage-packs'
        });
        // Add eventId
        var eventIdInput = $('<input>').attr({
            'type': 'hidden',
            'name': 'packId',
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
    function updateEvent(id){
        
        var form =  $("#addPackForm");
        var eventIdInput = $('<input>').attr({
            'type': 'hidden',
            'name': 'packId',
            'value': id  // You need to get this value from your logic
        });
        form.append(eventIdInput);       
        
        var form =  $("#addEventForm");
        
        
        $('#action').val('edit');
        
        $('#addNewEventModalLabel').html('Edit pack');
        $('#addNewEventModal').modal('show');
    }

    function submitAddEvent(){
        var form =  document.getElementById("addPackForm");
        if(!validateForm()){
            return;
        }
        form.submit();
    }

    
    function validateForm() {
        // Get form values
        let name = document.getElementById('name').value;
        let price = document.getElementById('price').value;
        let value = document.getElementById('value').value;

        // Remove hours, minutes, seconds, and milliseconds for accurate date comparison
        

        // Validate content
        if (!name) {
            alert('Pack Name must not be null.');
            return false;
        }

        // Validate discount
        if (isNaN(price) || price === '') {
            alert('Price must be a number.');
            return false;
        }

        // Validate expiredDate
        if (isNaN(value) || value === '') {
            alert('Value must be a number.');
            return false;
        }

        return true;
    }
</script>
</body>
</html>