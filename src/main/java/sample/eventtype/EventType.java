/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.eventtype;

/**
 *
 * @author light
 */
public class EventType {

    private int eventTypeID;
    private String eventTypeName;
    private boolean status;

    public EventType(int eventTypeID, String eventTypeName, boolean status) {
        this.eventTypeID = eventTypeID;
        this.eventTypeName = eventTypeName;
        this.status = status;
    }

     public EventType(String eventTypeName, boolean status) {
        this.eventTypeName = eventTypeName;
        this.status = status;
    }
    
    public EventType() {
        this.eventTypeID = 0;
        this.eventTypeName = "";
        this.status = false;
    }

    public EventType(int eventTypeID, String eventTypeName) {
        this.eventTypeID = eventTypeID;
        this.eventTypeName = eventTypeName;
    }

    public int getEventTypeID() {
        return eventTypeID;
    }

    public void setEventTypeID(int eventTypeID) {
        this.eventTypeID = eventTypeID;
    }

    public String getEventTypeName() {
        return eventTypeName;
    }

    public void setEventTypeName(String eventTypeName) {
        this.eventTypeName = eventTypeName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
