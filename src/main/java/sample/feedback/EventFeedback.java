/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.feedback;

/**
 *
 * @author tvfep
 */
public class EventFeedback {
    private int feedbackID;
    private String userID;
    private String eventID;
    private String content;

    public EventFeedback() {
    }

    public EventFeedback(int FeedbackID, String userID, String eventID, String content) {
        this.feedbackID = FeedbackID;
        this.userID = userID;
        this.eventID = eventID;
        this.content = content;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int FeedbackID) {
        this.feedbackID = FeedbackID;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
