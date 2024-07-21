/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Modals.OrderDetail;
import Modals.OrderStatusLog;
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
public class OrderStatusLogDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public OrderStatusLogDAO() {
        conn = DBcontext.DBContext.getConnection();
    }

    public int AddNewOrderStatusLog(OrderStatusLog ord) throws SQLException {
        String sql = "insert into OrderStatusLog (orderID, accountID, statusDate, orderStatus) values (?,?,?,?);";

        int ketqua = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ord.getOrderID());
            if (ord.getAcccountID() != 0) {
                ps.setInt(2, ord.getAcccountID());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }

            ps.setTimestamp(3, Timestamp.valueOf(ord.getStatusDate()));
            ps.setString(4, ord.getOrderStatus());

            ketqua = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderStatusLogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ketqua;
    }

    public List<OrderStatusLog> getAllOrderStatusLogByOrderId(int id) {
        List<OrderStatusLog> list = new ArrayList<>();
        try {

 ps = conn.prepareStatement("SELECT * FROM [OrderStatusLog] WHERE orderID=? ORDER BY statusDate DESC");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderStatusLog ord = new OrderStatusLog(rs.getInt("orderID"), rs.getInt("accountID"), rs.getTimestamp("statusDate").toLocalDateTime(),
                        rs.getString("orderStatus"));
                list.add(ord);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderStatusLogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
