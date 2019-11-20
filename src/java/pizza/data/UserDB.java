/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.data;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.business.User;
import pizza.utility.PasswordUtil;

/**
 *
 * @author LarryXu
 */
public class UserDB {
    private JSONObject userJSON;
    private User user;

    public JSONObject getUserJSON() {
        return userJSON;
    }
    
    public User getUser() {
        return user;
    }
    
    public UserDB () {
        userJSON = new JSONObject();
    }
    
    public String[] authenticate(String email, String password) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM user WHERE user_email = ?";
        String results[] = {"",""};
        
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);

            rs = ps.executeQuery();

            if (rs.next()) {
                String salt = rs.getString("user_pwd_salt");
                user  = new User(
                    rs.getString("user_firstName"),
                    rs.getString("user_lastName"),
                    rs.getString("user_password"),
                    rs.getString("user_email"),
                    rs.getString("user_phone"),
                    rs.getString("user_street"),
                    rs.getString("user_bldType"),
                    rs.getString("user_bldNum"),
                    rs.getString("user_city"),
                    rs.getString("user_state"),
                    rs.getString("user_zipCode"),
                    salt);
 
                String hashedPwd = PasswordUtil.hashPassword(password+salt);
                if (user.getPassword().equals(hashedPwd)) {
                    //gerneate new salt and password and store them.
                    String newSalt = PasswordUtil.getSalt();
                    String newHashedPwd = PasswordUtil.hashPassword(password + newSalt);
                    updatePwd(user.getEmail(), newHashedPwd, newSalt);
                    
                    //save user detail in a JSONObject (name, phone, email).
                    userJSON.put("name", user.getFirstName());
                    userJSON.put("lastName", user.getLastName());
                    userJSON.put("phone", user.getPhone());
                    userJSON.put("email", user.getEmail());
                    
                    //save address based on order history(pursue later).
                    results[1] = "Success";
                    results[0] = "";
                } else {
                    results[1] = "Sorry, the e-mail/password combination didn't " +
                                 "match what we have on file. Please try again.";
                    results[0] = "/user";
                }
            } else {
                results[1] = "Sorry, the e-mail/password combination didn't " +
                             "match what we have on file. Please try again.";
                results[0] = "/user";
            }
        } catch (JSONException | SQLException | NoSuchAlgorithmException e) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
            results[1] = "Internal Error! Please try again.";
            results[0] = "/user";
            return results;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return results;
    }
    
    public boolean updatePwd(String email, String password, String salt) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        String query = 
            "UPDATE user " + 
            "SET user_password = ?, user_pwd_salt = ? " + 
            "WHERE user_email = ?";
        
        try {
            ps = connection.prepareStatement(query);

            ps.setString(1, password);
            ps.setString(2, salt);
            ps.setString(3, email);

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 1) {
                return true;
            }
        } catch (SQLException e) {
            String err = e.getMessage();
            System.out.println(err);
            return false;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return false; 
    }
    
    public boolean checkUser(String email) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT user_id, user_password FROM user WHERE user_email = ?";

        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserID(rs.getInt("user_id"));
                String pwd = rs.getString("user_password");
                if (pwd != null) {
                    user.setPassword(pwd);
                }
                return true;
            }   
        } catch (SQLException e) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return false;
    }
    
    public String[] createAccount(String firstName,
                                  String lastName,
                                  String password,
                                  String email,
                                  String phone,
                                  String street,
                                  String bldType,
                                  String bldNum,
                                  String city,
                                  String state,
                                  String zipCode,
                                  String addrType,
                                  String country,
                                  String salt) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = "SELECT * FROM user WHERE user_email = ?";

        String results[] = {"",""};
        
        try {
            //check if user exist
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            
            if (!rs.next()) { //could not find the result
                //insert
                query = "INSERT INTO user " + 
                    "(user_password, user_firstName, user_lastName, " +
                    "user_email, user_phone, user_street, user_bldType, " +
                    "user_bldNum, user_city, user_state, user_zipCode, " +
                    "user_addrType, user_country, user_pwd_salt) " + 
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = null;
                ps = connection.prepareStatement(query);
                ps.setString(1, password);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.setString(6, street);
                ps.setString(7, bldType);
                ps.setString(8, bldNum);
                ps.setString(9, city);
                ps.setString(10, state);
                ps.setString(11, zipCode);
                ps.setString(12, addrType);
                ps.setString(13, country);
                ps.setString(14, salt);
                int insertedRows = ps.executeUpdate();
                if (insertedRows == 1) {
                    results[1] = "Success";
                    results[0] = "/user/login/view";
                }
                else if (insertedRows == 0) {
                    results[1] = "Internal error while creating account!";
                    results[0] = "/user/create_account/view";
                }
            }
            else {
                results[1] = "User email already exists!";
                results[0] = "/user/create_account/view";
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
            results[1] = "Internal error while creating account!";
            results[0] = "/user/create_account/view";
            return results;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return results;
    }
    
    public int createUser(String firstName,
                          String lastName,
                          String password,
                          String email,
                          String phone,
                          String salt) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = 
            "INSERT INTO user " + 
            "(user_password, user_firstName, user_lastName, " +
            "user_email, user_phone, user_pwd_salt) " + 
            "VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, password);
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, salt);

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 1) {
                int userID = 0;
                rs = ps.getGeneratedKeys();
                rs.next();
                userID = rs.getInt(1);
                return userID;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return -1;
    }
    
    public int createUserNoPwd(String firstName,
                               String lastName,
                               String email,
                               String phone) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = 
            "INSERT INTO user " + 
            "(user_firstName, user_lastName, " +
            "user_email, user_phone) " + 
            "VALUES (?, ?, ?, ?, ?)";
        
        try {
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, email);
            ps.setString(5, phone);

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 1) {
                int userID = 0;
                rs = ps.getGeneratedKeys();
                rs.next();
                userID = rs.getInt(1);
                return userID;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return -1;
    }
    
    public boolean updateUser(int userID,
                           String firstName,
                           String lastName,
                           String password,
                           String email,
                           String phone) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        String query = 
            "UPDATE user " + 
            "SET user_password = ?, user_firstName = ?, user_lastName = ?, " +
            "user_email = ?, user_phone = ?" + 
            "WHERE user_id = ?";
        
        try {
            ps = connection.prepareStatement(query);

            ps.setString(1, password);
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setInt(6, userID);

            int insertedRows = ps.executeUpdate();
            if (insertedRows == 1) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return false;
    }
    
}