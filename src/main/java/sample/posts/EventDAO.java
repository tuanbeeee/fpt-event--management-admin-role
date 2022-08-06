/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.posts;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sample.eventtype.EventType;
import sample.slot.SlotTime;
import sample.users.UserDTO;
import sample.util.DBUtils;

/**
 *
 * @author tvfep
 */
public class EventDAO {

    private static final String GET_ALL_EVENT_POST = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID, numberOfView, speaker, summary, tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblSlot.slotID, tblSlot.slotTime\n"
            + "                        FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "                        WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID and tblEventPost.location = tblLocation.locationID and tblEventPost.statusTypeID = tblStatusType.statusTypeID and tblSlot.slotID = tblEventPost.slotID";

    private static final String GET_ALL_EVENT_BY_TITLE = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID, numberOfView, speaker, summary, \n"
            + "            tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblEventPost.slotID, slotTime\n"
            + "            FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "            WHERE (ufn_removeMark(tblEventPost.title) LIKE ufn_removeMark(?) or title LIKE ?)\n"
            + "            and tblEventPost.eventTypeID = tblEventType.eventTypeID and \n"
            + "            tblEventPost.location = tblLocation.locationID and tblEventPost.statusTypeID = tblStatusType.statusTypeID and tblSlot.slotID = tblEventPost.slotID";

    private static final String GET_AN_EVENT_BY_ID = "SELECT eventID, tblOrgPage.orgID, tblEventPost.createDate, takePlaceDate, content, title, location, tblEventPost.imgUrl, tblEventPost.eventTypeID, numberOfView, speaker, summary,\n"
            + "            tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblOrgPage.orgName, participationLimit, tblSlot.slotID, slotTime\n"
            + "            FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblOrgPage, tblSlot\n"
            + "            WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID and tblEventPost.location = tblLocation.locationID \n"
            + "            and tblEventPost.statusTypeID = tblStatusType.statusTypeID and tblOrgPage.orgID = tblEventPost.orgID and tblSlot.slotID = tblEventPost.slotID and tblEventPost.eventID = ?\n";

    private static final String ADD_AN_EVENT = "INSERT INTO tblEventPost\n"
            + "           (eventID, orgID, status, statusTypeID, content,\n"
            + "		   title, location ,imgUrl, eventTypeID, numberOfView, speaker, approvalDes, summary, createDate ,takePlaceDate, participationLimit, slotID)\n"
            + "     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String CHECK_EVENT_DUPLICATE = "SELECT eventID FROM tblEventPost where eventID = ?";

    private static final String UPDATE_AN_EVENT = "UPDATE tblEventPost\n"
            + "   SET takePlaceDate = ?\n"
            + "      ,content = ?\n"
            + "      ,title = ?\n"
            + "      ,location = ?\n"
            + "      ,imgUrl = ?\n"
            + "      ,eventTypeID = ?\n"
            + "      ,speaker = ?\n"
            + "      ,summary = ?\n"
            + "      ,participationLimit = ?\n"
            + "      ,slotID = ?\n"
            + " WHERE eventID = ?";

    private static final String UPDATE_AN_EVENT_BY_MOD = "UPDATE tblEventPost\n"
            + "   SET takePlaceDate = ?\n"
            + "      ,content = ?\n"
            + "      ,title = ?\n"
            + "      ,location = ?\n"
            + "      ,imgUrl = ?\n"
            + "      ,eventTypeID = ?\n"
            + "      ,speaker = ?\n"
            + "      ,summary = ?\n"
            + "      ,status = ?\n"
            + "      ,participationLimit = ?\n"
            + "      ,slotID = ?\n"
            + " WHERE eventID = ?";

    private static final String GET_ALL_EVENT_TYPE = "SELECT eventTypeID, eventTypeName\n"
            + "FROM tblEventType\n"
            + "WHERE status = '1'";

    private static final String GET_ALL_EVENT_LOCATION = "SELECT locationID, locationName\n"
            + "FROM tblLocation\n"
            + "WHERE status = '1'";

    private static final String GET_NUMBER_OF_PARTICIPANTS = "SELECT COUNT(userID) as total\n"
            + "  FROM tblParticipants\n"
            + "  Where eventID = ? AND status = '1'";

    private static final String GET_ALL_EVENT_BY_ORG = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID,\n"
            + "numberOfView, speaker, summary, tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblEventPost.slotId, slotTime\n"
            + "FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID AND tblEventPost.location = tblLocation.locationID\n"
            + "AND tblEventPost.statusTypeID = tblStatusType.statusTypeID AND tblSlot.slotID = tblEventPost.slotID AND tblEventPost.orgID = ? ";

