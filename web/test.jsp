<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />
    </head>
    <body>
        <table id="coursesTable" class="table table-striped table-bordered" style="width:100%" cellspacing="0">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Discount</th>
                    <th>Description</th>
                    <th>Created Date</th>
                    <th>Major</th>
                    <th>Level</th>
                    <th>Creator</th>
                    <th>
                        <a class="icon icon-add" href="create-account" role="button"></a>
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.courses}" var="c">
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.name}</td>
                        <th>${c.price}</th>
                        <th>${c.discount}</th>
                        <th>${c.description}</th>
                        <th>${c.createdDate}</th>
                        <th>${c.major.name}</th>
                        <th>${c.level.name}</th>
                        <th>${c.creator.firstName}</th>
                        <td>
                            <a class="icon icon-edit" href="" role="button"></a>
                            <a class="icon icon-delete" href="" onclick=""></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
                <script type="text/javascript">
            $(document).ready(function () {
                $('#coursesTable').DataTable();
            });
        </script>
    </body>
</html>
