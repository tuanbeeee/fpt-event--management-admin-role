/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sample.ticket;

/**
 *
 * @author Tuan Be
 */
public class TicketDTO {

    private String fullName;
    private String avatarURL;
    private String title;
    private String org_ID;
    private String location;
    private String takePlaceDate;
    private String eventTypeID;
    private String speaker;
    private String eventTypeName;
    private String evt_TypeID;
    private String locationName;
    private String location_ID;
    private String orgName;
    private String orgid;
    private String qrCode;
    private String slotTime;
    private String userID;
    private String eventID;

    public TicketDTO() {
        this.fullName = "";
        this.avatarURL = "";
        this.title = "";
        this.org_ID = "";
        this.location = "";
        this.takePlaceDate = "";
        this.eventTypeID = "";
        this.speaker = "";
        this.eventTypeName = "";
        this.evt_TypeID = "";
        this.locationName = "";
        this.location_ID = "";
        this.orgName = "";
        this.orgid = "";
        this.qrCode = "";
        this.userID = "";
        this.eventID = "";
    }

    public TicketDTO(String fullName, String avatarURL, String title, String org_ID, String location, String takePlaceDate, String eventTypeID, String speaker, String eventTypeName, String evt_TypeID, String locationName, String location_ID, String orgName, String orgid, String qrCode, String slotTime, String userID, String eventID) {
        this.fullName = fullName;
        this.avatarURL = avatarURL;
        this.title = title;
        this.org_ID = org_ID;
        this.location = location;
        this.takePlaceDate = takePlaceDate;
        this.eventTypeID = eventTypeID;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.evt_TypeID = evt_TypeID;
        this.locationName = locationName;
        this.location_ID = location_ID;
        this.orgName = orgName;
        this.orgid = orgid;
        this.qrCode = qrCode;
        this.slotTime = slotTime;
        this.userID = userID;
        this.eventID = eventID;
    }

    public String getSlotTime() {
        return slotTime;
    }

    public void setSlotTime(String slotTime) {
        this.slotTime = slotTime;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAvatarURL() {
        return avatarURL;
    }

    public void setAvatarURL(String avatarURL) {
        this.avatarURL = avatarURL;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOrg_ID() {
        return org_ID;
    }

    public void setOrg_ID(String org_ID) {
        this.org_ID = org_ID;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTakePlaceDate() {
        return takePlaceDate;
    }

    public void setTakePlaceDate(String takePlaceDate) {
        this.takePlaceDate = takePlaceDate;
    }

    public String getEventTypeID() {
        return eventTypeID;
    }

    public void setEventTypeID(String eventTypeID) {
        this.eventTypeID = eventTypeID;
    }

    public String getSpeaker() {
        return speaker;
    }

    public void setSpeaker(String speaker) {
        this.speaker = speaker;
    }

    public String getEventTypeName() {
        return eventTypeName;
    }

    public void setEventTypeName(String eventTypeName) {
        this.eventTypeName = eventTypeName;
    }

    public String getEvt_TypeID() {
        return evt_TypeID;
    }

    public void setEvt_TypeID(String evt_TypeID) {
        this.evt_TypeID = evt_TypeID;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getLocation_ID() {
        return location_ID;
    }

    public void setLocation_ID(String location_ID) {
        this.location_ID = location_ID;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
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

    
    @Override
    public String toString() {
        return "TicketDTO{" + "fullName=" + fullName + ", avatarURL=" + avatarURL + ", title=" + title + ", org_ID=" + org_ID + ", location=" + location + ", takePlaceDate=" + takePlaceDate + ", eventTypeID=" + eventTypeID + ", speaker=" + speaker + ", eventTypeName=" + eventTypeName + ", evt_TypeID=" + evt_TypeID + ", locationName=" + locationName + ", location_ID=" + location_ID + ", orgName=" + orgName + ", orgid=" + orgid + ", qrCode=" + qrCode + '}';
    }

}
