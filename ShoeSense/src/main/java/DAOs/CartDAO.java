/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Cart;
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
public class CartDAO {
   private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public CartDAO() {
        conn = DBcontext.DBContext.getConnection();
    }

    public int AddNew(Cart c) {
        String sql = "insert into Cart values(?,?,?,?)";
        int ketqua = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, c.getUserID());
            ps.setInt(2, c.getProductID());
            ps.setInt(3, c.getVariantID());
            ps.setInt(4, c.getQuantity());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
    

       
        public List<Cart> getAll(int userID) {
        String sql = "SELECT * FROM Cart WHERE accountID=?";
        List<Cart> c = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            int cartID = rs.getInt("cartID");
            int productID = rs.getInt("productID");
            int variantID = rs.getInt("variantID");
            int quantity = rs.getInt("quantity");
            Cart cart = new Cart(cartID, userID, productID, variantID, quantity);
            c.add(cart);
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return c;
    }
        
        
    public List<Cart> getAllInUserCart(int userID) {
        List<Cart> mycart = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE accountID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mycart.add(new Cart(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mycart;
    }
    
        public Cart getCartByVariantID(int id) {
//        List<Cart> mycart = new ArrayList<>();
        Cart cart = new Cart();
        String sql = "SELECT * FROM Cart WHERE variantID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cart = new Cart(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cart;
    }
    
    
           public int update(Cart cart) {
        String sql = "UPDATE Cart SET accountID = ?, productID = ?, variantID = ?, quantity = ? WHERE cartID = ?";
        int ketqua = 0;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cart.getUserID());
            ps.setInt(2, cart.getProductID());
            ps.setInt(3, cart.getVariantID());
            ps.setInt(4, cart.getQuantity());
            ps.setInt(5, cart.getCartID()); // Cập nhật cho cartID được truyền vào

            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }

               public void deleteByVariantID(int variantID) {
        String sql = "delete from [Cart] where variantID = ?";

        try {
            PreparedStatement preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setInt(1, variantID);

            int rowsDeleted = preparedStatement.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Xóa gio hang thành công!");
            } else {
                System.out.println("Không có go hang nào bị xóa.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
           
           
    public void deleteByProductID(int productId) {
        String sql = "delete from [Cart] where productID = ?";

        try {
            PreparedStatement preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setInt(1, productId);

            int rowsDeleted = preparedStatement.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Xóa gio hang thành công!");
            } else {
                System.out.println("Không có go hang nào bị xóa.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int deleteWhenBuy(int cartID) {
        String sql = "delete from [Cart] where cartID = ?";
        int rs = 0;
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setInt(1, cartID);

            rs = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }



}