    private static final String GET_ALL_EVENT_BY_TYPE_AND_ORG = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID,\n"
            + "numberOfView, speaker, summary, tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblSlot.slotID, slotTime\n"
            + "FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID AND tblEventPost.location = tblLocation.locationID AND tblSlot.slotID = tblEventPost.slotID\n"
            + "AND tblEventPost.statusTypeID = tblStatusType.statusTypeID AND tblEventPost.orgID = ? AND tblEventPost.statusTypeID = ?";

    private static final String UPDATE_STATUS_EVENT = "UPDATE tblEventPost SET status = ? WHERE eventID = ?";

    private static final String GET_ALL_ORG_EVENT_BY_TITLE = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID, numberOfView, speaker, summary, \n"
            + "            tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblEventPost.slotID, slotTime\n"
            + "            FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "            WHERE (ufn_removeMark(tblEventPost.title) LIKE ufn_removeMark(?) or title LIKE ?)\n"
            + "            and tblEventPost.eventTypeID = tblEventType.eventTypeID and \n"
            + "            tblEventPost.location = tblLocation.locationID and tblEventPost.statusTypeID = tblStatusType.statusTypeID AND tblSlot.slotID = tblEventPost.slotID AND tblEventPost.orgID = ?";

    private static final String APPROVE_EVENT = "UPDATE tblEventPost SET statusTypeID = ? WHERE eventID = ?";

    private static final String DECLINE_DESCRIPTION = "UPDATE tblEventPost SET approvalDes = ? WHERE eventID = ?";

    private static final String GET_ALL_EVENT_BY_TYPE = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID, numberOfView, speaker, summary, \n"
            + "			tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblSlot.slotID, slotTime\n"
            + "            FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "            WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID and tblEventPost.location = tblLocation.locationID and tblEventPost.statusTypeID = tblStatusType.statusTypeID AND tblSlot.slotID = tblEventPost.slotID AND tblEventPost.statusTypeID = ?\n";

    private static final String GET_ALL_PARTICIPANTS_BY_EVENT_ID = "select fullName, email, phone, gender, participantcheck from tblParticipants, tblUsers where tblParticipants.status = '1' AND tblParticipants.userID = tblUsers.userID AND eventID = ?";

    private static final String GET_ALL_ACTUAL_PARTICIPANTS_BY_EVENT_ID = "select fullName, email, phone, gender from tblParticipants, tblUsers where tblParticipants.status = '1' AND tblParticipants.userID = tblUsers.userID AND participantCheck = '1' AND eventID = ?";

    private static final String SEARCH_DATE = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID,\n"
            + "numberOfView, speaker, summary, tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblEventPost.slotID, slotTime\n"
            + "FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID AND tblEventPost.location = tblLocation.locationID\n"
            + "AND tblEventPost.statusTypeID = tblStatusType.statusTypeID AND tblEventPost.slotID = tblSlot.slotID\n"
            + "AND tblEventPost.takePlaceDate between ? and ?";

    private static final String SEARCH_DATE_BY_ORG = "SELECT eventID, orgID, createDate, takePlaceDate, content, title, location, imgUrl, tblEventPost.eventTypeID,\n"
            + "numberOfView, speaker, summary, tblEventPost.status, tblEventPost.statusTypeID, statusTypeName, eventTypeName, locationName, approvalDes, tblEventPost.slotID, slotTime\n"
            + "FROM tblEventPost, tblEventType, tblLocation, tblStatusType, tblSlot\n"
            + "WHERE tblEventPost.eventTypeID = tblEventType.eventTypeID AND tblEventPost.location = tblLocation.locationID\n"
            + "AND tblEventPost.statusTypeID = tblStatusType.statusTypeID AND tblEventPost.slotID = tblSlot.slotID\n"
            + "AND tblEventPost.takePlaceDate between ? and ?\n"
            + " AND tblEventPost.orgID = ?";

    private static final String GET_ALL_SLOT_TIME = "SELECT slotID, slotTime\n"
            + "	FROM tblSlot";

    private static final String CHECK_AVALABLE_SLOT = "SELECT eventID FROM tblEventPost WHERE statusTypeID != 'DE' AND status = '1' AND takePlaceDate = ? AND location = ? AND tblEventPost.slotID = ? AND tblEventPost.eventID != ?";

