<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Last Chance</title>
    <style>
    
        .container {
            max-width: 700px; /* 너비를 제한하여 중앙 정렬 유지 */
            margin: 0 auto; /* 중앙 정렬 */
            padding: 20px;
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
            cursor: pointer; /* 커서 모양을 손가락으로 변경 */
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
        .button-form-container {
            display: flex;
            justify-content: flex-end;
        }
        .central-align {
            text-align: center; /* 중앙 정렬 */
        }
        .choice-form {
            display: flex;
            flex-direction: column;
            align-items: left;
            /* 왼쪽 여백을 줄이기 위해 추가 */
            padding-left: 150px;
        }
        .choice-options {
            text-align: left; /* 왼쪽 정렬 */
            padding-left: 150px; /* 왼쪽 여백 */
        }
    </style>
</head>
<body>
    <div class="container">
	    <h1>Monty Hall Game</h1>
	    <p>당신이 고른 문은 <%= request.getAttribute("initialChoice") %>번 입니다.</p>
	    <p><%= request.getAttribute("revealedDoor") %>번 문 뒤에는 염소가 있습니다.</p>
	    <div class="door-container">
	        <!-- 문 1 -->
	        <div class="door-box" id="1">
	            <img src="images/door.png" alt="Door 1">
	            <div class="goat" id="goat1" style="background-image: url('images/goat.png');"></div>
	        </div>
	        <!-- 문 2 -->
	        <div class="door-box" id="2">
	            <img src="images/door.png" alt="Door 2">
	            <div class="goat" id="goat2" style="background-image: url('images/goat.png');"></div>
	        </div>
	        <!-- 문 3 -->
	        <div class="door-box" id="3">
	            <img src="images/door.png" alt="Door 3">
	            <div class="goat" id="goat3" style="background-image: url('images/goat.png');"></div>
	        </div>
	    </div>
	
	    <form action="montyhall" method="post">
	        <input type="hidden" name="initialChoice" value="<%= request.getAttribute("initialChoice") %>">
			<div class="choice-options choice-form">
	        	<p>선택을 바꾸시겠습니까?</p>
	            <!-- 라디오 버튼과 라벨을 나란히 배치 -->
	            <div style="display: flex; align-items: center;">
	                <input type="radio" id="stay" name="choice" value="stay" required>
	                <label for="stay" style="margin-left: 5px;">바꾸지 않는다. (<%= request.getAttribute("initialChoice") %>번 문)</label>
	            </div>
	            <div style="display: flex; align-items: center; margin-top: 10px;">
	                <input type="radio" id="switch" name="choice" value="switch" required>
	                <label for="switch" style="margin-left: 5px;">바꾼다. (<%= request.getAttribute("remainingDoor") %>번 문)</label>
	            </div>
	        </div>
	        <div class="button-form-container">
	        	<input type="submit" value="Submit">
	        </div>
	    </form>
	</div>

    <!-- JavaScript to show the goat -->
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        var revealedDoor = "<%= request.getAttribute("revealedDoor") %>";
        var initialChoice = "<%= request.getAttribute("initialChoice") %>";
        var remainingDoor = "<%= request.getAttribute("remainingDoor") %>";

        // Show the goat on the revealed door
        if (revealedDoor) {
            var goat = document.getElementById('goat' + revealedDoor);
            if (goat) {
                goat.style.display = 'block'; // Show the goat image
            }
        }

        // Handle door image clicks
        document.querySelectorAll('.door-box').forEach(function(doorBox) {
            doorBox.addEventListener('click', function() {
                var doorId = doorBox.id;
                if (doorId !== revealedDoor) {
                    if (doorId === remainingDoor) {
                        // Initial choice door clicked, select second option
                        document.getElementById('switch').checked = true;
                    } else {
                        // Remaining door clicked, select first option
                        document.getElementById('stay').checked = true;
                    }
                    // Trigger the submit button click
                    document.getElementById('submitButton').click();
                }
            });
        });
    });
    </script>
</body>
</html>

	
