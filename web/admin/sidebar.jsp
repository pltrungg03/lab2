<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="ttr-sidebar">
    <div class="ttr-sidebar-wrapper content-scroll">
        <!-- side menu logo start -->
        <div class="ttr-sidebar-logo">
            <a href="#">ByteScholar</a>
            <!-- <div class="ttr-sidebar-pin-button" title="Pin/Unpin Menu">
                    <i class="material-icons ttr-fixed-icon">gps_fixed</i>
                    <i class="material-icons ttr-not-fixed-icon">gps_not_fixed</i>
            </div> -->
            <div class="ttr-sidebar-toggle-button">
                <i class="ti-arrow-left"></i>
            </div>
        </div>
        <!-- side menu logo end -->
        <!-- sidebar menu start -->
        <nav class="ttr-sidebar-navi">
            <ul>
                <c:if test="${sessionScope.user.admin}">
                    <li>
                        <a href="dashboard" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-home"></i></span>
                            <span class="ttr-label">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="registration-list" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-alarm-clock"></i></span>
                            <span class="ttr-label">Registraion List</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-dropbox"></i></span>
                            <span class="ttr-label">Events</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="manage-events" class="ttr-material-button"><span class="ttr-label">Manage Events</span></a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-crown"></i></span>
                            <span class="ttr-label">Premium Packs</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="manage-packs" class="ttr-material-button"><span class="ttr-label">Manage Premium Packs</span></a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-user"></i></span>
                            <span class="ttr-label">Accounts</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="manage-accounts" class="ttr-material-button"><span class="ttr-label">Manage Accounts</span></a>
                            </li>
                        </ul>
                    </li>

                </c:if>


                <c:if test="${sessionScope.user.moderator}">

                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-bookmark"></i></span>
                            <span class="ttr-label">Blogs</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="moderator-bloglist" class="ttr-material-button"><span class="ttr-label">Manage Blog</span></a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-list"></i></span>
                            <span class="ttr-label">Comments</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="commentblog-list" class="ttr-material-button"><span class="ttr-label">Blog Comments</span></a>
                            </li>
                            <li>
                                <a href="commentcourse-list" class="ttr-material-button"><span class="ttr-label">Course Comments</span></a>
                            </li>
                            <li>
                                <a href="commentlesson-list" class="ttr-material-button"><span class="ttr-label">Lesson Comments</span></a>
                            </li>

                        </ul>
                    </li>
                </c:if>


                <c:if test="${sessionScope.user.courseManager}">
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-book"></i></span>
                            <span class="ttr-label">Courses</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="manage-courses" class="ttr-material-button"><span class="ttr-label">Manage Courses</span></a>
                            </li>
                            <li>
                                <a href="create-course" class="ttr-material-button"><span class="ttr-label">Create Course</span></a>
                            </li>
                            <li>
                                <a href="update-course" class="ttr-material-button"><span class="ttr-label">Update Course</span></a>
                            </li>
                        </ul>
                    </li>
                </c:if>


                <li class="ttr-seperate"></li>
            </ul>
            <!-- sidebar menu end -->
        </nav>
        <!-- sidebar menu end -->
    </div>
</div>
