/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modals;

/**
 *
 * @author ADMIN
 */
public class ProductVariant {
        private int variantID;
        private int productID;
        private String variantImg;
        private String variantSize;
        private String variantColor;
        private int variantQuantity;

    public ProductVariant() {
    }

    public ProductVariant(int variantID, int productID, String variantImg, String variantSize, String variantColor, int variantQuantity) {
        this.variantID = variantID;
        this.productID = productID;
        this.variantImg = variantImg;
        this.variantSize = variantSize;
        this.variantColor = variantColor;
        this.variantQuantity = variantQuantity;
    }

    public ProductVariant(int productID, String variantImg, String variantSize, String variantColor, int variantQuantity) {
        this.productID = productID;
        this.variantImg = variantImg;
        this.variantSize = variantSize;
        this.variantColor = variantColor;
        this.variantQuantity = variantQuantity;
    }
    
    

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getVariantImg() {
        return variantImg;
    }

    public void setVariantImg(String variantImg) {
        this.variantImg = variantImg;
    }

    public String getVariantSize() {
        return variantSize;
    }

    public void setVariantSize(String variantSize) {
        this.variantSize = variantSize;
    }

    public String getVariantColor() {
        return variantColor;
    }

    public void setVariantColor(String variantColor) {
        this.variantColor = variantColor;
    }

    public int getVariantQuantity() {
        return variantQuantity;
    }

    public void setVariantQuantity(int variantQuantity) {
        this.variantQuantity = variantQuantity;
    }

   
        
}
