/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Import;
import Modals.Order;
import Modals.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class OrderDAO {
     private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public OrderDAO() {
        conn = DBcontext.DBContext.getConnection();
    }

    public int AddNewOrder(Order ord) throws SQLException {
        String sql = "insert into [Order] (accountID, orderAddress, paymentMethod, totalPrice, orderStatus) values (?,?,?,?,?);";

        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ord.getAccountID());
            ps.setString(2, ord.getOrderAddress());
             ps.setString(3, ord.getPaymentMethod());
            ps.setDouble(4, ord.getTotalPrice());
            ps.setString(5, ord.getOrderStatus());


            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }
    
        public List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Order]");
//            ps.setString(1, role);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order ord = new Order(rs.getInt("orderID"), rs.getInt("accountID"), rs.getString("orderAddress"), rs.getString("paymentMethod"), rs.getInt("totalPrice"),
                         rs.getString("orderStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
        
        
                public List<Order> getAllOrderByStatus(String status) {
        List<Order> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Order] where orderStatus=?");
            ps.setString(1, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order ord = new Order(rs.getInt("orderID"), rs.getInt("accountID"), rs.getString("orderAddress"),  rs.getString("paymentMethod"),  rs.getInt("totalPrice"),
                        rs.getString("orderStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Order getOrderById(int id) {
        Order ord = new Order();
        try {
            ps = conn.prepareStatement("select * from [Order] where orderID=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                ord = new Order(rs.getInt("orderID"), rs.getInt("accountID"),rs.getString("orderAddress"),  rs.getString("paymentMethod"),  rs.getInt("totalPrice"),
                         rs.getString("orderStatus"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ord;
    }

      public Order getNewestOrderinAccount(int id) {
        Order ord = new Order();
        try {
            ps = conn.prepareStatement("SELECT TOP 1 * FROM [Order] WHERE accountID=? ORDER BY orderID DESC");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                ord = new Order(rs.getInt("orderID"), rs.getInt("accountID"),rs.getString("orderAddress"),  rs.getString("paymentMethod"),  rs.getInt("totalPrice"),
                         rs.getString("orderStatus"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ord;
    }
    

    
            public List<Order> getAllOrderByAccountId(int id) {
        List<Order> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Order] where accountID=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order ord = new Order(rs.getInt("orderID"), rs.getInt("accountID"),rs.getString("orderAddress"),  rs.getString("paymentMethod"),  rs.getInt("totalPrice"),
                         rs.getString("orderStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
            
                
            public List<Order> getAllOrderByAccountIdAndStatus(int id, String status) {
        List<Order> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [Order] where accountID=? and orderStatus=?");
            ps.setInt(1, id);
            ps.setString(2, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order ord = new Order(rs.getInt("orderID"), rs.getInt("accountID"),rs.getString("orderAddress"),  rs.getString("paymentMethod"),  rs.getInt("totalPrice"),
                         rs.getString("orderStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
            

            
        public int updateOrderStatus(Order ord) {
        String sql = "update [Order] set accountID=?,orderAddress=?, paymentMethod=?,totalPrice=?, orderStatus=? where orderID=?";
        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ord.getAccountID());
            ps.setString(2, ord.getOrderAddress());
             ps.setString(3, ord.getPaymentMethod());
            ps.setDouble(4, ord.getTotalPrice());
            ps.setString(5, ord.getOrderStatus());

            ps.setInt(6, ord.getOrderID());

            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ketqua;
    }
    
    
                                  public void deleteOrderByID(int id) {
        try {
            ps = conn.prepareStatement("DELETE FROM [dbo].[Order]\n"
                    + "      WHERE orderID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
                                  
                                  
//       public double dailyRevenue() {
//        double revenue = 0;
//        LocalDateTime today = LocalDateTime.now();
//        LocalDate currentDate = today.toLocalDate(); // Extract the date part
//
//        try {
//            String sql = "SELECT o.totalPrice " +
//                         "FROM [Order] o " +
//                         "JOIN OrderStatusLog osl ON o.orderID = osl.orderID " +
//                         "WHERE CAST(osl.statusDate AS DATE) = ? " +
//                         "AND osl.orderStatus = ?";
//
//            ps = conn.prepareStatement(sql);
//            ps.setTimestamp(1, Timestamp.valueOf(currentDate.atStartOfDay())); // Start of the current day
//            ps.setString(2, "Delivered");
//            rs = ps.executeQuery();
//            
//            while (rs.next()) {
//                revenue += rs.getDouble("totalPrice");
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            // Close resources in a finally block
//            try {
//                if (rs != null) rs.close();
//                if (ps != null) ps.close();
//            } catch (SQLException e) {
//                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
//            }
//        }
//        return revenue;
//    }
    
//    public double monthlyRevenue() {
//        double revenue = 0;
//        LocalDate firstDayOfMonth = LocalDate.now().withDayOfMonth(1);
//        LocalDate lastDayOfMonth = LocalDate.now().withDayOfMonth(firstDayOfMonth.lengthOfMonth());
//        try {
//            ps = conn.prepareStatement("SELECT totalPrice FROM [Order] WHERE CAST(orderDate AS DATE) BETWEEN ? AND ?");
//            ps.setDate(1, Date.valueOf(firstDayOfMonth));
//            ps.setDate(2, Date.valueOf(lastDayOfMonth));
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                revenue += rs.getDouble("totalPrice");
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return revenue;
//    }
//    
//    public double yearlyRevenue() {
//        double revenue = 0;
//        LocalDate firstDayOfYear = LocalDate.now().withDayOfYear(1);
//        LocalDate lastDayOfYear = LocalDate.now().withDayOfYear(firstDayOfYear.lengthOfYear());
//        try {
//            ps = conn.prepareStatement("SELECT totalPrice FROM [Order] WHERE CAST(orderDate AS DATE) BETWEEN ? AND ?");
//            ps.setDate(1, Date.valueOf(firstDayOfYear));
//            ps.setDate(2, Date.valueOf(lastDayOfYear));
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                revenue += rs.getDouble("totalPrice");
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return revenue;
//    }
                                  
}
