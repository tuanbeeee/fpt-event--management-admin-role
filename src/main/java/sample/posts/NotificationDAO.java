package sample.posts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sample.users.UserNotification;
import sample.util.DBUtils;

public class NotificationDAO {

    private static final String GET_ALL_NOTIFICATION = "SELECT tblUserNotification.eventID, notiDate, tblUserNotification.content, imgUrl\n"
            + "FROM tblUserNotification, tblEventPost\n"
            + "WHERE userID = ? AND tblUserNotification.eventID = tblEventPost.eventID\n"
            + "ORDER BY userNoti DESC";

    public static List<UserNotification> getAllNotification(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<UserNotification> listNoti = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_NOTIFICATION);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                String userID = id;
                String eventID = rs.getString("eventID");
                String notiDate = rs.getString("notiDate");
                String content = rs.getString("content");
                String imgUrl = rs.getString("imgUrl");
                listNoti.add(new UserNotification(userID, eventID, notiDate, content, imgUrl));
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
        return listNoti;
    }

}
