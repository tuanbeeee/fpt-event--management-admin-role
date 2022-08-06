 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.comment;

/**
 *
 * @author light
 */
public class CommentDTO {

    private String commentID;
    private String replyID;
    private String time;
    private String content;
    private String userID;
    private String eventID;
    private String userName;
    private String avatarUrl;
    private String userRoleID;
    private String userRoleName;
    private boolean status;

    public CommentDTO(String replyID ,String content, String userID, String eventID, boolean status) {
        this.content = content;
        this.replyID = replyID;
        this.userID = userID;
        this.eventID = eventID;
        this.status = status;
    }

    
    
    
    public CommentDTO(String commentID, String replyID, String time, String content, String userID, String eventID, String userName, String avatarUrl, String userRoleID, String userRoleName, boolean status) {
        this.commentID = commentID;
        this.replyID = replyID;
        this.time = time;
        this.content = content;
        this.userID = userID;
        this.eventID = eventID;
        this.userName = userName;
        this.avatarUrl = avatarUrl;
        this.userRoleID = userRoleID;
        this.userRoleName = userRoleName;
        this.status = status;
    }



    public CommentDTO() {
        this.commentID = "";
        this.replyID = "";
        this.time = "";
        this.content = "";
        this.userID = "";
        this.eventID = "";
        this.userName = "";
        this.avatarUrl = "";
        this.userRoleID = "";
        this.userRoleName = "";
        this.status = false;
        
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getUserRoleID() {
        return userRoleID;
    }

    public void setUserRoleID(String userRoleID) {
        this.userRoleID = userRoleID;
    }

    public String getUserRoleName() {
        return userRoleName;
    }

    public void setUserRoleName(String userRoleName) {
        this.userRoleName = userRoleName;
    }

    
    
    
    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

        
    
    public String getCommentID() {
        return commentID;
    }

    public void setCommentID(String commentID) {
        this.commentID = commentID;
    }

    public String getReplyID() {
        return replyID;
    }

    public void setReplyID(String replyID) {
        this.replyID = replyID;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
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

}
