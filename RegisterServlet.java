import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            // Check if user already exists
            String checkQuery = "SELECT * FROM users WHERE mobile=? OR email=?";
            ps = con.prepareStatement(checkQuery);
            ps.setString(1, mobile);
            ps.setString(2, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=User already exists");
                return;
            }

            rs.close();
            ps.close();

            // Insert new user
            String insertQuery = "INSERT INTO users(full_name, email, mobile, password) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(insertQuery);

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, password);

            ps.executeUpdate();

            response.sendRedirect("login.jsp?success=Account created successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Something went wrong");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}