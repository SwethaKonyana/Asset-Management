<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Assets</title>
    <style>
        /* Define CSS styles for the table */
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>

<body>
<jsp:include page="navigation.jsp" /> 
<h2>Welcome, User <%= session.getAttribute("username") %></h2>

    <h2>Asset List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>asset_id</th>
           
            
            <th>name</th>
            <th>Description</th>
            <th>Value</th>
        </tr>
        
        <% 
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        String url = "jdbc:mysql://localhost:3306/assetdb";
        String username = "root";
        String password = "Swetha@1234";
        try {
            Class.forName("com.mysql.jdbc.Driver"); // Load MySQL JDBC driver
            connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM asset");

            while (resultSet.next()) {
                out.println("<tr>");
                out.println("<td>" + resultSet.getInt("asset_id") + "</td>");
                
                out.println("<td>" + resultSet.getInt("asset_id") + "</td>");
               
                
                out.println("<td>" + resultSet.getString("name") + "</td>");
                out.println("<td>" + resultSet.getString("description") + "</td>");
                out.println("<td>" + resultSet.getInt("value") + "</td>");
                out.println("</tr>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error fetching account data: " + e.getMessage());
        } finally {
            // Close resources in finally block
            try { if (resultSet != null) resultSet.close(); } catch (Exception e) {}
            try { if (statement != null) statement.close(); } catch (Exception e) {}
            try { if (connection != null) connection.close(); } catch (Exception e) {}
        }
        %>
    </table>
</body>
</html>
