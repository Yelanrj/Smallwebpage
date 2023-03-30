<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>插入新基因</title>
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
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String url="jdbc:mysql://localhost:3306/a15055";
	String user="root";
	String pwd="";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,user,pwd);

	String sql="insert into gene55(gene_id,start,end,biotype) "
			+"values (?,?,?,?)";
	pstmt=conn.prepareStatement(sql);
	
	int id,start,end;
	String biotype=null;
	System.out.print("Please input the gene_id, start, end and biotype: ");
	id=Integer.parseInt(request.getParameter("geneid"));
	pstmt.setInt(1, id);
	start=Integer.parseInt(request.getParameter("start"));
	pstmt.setInt(2, start);
	end=Integer.parseInt(request.getParameter("end"));
	pstmt.setInt(3, end);
	biotype=request.getParameter("biotype");
	pstmt.setString(4, biotype);
	
	pstmt.executeUpdate();
	%>
	<form action="">
	<div style=" margin:0 auto; text-align:center">	Congratulations!It works!!!</div>
	</form>
</body>
</html>