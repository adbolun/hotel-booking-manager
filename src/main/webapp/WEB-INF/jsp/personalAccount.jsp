<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Personal account</title>
</head>
<body>
<%@ include file="header.jsp" %>
<h2>Your details!</h2>

<c:choose>
    <c:when test="${not empty requestScope.userDetail}">
        <form action="${pageContext.request.contextPath}/personalAccount" method="post" enctype="multipart/form-data">
            <label for="contact-number"><fmt:message key="page.user.detail.telephone"/>:</label>
            <input type="tel" name="contact-number" id="contact-number" value="${requestScope.userDetail.contactNumber}">
            <br><br>
            <label for="photo"><fmt:message key="page.user.detail.photo"/>:</label>
            <img src="${pageContext.request.contextPath}/images/${requestScope.userDetail.photo}" width="300px" alt="You does not have a image">
            <br><br>
            <input type="file" name="photo" id="photo">
            <br><br>
            <label for="birthdate"><fmt:message key="page.user.detail.birthdate"/></label>
            <input type="date" name="birthdate" id="birthdate" value="${requestScope.userDetail.birthdate}">
            <br><br>
            <label for="money"><fmt:message key="page.user.detail.amount"/>:</label>
            <input type="number" name="money" id="money" value="${requestScope.userDetail.money}">
            <br><br>
            <button type="submit"><fmt:message key="page.personal.account.edit"/></button>
        </form>
    </c:when>
    <c:otherwise>
        <p><fmt:message key="page.personal.account.message"/>You did not indicate the details!</p>
    </c:otherwise>
</c:choose>

<%@ include file="toApartmentButton.jsp" %>

<c:if test="${not empty requestScope.errors}">
    <c:forEach var="error" items="${requestScope.errors}">
        <p class="ui-state-error-text">${error.message}</p>
    </c:forEach>
</c:if>
</body>
</html>
