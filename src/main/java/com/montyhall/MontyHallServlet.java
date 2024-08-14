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

    @Override
    public void init() throws ServletException {
        // 서버 시작 시 winCount와 loseCount 초기화
        getServletContext().setAttribute("winCount", 0);
        getServletContext().setAttribute("loseCount", 0);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int initialChoice = (int) request.getSession().getAttribute("initialChoice");
        int carPosition = (int) request.getSession().getAttribute("carPosition");
        String choice = request.getParameter("choice");

        int finalChoice = "switch".equals(choice)
            ? 6 - initialChoice - (int) request.getSession().getAttribute("revealedDoor")
            : initialChoice;

        boolean win = (finalChoice == carPosition);

        // 당첨/꽝 횟수 세기 - 서버 컨텍스트에서 관리
        Integer winCount = (Integer) getServletContext().getAttribute("winCount");
        Integer loseCount = (Integer) getServletContext().getAttribute("loseCount");

        if (win) {
            winCount++;
        } else {
            loseCount++;
        }

        getServletContext().setAttribute("winCount", winCount);
        getServletContext().setAttribute("loseCount", loseCount);

        request.setAttribute("choice", choice);
        request.setAttribute("win", win);
        request.setAttribute("carPosition", carPosition);
        request.getRequestDispatcher("/montyhall.jsp").forward(request, response);
    }
}
