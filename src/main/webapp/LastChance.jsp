<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Last Chance</title>
</head>
<body>
    <h1>Monty Hall Game</h1>
    <p>당신이 고른 문은 <%= request.getAttribute("initialChoice") %>번 입니다.</p>
    <p><%= request.getAttribute("revealedDoor") %>번 문 뒤에는 염소가 있습니다.</p>
    <form action="montyhall" method="post">
        <input type="hidden" name="initialChoice" value="<%= request.getAttribute("initialChoice") %>">
        <p>선택을 바꾸시겠습니까?</p>
        <input type="radio" id="stay" name="choice" value="stay" required>
        <label for="stay">바꾸지 않는다. (<%= request.getAttribute("initialChoice") %>번 문)</label><br>
        <input type="radio" id="switch" name="choice" value="switch" required>
        <label for="switch">바꾼다. (<%= request.getAttribute("remainingDoor") %>번 문)</label><br><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
