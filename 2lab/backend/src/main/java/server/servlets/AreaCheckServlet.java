package server.servlets;


import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext context = getServletContext();

        try {
            float x = new BigDecimal(req.getParameter("x")).setScale(2, RoundingMode.HALF_UP).floatValue();
            float y = new BigDecimal(req.getParameter("y")).setScale(2, RoundingMode.HALF_UP).floatValue();
            float r = new BigDecimal(req.getParameter("r")).setScale(2, RoundingMode.HALF_UP).floatValue();
            TableRow row = new TableRow(x, y, r, Checker.hit(x, y, r));
            Object rowsData = context.getAttribute("rows");
            ArrayList<TableRow> rows = new ArrayList<>();
            if (rowsData != null) {
                rows.addAll((ArrayList<TableRow>) rowsData);
            }
            rows.add(row);
            context.setAttribute("rows", rows);
            req.setAttribute("new_row", row);
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("results.jsp").forward(req, resp);
    }


    private static class Checker {
        public static boolean hit(float x, float y, float r) {
            return inRect(x, y, r) || inTriangle(x, y, r) || inCircle(x, y, r);
        }

        private static boolean inRect(float x, float y, float r) {
            return x >= 0 && y >= 0 && x <= r && y <= r;
        }

        private static boolean inTriangle(float x, float y, float r) {
            return x <= 0 && y >= 0 && x >= -r && y <= (x + r) / 2;
        }

        private static boolean inCircle(float x, float y, float r) {
            return x >= 0 && y <= 0 && x <= r && y >= -r && (Math.pow(x, 2) + Math.pow(y, 2) - Math.pow(r, 2) <= 0);
        }
    }

}
