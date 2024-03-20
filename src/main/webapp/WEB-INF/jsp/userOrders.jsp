<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Your Orders</title>
</head>
<body>

<c:if test="${not empty sessionScope.user}">
    <%@ include file="header.jsp" %>
    <a href="${pageContext.request.contextPath}/download">
        <button type="button"><fmt:message key="page.download.button"/></button>
    </a>
</c:if>

<h2><fmt:message key="page.user.orders.title"/></h2>
<ul>
    <c:choose>
        <c:when test="${not empty requestScope.orders}">
            <c:choose>
                <c:when test="${sessionScope.user.role eq 'ADMIN'}">
                    <c:forEach var="order" items="${requestScope.orders}">
                        <li>
                            <a href="${pageContext.request.contextPath}/setOrderStatus?orderId=${order.orderId}&userId=${requestScope.userId}">${order}</a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${requestScope.orders}">
                        <li>
                            <p>${order}</p>
                        </li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <p><fmt:message key="page.user.orders.message"/></p>
        </c:otherwise>
    </c:choose>
</ul>

<br>

<c:choose>
    <c:when test="${sessionScope.user.role eq 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/allUsers?userId=${sessionScope.user.id}&pageSize=1&pageNumber=1">
            <button type="button"><fmt:message key="page.button.back"/></button>
        </a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/apartment">
            <button type="button"><fmt:message key="page.button.back"/></button>
        </a>
    </c:otherwise>
</c:choose>
</body>
</html>

