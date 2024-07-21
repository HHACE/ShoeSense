/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Cart;
import Modals.Comment;
import Modals.OrderStatusLog;
import java.sql.Connection;
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
public class CommentDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public CommentDAO() {
        conn = DBcontext.DBContext.getConnection();
    }

    public int AddNew(Comment c) {
        String sql = "insert into Comment values(?,?,?,?,?)";
        int ketqua = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, c.getAccountID());
            ps.setInt(2, c.getProductID());
            ps.setString(3, c.getContent());

            ps.setTimestamp(4, Timestamp.valueOf(c.getCreatedDate()));

            ps.setString(5, c.getCommentStatus());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }

    public List<Comment> getAllCommentByProductID(int id) {
        List<Comment> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("SELECT * FROM [Comment] WHERE productID=? ");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {

                Comment ord = new Comment(rs.getInt("commentID"), rs.getInt("productID"), rs.getInt("accountID"), rs.getString("content"), rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getString("commentStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

       public List<Comment> getAllCommentByAccountID(int id) {
        List<Comment> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("SELECT * FROM [Comment] WHERE accountID=? ");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {

                Comment ord = new Comment(rs.getInt("commentID"), rs.getInt("productID"), rs.getInt("accountID"), rs.getString("content"), rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getString("commentStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Comment getAccountCommentByAccountID(int accountID, int ProductID) {
        Comment ord = null;
        try {

            ps = conn.prepareStatement("SELECT * FROM [Comment] WHERE accountID=? and  productID=? ");
            ps.setInt(1, accountID);
            ps.setInt(2, ProductID);
            rs = ps.executeQuery();
            while (rs.next()) {

                ord = new Comment(rs.getInt("commentID"), rs.getInt("productID"), rs.getInt("accountID"), rs.getString("content"), rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getString("commentStatus"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ord;
    }

    public Comment getCommentByID(int id) {
        Comment ord = null;
        try {

            ps = conn.prepareStatement("SELECT * FROM [Comment] WHERE commentID=? ");
            ps.setInt(1, id);
 
            rs = ps.executeQuery();
            while (rs.next()) {

                ord = new Comment(rs.getInt("commentID"), rs.getInt("productID"), rs.getInt("accountID"), rs.getString("content"), rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getString("commentStatus"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ord;
    }
    
    public boolean checkAccountCommentInProduct(int accountID, int ProductID) {
        boolean existed = false;
        try {

            ps = conn.prepareStatement("SELECT * FROM [Comment] WHERE accountID=? and  productID=? ");
            ps.setInt(1, accountID);
            ps.setInt(2, ProductID);
            rs = ps.executeQuery();
            while (rs.next()) {

                existed = true;
                break;

            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return existed;
    }

    public int updateComment(Comment c) {
        String sql = "update [Comment] set productID=?,accountID=?, content=?, createdDate=? where commentID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, c.getAccountID());
            ps.setInt(2, c.getProductID());
            ps.setString(3, c.getContent());

            ps.setTimestamp(4, Timestamp.valueOf(c.getCreatedDate()));

 

            ps.setInt(5, c.getCommentID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }

    
     public int updateCommentStatus(Comment c) {
        String sql = "update [Comment] set commentStatus=? where commentID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCommentStatus());

            ps.setInt(2, c.getCommentID());
            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
    
}
