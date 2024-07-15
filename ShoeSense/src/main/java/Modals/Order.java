/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modals;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class Order {

      
      
      private int orderID;
      private int accountID;
      private String orderAddress;
        private String paymentMethod;
      private double totalPrice;
//      private Date purchaseDate;
//      interactiveDate
      private String orderStatus;

    public Order() {
    }

    public Order(int orderID, int accountID, String orderAddress, String paymentMethod, double totalPrice, String orderStatus) {
        this.orderID = orderID;
        this.accountID = accountID;
        this.orderAddress = orderAddress;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.orderStatus = orderStatus;
    }

    public Order(int accountID, String orderAddress, String paymentMethod, double totalPrice, String orderStatus) {
        this.accountID = accountID;
        this.orderAddress = orderAddress;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.orderStatus = orderStatus;
    }
    
    
    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(String orderAddress) {
        this.orderAddress = orderAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    
}
