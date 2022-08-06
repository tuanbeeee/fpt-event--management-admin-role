package sample.posts;

/**
 *
 * @author tvfep
 */
public class EventPost extends Post {

    private String takePlaceDate;
    private String location;
    private String eventType;
    private String speaker;
    private String eventTypeName;
    private String locationName;
    private String statusTypeID;
    private String statusTypeName;
    private String approvalDes;
    private int numberOfParticipants;
    private int participationLimit;
    private int slotID;
    private String slotTime;

    public EventPost() {
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String eventTypeName, String locationName, String statusTypeID, String statusTypeName) {
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.locationName = locationName;
        this.statusTypeID = statusTypeID;
        this.statusTypeName = statusTypeName;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String eventTypeName, String locationName, String statusTypeID, String statusTypeName, String id, String orgID, String title, String content, String createDate, String imgUrl, int numberOfView, String summary, int participationLimit) {
        super(id, orgID, title, content, createDate, imgUrl, numberOfView, summary);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.locationName = locationName;
        this.statusTypeID = statusTypeID;
        this.statusTypeName = statusTypeName;
        this.participationLimit = participationLimit;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String eventTypeName, String locationName, String statusTypeID, String statusTypeName, String id, String orgID, String title, String content, String createDate, String imgUrl, int numberOfView, String summary, boolean status) {
        super(id, orgID, title, content, createDate, imgUrl, numberOfView, summary, status);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.locationName = locationName;
        this.statusTypeID = statusTypeID;
        this.statusTypeName = statusTypeName;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String eventTypeName, String locationName, String statusTypeID, String statusTypeName, String approvalDes, String id, String orgID, String title, String content, String createDate, String imgUrl, int numberOfView, String summary, boolean status) {
        super(id, orgID, title, content, createDate, imgUrl, numberOfView, summary, status);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.locationName = locationName;
        this.statusTypeID = statusTypeID;
        this.statusTypeName = statusTypeName;
        this.approvalDes = approvalDes;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String statusTypeID, String approvalDes, String id, String orgID, String title, String content, String createDate, String imgUrl, int numberOfView, String summary, boolean status, int participationLimit) {
        super(id, orgID, title, content, createDate, imgUrl, numberOfView, summary, status);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.statusTypeID = statusTypeID;
        this.approvalDes = approvalDes;
        this.participationLimit = participationLimit;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String id, String title, String content, String imgUrl, String summary, int participationLimit) {
        super(id, title, content, imgUrl, summary);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.participationLimit = participationLimit;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String id, String title, String content, String imgUrl, String summary, boolean status, int participationLimit) {
        super(id, title, content, imgUrl, summary, status);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.participationLimit = participationLimit;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String eventTypeName, String locationName, String statusTypeID, String statusTypeName, String approvalDes, String id, String orgID, String orgName, String title, String content, String createDate, String imgUrl, int numberOfView, String summary, boolean status, int participationLimit) {
        super(id, orgID, orgName, title, content, createDate, imgUrl, numberOfView, summary, status);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.locationName = locationName;
        this.statusTypeID = statusTypeID;
        this.statusTypeName = statusTypeName;
        this.approvalDes = approvalDes;
        this.participationLimit = participationLimit;
    }

    public EventPost(String takePlaceDate, String location, String eventType, String speaker, String eventTypeName, String locationName, String statusTypeID, String statusTypeName, String approvalDes, String id, String orgID, String orgName, String title, String content, String createDate, String imgUrl, int numberOfView, String summary, boolean status, int numberOfParticipants, int participationLimit, int slotID, String slotTime) {
        super(id, orgID, orgName, title, content, createDate, imgUrl, numberOfView, summary, status);
        this.takePlaceDate = takePlaceDate;
        this.location = location;
        this.eventType = eventType;
        this.speaker = speaker;
        this.eventTypeName = eventTypeName;
        this.locationName = locationName;
        this.statusTypeID = statusTypeID;
        this.statusTypeName = statusTypeName;
        this.approvalDes = approvalDes;
        this.numberOfParticipants = numberOfParticipants;
        this.participationLimit = participationLimit;
        this.slotID = slotID;
        this.slotTime = slotTime;
    }

    public String getTakePlaceDate() {
        return takePlaceDate;
    }

    public void setTakePlaceDate(String takePlaceDate) {
        this.takePlaceDate = takePlaceDate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
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

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getStatusTypeID() {
        return statusTypeID;
    }

    public void setStatusTypeID(String statusTypeID) {
        this.statusTypeID = statusTypeID;
    }

    public String getStatusTypeName() {
        return statusTypeName;
    }

    public void setStatusTypeName(String statusTypeName) {
        this.statusTypeName = statusTypeName;
    }

    public String getApprovalDes() {
        return approvalDes;
    }

    public void setApprovalDes(String approvalDes) {
        this.approvalDes = approvalDes;
    }

    public int getNumberOfParticipants() {
        return numberOfParticipants;
    }

    public void setNumberOfParticipants(int numberOfParticipants) {
        this.numberOfParticipants = numberOfParticipants;
    }

    public int getParticipationLimit() {
        return participationLimit;
    }

    public void setParticipationLimit(int participationLimit) {
        this.participationLimit = participationLimit;
    }

    public int getSlotID() {
        return slotID;
    }

    public void setSlotID(int slotID) {
        this.slotID = slotID;
    }

    public String getSlotTime() {
        return slotTime;
    }

    public void setSlotTime(String slotTime) {
        this.slotTime = slotTime;
    }
    
}
