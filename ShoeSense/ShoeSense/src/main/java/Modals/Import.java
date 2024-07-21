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
public class Import {
        private int importID;
            private LocalDateTime  importDate;
    private int accountID;
    private int productID;
    private int variantID;
    private int quantity;

    public Import() {
    }
  public Import(int importID, LocalDateTime importDate, int accountID, int productID, int variantID, int quantity) {
        this.importID = importID;
        this.importDate = importDate;
        this.accountID = accountID;
        this.productID = productID;
        this.variantID = variantID;
        this.quantity = quantity;
    }

    public Import(LocalDateTime importDate, int accountID, int productID, int variantID, int quantity) {
        this.importDate = importDate;
        this.accountID = accountID;
        this.productID = productID;
        this.variantID = variantID;
        this.quantity = quantity;
    }

  
    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public LocalDateTime getImportDate() {
        return importDate;
    }

    public void setImportDate(LocalDateTime importDate) {
        this.importDate = importDate;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
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
