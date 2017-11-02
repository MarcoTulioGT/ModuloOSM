<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <sql:query var="listUsers" dataSource="jdbc/OSM">
  select 
SUBSTR (COMPOSITE_DN,0,INSTR(COMPOSITE_DN,'/')-1) PARTICION,
SUBSTR (COMPOSITE_DN,INSTR(COMPOSITE_DN,'/')+1,INSTR(COMPOSITE_DN,'!')-INSTR(COMPOSITE_DN,'/')-1) PROCESO,
SUBSTR (COMPOSITE_DN,INSTR(COMPOSITE_DN,'!')+1,INSTR(COMPOSITE_DN,'*')-INSTR(COMPOSITE_DN,'!')-1) VERSION,
SUBSTR (COMPOSITE_DN,INSTR(COMPOSITE_DN,'*')+1,100) EICD,
count(COMPOSITE_DN) CANTIDAD
from COMPOSITE_INSTANCE
where CREATED_TIME >= trunc(sysdate-7)
and STATE = 1
group by COMPOSITE_DN 
order by 1,2,5  desc
</sql:query>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ejecucciones OSM Desarrollo (Ultimos 7 dias)</title>
</head>
<body>
    <div align="center">
        <table border="1" cellpadding="5">
            <caption><h2>Ejecucciones OSM Desarrollo (Ultimos 7 dias)</h2></caption>
            <tr>
                <th>Partición</th>
                <th>Compuesto</th>
                  <th>Versión</th>
                  <th>EICD</th>
                <th>Cantidad</th>
            </tr>
            <c:forEach var="user" items="${listUsers.rows}">
                <tr>
                <td><c:out value="${user.PARTICION}" /></td>
                <td><c:out value="${user.PROCESO}" /></td>
                    <td><c:out value="${user.VERSION}" /></td>
                    <td><c:out value="${user.EICD}" /></td>
                     <td><c:out value="${user.CANTIDAD}" /></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>