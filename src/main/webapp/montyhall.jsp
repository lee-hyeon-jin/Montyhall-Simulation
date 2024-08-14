<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Monty Hall Simulation</title>
</head>
<body>
    <h1>Monty Hall Game</h1>
    <p>당신은 선택을 <%= request.getAttribute("choice").equals("stay") ? "바꾸지 않았습니다." : "바꿨습니다." %></p>
    <p>정답은 <%= request.getAttribute("carPosition") %>번 문이었습니다.</p>
    <% if ((boolean) request.getAttribute("win")) { %>
        <p>축하드립니다! 당첨입니다!</p>
    <% } else { %>
        <p>탈락입니다!</p>
    <% } %>
    <a href="index.jsp">Play Again</a>
</body>
</html>
