<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Monty Hall Simulation</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }
        .chart-item {
            display: flex;
            flex-direction: column;
            align-items: center;
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
    </style>
</head>
<body>
    <h1>Welcome to the Monty Hall Simulation</h1>
    
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
        <input type="submit" value="Submit"><br>
    </form>

    <h2>몬티홀 시뮬레이션</h2>
    <form action="simulate" method="post">
        <label for="numRuns">시뮬레이션 횟수:</label>
        <input type="number" id="numRuns" name="numRuns" min="1" required>
        <br>
        <input type="radio" id="simulateChange" name="simulationType" value="change" required>
        <label for="simulateChange">문 변경 시</label><br>
        <input type="radio" id="simulateKeep" name="simulationType" value="keep" required>
        <label for="simulateKeep">문 유지 시</label><br><br>
        <input type="submit" value="Run Simulation">
    </form>

    <div class="chart-container">
        <!-- 게임 결과 통계 그래프 -->
        <div class="chart-item">
            <div class="chart-title">
                <h2>게임 결과 통계</h2>
            </div>
            <canvas id="resultChart" width="300" height="300"></canvas>
        </div>
        <!-- 시뮬레이션 결과 그래프 -->
        <div class="chart-item">
            <div class="chart-title">
                <h2>시뮬레이션 결과 통계</h2>
            </div>
            <canvas id="simulationChart" width="300" height="300"></canvas>
        </div>
    </div>

    <script>
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
