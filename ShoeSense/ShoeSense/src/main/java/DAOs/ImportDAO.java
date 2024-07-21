/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Import;
import Modals.ProductVariant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class ImportDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public ImportDAO() {
        conn = DBcontext.DBContext.getConnection();
    }

    public int AddNew(Import imp) throws SQLException {
        String sql = "insert into Import (importDate,accountID, productID, variantID, quantity) values (?,?,?,?,?);";

        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, Timestamp.valueOf(imp.getImportDate()));
            ps.setInt(2, imp.getAccountID());
            ps.setInt(3, imp.getProductID());
            ps.setInt(4, imp.getVariantID());
            ps.setInt(5, imp.getQuantity());

            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }

    public List<Import> getAllImport() {
        List<Import> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Import]");
//            ps.setString(1, role);
            rs = ps.executeQuery();
            while (rs.next()) {
                Import imp = new Import(rs.getInt("importID"), rs.getTimestamp("importDate").toLocalDateTime(), rs.getInt("accountID"),
                        rs.getInt("productID"), rs.getInt("variantID"), rs.getInt("quantity"));
                list.add(imp);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Import getImportById(int id) {
        Import imp = new Import();
        try {
            ps = conn.prepareStatement("select * from [Import] where importID=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                imp = new Import(rs.getInt("importID"), rs.getTimestamp("importDate").toLocalDateTime(), rs.getInt("accountID"),
                        rs.getInt("productID"), rs.getInt("variantID"), rs.getInt("quantity"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ImportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return imp;
    }


    
                               public int updateImport(Import imp) {
        String sql = "update [Import] set importDate=?,accountID=?, productID=?, variantID=?, quantity=? where importID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
             ps.setTimestamp(1, Timestamp.valueOf(imp.getImportDate()));
            ps.setInt(2, imp.getAccountID());
            ps.setInt(3, imp.getProductID());
            ps.setInt(4, imp.getVariantID());
            ps.setInt(5, imp.getQuantity());
            ps.setInt(6, imp.getImportID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
    
    
                                  public void deleteImporttByID(int id) {
        try {
            ps = conn.prepareStatement("DELETE FROM [dbo].[Import]\n"
                    + "      WHERE importID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
                               
    
    
}
