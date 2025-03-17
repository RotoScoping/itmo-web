<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="server.servlets.TableRow" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Лабораторная работа №2 по веб-программированию</title>
    <script src="https://cdn.jsdelivr.net/npm/superagent@8.0.0/dist/superagent.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/static/js/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<table>
    <thead>
    <tr>
        <th colspan="4">
            <header>
                <h1>Kriger Mark</h1>
                <h2>P3213, var: 99</h2>
            </header>
        </th>
    </thead>
    <tbody>
    <tr>
    </tr>
    <td>
        <label>x:</label>
        <form id="buttonForm">
            <div class="button-group">
                <button type="button" onclick="setXValue(-2)">-2</button>
                <button type="button" onclick="setXValue(-1.5)">-1.5</button>
                <button type="button" onclick="setXValue(-1)">-1</button>
                <button type="button" onclick="setXValue(-0.5)">-0.5</button>
                <button type="button" onclick="setXValue(0)">0</button>
                <button type="button" onclick="setXValue(0.5)">0.5</button>
                <button type="button" onclick="setXValue(1)">1</button>
                <button type="button" onclick="setXValue(1.5)">1.5</button>
                <button type="button" onclick="setXValue(2)">2</button>
            </div>
            <input type="hidden" name="x" id="selectedX">
        </form>
    </td>
    <td>
        <label for="y">y:</label>
        <div>
            <input title="Enter a value y" class="inputY" id="y" type="text" placeholder="Range from -3 to 3" oninput="checkInputs()" />
            <span class="error-message" style="display: block; height: 20px;"></span>
        </div>
    </td>
    <td>
        <label>R:</label>
        <div class="checkbox-group">
            <label>
                <input type="checkbox" name="r" value="1" onclick="toggleCheckboxes(this)"> 1
            </label>
            <label>
                <input type="checkbox" name="r" value="1.5" onclick="toggleCheckboxes(this)"> 1.5
            </label>
            <label>
                <input type="checkbox" name="r" value="2" onclick="toggleCheckboxes(this)"> 2
            </label>
            <label>
                <input type="checkbox" name="r" value="2.5" onclick="toggleCheckboxes(this)"> 2.5
            </label>
            <label>
                <input type="checkbox" name="r" value="3" onclick="toggleCheckboxes(this)"> 3
            </label>
        </div>
        <span class="error-message" style="display: block; height: 20px;"></span>
    </td>

    <td>
        <div class="main__block" id="graph-container">
            <%@include file="static/media/graph.svg" %>
        </div>
    </td>
    </tr>
    </tbody>
</table>

<div class="button-group">
    <button type="reset" onclick="resetForm()">Сбросить данные</button>
    <button id="submitButton" type="submit" disabled onclick="checkPoint()">Отправить</button>
</div>

<table id="results">
    <thead>
    <tr>
        <th>Attempt #</th>
        <th>X</th>
        <th>Y</th>
        <th>R</th>
        <th>Result</th>
    </tr>
    </thead>
    <tbody>
    <% if (application.getAttribute("rows") != null) { %>
    <% ArrayList<Row> array = (ArrayList<Row>) application.getAttribute("rows"); %>
    <% for (int i = 0; i < array.size(); i++) { Row row = array.get(i); %>
    <tr>
        <td><%= i + 1 %></td>
        <td><%= row.getX() %></td>
        <td><%= row.getY() %></td>
        <td><%= row.getR() %></td>
        <td><%= row.getResult() ? "<span style='color:green'>Да</span>" : "<span style='color:red'>Нет</span>" %></td>
    </tr>
    <% } %>
    <% } %>
    </tbody>
</table>
<script src="${pageContext.request.contextPath}/static/js/index.js"></script>
<script>
    window.onload = function() {
        <% if (application.getAttribute("rows") != null) { %>
        <% ArrayList<TableRow> array = (ArrayList<TableRow>) application.getAttribute("rows");%>
        <% for (int index = array.size() - 1; index >= 0; index--) { %>
        drawPoint(
            <%= array.get(index).getX() %>,
            <%= array.get(index).getY() %>,
            <%= array.get(index).getR() %>,
            <%= array.get(index).getResult() %>
        );
        <% } %>
        <% } %>
    }
</script>
</body>

</html>
