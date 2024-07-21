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
public class Comment {
    private int commentID;
    private int productID;
    private int accountID;
    private String content;
    private LocalDateTime createdDate;
    private String commentStatus;

    public Comment() {
    }

    
    public Comment(int commentID, int productID, int accountID, String content, LocalDateTime createdDate, String commentStatus) {
        this.commentID = commentID;
        this.productID = productID;
        this.accountID = accountID;
        this.content = content;
        this.createdDate = createdDate;
        this.commentStatus = commentStatus;
    }

    public Comment(int productID, int accountID, String content, LocalDateTime createdDate, String commentStatus) {
        this.productID = productID;
        this.accountID = accountID;
        this.content = content;
        this.createdDate = createdDate;
        this.commentStatus = commentStatus;
    }

    
    
    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getCommentStatus() {
        return commentStatus;
    }

    public void setCommentStatus(String commentStatus) {
        this.commentStatus = commentStatus;
    }

    
    
}
