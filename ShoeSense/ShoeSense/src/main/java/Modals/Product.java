/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modals;

/**
 *
 * @author ADMIN
 */
public class Product {
    private int productID;
    private String productName;
    private double productPrice;
    private String productImg;
    private String productCategory;
    private String productDis;
    private String productStatus;

    public Product() {
    }

    public Product(int productID, String productName, double productPrice, String productImg, String productCategory, String productDis, String productStatus) {
        this.productID = productID;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImg = productImg;
        this.productCategory = productCategory;
        this.productDis = productDis;
        this.productStatus = productStatus;
    }

    public Product(String productName, double productPrice, String productImg, String productCategory, String productDis, String productStatus) {
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImg = productImg;
        this.productCategory = productCategory;
        this.productDis = productDis;
        this.productStatus = productStatus;
    }

    

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
    }

    public String getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(String productCategory) {
        this.productCategory = productCategory;
    }

    public String getProductDis() {
        return productDis;
    }

    public void setProductDis(String productDis) {
        this.productDis = productDis;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    
    
    
}
