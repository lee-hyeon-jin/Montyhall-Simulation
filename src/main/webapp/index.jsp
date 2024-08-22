<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Monty Hall Simulation</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 700px; /* 너비를 제한하여 중앙 정렬 유지 */
            margin: 0 auto; /* 중앙 정렬 */
            padding: 20px;
        }
        .chart-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .chart-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 10px;
        }
        .chart-item canvas {
            max-width: 400px;
            max-height: 400px;
            margin: 10px;
        }
        .chart-title {
            margin-bottom: 10px;
        }
        .door-container {
            text-align: center;
            margin: 20px;
        }
        .door-container img {
            width: 100px;
            height: 150px;
            margin: 10px;
            cursor: pointer;
        }
        .button-form-container {
            display: flex;
            justify-content: flex-end;
        }
        .button-form-container form {
            margin-left: 20px; /* 폼과 버튼 간의 간격 */
        }
        .central-align {
            text-align: center; /* 중앙 정렬 */
        }
        .simulation-form {
            display: flex;
            flex-direction: column;
            align-items: center;
            /* 오른쪽 여백을 줄이기 위해 추가 */
            padding-right: 0px;
        }
        .simulation-options {
            text-align: right; /* 오른쪽 정렬 */
            padding-right: 200px; /* 오른쪽 여백 */
        }
        .progress-bar {
            position: fixed;
            top: 0;
            left: 0;
            width: 0;
            height: 3px;
            background-color: #4caf50;
            z-index: 1000;	/* 요소 쌓임 순서 정의. 값이 클수록 앞에 쌓임 */
            transition: width 0.2s;
        }
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: white;
            z-index: 1000;
            padding: 20px 0;
            text-align: center;
            transition: transform 0.3s ease, opacity 0.3s ease;
        }
        .hidden {
            transform: translateY(-100%);
            opacity: 0;
        }
    </style>
</head>
<body>
    <div class="progress-bar" id="progressBar"></div> <!-- Progress Bar -->
    <div class="header" id="header">
        <h1>Welcome to the Monty Hall Simulation</h1>
    </div>
    <br><br><br><br><br><br><br>
    <div class="container" id="content"> <!-- Content Start -->    
        <h2>몬티홀 게임</h2>
        <form action="switchdoor" method="post">
            <p>문을 고르세요:</p>
            <div class="door-container">
                <input type="radio" id="door1" name="door" value="1" required>
                <label for="door1"><img src="images/door.png" alt="Door 1"></label>
                <input type="radio" id="door2" name="door" value="2" required>
                <label for="door2"><img src="images/door.png" alt="Door 2"></label>
                <input type="radio" id="door3" name="door" value="3" required>
                <label for="door3"><img src="images/door.png" alt="Door 3"></label>
            </div>
            <div class="button-form-container">
                <input type="submit" value="Submit">
            </div>
        </form>
        <br>

        <h2>몬티홀 시뮬레이션</h2>
        <form action="simulate" method="post">
            <div class="central-align">
                <label for="numRuns">시뮬레이션 횟수:</label>
                <input type="number" id="numRuns" name="numRuns" min="1" step="1" required>
            </div>
            <br>
            <div class="simulation-options simulation-form">
                <div style="display: flex; align-items: center;">
                    <input type="radio" id="simulateChange" name="simulationType" value="change" required>
                    <label for="simulateChange" style="margin-left: 5px;">문 변경 시</label>
                </div>
                <div style="display: flex; align-items: center; margin-top: 10px;">
                    <input type="radio" id="simulateKeep" name="simulationType" value="keep" required>
                    <label for="simulateKeep" style="margin-left: 5px;">문 유지 시</label>
                </div>
            </div>
            <br>
            <div class="button-form-container">
                <input type="submit" value="Run Simulation">
            </div>
        </form>

        <div class="chart-container">
        	<!-- 게임 결과 통계 그래프 -->
            <div class="chart-item">
                <div class="chart-title">
                    <h2>게임 결과 통계</h2>
                </div>
                <canvas id="resultChart" width="300" height="300"></canvas>
            </div>
            <div class="chart-item">
            	<!-- 시뮬레이션 결과 통계 그래프 -->
                <div class="chart-title">
                    <h2>시뮬레이션 결과 통계</h2>
                </div>
                <canvas id="simulationChart" width="300" height="300"></canvas>
            </div>
        </div>
    </div> <!-- Content End -->

    <script>
        window.onscroll = function() {
        	// 스크롤에 따른 상단 타이틀 투명화 동적옵션
            var header = document.getElementById('header');
            var scrollPosition = window.scrollY;

            // 스크롤 위치가 30px 이상이면 헤더가 사라지게 함
            if (scrollPosition > 30) {
                header.classList.add('hidden');
            } else {
                header.classList.remove('hidden');
            }
            
         	// 프로그레스 바 업데이트
            var content = document.getElementById('content');
            var progressBar = document.getElementById('progressBar');
            var contentHeight = content.scrollHeight - window.innerHeight;
            var scrollPosition = window.scrollY;

            var progress = (scrollPosition / contentHeight) * 100;
            progressBar.style.width = progress + "%";
        };

        // 게임 결과 통계 그래프
        var ctx1 = document.getElementById('resultChart').getContext('2d');
        new Chart(ctx1, {
            type: 'pie',
            data: {
                labels: ['당첨', '꽝'],
                datasets: [{
                    label: '게임 결과',
                    data: [
                        <%= getServletContext().getAttribute("winCount") != null ? getServletContext().getAttribute("winCount") : 0 %>,
                        <%= getServletContext().getAttribute("loseCount") != null ? getServletContext().getAttribute("loseCount") : 0 %>
                    ],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(255, 99, 132, 0.2)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 99, 132, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: '게임 결과 통계'
                    }
                }
            }
        });

        // 시뮬레이션 결과 그래프
        var ctx2 = document.getElementById('simulationChart').getContext('2d');
        new Chart(ctx2, {
            type: 'pie',
            data: {
                labels: ['당첨', '꽝'],
                datasets: [{
                    label: '시뮬레이션 결과',
                    data: [
                        <%= session.getAttribute("simulationWinCount") != null ? session.getAttribute("simulationWinCount") : 0 %>,
                        <%= session.getAttribute("simulationLoseCount") != null ? session.getAttribute("simulationLoseCount") : 0 %>
                    ],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(255, 99, 132, 0.2)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 99, 132, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: '시뮬레이션 결과 통계'
                    }
                }
            }
        });
    </script>
</body>
</html>
