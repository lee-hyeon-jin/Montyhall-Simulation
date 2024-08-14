package com.montyhall;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/simulate")
public class SimulateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int numRuns = Integer.parseInt(request.getParameter("numRuns"));
        String simulationType = request.getParameter("simulationType");

        int winCount = 0;
        int loseCount = 0;

        for (int i = 0; i < numRuns; i++) {
            int carPosition = (int) (Math.random() * 3) + 1;
            int initialChoice = (int) (Math.random() * 3) + 1;
            int revealedDoor = -1;

            if ("change".equals(simulationType)) {
                for (int j = 1; j <= 3; j++) {
                    if (j != initialChoice && j != carPosition) {
                        revealedDoor = j;
                        break;
                    }
                }
                int finalChoice = 6 - initialChoice - revealedDoor;
                if (finalChoice == carPosition) {
                    winCount++;
                } else {
                    loseCount++;
                }
            } else if ("keep".equals(simulationType)) {
                if (initialChoice == carPosition) {
                    winCount++;
                } else {
                    loseCount++;
                }
            }
        }

        // 세션에 결과 저장
        request.getSession().setAttribute("simulationWinCount", winCount);
        request.getSession().setAttribute("simulationLoseCount", loseCount);
        
        // 결과 페이지로 리디렉션
        response.sendRedirect("index.jsp");
    }
}
