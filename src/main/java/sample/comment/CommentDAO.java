/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import sample.util.DBUtils;

/**
 *
 * @author light
 */
public class CommentDAO {

    private static final String GET_COMMENT_BY_EVENT = "SELECT commentID, replyID, time, content, comt.userID, eventID, us.fullName, us.avatarUrl, us.roleID, ro.roleName ,comt.status\n"
            + "FROM tblCommentSections comt, tblUsers us, tblRoles ro\n"
            + "WHERE comt.eventID = ? AND comt.userID = us.userID AND us.status = '1' AND comt.status = '1' AND ro.roleID = us.roleID";

    private static final String ADD_COMMENT = "INSERT INTO tblCommentSections(status, time, content, userID, eventID, replyID) VALUES(? ,?, ?, ?, ?, ?)";

    private static final String DELETE_COMMENT = "UPDATE tblCommentSections "
            + "SET status = '0' \n"
            + "WHERE commentID = ? or replyID = ?";

    public boolean deleteComment(String commentID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_COMMENT);
                ptm.setInt(1, Integer.parseInt(commentID));
                ptm.setInt(2, Integer.parseInt(commentID));

                if (ptm.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addComment(CommentDTO cmt) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(ADD_COMMENT);
                ptm.setBoolean(1, cmt.isStatus());
                long millis = System.currentTimeMillis();
                java.sql.Timestamp nowDate = new java.sql.Timestamp(millis);
                ptm.setTimestamp(2, nowDate);
                ptm.setString(3, cmt.getContent());
                ptm.setString(4, cmt.getUserID());
                ptm.setString(5, cmt.getEventID());
                if (!cmt.getReplyID().equals("0")) {
                    ptm.setInt(6, Integer.parseInt(cmt.getReplyID()));
                } else {
                     ptm.setNull(6, Types.INTEGER);
                }

                if (ptm.executeUpdate() > 0) {
                    check = true;
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<CommentDTO> getAllComment(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        CommentDTO cmt;
        List<CommentDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_COMMENT_BY_EVENT);
                ptm.setString(1, eventID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String commentID = rs.getString("commentID");
                    String replyID = rs.getString("replyID");
                    String time = rs.getString("time");
                    String content = rs.getString("content");
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    String avatarUrl = rs.getString("avatarUrl");
                    String roleID = rs.getString("roleID");
                    String roleName = rs.getString("roleName");
                    boolean status = rs.getBoolean("status");

                    cmt = new CommentDTO(commentID, replyID, time, content, userID, eventID, fullName, avatarUrl, roleID, roleName, status);
                    list.add(cmt);
                }
            }
        } catch (Exception e) {
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
        return list;
    }
}
