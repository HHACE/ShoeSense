/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modals;

/**
 *
 * @author ADMIN
 */
public class Cart {
        private int cartID;
    private int userID;
    private int productID;
    private int variantID;
    private int quantity;

    public Cart() {
    }

    public Cart(int cartID, int userID, int productID, int variantID, int quantity) {
        this.cartID = cartID;
        this.userID = userID;
        this.productID = productID;
        this.variantID = variantID;
        this.quantity = quantity;
    }

    public Cart(int userID, int productID, int variantID, int quantity) {
        this.userID = userID;
        this.productID = productID;
        this.variantID = variantID;
        this.quantity = quantity;
    }

    
    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }



    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
    
}