    private static final String CONFIRM_TICKET = "UPDATE tblparticipants\n"
            + "	SET participantcheck = '1'\n"
            + "	WHERE userId = ? AND eventId = ?";

    public boolean checkAvailableSlot(EventPost event) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean check = true;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(CHECK_AVALABLE_SLOT);

            ps.setDate(1, java.sql.Date.valueOf(event.getTakePlaceDate()));
            ps.setInt(2, Integer.parseInt(event.getLocation()));
            ps.setInt(3, event.getSlotID());
            ps.setString(4, event.getId());

            rs = ps.executeQuery();
            if (rs.next()) {
                check = false;

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    //statusTypeID = PE va AP, location = ?, slot = ?, takePlaceDate = ?, status = true => tra ve true
    public List<EventPost> searchEventByDate(String fromDate, String endDate, String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<EventPost> listEvent = new ArrayList<>();

        try {
            conn = DBUtils.getConnection();
            if ("FPT".equals(orgID)) {
                ps = conn.prepareStatement(SEARCH_DATE);

            } else {
                ps = conn.prepareStatement(SEARCH_DATE_BY_ORG);
                ps.setString(3, orgID);
            }

            ps.setObject(1, java.sql.Date.valueOf(fromDate));
            ps.setObject(2, java.sql.Date.valueOf(endDate));

            rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("eventID");
                String createDate = rs.getString("createDate");
                Date takePlaceDate = rs.getDate("takePlaceDate");
                String content = rs.getString("content");
                String title = rs.getString("title");
                String location = rs.getString("location");
                String imgUrl = rs.getString("imgUrl");
                String orgIDOfEvent = rs.getString("orgID");
                int numberOfView = rs.getInt("numberOfView");
                String speaker = rs.getString("speaker");
                String summary = rs.getString("summary");
                Boolean status = rs.getBoolean("status");
                String eventType = rs.getString("eventTypeID");
                String eventTypeName = rs.getString("eventTypeName");
                String locationName = rs.getString("locationName");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");
                String approvalDes = rs.getString("approvalDes");
                int slotID = rs.getInt("slotID");
                String slotTime = rs.getString("slotTime");

                EventPost event = new EventPost(takePlaceDate.toString(), location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, approvalDes, id, orgIDOfEvent, "", title, content, createDate, imgUrl, numberOfView, summary, status, 0, 0, slotID, slotTime);
                listEvent.add(event);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listEvent;
    }

    public List<EventPost> getAllEventByType(String eventType, String roleID, String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String onGoing = "ON";
        String approve = "AP";
        List<EventPost> listEvent = new ArrayList<>();
        long millis = System.currentTimeMillis();
        java.sql.Date nowDate = new java.sql.Date(millis);
        try {
            conn = DBUtils.getConnection();
            if (!eventType.equals(onGoing)) {
                if ("MOD".equals(roleID)) {
                    ps = conn.prepareStatement(GET_ALL_EVENT_BY_TYPE);
                    ps.setString(1, eventType);

                } else {
                    ps = conn.prepareStatement(GET_ALL_EVENT_BY_TYPE_AND_ORG);
                    ps.setString(1, orgID);
                    ps.setString(2, eventType);

                }
            } else {
                if ("MOD".equals(roleID)) {
                    ps = conn.prepareStatement(GET_ALL_EVENT_BY_TYPE);
                    ps.setString(1, approve);

                } else {
                    ps = conn.prepareStatement(GET_ALL_EVENT_BY_TYPE_AND_ORG);
                    ps.setString(1, orgID);
                    ps.setString(2, approve);

                }
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("eventID");
                String createDate = rs.getString("createDate");
                Date takePlaceDate = rs.getDate("takePlaceDate");
                String content = rs.getString("content");
                String title = rs.getString("title");
                String location = rs.getString("location");
                String imgUrl = rs.getString("imgUrl");
                String orgIDOfEvent = rs.getString("orgID");
                int numberOfView = rs.getInt("numberOfView");
                String speaker = rs.getString("speaker");
                String summary = rs.getString("summary");
                Boolean status = rs.getBoolean("status");
                String eventTypeName = rs.getString("eventTypeName");
                String locationName = rs.getString("locationName");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");

                int slotID = rs.getInt("slotID");
                String slotTime = rs.getString("slotTime");

                if (!eventType.equals(onGoing)) {
                    EventPost event = new EventPost(takePlaceDate.toString(), location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, "", id, orgIDOfEvent, "", title, content, createDate, imgUrl, numberOfView, summary, status, 0, 0, slotID, slotTime);
                    listEvent.add(event);
                } else {
                    if (nowDate.before(takePlaceDate) && status == true) {
                        EventPost event = new EventPost(takePlaceDate.toString(), location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, "", id, orgIDOfEvent, "", title, content, createDate, imgUrl, numberOfView, summary, status, 0, 0, slotID, slotTime);
                        listEvent.add(event);

                    }
                }

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listEvent;

    }

    public boolean addDeclineDescription(String eventID, String approvalDes) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(DECLINE_DESCRIPTION);
                ps.setString(1, approvalDes);
                ps.setString(2, eventID);

                if (ps.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (Exception e) {
        } finally {

            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean approveAnEvent(String eventID, String statusTypeID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(APPROVE_EVENT);
                ps.setString(1, statusTypeID);
                ps.setString(2, eventID);

                if (ps.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (Exception e) {
        } finally {

            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<EventPost> getAllEvent() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<EventPost> listEvent = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_EVENT_POST);
            rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("eventID");
                String orgID = rs.getString("orgID");
                String createDate = rs.getString("createDate");
                String takePlaceDate = rs.getString("takePlaceDate");
                String content = rs.getString("content");
                String title = rs.getString("title");
                String location = rs.getString("location");
                String imgUrl = rs.getString("imgUrl");
                String eventType = rs.getString("eventTypeID");
                int numberOfView = rs.getInt("numberOfView");
                String speaker = rs.getString("speaker");
                String summary = rs.getString("summary");
                Boolean status = rs.getBoolean("status");
                String eventTypeName = rs.getString("eventTypeName");
                String locationName = rs.getString("locationName");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");
                String approvalDes = rs.getString("approvalDes");
                int slotID = rs.getInt("slotID");
                String slotTime = rs.getString("slotTime");

                EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, approvalDes, id, orgID, "", title, content, createDate, imgUrl, numberOfView, summary, status, 0, 0, slotID, slotTime);
                listEvent.add(event);

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listEvent;

    }

    public List<EventPost> getListEventByTitle(String search) throws SQLException {
        List<EventPost> listEvent = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_EVENT_BY_TITLE);
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");

                rs = ps.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("eventID");
                    String orgID = rs.getString("orgID");
                    String createDate = rs.getString("createDate");
                    String takePlaceDate = rs.getString("takePlaceDate");
                    String content = rs.getString("content");
                    String title = rs.getString("title");
                    String location = rs.getString("location");
                    String imgUrl = rs.getString("imgUrl");
                    String eventType = rs.getString("eventTypeID");
                    int numberOfView = rs.getInt("numberOfView");
                    String speaker = rs.getString("speaker");
                    String summary = rs.getString("summary");
                    Boolean status = rs.getBoolean("status");
                    String eventTypeName = rs.getString("eventTypeName");
                    String locationName = rs.getString("locationName");
                    String statusTypeID = rs.getString("statusTypeID");
                    String statusTypeName = rs.getString("statusTypeName");
                    String approvalDes = rs.getString("approvalDes");
                    int slotID = rs.getInt("slotID");
                    String slotTime = rs.getString("slotTime");

                    EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, approvalDes, id, orgID, "", title, content, createDate, imgUrl, numberOfView, summary, status, 0, 0, slotID, slotTime);
                    listEvent.add(event);

                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listEvent;
    }

    public EventPost getAnEventByID(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        EventPost event = new EventPost();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_AN_EVENT_BY_ID);
                ps.setString(1, eventID);

                rs = ps.executeQuery();
                if (rs.next()) {
                    String id = rs.getString("eventID");
                    String orgID = rs.getString("orgID");
                    String createDate = rs.getString("createDate");
                    String takePlaceDate = rs.getString("takePlaceDate");
                    String content = rs.getString("content");
                    String title = rs.getString("title");
                    String location = rs.getString("location");
                    String imgUrl = rs.getString("imgUrl");
                    String eventType = rs.getString("eventTypeID");
                    int numberOfView = rs.getInt("numberOfView");
                    String speaker = rs.getString("speaker");
                    String summary = rs.getString("summary");
                    Boolean status = rs.getBoolean("status");
                    String eventTypeName = rs.getString("eventTypeName");
                    String locationName = rs.getString("locationName");
                    String statusTypeID = rs.getString("statusTypeID");
                    String statusTypeName = rs.getString("statusTypeName");
                    String approvalDes = rs.getString("approvalDes");
                    String orgName = rs.getString("orgName");
                    int participationLimit = rs.getInt("participationLimit");
                    int slotID = rs.getInt("slotID");
                    String slotTime = rs.getString("slotTime");

                    event = new EventPost(takePlaceDate, location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, approvalDes, id, orgID, orgName, title, content, createDate, imgUrl, numberOfView, summary, status, 0, participationLimit, slotID, slotTime);
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return event;
    }

    public boolean checkEventIDDuplicate(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean check = true;
        String checkID = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_EVENT_DUPLICATE);
                ps.setString(1, eventID);
                rs = ps.executeQuery();
                while (rs.next()) {
                    checkID = rs.getString("eventID");
                }
                if (checkID == null) {
                    check = false;

                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean createAnEvent(EventPost event) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(ADD_AN_EVENT);
                ps.setString(1, event.getId());
                ps.setString(2, event.getOrgID());
                ps.setBoolean(3, event.isStatus());
                ps.setString(4, event.getStatusTypeID());

                ps.setString(5, event.getContent());
                ps.setString(6, event.getTitle());
                ps.setInt(7, Integer.parseInt(event.getLocation()));
                ps.setString(8, event.getImgUrl());
                ps.setInt(9, Integer.parseInt(event.getEventType()));
                ps.setInt(10, event.getNumberOfView());
                ps.setString(11, event.getSpeaker());
                ps.setString(12, event.getApprovalDes());
                ps.setString(13, event.getSummary());

                ps.setObject(14, LocalDate.parse(event.getCreateDate()));

                ps.setObject(15, java.sql.Date.valueOf(event.getTakePlaceDate()));

                ps.setInt(16, event.getParticipationLimit());
                ps.setInt(17, event.getSlotID());

                if (ps.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean updateAnEvent(EventPost event) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE_AN_EVENT);
                ps.setObject(1, java.sql.Date.valueOf(event.getTakePlaceDate()));
                ps.setString(2, event.getContent());
                ps.setString(3, event.getTitle());
                ps.setInt(4, Integer.parseInt(event.getLocation()));
                ps.setString(5, event.getImgUrl());
                ps.setInt(6, Integer.parseInt(event.getEventType()));
                ps.setString(7, event.getSpeaker());
                ps.setString(8, event.getSummary());
                ps.setInt(9, event.getParticipationLimit());
                ps.setInt(10, event.getSlotID());
                ps.setString(11, event.getId());

                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
                    check = true;

                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean updateAnEventByAdmin(EventPost event) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {

                ps = conn.prepareStatement(UPDATE_AN_EVENT_BY_MOD);
                ps.setObject(1, java.sql.Date.valueOf(event.getTakePlaceDate()));
                ps.setString(2, event.getContent());
                ps.setString(3, event.getTitle());
                ps.setInt(4, Integer.parseInt(event.getLocation()));
                ps.setString(5, event.getImgUrl());
                ps.setInt(6, Integer.parseInt(event.getEventType()));
                ps.setString(7, event.getSpeaker());
                ps.setString(8, event.getSummary());
                ps.setBoolean(9, event.isStatus());
                ps.setInt(10, event.getParticipationLimit());
                ps.setInt(11, event.getSlotID());
                ps.setString(12, event.getId());

                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
                    check = true;
                }
            }
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<EventType> getAllEventType() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<EventType> listTypes = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_EVENT_TYPE);
            rs = ps.executeQuery();
            while (rs.next()) {
                int eventTypeID = rs.getInt("eventTypeID");
                String eventTypeName = rs.getString("eventTypeName");

                EventType evtType = new EventType(eventTypeID, eventTypeName);
                listTypes.add(evtType);

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listTypes;
    }

    public List<EventLocation> getAllEventLocation() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<EventLocation> listLocations = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_EVENT_LOCATION);
            rs = ps.executeQuery();
            while (rs.next()) {
                String locationID = rs.getString("locationID");
                String locationName = rs.getString("locationName");

                EventLocation evtLocation = new EventLocation(locationID, locationName);
                listLocations.add(evtLocation);

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listLocations;
    }

    public int getNumberOfParticipants(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int total = 0;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_NUMBER_OF_PARTICIPANTS);
            ps.setString(1, eventID);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return total;
    }

    public boolean updateStatusEventByID(String eventID, boolean status) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE_STATUS_EVENT);
                ps.setBoolean(1, status);
                ps.setString(2, eventID);

                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
                    check = true;

                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<EventPost> getAllOrgEvent(String memberOrgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<EventPost> listEvent = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_EVENT_BY_ORG);
            ps.setString(1, memberOrgID);
            rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("eventID");
                String orgID = rs.getString("orgID");
                String createDate = rs.getString("createDate");
                String takePlaceDate = rs.getString("takePlaceDate");
                String content = rs.getString("content");
                String title = rs.getString("title");
                String location = rs.getString("location");
                String imgUrl = rs.getString("imgUrl");
                String eventType = rs.getString("eventTypeID");
                int numberOfView = rs.getInt("numberOfView");
                String speaker = rs.getString("speaker");
                String summary = rs.getString("summary");
                Boolean status = rs.getBoolean("status");
                String eventTypeName = rs.getString("eventTypeName");
                String locationName = rs.getString("locationName");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");
                String approvalDes = rs.getString("approvalDes");
                int slotID = rs.getInt("slotID");
                String slotTime = rs.getString("slotTime");

