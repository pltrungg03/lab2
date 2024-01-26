<%-- 
    Document   : registration
    Created on : Oct 1, 2023, 9:48:26 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
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

    <!-- TYPOGRAPHY ============================================= -->
    <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">

    <!-- SHORTCODES ============================================= -->
    <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">

    <!-- STYLESHEETS ============================================= -->
    <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
    <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">

</head>
<style>
    .hide{
        display: none;
    }
</style>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">

    <%@include file="/admin/admin-header.jsp" %>
    <!-- header end -->
    <!-- Left sidebar menu start -->
    <%@include file="/admin/sidebar.jsp" %>
    <!-- header start -->

    <!-- header end -->
    <!-- Left sidebar menu start -->

<body class="ttr-opened-sidebar ttr-pinned-sidebar">
    <div class="page-wraper">
        <div id="loading-icon-bx"></div>

        <!-- Header Top ==== -->

        <!-- header END ==== -->
        <!-- Content -->
        <div class="page-content bg-white">
            <!-- inner page banner -->

            <!-- Breadcrumb row -->

            <!-- Breadcrumb row END -->
            <!-- inner page banner END -->
            <div class="content-block">
                <!-- About Us -->
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                <div class="widget courses-search-bx placeani">
                                    <div class="form-group">
                                        <div class="widget widget_archive">
                                            <h3 class="ttr-material-button">Search By Email </h3> 
                                            <input id="searchbyemail" class="filter-button" type="text" name="searchbyemail" onkeypress="preventEnterSubmit(event)">                                        
                                            <br/>
                                            <br/>
                                            <h3 class="ttr-material-button">Registration time</h3>        
                                            &nbsp;  From   <input  class="filter-button" id="datefrom" onchange="TDate1()"  type="date" name="datefrom" > <br/>                              
                                            &nbsp;To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input  class="filter-button" type="date" onchange="TDate()" id="dateto" name="dateto"> 
                                            <br/>
                                            <br/><h3 class="ttr-material-button">&nbsp;Author</h3> 

                                            <c:forEach items="${listCre}" var="o">
                                                &nbsp;     &nbsp;   <input class="filter-button"
                                                                           <c:forEach items="${account}" var="check">
                                                                               <c:if test="${check == o.id}">checked</c:if>
                                                                           </c:forEach>
                                                                           type="checkbox" value="${o.id}"  name="creator">
                                                <label for="${o.firstName}${o.lastName}">${o.firstName}${o.lastName}</label> <br/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="widget widget_archive">
                                    <h3 class="ttr-material-button">&nbsp;Major</h3> 
                                    <c:forEach items="${listM}" var="o">
                                        &nbsp;     &nbsp;   <input class="filter-button"
                                                                   <c:forEach items="${major}" var="check">
                                                                       <c:if test="${check == o.id}">checked</c:if>
                                                                   </c:forEach>
                                                                   type="checkbox" value="${o.id}" id="${o.name}" name="major">
                                        <label  for="${o.name}">${o.name}</label> <br/>
                                    </c:forEach>

                                </div>
                                <div class="widget widget_archive">
                                    <h3 class="ttr-material-button">&nbsp;Level</h3> 
                                    <c:forEach items="${listL}" var="o">
                                        &nbsp;     &nbsp;   <input class="filter-button"
                                                                   <c:forEach items="${major}" var="check">
                                                                       <c:if test="${check == o.id}">checked</c:if>
                                                                   </c:forEach>
                                                                   type="checkbox" value="${o.id}" id="${o.name}" name="major">
                                        <label for="${o.name}">${o.name}</label> <br/>
                                    </c:forEach>

                                </div>


                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-12">
                                <div class="db-breadcrumb">
                                    <h4 class="breadcrumb-title">Registration List</h4>
                                    <ul class="db-breadcrumb-list">
                                        <li><a href="home"><i class="fa fa-home"></i>Home
                                            </a></li>
                                    </ul>
                                </div>	
                                <div class="row" style="width: 120%">
                                    <div class="col-lg-12 m-b30">
                                        <label>Price</label>
                                        <div class="price-input">
                                            <div class="field">
                                                <span>Min</span>
                                                <input type="number" class="input-min" readonly>
                                                <span>Max</span>
                                                <input type="number" class="input-max"readonly>

                                                <span class="ttr-material-button">&nbsp;Search By Course Name</span>
                                                <input id="searchbycourse" class="filter-button" type="text" name="searchbyemail" onkeypress="preventEnterSubmit(event)">    
                                            </div>
                                        </div>
                                        <div class="range-input">
                                            &nbsp;&nbsp; &nbsp; &nbsp; <input type="range" value="0"  id="min"  class="filter-button" min="0" max="500" step="10"> &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                                            <input type="range" id="max"  class="filter-button" min="0" max="500"  step="10" value="300">
                                        </div>

                                        <label>Sort by</label>
                                        &nbsp;&nbsp; &nbsp; &nbsp;      <input class="filter-button" type="radio" <c:if test="${op eq 'price asc'}">checked</c:if> value="price asc" id="op1" name="op"/>
                                            <label> Min to Max Price</label>  &nbsp;&nbsp; &nbsp; &nbsp;
                                            <input class="filter-button" type="radio" <c:if test="${op eq 'price desc'}">checked</c:if> value="price desc" name="op"/>
                                            <label > Max to Min Price </label> &nbsp;&nbsp; &nbsp; &nbsp;

                                            <input class="filter-button" type="radio" <c:if test="${op eq 'joined_date asc'}">checked</c:if> value="joined_date asc" name="op"/>
                                            <label >Day Increases </label> &nbsp;&nbsp; &nbsp; &nbsp;

                                            <input class="filter-button" type="radio" <c:if test="${op eq 'joined_date desc'}">checked</c:if> value="joined_date desc"  name="op"/>
                                            <label>Day Decrease</label>  &nbsp;&nbsp; &nbsp; &nbsp;
                                            <form action="registration-list" method="get">
                                                <label>   <input type="submit"  id="reset"    value="Reset"></label>
                                            </form>
                                            <div class="widget-inner" id="widget-inner">
                                                <table class="content-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Email</th>
                                                            <th>Registration Date</th>
                                                            <th>Course Name</th>
                                                            <th>Cost</th>
                                                            <th>Creator</th>
                                                            <th>Major</th>
                                                            <th>Level</th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="widget-inner12">
                                                    <div class="huuloc">
                                                        <h4 id="total">Showing ${n} results</h4>
                                                    <h5 id="sum">Total cost: ${totalcost}$</h5>
                                                </div>
                                                <c:forEach items="${listRegistration}" var="o">                       
                                                    <tr class="test">
                                                        <td>
                                                            <c:forEach items="${o.students}" var="c">
                                                                ${c.email}
                                                            </c:forEach>                                                   
                                                        </td>
                                                        <td>${o.joinedDate}</td>
                                                        <td>${o.name}</td>
                                                        <td>${o.price}</td>
                                                        <td>${o.creator.firstName}${o.creator.lastName}</td>
                                                        <td>${o.major.name}</td>
                                                        <td>${o.level.name}</td>
                                                        <td>
                                                            <c:forEach items="${o.students}" var="c">
                                                                <a href="registration-detail?aid=${c.id}&cid=${o.id}">View Detail</a>
                                                            </c:forEach>
                                                        </td>
                                                    </tr> 
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <ul class="pagination">
                                            <li class="page-item"><a class="page-link hide" id="pre">Previous</a></li>
                                            <li class="page-item active"><a class="page-link" id="current">1</a></li>
                                            <li class="page-item"><a class="page-link hide" id="next">Next</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- contact area END -->

