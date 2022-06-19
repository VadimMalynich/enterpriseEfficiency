<%--
  Created by IntelliJ IDEA.
  User: Vadim
  Date: 02.10.2021
  Time: 22:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Favicon -->
    <link rel="shortcut icon" href="<c:url value="/resources/images/logo/favicon.png"/>" type="image/x-icon">

    <!-- Locale -->
    <fmt:setLocale value="${sessionScope.locale}"/>
    <fmt:setBundle basename="langs.labels" var="loc"/>

    <fmt:message bundle="${loc}" key="signIn.button" var="signIn"/>
    <fmt:message bundle="${loc}" key="signUp.button" var="signUp"/>
    <fmt:message bundle="${loc}" key="import.button" var="importButton"/>
    <fmt:message bundle="${loc}" key="logout.button" var="logout"/>
    <fmt:message bundle="${loc}" key="profile.button" var="profile"/>
    <fmt:message bundle="${loc}" key="assortment.button" var="assortment"/>
    <fmt:message bundle="${loc}" key="users.button" var="usersButton"/>
    <fmt:message bundle="${loc}" key="home.button" var="home"/>
    <fmt:message bundle="${loc}" key="indicators.button" var="indicatorsButton"/>

    <fmt:message bundle="${loc}" key="label.okpo" var="okpo"/>
    <fmt:message bundle="${loc}" key="label.ynn" var="kodUnn"/>
    <fmt:message bundle="${loc}" key="label.name" var="name"/>
    <fmt:message bundle="${loc}" key="label.fullName" var="fullName"/>
    <fmt:message bundle="${loc}" key="label.activityType" var="activityType"/>
    <fmt:message bundle="${loc}" key="label.areas" var="areas"/>
    <fmt:message bundle="${loc}" key="label.signUp" var="signUpLabel"/>
    <fmt:message bundle="${loc}" key="label.excel" var="excelLabel"/>

    <fmt:message bundle="${loc}" key="search.input.placeholder" var="searchPlaceholder"/>

    <fmt:message bundle="${loc}" key="page.home" var="pageTitle"/>

    <fmt:message bundle="${loc}" key="message.area" var="areaMessage">
        <fmt:param value="${sessionScope.filterArea}"/>
    </fmt:message>
    <fmt:message bundle="${loc}" key="message.district" var="districtMessage">
        <fmt:param value="${sessionScope.filterDistrict}"/>
    </fmt:message>
    <fmt:message bundle="${loc}" key="message.emptyCompanies" var="emptyCompanies"/>
    <fmt:message bundle="${loc}" key="message.emptyCompanies.continue" var="emptyCompaniesContinue"/>
    <c:if test="${requestScope.message ne null}">
        <fmt:message bundle="${loc}" key="${requestScope.message}" var="messageText"/>
    </c:if>

    <!-- Page Title -->
    <title>${pageTitle}</title>
</head>
<body>
<c:import url="parts/header.jsp"/>

<!-- Preloader Starts -->
<div class="preloader">
    <div class="spinner"></div>
</div>
<!-- Preloader End -->

<!-- Page Title Starts -->
<div class="page-title text-center">
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <c:choose>
                    <c:when test="${sessionScope.filterArea ne null}">
                        <h2>${areaMessage}</h2>
                    </c:when>
                    <c:when test="${sessionScope.filterDistrict ne null}">
                        <h2>${districtMessage}</h2>
                    </c:when>
                    <c:when test="${empty sessionScope.companiesList}">
                        <h2>${emptyCompanies}</h2>
                        <p>${emptyCompaniesContinue}</p>
                        <c:if test="${sessionScope.user ne null}">
                            <div class="whole-wrap">
                                <div class="container">
                                    <div class="section-top-border">
                                        <div class="row">
                                            <div class="col-lg-3 mb-5 mb-lg-0">
                                                <br>
                                                <div class="d-flex">
                                                    <div class="info-text">
                                                        <h5>${excelLabel}</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-8">
                                                <form action="enterpriseEfficiency" method="post" enctype="multipart/form-data">
                                                    <input type="hidden" name="command" value="import_data"/>
                                                    <input class="mt-10" type="file" name="importFile"
                                                           accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                                                    <br>
                                                    <br>
                                                    <button type="submit" class="template-btn">${importButton}</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!-- Page Title End -->

