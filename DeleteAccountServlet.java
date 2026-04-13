import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

                            System.out.println("Delete servlet reached!");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String enteredPassword = request.getParameter("deletePassword");

        try (Connection conn = DBConnection.getConnection()) {

            // Check password
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT password FROM users WHERE user_id=?");

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(enteredPassword)) {
                    response.getWriter().println("Password incorrect. Account not deleted.");
                    return;
                }
            }

            rs.close();
            ps.close();

            // Delete user

            // DELETE TRANSACTIONS FIRST
            PreparedStatement deleteTxn = conn.prepareStatement(
                    "DELETE FROM transactions WHERE user_id=?");

            deleteTxn.setInt(1, userId);
            deleteTxn.executeUpdate();
            deleteTxn.close();


            // THEN DELETE USER
            PreparedStatement deleteUser = conn.prepareStatement(
                    "DELETE FROM users WHERE user_id=?");

            deleteUser.setInt(1, userId);
            deleteUser.executeUpdate();
            deleteUser.close();

            // Destroy session
            session.invalidate();

            // Redirect to login
            response.sendRedirect("login.jsp?message=Account deleted successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}