package asset;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rollNumber = request.getParameter("studentId");
        int asset_id = Integer.parseInt(request.getParameter("asset_id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int value = Integer.parseInt(request.getParameter("value"));

        String url = "jdbc:mysql://localhost:3306/assetdb";
        String username = "root";
        String password = "Swetha@1234";

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            String sql = "UPDATE asset SET asset_id=?, name=?, description=?, value=? WHERE asset_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, asset_id);
            ps.setString(2, name);
            ps.setString(3, description);
            ps.setInt(4, value);
            ps.setString(5,rollNumber);
            

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("viewAccounts.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