</div>
<!-- Content END-->
<!-- Footer ==== -->

<!-- Footer END ==== -->
<button class="back-to-top fa fa-chevron-up" ></button>
</div>

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
<script type="text/javascript">
                                                    var reset = document.querySelector('#side');
</script>
<script type="text/javascript">
    var reset = document.querySelector('#reset');
    reset.style.display = 'none';
    let currentPage = 1;
    let pageSize = 10;
    var current = document.querySelector('#current');
    var preBt = document.querySelector('#pre');
    var nextBt = document.querySelector('#next');

    // Set the content of the h4 element to display the result
    function show() {
        var d1 = document.getElementsByClassName("test");
        var d2 = d1.length;

        var start = (currentPage - 1) * pageSize;
        var end = start + pageSize;
        for (var i = 0; i < d2; i++) {
            if (i >= start && i <= end) {
                d1[i].style.display = 'table-row';
            } else {
                d1[i].style.display = 'none';
            }
        }
        paging(d2);
    }
    function paging(data) {
        let maxPage = Math.ceil(data / pageSize) + 1;
        current.innerHTML = currentPage;
        if (currentPage < maxPage) {
            nextBt.classList.remove('hide');
        } else {
            nextBt.classList.add('hide');
        }
        if (currentPage > 1) {
            preBt.classList.remove('hide');
        } else {
            preBt.classList.add('hide');
        }
    }
    nextBt.addEventListener('click', () => {
        currentPage++;
        show();
    });
    preBt.addEventListener('click', () => {
        currentPage--;
        show();
    });
    show();
