<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="키워드">
    <meta name="keywords" content="키워드">
    <meta property="og:url" content="도메인">
    <meta property="og:title" content="키워드">
    <meta property="og:description" content="사이트설명">
    <meta property="og:image" content="대표이미지">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/promotion.css">
    <link rel="stylesheet" href="css/article.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/floating.css">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
    <link rel="shortcut icon" href="images/favicon.png"  type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css">
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <title>Document</title>
</head>
<body>
	<%
	String ID = null;
		if(session.getAttribute("ID") != null){
			ID = (String) session.getAttribute("ID");
		}
	%>
    <div class="floating">
        <a href="/"><img src="images/top.png"></a>
    </div>
    <header>
        <nav>
            <a href="searchmain.jsp" class="logo"><img src="images/logo.png"></a>
            <form action="" class="search-wrapper">
                <input type="text" name="searchText" placeholder="공간을 검색해보세요" class="searchBar">
                <button type="submit" class="searchBtn">
                    <ion-icon name="search-sharp"></ion-icon>
                </button>
            </form>
            <%
            if(ID == null){
            %>
    			<a href="login.html"><div class="loginBtn"><p>로그인</p></div></a>
    		<%
    		} else {
    		%>
    			<div class="myIcons">
                <a href="myPostView.jsp"><div class="myIcon">
                    <i class="ri-file-list-line"></i>
                </div></a>
                <a href="rentView.jsp"><div class="myIcon">
                    <i class="ri-task-line"></i>
                </div></a>
                <a href="reserveView.jsp"><div class="myIcon">
                    <i class="ri-draft-line"></i>
                </div></a>
                <a href="myInfo.jsp"><div class="myIcon">
                    <i class="ri-emotion-happy-line"></i>
                </div></a>
            </div>
    		<%
    		}
    		%>
        </nav>
    </header>
    <main>
        <section class="article">
            <div class="article-wrapper">
                <div class="article-title">
                    <h1>
                        <span class="city">내 게시글</span>
                    </h1>
                </div>
                <div class="article-box-wrapper">
                	<%
                	PostDAO postDAO = new PostDAO();
                	                	                		ArrayList<Post> list = postDAO.getSearch("ID", ID);
                	                	                		for(int i = 0; i < list.size(); i++){
                	                	                			String titleMain = "images/mainImage/" + list.get(i).getPHOTO();
                	                	                			String postDetail = "postRevise.jsp?postID=" + list.get(i).getPOST_NUM();
                	                	                			String scoreText = Double.toString(Math.round(list.get(i).getSCORE() * 10) / 10.0);
                	                	                			String postDate = "0";
                	                	                			if(list.get(i).getPOST_DATE() != null){
                	                	                				postDate = list.get(i).getPOST_DATE().substring(0, 10);
                	                	                			}
                	%>
                    <div class="article-box">
                        <img src=<%=titleMain%> class="a-box-image">
                        <div class="a-box-info">
                            <div class="a-box-title">
                                <h1 class="product"><%=list.get(i).getTITLE()%></h1>
                                <h5 class="address"><%=list.get(i).getADDRESS()%></h5>
                                <p class="spaceInfo">
                                    <%=list.get(i).getINFO()%>
                                </p>
                                <h2 class="price">₩<%=list.get(i).getPRICE()%> <span class="time">/ <%=list.get(i).getRENTAL_TIME()%></span></h2>
                            </div>
                            <div class="a-box-under">
                                <div class="a-box-text">
                                    <p>
                                        <span class="date"><ion-icon name="cloud-upload-sharp"></ion-icon><%=postDate%></span>
                                        <span class="view"><ion-icon name="eye-sharp"></ion-icon> <%=list.get(i).getVIEW_COUNT()%></span>
                                    </p>
                                    <div class="star">
                                        <h4>
                                            ★<%=scoreText%>
                                        </h4>
                                    </div>
                                </div>
                                <a href= <%= postDetail%> >
                                    <button class="moreBtn" ><p>수정하기</p></button>
                                </a>
                            </div>
                        </div>
                    </div>
                    <%
                		}
                	%>
                </div>
            </div>
        </section>
    </main>
    <footer>
        <div class="footer-wrapper">
            <p>
                Copyright (C) 2022 All Rights Reserved.
            </p>
        </div>
    </footer>
</body>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<script>
    AOS.init({
        once: true
    })
</script>

<script>
    $('.moreboxBtn').click(function(){
        $('.morebox').css('display','flex');
        $('.moreboxBtn').css('display','none');
    })
</script>

<script>
    $(document).ready(function() {
 
        $(".floating").hide();
        $(function() {
 
            $(window).scroll(function() {
                if ($(this).scrollTop() > 200) {
                    $('.floating').fadeIn();
                } else {
                    $('.floating').fadeOut();
                }
            });
        });
 
    });
</script>

<script src="js/jquery.scrollTo.min.js"></script>
<script>
    $(function () {
        $('.floating a, .logo').click(function (e) {
            $.scrollTo(this.hash || 0, 500); /* 속도 절, 숫자가 작을수록 빠름 */
            e.preventDefault();
        });
    });
</script>

<script>
    if (window.navigator.userAgent.match(/MSIE|Internet Explorer|Trident/i)) {
        // IE!!
        window.location = 'https://support.microsoft.com/ko-kr/office/%ec%97%b0%ea%b2%b0%ed%95%98%eb%a0%a4%eb%8a%94-%ec%9b%b9-%ec%82%ac%ec%9d%b4%ed%8a%b8%ea%b0%80-internet-explorer%ec%97%90%ec%84%9c-%ec%9e%91%eb%8f%99%ed%95%98%ec%a7%80-%ec%95%8a%ec%8a%b5%eb%8b%88%eb%8b%a4-8f5fc675-cd47-414c-9535-12821ddfc554?ui=ko-kr&rs=ko-kr&ad=kr';
    }
</script>

</html>