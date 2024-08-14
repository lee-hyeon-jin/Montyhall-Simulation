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

        int winCount = 0;
        int loseCount = 0;

        for (int i = 0; i < numRuns; i++) {
            int carPosition = (int) (Math.random() * 3) + 1;
            int initialChoice = (int) (Math.random() * 3) + 1;
            int revealedDoor = -1;

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
        }

        request.getSession().setAttribute("simulationWinCount", winCount);
        request.getSession().setAttribute("simulationLoseCount", loseCount);
        
        // Redirect back to index.jsp
        response.sendRedirect("index.jsp");
    }
}
