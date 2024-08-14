<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Index Page</title>
</head>
<body>
    <h1>Welcome to the Monty Hall Simulation</h1>
    <form action="switchdoor" method="post">
        <p>문을 고르세요:</p>
        <input type="radio" id="door1" name="door" value="1" required>
        <label for="door1">1번 문</label><br>
        <input type="radio" id="door2" name="door" value="2" required>
        <label for="door2">2번 문</label><br>
        <input type="radio" id="door3" name="door" value="3" required>
        <label for="door3">3번 문</label><br><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
