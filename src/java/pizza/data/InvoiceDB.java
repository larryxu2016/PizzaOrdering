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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

/**
 *
 * @author LarryXu
 */
public class InvoiceDB {
    public int saveInvoice(int userID) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = 
            "INSERT INTO invoice " + 
            "(user_id, invoice_date) " + 
            "VALUES (?, ?)";
        
        try {

            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            LocalDate today = LocalDate.now();
            
            ps.setInt(1, userID);
            ps.setObject(2, today);

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 1) {
                int invoiceID = 0;
                rs = ps.getGeneratedKeys();
                rs.next();
                invoiceID = rs.getInt(1);
                return invoiceID;
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
