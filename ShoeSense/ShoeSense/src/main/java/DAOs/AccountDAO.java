/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Account;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class AccountDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public AccountDAO() {
        conn = DBcontext.DBContext.getConnection();
    }

    public String hashPassword(String password, String algorithm) {
        try {
            MessageDigest digest = MessageDigest.getInstance(algorithm);
            byte[] hashedBytes = digest.digest(password.getBytes());

            StringBuilder stringBuilder = new StringBuilder();
            for (byte b : hashedBytes) {
                stringBuilder.append(String.format("%02x", b));
            }

            return stringBuilder.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
    
         public List<Account> getAllByRole(String role) {
        List<Account> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Account] where accountRole=?");
            ps.setString(1, role);
            rs = ps.executeQuery();
            while (rs.next()) {
                Account user = new Account(rs.getInt("accountID"), rs.getString("accountEmail"), rs.getString("accountPassword"), rs.getString("accountName"), rs.getString("accountGender"),
                        rs.getDate("accountBirthdate"), rs.getString("accountPhone"), rs.getString("accountAddress"), rs.getString("accountRole"), rs.getString("accountStatus"), rs.getString("otp"), rs.getTimestamp("otp_time"));
                list.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    

    public Account GetAccountById(String id) {
        Account a = new Account();
        try {
            ps = conn.prepareStatement("select * from [Account] where accountID=?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                a = new Account(rs.getInt("accountID"), rs.getString("accountEmail"), rs.getString("accountPassword"), rs.getString("accountName"), rs.getString("accountGender"),
                        rs.getDate("accountBirthdate"), rs.getString("accountPhone"), rs.getString("accountAddress"), rs.getString("accountRole"), rs.getString("accountStatus"), rs.getString("otp"), rs.getTimestamp("otp_time"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }

    public Account GetAccountByEmail(String email) {
        Account a = new Account();
        try {
            ps = conn.prepareStatement("select * from Account where accountEmail=?");
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                a = new Account(rs.getInt("accountID"), rs.getString("accountEmail"), rs.getString("accountPassword"), rs.getString("accountName"), rs.getString("accountGender"),
                        rs.getDate("accountBirthdate"), rs.getString("accountPhone"), rs.getString("accountAddress"), rs.getString("accountRole"), rs.getString("accountStatus"), rs.getString("otp"), rs.getTimestamp("otp_time"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }

    public boolean checkAccountByEmail(String email) throws SQLException {
        ResultSet rs = null;
        Account a = new Account();
        try {
            ps = conn.prepareStatement("select * from Account where accountEmail=?");
            ps.setString(1, email);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs.next();
    }

    public boolean Login(String email, String password) throws SQLException {
        ResultSet rs = null;
        String sql = "Select * from Account where accountEmail=? and accountPassword=?";
//        String password = password;
        String hashPassword = hashPassword(password, "MD5");
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, email);
            ps.setString(2, hashPassword);
            rs = ps.executeQuery();
            
            
        } catch (Exception e) {
             Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return rs.next() ;
    }

    public int AddNew(Account acc) throws SQLException {
        String sql = "insert into Account (accountEmail,accountPassword, accountName, accountGender, accountBirthdate, accountPhone, accountAddress, accountRole, accountStatus, otp, otp_time) values (?,?,?,?,?,?,?,?,?,?,?);";
        String password = acc.getAccountPassword();
        String hashPassword = hashPassword(password, "MD5");
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, acc.getAccountEmail());
            ps.setString(2, hashPassword.toUpperCase());
            ps.setString(3, acc.getAccountName());
            ps.setString(4, acc.getAccountGender());
            ps.setDate(5, acc.getAccountBirthdate());
            ps.setString(6, acc.getAccountPhone());
            ps.setString(7, acc.getAccountAddress());
            ps.setString(8, acc.getAccountRole());
            ps.setString(9, acc.getAccountStatus());
            ps.setString(10, acc.getOtp());
            ps.setTimestamp(11, null);
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }

    
    public int Update(Account u) {
        String sql = "update [Account] set accountName=?,accountGender=?, accountBirthdate=?, accountPhone=?, accountAddress=? where accountID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, u.getAccountName());
            ps.setString(2, u.getAccountGender());
            ps.setDate(3, u.getAccountBirthdate());
            ps.setString(4, u.getAccountPhone());
            ps.setString(5, u.getAccountAddress());
            ps.setInt(6, u.getAccountID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
    
      public int UpdatePassword(Account u) {
        String password = u.getAccountPassword();
        String hashPassword = hashPassword(password, "MD5");
        String sql = "update [Account] set accountPassword=? where accountID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, hashPassword.toUpperCase());
            ps.setInt(2, u.getAccountID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
      
      public int banUserAccount(int id) {

        String sql = "update [Account] set accountStatus=? where accountID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, "Banned");
            ps.setInt(2, id);
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
      
            public int unbanUserAccount(int id) {

        String sql = "update [Account] set accountStatus=? where accountID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, "Active");
            ps.setInt(2, id);
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
      
    
            
            
    public void deleteAccountByID(int id) {
        try {
            ps = conn.prepareStatement("DELETE FROM [dbo].[Account]\n"
                    + "      WHERE accountID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
// ----------------- Address management
    
    
    
//   --------------------------- OTP functions
    public boolean otpCheckEmail(String email) throws SQLException {
        ResultSet rs = null;
        String sql = "Select * from Account where accountEmail = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            rs = ps.executeQuery();
        } catch (Exception e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return rs.next();
    }

    public boolean otpCheckCode(String email, String otp) throws SQLException {
        ResultSet rs = null;
        String sql = "Select * from Account where accountEmail = ? and otp=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, otp);
            rs = ps.executeQuery();
        } catch (Exception e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return rs.next();
    }
    
    public boolean otpCheckCodeTimer(String email) throws SQLException {
        Account acc = GetAccountByEmail(email);
       java.util.Date currentDate = new java.util.Date();

        if(acc.getOtp_time().toInstant().isBefore(currentDate.toInstant())) {
            return false;
        }
        return true;
        
    }

    public int otpUpdatePassword(String email, String password) throws SQLException {
//        ResultSet rs = null;
        int ketqua = 0;
        String sql = "Update Account Set accountPassword = ? where accountEmail = ?";
        String hashPassword = hashPassword(password, "MD5");
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, hashPassword);
            ps.setString(2, email);
//            rs = ps.executeQuery();
            ketqua = ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return ketqua;
    }

    public int otpUpdateCode(String email, String otp) throws SQLException {
//        ResultSet rs = null;
        int ketqua = 0;
        String sql = "UPDATE Account SET otp = ?, otp_time = ? WHERE accountEmail = ?";
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDateTime newTime = currentTime.plusMinutes(5);
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, otp);
            ps.setTimestamp(2, Timestamp.valueOf(newTime));
            ps.setString(3, email);
//            rs = ps.executeQuery();
            ketqua = ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return ketqua;
    }

    public int otpDeleteCode(String email) throws SQLException {
//        ResultSet rs = null;
        int ketqua = 0;
        String sql = "UPDATE Account SET otp = ?, otp_time = ? WHERE accountEmail = ?";
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDateTime newTime = currentTime.plusMinutes(5);
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, null);
            ps.setTimestamp(2, null);
            ps.setString(3, email);
//            rs = ps.executeQuery();
            ketqua = ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return ketqua;
    }

}
