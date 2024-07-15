/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Account;
import Modals.Product;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class ProductDAO {
    
       private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public ProductDAO() {
        conn = DBcontext.DBContext.getConnection();
    }
    
    
      public int AddNew(Product p) throws SQLException {
        String sql = "insert into Product (productName,productPrice, productImg, productCategory, productDis, productStatus) values (?,?,?,?,?,?);";

        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, p.getProductName());
            ps.setDouble(2, p.getProductPrice());
            ps.setString(3, p.getProductImg());
            ps.setString(4, p.getProductCategory());
            ps.setString(5, p.getProductDis());
            ps.setString(6, p.getProductStatus());

            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }
    
    
    
                 public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Product]");
//            ps.setString(1, role);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt("productID"), rs.getString("productName"), rs.getDouble("productPrice"), 
                        rs.getString("productImg"), rs.getString("productCategory"), rs.getString("productDis"), rs.getString("productStatus"));
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
        
    
    
                public Product getProductById(int id) {
        Product p = new Product();
        try {
            ps = conn.prepareStatement("select * from [Product] where productID=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
p = new Product(rs.getInt("productID"), rs.getString("productName"), rs.getDouble("productPrice"), 
                        rs.getString("productImg"), rs.getString("productCategory"), rs.getString("productDis"), rs.getString("productStatus"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }
                
                
                              public Product getProductByName(String name) {
        Product p = new Product();
        try {
            ps = conn.prepareStatement("select * from [Product] where productName=?");
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
p = new Product(rs.getInt("productID"), rs.getString("productName"), rs.getDouble("productPrice"), 
                        rs.getString("productImg"), rs.getString("productCategory"), rs.getString("productDis"), rs.getString("productStatus"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }
                
                
     
                    public ArrayList<Product> getProduct(String search, int index, String sort, String category) {
        String sortby = "";
        switch (sort) {
            case "1":
                sortby = "order by p.productName asc";
                break;
            case "2":
                sortby = "order by p.productPrice asc";
                break;
            case "3":
                sortby = "order by p.productPrice desc";
                break;
            default:
                sortby = "order by p.productName desc";
                break;

        }
        ArrayList<Product> list = new ArrayList<>();
        String sql = "  select * from [Product] p where p.productName like ? and [productCategory] like ? "
                + sortby
                + "  OFFSET ? ROWS FETCH NEXT 8  ROWS ONLY"; // 6 0-2,2-4,4-6
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + search + "%"); // Short   %h%  zzzhqwoeoqw hqoweoqwe qưuioeqioweioh
            ps.setString(2, "%" + category + "%");
            ps.setInt(3, (index - 1) * 8);
            ResultSet resultSet = ps.executeQuery();
            while (resultSet.next()) {
                int productID = resultSet.getInt("productID");
                String productName = resultSet.getString("productName");
                double productPrice = resultSet.getDouble("productPrice");
                String productImg = resultSet.getString("productImg");
                String productCategory = resultSet.getString("productCategory");
                String productDescription = resultSet.getString("productDis");
                String productStatus = resultSet.getString("productStatus");
                Product product = new Product(productID, productName, productPrice, productImg,  productDescription, productCategory, productStatus);
                list.add(product);
            }
        } catch (Exception e) {
        }
        return list;
    }
                                
                
                    public int getNumberProduct(String search) {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "  select count(*) from Product p where p.productName like ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
                
                
                
                   public int updateProduct(Product p) {
        String sql = "update [Product] set productName=?,productPrice=?, productImg=?, productCategory=?, productDis=? where productID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, p.getProductName());
            ps.setDouble(2, p.getProductPrice());
            ps.setString(3, p.getProductImg());
            ps.setString(4, p.getProductCategory());
            ps.setString(5, p.getProductDis());
            ps.setInt(6, p.getProductID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
     
                         public int hideProduct(int id) {

        String sql = "update [Product] set productStatus=? where productID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, "Hide");
            ps.setInt(2, id);
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
                         
                                                  public int unhideProduct(int id) {

        String sql = "update [Product] set productStatus=? where productID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, "Public");
            ps.setInt(2, id);
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
                         
                   
        public void deleteProductByID(int id) {
        try {
            ps = conn.prepareStatement("DELETE FROM [dbo].[Product]\n"
                    + "      WHERE productID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