<!-- Start blog-posts Area -->
<c:choose>
    <c:when test="${not empty sessionScope.companiesList}">
        <section class="blog-posts-area section-padding">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <table id="companiesTable" class="display">
                            <thead>
                            <tr class="table-head">
                                <th class="serial">${kodUnn}</th>
                                <th class="serial">${okpo}</th>
                                <th class="country">${name}</th>
                                <th class="percentage">${fullName}</th>
                                <c:if test="${sessionScope.user.role.value eq 1 or sessionScope.user.role.value eq 2}">
                                    <th class="visit"></th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="company" items="${sessionScope.companiesList}">
                                <tr class="table-row">
                                    <td class="serial"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.ynn}</h5></a>
                                    </td>
                                    <td class="serial"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.okpo}</h5></a>
                                    </td>
                                    <td class="country"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.name}</h5></a>
                                    </td>
                                    <td class="percentage"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.fullName}</h5></a>
                                    </td>
                                    <c:if test="${sessionScope.user.role.value eq 1 or sessionScope.user.role.value eq 2}">
                                        <td class="visit">
                                            <button type="button">
                                                <a href="enterpriseEfficiency?command=go_to_edit_company_page&editCompanyYnn=${company.ynn}"
                                                   style="color: #0b2e13">
                                                    <em class="fa fa-edit fa-1x"></em></a></button>
                                            <c:if test="${sessionScope.user.role.value eq 1}">
                                                <form action="enterpriseEfficiency" method="post" style="display: inherit">
                                                    <input type="hidden" name="command" value="delete_company">
                                                    <input type="hidden" name="deleteCompanyYnn" value="${company.ynn}">
                                                    <div class="serial">
                                                        <button type="submit">
                                                            <em class="fa fa-close fa-1x"></em>
                                                        </button>
                                                    </div>
                                                </form>
                                            </c:if>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-3 sidebar">
                        <c:if test="${sessionScope.locationMap ne null}">
                            <div class="single-widget category-widget">
                                <h4 class="title">${areas}</h4>
                                <ul class="top">
                                    <c:forEach var="area" items="${sessionScope.locationMap.keySet()}">
                                        <li>
                                            <a href="enterpriseEfficiency?command=filter_by_location&filterArea=${area}"
                                               class="justify-content-between align-items-center d-flex">
                                                <h6>${area}</h6>
                                            </a>
                                            <ul class="sub">
                                                <c:forEach var="district" items="${sessionScope.locationMap.get(area)}">
                                                    <li>
                                                        <a href="enterpriseEfficiency?command=filter_by_location&filterDistrict=${district}"
                                                           class="justify-content-between align-items-center d-flex">
                                                            <h6>${district}</h6>
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
    </c:when>
    <c:when test="${not empty sessionScope.filterCompanies}">
        <section class="blog-posts-area section-padding">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <table id="filterCompaniesTable" class="display">
                            <thead>
                            <tr class="table-head">
                                <th class="serial">${kodUnn}</th>
                                <th class="serial">${okpo}</th>
                                <th class="country">${name}</th>
                                <th class="percentage">${fullName}</th>
                                <c:if test="${sessionScope.user.role.value eq 1 or sessionScope.user.role.value eq 2}">
                                    <th class="visit"></th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="company" items="${sessionScope.filterCompanies}">
                                <tr class="table-row">
                                    <td class="serial"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.ynn}</h5></a>
                                    </td>
                                    <td class="serial"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.okpo}</h5></a>
                                    </td>
                                    <td class="country"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.name}</h5></a>
                                    </td>
                                    <td class="percentage"><a
                                            href="enterpriseEfficiency?command=go_to_company_page&companyYnn=${company.ynn}">
                                        <h5>${company.fullName}</h5></a>
                                    </td>
                                    <c:if test="${sessionScope.user.role.value eq 1 or sessionScope.user.role.value eq 2}">
                                        <td class="visit">
                                            <button type="button">
                                                <a href="enterpriseEfficiency?command=go_to_edit_company_page&editCompanyYnn=${company.ynn}"
                                                   style="color: #0b2e13">
                                                    <em class="fa fa-edit fa-1x"></em></a></button>
                                            <c:if test="${sessionScope.user.role.value eq 1}">
                                                <form action="enterpriseEfficiency" method="post" style="display: inherit">
                                                    <input type="hidden" name="command" value="delete_company">
                                                    <input type="hidden" name="deleteCompanyYnn" value="${company.ynn}">
                                                    <div class="serial">
                                                        <button type="submit">
                                                            <em class="fa fa-close fa-1x"></em>
                                                        </button>
                                                    </div>
                                                </form>
                                            </c:if>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-3 sidebar">
                        <c:if test="${sessionScope.locationMap ne null}">
                            <div class="single-widget category-widget">
                                <h4 class="title">${areas}</h4>
                                <ul class="top">
                                    <c:forEach var="area" items="${sessionScope.locationMap.keySet()}">
                                        <li>
                                            <a href="enterpriseEfficiency?command=filter_by_location&filterArea=${area}"
                                               class="justify-content-between align-items-center d-flex">
                                                <h6>${area}</h6>
                                            </a>
                                            <ul class="sub">
                                                <c:forEach var="district" items="${sessionScope.locationMap.get(area)}">
                                                    <li>
                                                        <a href="enterpriseEfficiency?command=filter_by_location&filterDistrict=${district}"
                                                           class="justify-content-between align-items-center d-flex">
                                                            <h6>${district}</h6>
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
    </c:when>
</c:choose>
<!-- End blog-posts Area -->

<div id="wrapper"></div>

<!-- Footer Area -->
<c:import url="parts/footer.jsp"/>

</body>
</html>
