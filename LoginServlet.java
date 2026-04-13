import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        System.out.println("Mobile received: [" + mobile + "]");
        System.out.println("Password received: [" + password + "]");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            // Connect to database
            con = DBConnection.getConnection();

            // Check user
            String sql = "SELECT * FROM users WHERE mobile=? AND password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, mobile);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

                // Create session
                HttpSession session = request.getSession(true);
                session.setMaxInactiveInterval(30 * 60);

                // Get previous login from database
                Timestamp previousLogin = rs.getTimestamp("last_login");

                // Store previous login in session
                session.setAttribute("previousLogin", previousLogin);

                // Store user info
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("userName", rs.getString("full_name"));
                session.setAttribute("mobile", rs.getString("mobile"));

                // Now update database with current login time
                PreparedStatement updatePs = con.prepareStatement(
                    "UPDATE users SET last_login = NOW() WHERE user_id = ?"
                );
                updatePs.setInt(1, rs.getInt("user_id"));
                updatePs.executeUpdate();
                updatePs.close();


                // ===== TOTAL SITE VISITS (DB METHOD) =====
                PreparedStatement totalUpdate = con.prepareStatement(
                    "UPDATE site_stats SET total_visits = total_visits + 1 WHERE id = 1"
                );
                totalUpdate.executeUpdate();
                totalUpdate.close();

                // Get updated total visits
                PreparedStatement totalSelect = con.prepareStatement(
                    "SELECT total_visits FROM site_stats WHERE id = 1"
                );
                ResultSet totalRs = totalSelect.executeQuery();

                int totalVisits = 0;
                if (totalRs.next()) {
                    totalVisits = totalRs.getInt("total_visits");
                }

                session.setAttribute("totalVisits", totalVisits);

                totalRs.close();
                totalSelect.close();

                // Redirect to home
                response.sendRedirect("home.jsp");
            }
            else {

                // Invalid login
                response.sendRedirect("login.jsp?error=Invalid mobile or password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Something went wrong");
        } finally {

            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}