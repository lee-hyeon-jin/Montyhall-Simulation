package com.montyhall;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/switchdoor")
public class LastChanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int initialChoice = Integer.parseInt(request.getParameter("door"));
        int carPosition = (int) (Math.random() * 3) + 1;
        request.getSession().setAttribute("carPosition", carPosition);
        request.getSession().setAttribute("initialChoice", initialChoice);

        int revealedDoor = -1;
        for (int i = 1; i <= 3; i++) {
            if (i != initialChoice && i != carPosition) {
                revealedDoor = i;
                break;
            }
        }
        
        int remainingDoor = 6 - initialChoice - revealedDoor;

        request.getSession().setAttribute("revealedDoor", revealedDoor);
        request.getSession().setAttribute("remainingDoor", remainingDoor);
        
        request.setAttribute("initialChoice", initialChoice);
        request.setAttribute("revealedDoor", revealedDoor);
        request.setAttribute("remainingDoor", remainingDoor);
        
        // JSP 파일 경로가 /LastChance.jsp로 설정됨
        request.getRequestDispatcher("/LastChance.jsp").forward(request, response);
    }
}
