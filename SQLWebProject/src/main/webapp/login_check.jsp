<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>登录结果</title>
    <style>
        body{
            background: url(./202.png);
            background-repeat:no-repeat;
            background-size:100%;

        }
        form{
            width: 500px;
            height: 500px;


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
<body style="text-align:center">
<%int count; %>
<%try{
	Connection conn=null;
	Statement stmt = null;
	String url="jdbc:mysql://localhost:3306/a15055";
	String user=request.getParameter("user");
	String pwd=request.getParameter("pwd");
	//if(pwd==null)
	//	pwd="";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,user,pwd);
	count=1;
}
catch(java.sql.SQLException error){%>
	<form action="">
	<h2>用户名或密码错误!</h2>
	</form>
<% count=0;
}%>
<%if(count!=0){ %>
	<form action="">
	<h2>登录成功<br>
	<%String user=request.getParameter("user"); %>
	欢迎 <font color="red"><%=user %></font> 使用！</h2>

	<br>
	<%
	Connection conn=null;
	ArrayList<String> strings=new ArrayList<String>();
	Statement stmt = null;
	String url="jdbc:mysql://localhost:3306/a15055";
	String pwd=request.getParameter("pwd");
	//if(pwd==null)
	//	pwd="";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn=DriverManager.getConnection(url,user,pwd);
	stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("show grants for "+user+"; ");
	
	while (rs.next()){
		String word=rs.getString("Grants for "+user+"@%");
		//System.out.println(word);
		strings.add(word);
	}
	int[] privileges=new int[4];
	String[] somStrings1;
	String[] somStrings2;
	String sqlname=null;
	int warn=0;
	/*SELECT,INSERT,UPDATE,DELETE*/
	for(String s:strings){
		if(warn==0){
			//用于跳过普通用户默认的第一条GRANT USAGE ON *.* TO 'xiaomore'@'localhost'
			warn++;
			continue;
		}
		somStrings1=s.split("`");
		somStrings2=somStrings1[1].split("`");
		sqlname=somStrings2[0];
		// int grants=0;
		if(s.contains("ALL PRIVILEGES")){
			for(int k=0;k<privileges.length;k++){
				privileges[k]=1;
			}
			break;
		}if(s.contains("SELECT")){
			privileges[0]=1;
		}if(s.contains("INSERT")){
			privileges[1]=1;
		}if(s.contains("UPDATE")){
			privileges[2]=1;
		}if(s.contains("DELETE")){
			privileges[3]=1;
		}//else{//实际运行不应该出现这种情况
		//	System.out.println("Wrong! ");
		//}
		
	}
	
	if(privileges[0]==1){%>
		<h2>您可以查询<%=sqlname %>数据库中的表，<a href="submitID.html">请点击链接查询转录本的外显子信息</a></h2>
	<%
	}
	if(privileges[1]==1){%>
	<h2>您可以向<%=sqlname %>数据库中的表插入数据，<a href="insertTuple.html">请点击链接向Gene表插入数据</a></h2>
	<%
	}
	if(privileges[2]==1){%>
	<h2>您可以向<%=sqlname %>数据库中的表更新数据，<a href="updateTuple.html">请点击链接向Gene表更新数据</a></h2>
	<%
	}if(privileges[3]==1){%>
	<h2>您可以向<%=sqlname %>数据库中的表删除数据，<a href="deleteTuple.html">请点击链接向Gene表删除数据</a></h2>
	<%
	}
	//ResultSet rs = stmt.executeQuery("SHOW DATABASES;");
	//ResultSetMetaData rs_metaData = rs.getMetaData();
	//while (rs.next()) {
	//	int count = rs_metaData.getColumnCount();
	//	for (int i=0;i<count;i++){
			
	//	}
	}
%></form>

<!--catch(jakarta.servlet.ServletException error  -->
</body>
</html>