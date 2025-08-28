<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transfer</title>
    <style>body{margin:0}</style>
    </head>
<body>
    <jsp:forward page="account">
        <jsp:param name="view" value="transfer"/>
    </jsp:forward>
</body>
</html>

