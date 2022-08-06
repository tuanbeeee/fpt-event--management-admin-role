/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

/**
 *
 * @author light
 */
public class UserNotification {

    private String userID;
    private String eventID;
    private String notiDate;
    private String content;
    private String notiImg;

    public UserNotification(String userID, String eventID, String notiDate, String content) {
        this.userID = userID;
        this.eventID = eventID;
        this.notiDate = notiDate;
        this.content = content;
    }

    public UserNotification() {
        this.userID = "";
        this.eventID = "";
        this.notiDate = "";
        this.content = "";

    }

    public UserNotification(String userID, String eventID, String notiDate, String content, String notiImg) {
        this.userID = userID;
        this.eventID = eventID;
        this.notiDate = notiDate;
        this.content = content;
        this.notiImg = notiImg;
    }

    public String getNotiImg() {
        return notiImg;
    }

    public void setNotiImg(String notiImg) {
        this.notiImg = notiImg;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    public String getNotiDate() {
        return notiDate;
    }

    public void setNotiDate(String notiDate) {
        this.notiDate = notiDate;
    }

}
