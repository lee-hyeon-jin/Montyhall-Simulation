package com.montyhall;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/montyhall")
public class MontyHallServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int initialChoice = (int) request.getSession().getAttribute("initialChoice");
        int carPosition = (int) request.getSession().getAttribute("carPosition");
        String choice = request.getParameter("choice");

        int finalChoice;
        if ("switch".equals(choice)) {
            finalChoice = 6 - initialChoice - (int) request.getSession().getAttribute("revealedDoor");
        } else {
            finalChoice = initialChoice;
        }

        boolean win = (finalChoice == carPosition);

        request.setAttribute("choice", choice);
        request.setAttribute("win", win);
        request.setAttribute("carPosition", carPosition);
        request.getRequestDispatcher("/montyhall.jsp").forward(request, response);
    }
}