                int numberOfParticipants = getNumberOfParticipants(id);
                EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, approvalDes, id, orgID, "", title, content, createDate, imgUrl, numberOfView, summary, status, numberOfParticipants, numberOfParticipants, slotID, slotTime);
                listEvent.add(event);

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listEvent;
    }

    public List<EventPost> getOrgListEventByTitle(String search, String memberOrgID) throws SQLException {
        List<EventPost> listEvent = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_ORG_EVENT_BY_TITLE);
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
                ps.setString(3, memberOrgID);

                rs = ps.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("eventID");
                    String orgID = rs.getString("orgID");
                    String createDate = rs.getString("createDate");
                    String takePlaceDate = rs.getString("takePlaceDate");
                    String content = rs.getString("content");
                    String title = rs.getString("title");
                    String location = rs.getString("location");
                    String imgUrl = rs.getString("imgUrl");
                    String eventType = rs.getString("eventTypeID");
                    int numberOfView = rs.getInt("numberOfView");
                    String speaker = rs.getString("speaker");
                    String summary = rs.getString("summary");
                    Boolean status = rs.getBoolean("status");
                    String eventTypeName = rs.getString("eventTypeName");
                    String locationName = rs.getString("locationName");
                    String statusTypeID = rs.getString("statusTypeID");
                    String statusTypeName = rs.getString("statusTypeName");
                    String approvalDes = rs.getString("approvalDes");
                    int slotID = rs.getInt("slotID");
                    String slotTime = rs.getString("slotTime");
                    EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, eventTypeName, locationName, statusTypeID, statusTypeName, approvalDes, id, orgID, "", title, content, createDate, imgUrl, numberOfView, summary, status, 0, 0, slotID, slotTime);

                    listEvent.add(event);

                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listEvent;
    }

    public List<UserDTO> getAllParticipantsByEventID(String eventID) throws SQLException {
        List<UserDTO> listUser = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_PARTICIPANTS_BY_EVENT_ID);
                ps.setString(1, eventID);

                rs = ps.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("fullName");
                    String email = rs.getString("email");
                    String phoneNumber = rs.getString("phone");
                    String gender = rs.getString("gender");
                    boolean participantCheck = rs.getBoolean("participantCheck");

                    UserDTO participants = new UserDTO("", name, "", email, participantCheck, "", "", gender, phoneNumber, "");
                    listUser.add(participants);

                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listUser;
    }

    public List<UserDTO> getAllActualParticipantsByEventID(String eventID) throws SQLException {
        List<UserDTO> listUser = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_ACTUAL_PARTICIPANTS_BY_EVENT_ID);
                ps.setString(1, eventID);

                rs = ps.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("fullName");
                    String email = rs.getString("email");
                    String phoneNumber = rs.getString("phone");
                    String gender = rs.getString("gender");

                    UserDTO participants = new UserDTO("", name, "", email, true, "", "", gender, phoneNumber, "");
                    listUser.add(participants);

                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listUser;
    }

    public List<SlotTime> getAllSlotTime() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<SlotTime> slotTimeList = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_SLOT_TIME);
                rs = ps.executeQuery();
                while (rs.next()) {
                    int slotID = rs.getInt("slotId");
                    String slotTime = rs.getString("slotTime");
                    slotTimeList.add(new SlotTime(slotID, slotTime));
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return slotTimeList;
    }

    public boolean ConfirmTicket(String userID, String eventID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CONFIRM_TICKET);
                ps.setString(1, userID);
                ps.setString(2, eventID);

                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
                    check = true;
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

}
