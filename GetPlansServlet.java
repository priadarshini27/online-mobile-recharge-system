import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/GetPlansServlet")
public class GetPlansServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {

            conn = DBConnection.getConnection();
            String query = "SELECT * FROM v_active_plans ORDER BY carrier_name, plan_price";

            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            out.println("<plans>");

            while (rs.next()) {

                out.println("<plan>");

                out.println("<plan_id>" + rs.getInt("plan_id") + "</plan_id>");
                out.println("<carrier_name>" + escapeXML(rs.getString("carrier_name")) + "</carrier_name>");
                out.println("<carrier_code>" + escapeXML(rs.getString("carrier_code")) + "</carrier_code>");
                out.println("<plan_name>" + escapeXML(rs.getString("plan_name")) + "</plan_name>");
                out.println("<plan_price>" + rs.getDouble("plan_price") + "</plan_price>");
                out.println("<validity_days>" + rs.getInt("validity_days") + "</validity_days>");
                out.println("<data_per_day>" + escapeXML(rs.getString("data_per_day")) + "</data_per_day>");
                out.println("<total_data>" + escapeXML(rs.getString("total_data")) + "</total_data>");
                out.println("<unlimited_calls>" + rs.getBoolean("unlimited_calls") + "</unlimited_calls>");
                out.println("<sms_per_day>" + rs.getInt("sms_per_day") + "</sms_per_day>");
                out.println("<unlimited_5g>" + rs.getBoolean("unlimited_5g") + "</unlimited_5g>");
                out.println("<plan_type>" + escapeXML(rs.getString("plan_type")) + "</plan_type>");
                out.println("<ott_benefits>" + escapeXML(rs.getString("ott_benefits")) + "</ott_benefits>");
                out.println("<additional_benefits>" + escapeXML(rs.getString("additional_benefits")) + "</additional_benefits>");

                out.println("</plan>");
            }

            out.println("</plans>");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    private String escapeXML(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&apos;");
    }
}