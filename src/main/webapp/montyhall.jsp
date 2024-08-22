<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Monty Hall Simulation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
        }
        .door-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px;
        }
        .door-box {
            width: 100px;
            height: 150px;
            margin: 0 25px;
            position: relative;
            border: 2px solid #000;
        }
        .door-box img {
            width: 100%;
            height: 100%;
        }
        .door-box .hidden-content {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            display: none;
        }
        .door-box.correct {
            border-color: green;
        }
        .door-box.incorrect {
            border-color: red;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Monty Hall Game</h1>
    <div class="result">
        <p>당신은 선택을 <%= request.getAttribute("choice").equals("stay") ? "바꾸지 않았습니다." : "바꿨습니다." %></p>
        <p>정답은 <%= request.getAttribute("carPosition") %>번 문이었습니다.</p>
        <% if ((boolean) request.getAttribute("win")) { %>
            <p class="correct">축하드립니다! 당첨입니다!</p>
        <% } else { %>
            <p class="incorrect">탈락입니다!</p>
        <% } %>
    </div>
    
    <div class="door-container">
        <!-- 문 1 -->
        <div class="door-box" id="door1">
            <img src="images/door.png" alt="Door 1">
            <div class="hidden-content" id="content1"></div>
        </div>
        <!-- 문 2 -->
        <div class="door-box" id="door2">
            <img src="images/door.png" alt="Door 2">
            <div class="hidden-content" id="content2"></div>
        </div>
        <!-- 문 3 -->
        <div class="door-box" id="door3">
            <img src="images/door.png" alt="Door 3">
            <div class="hidden-content" id="content3"></div>
        </div>
    </div>
    
    <a href="index.jsp">Play Again</a>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var carPosition = "<%= request.getAttribute("carPosition") %>";
            var door1 = document.getElementById("content1");
            var door2 = document.getElementById("content2");
            var door3 = document.getElementById("content3");

            function setDoorContent(doorElement, isCar) {
                doorElement.style.display = 'block';
                doorElement.style.backgroundImage = 'url("images/' + (isCar ? 'car.png' : 'goat.png') + '")';
            }

            if (carPosition === "1") {
                setDoorContent(door1, true);
                setDoorContent(door2, false);
                setDoorContent(door3, false);
            } else if (carPosition === "2") {
                setDoorContent(door1, false);
                setDoorContent(door2, true);
                setDoorContent(door3, false);
            } else if (carPosition === "3") {
                setDoorContent(door1, false);
                setDoorContent(door2, false);
                setDoorContent(door3, true);
            }
        });
    </script>
</body>
</html>
