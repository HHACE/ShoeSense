/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.Order;
import Modals.OrderDetail;
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
public class OrderDetailDAO {
         private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public OrderDetailDAO() {
        conn = DBcontext.DBContext.getConnection();
    }
    
            public int AddNewOrderDetail(OrderDetail ord) throws SQLException {
        String sql = "insert into OrderDetail (orderID,productID, variantID, quantity, total) values (?,?,?,?,?);";

        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ord.getOrderID());
            ps.setInt(2, ord.getProductID());
            ps.setInt(3, ord.getVariantID());
            ps.setInt(4, ord.getQuantity());
            ps.setDouble(5, ord.getTotal());


            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }
            
            
    
            public List<OrderDetail> getAllOrderDetailByOrderId(int id) {
        List<OrderDetail> list = new ArrayList<>();
        try {

            ps = conn.prepareStatement("select * from [OrderDetail] where orderID=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail ord = new OrderDetail(rs.getInt("orderID"), rs.getInt("productID"), rs.getInt("variantID"),
                        rs.getInt("quantity"), rs.getDouble("total"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
            
            
                
            public boolean checkOrderDetailByProductID( int productid ,int orderID ) {
       boolean check = false;
        try {

            ps = conn.prepareStatement("select * from [OrderDetail] where productID=? and orderID=?");
            ps.setInt(1, productid);
             ps.setInt(2, orderID);
            rs = ps.executeQuery();
            while (rs.next()) {
check = true;
break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }
}
