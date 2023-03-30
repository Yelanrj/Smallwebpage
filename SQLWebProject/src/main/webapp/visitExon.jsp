<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>外显子查询结果</title>
    <style>
        body{
            background: url(./202.png);
            /* 设置背景铺满 */
            background-repeat:no-repeat;
            background-size:100%;

        }
        form{
            width: 500px;
            height: 400px;


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
		<form action="">
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String url="jdbc:mysql://localhost:3306/a15055";
		String user="root";
		String pwd="";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url,user,pwd);
		stmt = conn.createStatement();
			
		String sql = "select transcript_id, exon_id, start, end, ranks "
				+ "from exon55 join exon_transcript55 using (exon_id) "
				+ "where transcript_id = "
				+ request.getParameter("transid"); 
		rs = stmt.executeQuery(sql);

		if (!rs.isBeforeFirst()){
			%>
			<p> There are no records for this ID!! </p>
		<%}			
		else {%>
			<table border="1">
			<tr>
			<td>transcript_id</td> <td> start</td> <td>end</td> <td>ranks</td>
			</tr>
			<%while (rs.next()){%>
			<tr>
			<td>	<%= rs.getString("transcript_id")%> </td>
			<td>	<%= rs.getString("start")%> </td>
			<td>	<%= rs.getString("end")%> </td>
			<td>	<%= rs.getString("ranks")%> </td>
			</tr>
			<%}%>
			</table>
		<%}%>
			
		<% if(rs!=null){
			rs.close();
		}
		if(stmt!=null){
			stmt.close();
		}
		if(conn!=null){
			conn.close();
		}			
		 %>	
		 	</form>
</body>
</html>