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
public class Account {
    
    private int accountID;
    private String accountEmail;
    private String accountPassword;
    private String accountName;
    private String accountGender;
    private Date accountBirthdate;
    private String accountPhone;
    private String accountAddress;
    private String accountRole;
    private String accountStatus;
    private String otp;
    private java.util.Date otp_time;
    
    
    public Account() {
    }

    public Account(int accountID, String accountEmail, String accountPassword, String accountName, String accountGender, Date accountBirthdate, String accountPhone, String accountAddress, String accountRole, String accountStatus, String otp, java.util.Date otp_time) {
        this.accountID = accountID;
        this.accountEmail = accountEmail;
        this.accountPassword = accountPassword;
        this.accountName = accountName;
        this.accountGender = accountGender;
        this.accountBirthdate = accountBirthdate;
        this.accountPhone = accountPhone;
        this.accountAddress = accountAddress;
        this.accountRole = accountRole;
        this.accountStatus = accountStatus;
        this.otp = otp;
        this.otp_time = otp_time;
    }

    public Account(int accountID, String accountName, String accountGender, Date accountBirthdate, String accountPhone,String accountAddress) {
        this.accountID = accountID;
        this.accountName = accountName;
        this.accountGender = accountGender;
        this.accountBirthdate = accountBirthdate;
        this.accountPhone = accountPhone;
        this.accountAddress = accountAddress;
    }

    public Account(int accountID, String accountPassword) {
        this.accountID = accountID;
        this.accountPassword = accountPassword;
    }

    
    
    public Account(String accountEmail, String accountPassword, String accountName, String accountGender, Date accountBirthdate, String accountPhone, String accountAddress, String accountRole, String accountStatus, String otp, java.util.Date otp_time) {
        this.accountEmail = accountEmail;
        this.accountPassword = accountPassword;
        this.accountName = accountName;
        this.accountGender = accountGender;
        this.accountBirthdate = accountBirthdate;
        this.accountPhone = accountPhone;
        this.accountAddress = accountAddress;
        this.accountRole = accountRole;
        this.accountStatus = accountStatus;
        this.otp = otp;
        this.otp_time = otp_time;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getAccountEmail() {
        return accountEmail;
    }

    public void setAccountEmail(String accountEmail) {
        this.accountEmail = accountEmail;
    }

    public String getAccountPassword() {
        return accountPassword;
    }

    public void setAccountPassword(String accountPassword) {
        this.accountPassword = accountPassword;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getAccountGender() {
        return accountGender;
    }

    public void setAccountGender(String accountGender) {
        this.accountGender = accountGender;
    }

    public Date getAccountBirthdate() {
        return accountBirthdate;
    }

    public void setAccountBirthdate(Date accountBirthdate) {
        this.accountBirthdate = accountBirthdate;
    }

    public String getAccountPhone() {
        return accountPhone;
    }

    public void setAccountPhone(String accountPhone) {
        this.accountPhone = accountPhone;
    }

    public String getAccountAddress() {
        return accountAddress;
    }

    public void setAccountAddress(String accountAddress) {
        this.accountAddress = accountAddress;
    }

    public String getAccountRole() {
        return accountRole;
    }

    public void setAccountRole(String accountRole) {
        this.accountRole = accountRole;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public java.util.Date getOtp_time() {
        return otp_time;
    }

    public void setOtp_time(java.util.Date otp_time) {
        this.otp_time = otp_time;
    }

   
}    