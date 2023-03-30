<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>注册结果</title>
    <style>
        body{
            background: url(./202.png);
            background-repeat:no-repeat;
            background-size:100%;

        }
        form{
            width: 500px;
            height: 250px;


            background-color: #E1E9EF;


            opacity: 80%;

            padding: 120px 100px;

            font-size: 18px;

            border-radius: 10px;


            margin: 120px auto;
        }

        .textinput{

            height: 40px;
            width: 300px;

            padding: 0 35px;

            border: none;

            background: #F8F9F9;

            font-size: 15px;

            box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), inset 0px 2px 5px #aaaaaa;

            border-radius: 5px;

            color: saddlebrown;
        }

        a {

            text-decoration: none;
        }

        a:hover {
        
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<%
	Connection conn=null;
	String url="jdbc:mysql://localhost:3306/a15055";
	String user="root";
	String pwd="";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,user,pwd);

	String sql="create user "+request.getParameter("user")+" identified by "+"'"+request.getParameter("pwd")+"'";
	
	Statement stmt = conn.createStatement();
	
	stmt.executeUpdate(sql);
	
// 	if(request.getParameter("select")!= null){
// 		stmt.executeUpdate("grant select on a15055.* to "+request.getParameter("user"));
// 	}
		
// 	if(request.getParameter("insert")!= null){
// 		stmt.executeUpdate("grant insert on a15055.* to "+request.getParameter("user"));
// 	}
	
// 	if(request.getParameter("update")!= null){
// 		stmt.executeUpdate("grant update on a15055.* to "+request.getParameter("user"));
// 	}
	
	
// 	if(request.getParameter("delete")!= null){
// 		stmt.executeUpdate("grant delete on a15055.* to "+request.getParameter("user"));
// 	}
	
  	String[] values=request.getParameterValues("permissions");
  	for(int i=0;i<values.length;i++){
  		System.out.println(values[i]);
  		stmt.executeUpdate("grant "+values[i]+" on a15055.* to "+request.getParameter("user"));
  	}
	
	%>
	<form action="">
	<h1><div style=" margin:0 auto; text-align:center">	注册成功！</div></h1>
	<h2><div style=" margin:0 auto; text-align:center">	<a href="login.html">跳转到登录界面</a></div></h2>
	</form>
</body>
</html>