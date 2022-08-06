/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.eventtype;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.util.DBUtils;

/**
 *
 * @author light
 */
public class EventTypeDAO {
    private static final String LIST_EVENT_TYPE = "SELECT eventTypeID, eventTypeName, status\n"
            + "FROM tblEventType";
        private static final String DELETE_EVENT_TYPE = "UPDATE tblEventType SET status = '0' WHERE eventTypeID = ?";
    private static final String SEARCH_EVENT_TYPE = "SELECT eventTypeID, eventTypeName, status FROM tblEventType WHERE ufn_removeMark(eventTypeName) like ufn_removeMark(?) OR eventTypeName like ?";
    private static final String CREATE_EVENT_TYPE = "INSERT INTO tblEventType(eventTypeName, status) VALUES (?, ?)";
    private static final String UPDATE_EVENT_TYPE = "UPDATE tblEventType SET eventTypeName = ?, status = ? WHERE eventTypeID = ?";

          public boolean updateEventType(EventType eventType) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_EVENT_TYPE );
                ptm.setString(1, eventType.getEventTypeName());
                ptm.setBoolean(2, eventType.isStatus());
                ptm.setInt(3, eventType.getEventTypeID());
                
                if(ptm.executeUpdate() > 0) {
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

    
    public boolean createEventType(EventType eventType) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_EVENT_TYPE );
                ptm.setString(1, eventType.getEventTypeName());
                ptm.setBoolean(2, eventType.isStatus());
                if(ptm.executeUpdate() > 0) {
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

    public List<EventType> searchEventTypeName(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<EventType> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_EVENT_TYPE);
                ptm.setString(1, "%" + search + "%");
                ptm.setString(2, "%" + search + "%");

                rs = ptm.executeQuery();
                while (rs.next()) {
                    int eventTypeID = rs.getInt("eventTypeID");
                    String eventTypeName = rs.getString("eventTypeName");
                    boolean status = rs.getBoolean("status");

                    EventType eventType = new EventType(eventTypeID, eventTypeName, status);
                    list.add(eventType);
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
        return list;
    }

    public boolean deleteEventType(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_EVENT_TYPE);
                ptm.setInt(1, Integer.parseInt(id));
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

    
        public List<EventType> getListEventType() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<EventType> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_EVENT_TYPE);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int eventTypeID = rs.getInt("eventTypeID");
                    String eventTypeName = rs.getString("eventTypeName");
                    boolean status = rs.getBoolean("status");

                    EventType evtType = new EventType(eventTypeID, eventTypeName, status);
                    list.add(evtType);
                }
            }
        } catch (Exception e) {
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
