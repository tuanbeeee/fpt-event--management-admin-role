/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sample.posts.EventDAO;
import sample.util.DBUtils;

/**
 *
 * @author tvfep
 */
public class EventFeedbackDAO {

    private static final String GET_ALL_FEEDBACK_BY_EVENT_ID = "select userFeedback, userID, eventID, content\n"
            + "from tblUser_Feedback where eventID = ?";
    
    
    public List<EventFeedback> getAllFeedbacksByEventID(String eventID) throws SQLException {
        List<EventFeedback> listFeedbacks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_FEEDBACK_BY_EVENT_ID);
                ps.setString(1, eventID);

                rs = ps.executeQuery();
                while (rs.next()) {
                    int feedbackID = Integer.parseInt(rs.getString("userFeedback"));
                    String userID = rs.getString("userID");
                    String content = rs.getString("content");

                    EventFeedback feedback = new EventFeedback(feedbackID, userID, eventID, content);
                    listFeedbacks.add(feedback);
                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return listFeedbacks;
    }
    
}
