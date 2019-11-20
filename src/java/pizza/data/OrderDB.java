/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author LarryXu
 */
public class OrderDB {
    public int saveOrder(int invoiceID, String orderType, String orderAddr) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = 
            "INSERT INTO pizzaordering.order " + 
            "(invoice_id, order_type, order_address) " + 
            "VALUES(?, ?, ?)";
        
        try {
            //check if user exist
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, invoiceID);
            ps.setString(2, orderType);
            ps.setString(3, orderAddr);

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 1) {
                int orderID = 0;
                rs = ps.getGeneratedKeys();
                rs.next();
                orderID = rs.getInt(1);
                return orderID;
            }
        } catch (SQLException e) {
            String err = e.getMessage();
            System.out.println(err);
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return -1;
    }
}
