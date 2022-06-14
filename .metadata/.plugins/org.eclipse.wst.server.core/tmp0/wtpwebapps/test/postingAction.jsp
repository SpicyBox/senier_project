<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="post" class="post.Post" scope="page" />
<jsp:setProperty name="post" property="TITLE" />
<jsp:setProperty name="post" property="INFO" />
<jsp:setProperty name="post" property="ID" />
<jsp:setProperty name="post" property="POST_CONTENTS" />
<jsp:setProperty name="post" property="ADDRESS" />
<jsp:setProperty name="post" property="PRICE" />
<jsp:setProperty name="post" property="RENTAL_TIME" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int maxImageSize = 100*1024*1024;
		String endCodingType = "UTF-8";
		String directory = "C:/Users/com/Desktop/spaceZ/test/src/main/webapp/images/mainImage";
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxImageSize, endCodingType, new DefaultFileRenamePolicy());
		String fileName = multipartRequest.getFilesystemName("upLoadFile");
		System.out.println(fileName);
		PostDAO postDAO = new PostDAO();
		int result = postDAO.posting(post, fileName);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('작성에 실패하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글을 작성하였습니다.')");
			script.println("location.href = 'searchmain.jsp'");
			script.println("</script>");
		}
	%>

</body>
</html>