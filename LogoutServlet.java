import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session (do NOT create new one)
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();  // Destroy session
        }

        response.sendRedirect("login.jsp?message=Logged out successfully");
    }
}
