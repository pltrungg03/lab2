<!DOCTYPE html>
<html lang="en">

<head>

	<!-- META ============================================= -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="" />
	<meta name="author" content="" />
	<meta name="robots" content="" />
	
	<!-- DESCRIPTION -->
	<meta name="description" content="EduChamp : Education HTML Template" />
	
	<!-- OG -->
	<meta property="og:title" content="EduChamp : Education HTML Template" />
	<meta property="og:description" content="EduChamp : Education HTML Template" />
	<meta property="og:image" content="" />
	<meta name="format-detection" content="telephone=no">
	
	<!-- FAVICONS ICON ============================================= -->
	<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />
	
	<!-- PAGE TITLE HERE ============================================= -->
	<title>EduChamp : Education HTML Template </title>
	
	<!-- MOBILE SPECIFIC ============================================= -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--[if lt IE 9]>
	<script src="assets/js/html5shiv.min.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
	
	<!-- All PLUGINS CSS ============================================= -->
	<link rel="stylesheet" type="text/css" href="assets/css/assets.css">
	
	<!-- TYPOGRAPHY ============================================= -->
	<link rel="stylesheet" type="text/css" href="assets/css/typography.css">
	
	<!-- SHORTCODES ============================================= -->
	<link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
	
	<!-- STYLESHEETS ============================================= -->
	<link rel="stylesheet" type="text/css" href="assets/css/style.css">
	<link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
	
</head>
<body id="bg">
<div class="page-wraper">
<div id="loading-icon-bx"></div>
<div class="onepage"></div>
    <!-- Header Top ==== -->
	<%@include file="header.jsp" %>
    <!-- header END ==== -->
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Events Details</h1>
				 </div>
            </div>
        </div>
		<!-- Breadcrumb row -->
		<div class="breadcrumb-row">
			<div class="container">
				<ul class="list-inline">
					<li><a href="#">Home</a></li>
					<li>Events Details</li>
				</ul>
			</div>
		</div>
		<!-- Breadcrumb row END -->
        <!-- inner page banner END -->
		<div class="content-block">
            <!-- About Us -->
			<div class="section-area section-sp1">
                <div class="container">
					 <div class="row">
						<div class="col-lg-7 col-md-6 col-sm-12">
							<div class="courses-post">
								<div class="ttr-post-media media-effect">
									<div id="carouselExampleControls-${event.id}" class="carousel slide" data-ride="carousel">
										<div class="carousel-inner" style="height: 450px;">
											<c:forEach items="${event.courses}" var="c" varStatus="loop">
												<c:if test="${loop.index eq 0 }">
													<div class="carousel-item active">
														<img class="d-block w-100" style="width: 330px; height: 460px; object-fit: cover; border: solid 2px" src="${c.image}" alt="First slide">
													</div>
												</c:if>
												<c:if test="${loop.index ne 0}">
													<div class="carousel-item">
														<img class="d-block w-100"  style="width: 330px; height: 460px; object-fit: cover; border: solid 2px" src="${c.image}" alt="First slide">
													</div>
												</c:if>
											</c:forEach>
										</div>
										<a class="carousel-control-prev" href="#carouselExampleControls-${event.id}" role="button" data-slide="prev">
											<span class="carousel-control-prev-icon" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a>
										<a class="carousel-control-next" href="#carouselExampleControls-${event.id}" role="button" data-slide="next">
											<span class="carousel-control-next-icon" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</div>
								</div>
								<div class="ttr-post-info">
									<div class="ttr-post-title ">
										<h2 class="post-title">${event.content}</h2>
									</div>
									<div class="ttr-post-text">
										<p></p>
									</div>
								</div>
							</div>
							 <div class="col-lg-4 col-md-5 col-sm-12 m-b30">
								 <div class="bg-primary text-white contact-info-bx m-b30">
									 <c:choose>
										 <c:when test="${canBuyEvent eq false}">
											 <button type="button" class="btn btn-danger btn-lg" disabled>Join now</button>
										 </c:when>
										 <c:otherwise>
											 <a class="btn btn-primary btn-lg m-auto" href="buy-event?eventId=${event.id}">Buy Combo</a>
										 </c:otherwise>
                                                                                         
									 </c:choose>
									
								 </div>
                                                             
							 </div>
							<div class="courese-overview" id="overview">
								<div class="row">
									<div class="col-md-8 col-lg-4">
										<ul class="course-features">
											<li><i class="ti-book"></i> <span class="label">Old cost</span> <span class="value" style="text-decoration: line-through;">${event.getOldPrice()}$</span></li>
											<li><i class="ti-help-alt"></i> <span class="label">Discount</span> <span class="value">${event.calculateDiscountPercentage()}%</span></li>
											<li><i class="ti-time"></i> <span class="label">Sale cost</span> <span class="value">${event.getSalePrice()}$</span></li>
											<jsp:useBean id="util" class="util.Helpers"></jsp:useBean>
											<li><i class="ti-stats-up"></i> <span class="label">Expired date</span> <span class="value">${util.formatDate(event.expiredDate)}</span></li>
											<li><i class="ti-face-smile"></i> <span class="label">Creator</span> <span class="value">${event.creator.firstName} ${event.creator.lastName}</span></li>
										</ul>
									</div>
									<div class="col-md-12 col-lg-7">
										<h5 class="m-b5">Combo courses in events</h5>
										<table class="table">
											<thead>
											<tr>
												<th scope="col">Course name</th>
												<th scope="col">Instructor</th>
												<th scope="col">Major</th>
												<th scope="col">Level</th>
											</tr>
											</thead>
											<tbody>
												<c:forEach items="${event.courses}" var="c">
													<tr>
														<th><a href="course-details?id=${c.id}" class="btn">${c.name}</a> </th>
														<th><a href="view-creator?id=${c.creator.id}" class="btn">${c.creator.firstName} ${c.creator.lastName}</a> </th>
														<th><a href="course-list?keyword=&majors=${c.major.id}" class="btn">${c.major.name}</a></th>
														<th><a href="course-list?keyword=&levels=${c.level.id}" class="btn">${c.level.name}</a></th>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										
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
	<%@include file="footer.jsp" %>
    <!-- Footer END ==== -->
    <button class="back-to-top fa fa-chevron-up" ></button>
</div>
<!-- External JavaScripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/vendors/bootstrap/js/popper.min.js"></script>
<script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
<script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
<script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
<script src="assets/vendors/counter/waypoints-min.js"></script>
<script src="assets/vendors/counter/counterup.min.js"></script>
<script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
<script src="assets/vendors/masonry/masonry.js"></script>
<script src="assets/vendors/masonry/filter.js"></script>
<script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
<script src="assets/js/functions.js"></script>
<script src="assets/js/contact.js"></script>
<script src='assets/vendors/switcher/switcher.js'></script>
<c:if test="${sessionScope.messageBuyEvent ne null}">
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog h-100 d-flex flex-column justify-content-center my-0" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					${sessionScope.messageBuyEvent}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#exampleModal').modal('show');
	</script>
	<c:remove var="messageBuyEvent" scope="session"></c:remove>

</c:if>
<script>
	$('.carousel').carousel({
		interval: 3000
	})
</script>
</body>

</html>
