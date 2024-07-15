/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Product;
import Modals.ProductVariant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class ProductVariantDAO {
    
           private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public ProductVariantDAO() {
        conn = DBcontext.DBContext.getConnection();
    }
    
    
          public int AddNew(ProductVariant p) throws SQLException {
        String sql = "insert into ProductVariant (productID,variantImg, variantSize, variantColor, variantQuantity) values (?,?,?,?,?);";

        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getProductID());
            ps.setString(2, p.getVariantImg());
            ps.setString(3, p.getVariantSize());
            ps.setString(4, p.getVariantColor());
            ps.setInt(5, p.getVariantQuantity());
  

            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }
          
                           public List<ProductVariant> getAllProductVariant() {
        List<ProductVariant> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [ProductVariant]");
//            ps.setString(1, role);
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant p = new ProductVariant(rs.getInt("variantID"), rs.getInt("productID"), rs.getString("variantImg"), 
                        rs.getString("variantSize"), rs.getString("variantColor"), rs.getInt("variantQuantity"));
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
                           
        public List<ProductVariant> getAllProductVariantByProductID(int pID) {
        List<ProductVariant> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [ProductVariant] where productID = ?");
            ps.setInt(1, pID);
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant p = new ProductVariant(rs.getInt("variantID"), rs.getInt("productID"), rs.getString("variantImg"), 
                        rs.getString("variantSize"), rs.getString("variantColor"), rs.getInt("variantQuantity"));
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
          
                        public ProductVariant getProductVariantById(int id) {
        ProductVariant p = new ProductVariant();
        try {
            ps = conn.prepareStatement("select * from [ProductVariant] where variantID=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                p = new ProductVariant(rs.getInt("variantID"), rs.getInt("productID"), rs.getString("variantImg"), 
                        rs.getString("variantSize"), rs.getString("variantColor"), rs.getInt("variantQuantity"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }
    
                        
                                 public int getTotalProductVariantByProductId(int id) {
        int totalQuantity = 0;
    try {
        ps = conn.prepareStatement("SELECT SUM(variantQuantity) AS totalQuantity FROM ProductVariant WHERE productID=?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalQuantity = rs.getInt("totalQuantity");
        }
    } catch (SQLException ex) {
        Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        // Close resources (Connection, PreparedStatement, ResultSet) properly
        // This should ideally be done in a finally block or using try-with-resources
        // to ensure resources are released even if an exception occurs.
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    return totalQuantity;
    }
        
                           public int updateProductVariant(ProductVariant p) {
        String sql = "update [ProductVariant] set productID=?,variantImg=?, variantSize=?, variantColor=?, variantQuantity=? where variantID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getProductID());
            ps.setString(2, p.getVariantImg());
            ps.setString(3, p.getVariantSize());
            ps.setString(4, p.getVariantColor());
            ps.setInt(5, p.getVariantQuantity());
            ps.setInt(6, p.getVariantID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
                           
                           
                         
                                   public void deleteProductVariantByID(int id) {
        try {
            ps = conn.prepareStatement("DELETE FROM [dbo].[ProductVariant] \n"
                    + "      WHERE variantID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            ps = conn.prepareStatement("DELETE FROM [dbo].[Import] \n"
                    + "      WHERE variantID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
                           
        
}
