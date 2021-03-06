<%@ page import='java.util.*,com.doublechaintech.retailscm.*'%>
<%@ page language="java" contentType="text/plain; charset=utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sky" tagdir="/tags"%>
<fmt:setLocale value="zh_CN"/>
<c:set var="ignoreListAccessControl" value="${true}"/>


<c:if test="${ empty pageList}" >
	<div class="row" style="font-size: 30px;">
		<div class="col-xs-12 col-md-12" style="padding-left:20px">
		 ${userContext.localeMap['@not_found']}${userContext.localeMap['page']}! 
		 <a href="./${ownerBeanName}Manager/addPage/${result.id}/"><i class="fa fa-plus-square" aria-hidden="true"></i></a>
		 
		 
		 
		 </div>
	</div>

</c:if>




	

 <c:if test="${not empty pageList}" >
    
    
<%

 	SmartList list=(SmartList)request.getAttribute("pageList"); 
 	int totalCount = list.getTotalCount();
 	List pages = list.getPages();
 	pageContext.setAttribute("rowsPerPage",list.getRowsPerPage()); 
 	
 	pageContext.setAttribute("pages",pages); 
 	pageContext.setAttribute("totalCount",totalCount); 
 	//pageContext.setAttribute("accessible",list.isAccessible()); 
 	//the reason using scriptlet here is the el express is currently not able resolv common property from a subclass of list
%>
    
 	   
    <div class="row" style="font-size: 30px;">
		<div class="col-xs-12 col-md-12" style="padding-left:20px">
		<i class='fa fa-table'></i> ${userContext.localeMap['page']}(${totalCount})
		<a href="./${ownerBeanName}Manager/addPage/${result.id}/"><i class="fa fa-plus-square" aria-hidden="true"></i></a>
		 
		 		 	<div class="btn-group" role="group" aria-label="Button group with nested dropdown">		
	<c:forEach var="action" items="${result.actionList}">
		<c:if test="${'pageList' eq action.actionGroup}">
		<a class="btn btn-${action.actionLevel} btn-sm" href="${action.managerBeanName}/${action.actionPath}">${userContext.localeMap[action.localeKey]}</a>
		</c:if>
	</c:forEach>
	</div><!--end of div class="btn-group" -->
	
		 
		 
		 
		 </div>
 </div>
    
    
<div class="table-responsive">


<c:set var="currentPageNumber" value="1"/>	



<nav aria-label="Page navigation example">
  <ul class="pagination">
<c:forEach var="page" items="${pages}"> 
<c:set var="classType" value=""/>
<c:if test='${page.selected}' >
<c:set var="classType" value="active"/>
<c:set var="currentPageNumber" value="${page.pageNumber}"/>
</c:if>


	<li class="page-item ${classType}">
		<a href='#${ownerBeanName}Manager/load${ownerClassName}/${result.id}/${pageListName};${pageListName}CurrentPage=${page.pageNumber};${pageListName}RowsPerPage=${rowsPerPage}/' 
			class='page-link page-action '>${page.title}</a>
	</li>
</c:forEach>
 </ul>
</nav>


   


	<table class="table table-striped" pageToken='pageListCurrentPage=${currentPageNumber}'>
		<thead><tr>
		<c:if test="${param.referName ne 'id'}">
	<th>${userContext.localeMap['page.id']}</th>
</c:if>
<c:if test="${param.referName ne 'pageTitle'}">
	<th>${userContext.localeMap['page.page_title']}</th>
</c:if>
<c:if test="${param.referName ne 'linkToUrl'}">
	<th>${userContext.localeMap['page.link_to_url']}</th>
</c:if>
<c:if test="${param.referName ne 'pageType'}">
	<th>${userContext.localeMap['page.page_type']}</th>
</c:if>
<c:if test="${param.referName ne 'mobileApp'}">
	<th>${userContext.localeMap['page.mobile_app']}</th>
</c:if>
<th>${userContext.localeMap['@action']}</th>
		</tr></thead>
		<tbody>
			
			<c:forEach var="item" items="${pageList}">
				<tr currentVersion='${item.version}' id="page-${item.id}" ><td><a class="link-action-removed" href="./pageManager/view/${item.id}/"> ${item.id}</a></td>
<c:if test="${param.referName ne 'pageTitle'}">	<td contenteditable='true' class='edit-value'  propertyToChange='pageTitle' storedCellValue='${item.pageTitle}' prefix='${ownerBeanName}Manager/updatePage/${result.id}/${item.id}/'>${item.pageTitle}</td>
</c:if><c:if test="${param.referName ne 'linkToUrl'}">	<td contenteditable='true' class='edit-value'  propertyToChange='linkToUrl' storedCellValue='${item.linkToUrl}' prefix='${ownerBeanName}Manager/updatePage/${result.id}/${item.id}/'>${item.linkToUrl}</td>
</c:if><c:if test="${param.referName ne 'pageType'}">
	<td class="select_candidate_td"
			data-candidate-method="./pageManager/requestCandidatePageType/${ownerBeanName}/${item.id}/"
			data-switch-method="./pageManager/transferToAnotherPageType/${item.id}/"
			data-link-template="./pageTypeManager/view/${'$'}{ID}/">
		<span class="display_span">
			<c:if test="${not empty  item.pageType}">
			<a href='./pageTypeManager/view/${item.pageType.id}/'>${item.pageType.displayName}</a>
			</c:if>
			<c:if test="${empty  item.pageType}">
			<a href='#'></a>
			</c:if>
			<button class="btn btn-link candidate-action">...</button>
		</span>
		<div class="candidate_span" style="display:none;">
			<input type="text" data-provide="typeahead" class="input-sm form-control candidate-filter-input" autocomplete="off" />
		</div>
	</td>
</c:if>
<c:if test="${param.referName ne 'mobileApp'}">
	<td class="select_candidate_td"
			data-candidate-method="./pageManager/requestCandidateMobileApp/${ownerBeanName}/${item.id}/"
			data-switch-method="./pageManager/transferToAnotherMobileApp/${item.id}/"
			data-link-template="./mobileAppManager/view/${'$'}{ID}/">
		<span class="display_span">
			<c:if test="${not empty  item.mobileApp}">
			<a href='./mobileAppManager/view/${item.mobileApp.id}/'>${item.mobileApp.displayName}</a>
			</c:if>
			<c:if test="${empty  item.mobileApp}">
			<a href='#'></a>
			</c:if>
			<button class="btn btn-link candidate-action">...</button>
		</span>
		<div class="candidate_span" style="display:none;">
			<input type="text" data-provide="typeahead" class="input-sm form-control candidate-filter-input" autocomplete="off" />
		</div>
	</td>
</c:if>

				<td>

				<a href='#${ownerBeanName}Manager/removePage/${result.id}/${item.id}/' class='delete-action btn btn-danger btn-xs'><i class="fa fa-trash-o fa-lg"></i> ${userContext.localeMap['@delete']}</a>
				<a href='#${ownerBeanName}Manager/copyPageFrom/${result.id}/${item.id}/' class='copy-action btn btn-success btn-xs'><i class="fa fa-files-o fa-lg"></i> ${userContext.localeMap['@copy']} </a>

				</td>
				</tr>
			</c:forEach>
		
		</tbody>
	</table>	
	

</div></c:if>


