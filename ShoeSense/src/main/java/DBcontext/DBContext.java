/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBcontext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */



public class DBContext {

    private static Connection conn ;

    public static Connection getConnection() {
        try {

          
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://MSI\\SQLEXPRESS:1433;"
                    
                            + "databaseName=ShoeSense;"
                            + "user=sa;password=123;"
                            + "encrypt=true;"
                            + "trustServerCertificate=true;");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return conn;
        
    }

    public static void main(String[] args) {
        DBContext context = new DBContext();
        context.getConnection();
    }
}
