import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class TransactionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String limit = request.getParameter("limit");

        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();

        out.println("<?xml version='1.0' encoding='UTF-8'?>");
        out.println("<?xml-stylesheet type='text/xsl' href='transactions.xsl'?>");
        out.println("<transactions>");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM transactions WHERE user_id=? ORDER BY created_at DESC";

            if ("4".equals(limit)) {
                sql += " LIMIT 4";
            }

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                out.println("<transaction>");
                out.println("<id>" + rs.getInt("transaction_id") + "</id>");
                out.println("<mobile>" + rs.getString("mobile_number") + "</mobile>");
                out.println("<amount>" + rs.getDouble("amount") + "</amount>");
                out.println("<payment>" + rs.getString("payment_method") + "</payment>");
                out.println("<status>" + rs.getString("payment_status") + "</status>");
                out.println("<date>" + rs.getTimestamp("created_at") + "</date>");
                out.println("</transaction>");
            }

            out.println("</transactions>");

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}