</script>
<script>
    function preventEnterSubmit(event) {
        if (event.key === "Enter") {
            event.preventDefault(); // Prevent the form from being submitted
        }
    }
    function TDate() {
        var UserDate = document.getElementById("dateto").value;
        var ToDate = new Date();
        if (new Date(UserDate).getTime() >= ToDate.getTime()) {
            document.getElementById("dateto").value = null;
            alert("The Date must be Less or Equal to today date");
            return false;
        }
        return true;
    }
    function TDate1() {
        var UserDate = document.getElementById("datefrom").value;
        var ToDate = new Date();
        if (new Date(UserDate).getTime() >= ToDate.getTime()) {
            document.getElementById("datefrom").value = null;
            alert("The Date must be Less or Equal to today date");
            return false;
        }
        return true;
    }

</script>
<script>
    $('.filter-button').on('click input', function () {
        var major = '';
        $('input[name="major"]:checked').each(function () {
            console.log(this.value);
            major += this.value + ',';
        });

        var creator = '';
        $('input[name="creator"]:checked').each(function () {
            console.log(this.value);
            creator += this.value + ',';
        });
        console.log(major.substring(0, major.length - 1));

        major = major.substring(0, major.length - 1);
        var level = '';
        $('input[name="level"]:checked').each(function () {
            console.log(this.value);
            level += this.value + ',';
        });
        console.log(level.substring(0, level.length - 1));
        level = level.substring(0, level.length - 1);
        var search = $('#searchbyemail').val();
        console.log(search);
        var sort = $('input[name="op"]:checked').val();
        if (sort === undefined) {
            sort = null;
        }
        var reset = document.querySelector('#reset');
        reset.style.display = 'block';
        var from = $('#datefrom').val();
        console.log(from);
        var to = document.getElementById('dateto').value;
        console.log(to);
        var min = $('#min').val();
        var max = $('#max').val();
        var total = document.querySelector('#total');
        var searchbycourse = $('#searchbycourse').val();
        total.style.display = 'none';
        var sum = document.querySelector('#sum');
        sum.style.display = 'none';
        $.ajax({
            url: "/SE1735_G5/registration-list",
            type: "post",
            data: {
                major: major,
                level: level,
                searchbyemail: search,
                op: sort,
                datefrom: from,
                dateto: to,
                minprice: min,
                creator: creator,
                maxprice: max,
                searchbycourse: searchbycourse
            },
            success: function (data) {
                var row = document.getElementById("widget-inner");
                row.innerHTML = data;
            },
            error: function (xhr) {
                //handle error
            }
        });

    });

</script>
<script type="text/javascript">
    const rangeInput = document.querySelectorAll(".range-input input"),
            priceInput = document.querySelectorAll(".price-input input"),
            range = document.querySelector(".slider .progress");
    let priceGap = 10;
    priceInput.forEach(input => {
        input.addEventListener("input", e => {
            let minPrice = parseInt(priceInput[0].value),
                    maxPrice = parseInt(priceInput[1].value);
            if ((maxPrice - minPrice >= priceGap) && maxPrice <= rangeInput[1].max) {
                if (e.target.className === "input-min") {
                    rangeInput[0].value = minPrice;
                    range.style.left = ((minPrice / rangeInput[0].max) * 10) + "%";
                } else {
                    rangeInput[1].value = maxPrice;
                    range.style.right = 10 - (maxPrice / rangeInput[1].max) * 10 + "%";
                }
            }
        });
    });

    rangeInput.forEach(input => {
        input.addEventListener("input", e => {
            let minVal = parseInt(rangeInput[0].value),
                    maxVal = parseInt(rangeInput[1].value);

            if ((maxVal - minVal) < priceGap) {
                if (e.target.className === "range-min") {
                    rangeInput[0].value = maxVal - priceGap;
                } else {
                    rangeInput[1].value = minVal + priceGap;
                }
            } else {
                priceInput[0].value = minVal;
                priceInput[1].value = maxVal;
                range.style.left = ((minVal / rangeInput[0].max) * 10) + "%";
                range.style.right = 10 - (maxVal / rangeInput[1].max) * 10 + "%";
            }
        });
    });
</script>
</body>


</html>