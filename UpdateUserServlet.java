import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class UpdateUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try (Connection conn = DBConnection.getConnection()) {

            // Verify current password
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT password FROM users WHERE user_id=?")) {

                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");

                    if (!dbPassword.equals(currentPassword)) {
                        response.getWriter().println("Current password is incorrect!");
                        return;
                    }
                }
            }

            // Update user info
            if (newPassword != null && !newPassword.isEmpty()) {

                if (!newPassword.equals(confirmPassword)) {
                    response.getWriter().println("New passwords do not match!");
                    return;
                }

                try (PreparedStatement ps = conn.prepareStatement(
                        "UPDATE users SET full_name=?, email=?, mobile=?, password=? WHERE user_id=?")) {

                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, mobile);
                    ps.setString(4, newPassword);
                    ps.setInt(5, userId);

                    ps.executeUpdate();
                }

            } else {

                try (PreparedStatement ps = conn.prepareStatement(
                        "UPDATE users SET full_name=?, email=?, mobile=? WHERE user_id=?")) {

                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, mobile);
                    ps.setInt(4, userId);

                    ps.executeUpdate();
                }
            }

            // Update session name
            session.setAttribute("userName", fullName);

            response.sendRedirect("home.jsp?update=success");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}