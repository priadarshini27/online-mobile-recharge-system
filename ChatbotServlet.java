import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        String userMsg = request.getParameter("message");

        // IMPORTANT FIX (prevents crash)
        if (userMsg == null || userMsg.trim().isEmpty()) {
            response.getWriter().write("Please enter a message.");
            return;
        }

        userMsg = userMsg.toLowerCase();

        String reply = "Sorry, I didn't understand that.";

        if (userMsg.contains("recharge")) {
            reply = "To recharge, go to the Recharge page, enter your mobile number, choose a plan, and complete payment.";
        }
        else if (userMsg.contains("plans")) {
            reply = "You can view available recharge plans in the Plans page for Airtel, Jio, BSNL, and VI.";
        }
        else if (userMsg.contains("payment")) {
            reply = "We support UPI, Debit Card, and Net Banking payments.";
        }
        else if (userMsg.contains("history")) {
            reply = "You can check your recharge history in the Transaction History page.";
        }
        else if (userMsg.contains("login")) {
            reply = "Click Login and enter your registered email and password.";
        }
        else if (userMsg.contains("register")) {
            reply = "Go to the Register page and create a new account.";
        }
        else if (userMsg.contains("operators")) {
            reply = "Supported operators: Airtel, Jio, BSNL, and VI.";
        }
        else if (userMsg.contains("account") || userMsg.contains("profile") || userMsg.contains("setting")) {
            reply = "You can manage your account settings in the User Settings page by clicking the User Avatar.";
        }
        else if (userMsg.contains("help")) {
            reply = "You can ask me about recharge, plans, payment, login, history, or account.";
        }
        else if (userMsg.contains("hello") || userMsg.contains("hi")) {
            reply = "Hello! How can I help you with your recharge today?";
        }
        else if (userMsg.contains("thanks") || userMsg.contains("thank you")) {
            reply = "You're welcome! Let me know if you need help with anything else.";
        }
        else if (userMsg.contains("bye")) {
            reply = "Goodbye! Have a great day.";
        }
        else if(userMsg.contains("password")){
            reply = "Users can reset their password in the User Settings";
        }
        else if(userMsg.contains("delete")){
            reply = "Users can delete their accounts in the User Settings";
        }

        response.getWriter().write(reply);
    }
}