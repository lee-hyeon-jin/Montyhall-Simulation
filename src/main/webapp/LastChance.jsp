<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Last Chance</title>
    <style>
        .door-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px;
        }
        .door-box {
            width: 100px;
            height: 150px;
            margin: 0 10px;
            position: relative;
        }
        .door-box img {
            width: 100%;
            height: 100%;
        }
        .goat {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            display: none; /* Hidden by default */
        }
    </style>
</head>
<body>
    <h1>Monty Hall Game</h1>
    <p>당신이 고른 문은 <%= request.getAttribute("initialChoice") %>번 입니다.</p>
    <p><%= request.getAttribute("revealedDoor") %>번 문 뒤에는 염소가 있습니다.</p>
    <div class="door-container">
        <!-- 문 1 -->
        <div class="door-box" id="door1">
            <img src="images/door.png" alt="Door 1">
            <div class="goat" id="goat1" style="background-image: url('images/goat.png');"></div>
        </div>
        <!-- 문 2 -->
        <div class="door-box" id="door2">
            <img src="images/door.png" alt="Door 2">
            <div class="goat" id="goat2" style="background-image: url('images/goat.png');"></div>
        </div>
        <!-- 문 3 -->
        <div class="door-box" id="door3">
            <img src="images/door.png" alt="Door 3">
            <div class="goat" id="goat3" style="background-image: url('images/goat.png');"></div>
        </div>
    </div>

    <form action="montyhall" method="post">
        <input type="hidden" name="initialChoice" value="<%= request.getAttribute("initialChoice") %>">
        <p>선택을 바꾸시겠습니까?</p>
        <input type="radio" id="stay" name="choice" value="stay" required>
        <label for="stay">바꾸지 않는다. (<%= request.getAttribute("initialChoice") %>번 문)</label><br>
        <input type="radio" id="switch" name="choice" value="switch" required>
        <label for="switch">바꾼다. (<%= request.getAttribute("remainingDoor") %>번 문)</label><br><br>
        <input type="submit" value="Submit">
    </form>

    <!-- JavaScript to show the goat -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var revealedDoor = "<%= request.getAttribute("revealedDoor") %>";

            // Show the goat on the revealed door
            if (revealedDoor) {
                var goat = document.getElementById('goat' + revealedDoor);
                if (goat) {
                    goat.style.display = 'block'; // Show the goat image
                }
            }
        });
    </script>
</body>
</html>
