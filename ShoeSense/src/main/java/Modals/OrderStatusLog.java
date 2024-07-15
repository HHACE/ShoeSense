/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modals;

import java.time.LocalDateTime;

/**
 *
 * @author ADMIN
 */
public class OrderStatusLog {
     private int orderID;
      private int acccountID;
      private LocalDateTime  statusDate;
       private String  orderStatus;
       

    public OrderStatusLog() {
    }

    public OrderStatusLog(int orderID, int acccountID, LocalDateTime statusDate, String orderStatus) {
        this.orderID = orderID;
        this.acccountID = acccountID;
        this.statusDate = statusDate;
        this.orderStatus = orderStatus;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getAcccountID() {
        return acccountID;
    }

    public void setAcccountID(int acccountID) {
        this.acccountID = acccountID;
    }

    public LocalDateTime getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(LocalDateTime statusDate) {
        this.statusDate = statusDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
       
}
