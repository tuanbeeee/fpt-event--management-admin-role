/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sample.ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import sample.util.DBUtils;

/**
 *
 * @author Tuan Be
 */
public class TicketDAO {

    private static final String GET_INFO_FOR_TICKET = "SELECT fullName, avatarURL,\n"
            + "            	   content, tblEventPost.orgID AS org_ID, location, takePlaceDate, tblEventPost.eventTypeID AS event_TypeID, speaker,   \n"
            + "            	   eventTypeName, tblEventType.eventTypeID AS evt_TypeID,\n"
            + "            	   locationName, tblLocation.locationID AS location_ID,\n"
            + "            	   orgName, tblOrgPage.orgID AS orgid,\n"
            + "            	   QRCode,\n"
            + "                    slottime \n"
            + "            	   FROM tblUsers, tblEventPost, tblEventType, tblLocation, tblorgpage, tblparticipants, tblslot\n"
            + "            	   WHERE tblOrgPage.orgID = tblEventPost.orgID AND \n"
            + "            			 location = tblLocation.locationID AND \n"
            + "            			 tblEventPost.eventTypeID = tblEventType.eventTypeID AND tblParticipants.userID = tblUsers.userID AND\n"
            + "                                tblEventPost.eventID = tblParticipants.eventID AND\n"
            + "                                tbleventpost.slotid = tblslot.slotid AND\n"
            + "            			 tblUsers.status = '1' AND tblEventPost.statusTypeID = 'AP' AND tblEventPost.status = '1' AND\n"
            + "            			 tblEventType.status = '1' AND  tblLocation.status = '1' AND tblOrgPage.status = '1' AND \n"
            + "                                tblparticipants.eventID = ? AND tblparticipants.userID = ? AND participantcheck = ? AND tblparticipants.status = '1'";

    public TicketDTO getInfoForTiket(String eventID, String userID, String check) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        TicketDTO ticket = new TicketDTO();
        boolean participantCheck = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_INFO_FOR_TICKET);
            
            if ("CONFIRM".equals(check)){
                participantCheck = true;
            }
            
            ptm.setString(1, eventID);
            ptm.setString(2, userID);
            ptm.setBoolean(3, participantCheck);
            
            
            rs = ptm.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("fullName");
                String avatarURL = rs.getString("avatarURL");
                String title = rs.getString("content");
                String org_ID = rs.getString("org_ID");
                String location = rs.getString("location");
                String takePlaceDate = rs.getString("takePlaceDate");
                String eventTypeID = rs.getString("event_TypeID");
                String speaker = rs.getString("speaker");
                String eventTypeName = rs.getString("eventTypeName");
                String evt_TypeID = rs.getString("evt_TypeID");
                String locationName = rs.getString("locationName");
                String location_ID = rs.getString("location_ID");
                String orgName = rs.getString("orgName");
                String orgid = rs.getString("orgid");
                String qrCode = rs.getString("qrCode");
                String slotTime = rs.getString("slottime");

                ticket = new TicketDTO(fullName, avatarURL, title, org_ID, location, takePlaceDate, eventTypeID, speaker, eventTypeName, evt_TypeID, locationName, location_ID, orgName, orgid, qrCode, slotTime, userID, eventID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return ticket;
    }

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        TicketDTO t = new TicketDTO();
        TicketDAO d = new TicketDAO();
        t = d.getInfoForTiket("EVT1", "Haisan", "");
        System.out.println(t);
    }
}
