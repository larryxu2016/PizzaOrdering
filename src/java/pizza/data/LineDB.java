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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author LarryXu
 */
public class LineDB {
    public boolean saveLines(int invoiceID, JSONArray cart) throws JSONException {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            //check if user exist
            String query = 
                "INSERT INTO line " + 
                "(invoice_id, item_id, line_units, line_price) VALUES";
            
            int length = cart.length();
            for (int i = 0; i < length; i++) {
                query += "(?, ?, ?, ?)";
                if (i < (length - 1)) {
                    query += ",";
                }
            }
            ps = connection.prepareStatement(query);
            
            int j = 0;
            for (int i = 0; i < length; i++) {
                JSONObject line = cart.getJSONObject(i);
                ps.setInt(i+j+1, invoiceID);
                ps.setInt(i+j+2, line.getInt("item_id"));
                ps.setInt(i+j+3, line.getInt("item_qty"));
                ps.setFloat(i+j+4, Float.parseFloat(line.getString("item_price")));
                j += 3;
            }

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 0) {
                return false;
            }
        } catch (SQLException e) {
            String err = e.getMessage();
            System.out.println(err);
            return false;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return true;
    }
}
