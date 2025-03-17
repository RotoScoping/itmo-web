<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>results</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="header">
    <h1>results</h1>
</div>
<div class="container">
    <div class="results-holder">
        <table class="results">
            <thead>
            <tr>
                <th>x value</th>
                <th>y value</th>
                <th>r value</th>
                <th>result</th>
            </tr>
            </thead>
            <tbody id="body">
            <c:forEach var="row" items="${applicationScope.rows}">
                <tr>
                    <td>${row.x}</td>
                    <td>${row.y}</td>
                    <td>${row.r}</td>
                    <td>${row.result}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="button-holder">
        <a href="<%=request.getContextPath()%>/index.jsp">
            <button id="back-button">back</button>
        </a>
    </div>
</div>
</body>
</html>