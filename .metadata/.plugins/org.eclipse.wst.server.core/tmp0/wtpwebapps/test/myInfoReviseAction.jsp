<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.util.Enumeration" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String ID = (String) session.getAttribute("ID");
		int maxImageSize = 100*1024*1024;
		String endCodingType = "UTF-8";
		String directory = "C:/Users/com/Desktop/spaceZ/test/src/main/webapp/images/userProfile";
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxImageSize, endCodingType, new DefaultFileRenamePolicy());
		String fileName = multipartRequest.getFilesystemName("upLoadFile");
		if(fileName != null){
			try {
				File deleteFile = new File(directory + "/" + ID +".jpg");
				deleteFile.delete();
				Path oldfile = Paths.get(directory + "/" + fileName);
				Path newfile = Paths.get(directory + "/" + ID +".jpg");
				Files.move(oldfile, newfile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		user.setEMAIL(multipartRequest.getParameter("EMAIL"));
		user.setPASSWORD(multipartRequest.getParameter("PASSWORD"));
		user.setNICKNAME(multipartRequest.getParameter("NICKNAME"));
		user.setPHONE_NUM(multipartRequest.getParameter("PHONE_NUM"));
		user.setADDRESS(multipartRequest.getParameter("ADDRESS"));
		UserDAO userDAO = new UserDAO();
		int result = userDAO.reviseUserInfo(user);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 사항을 입력해 주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정이 완료되었습니다.')");
			script.println("location.href = 'myInfo.jsp'");
			script.println("</script>");
		}
	%>

</body>
</html>