/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.location;

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
public class LocationDAO {

    private static final String GET_ALL_LOCATION = "SELECT locationID, locationName, status FROM tblLocation";
    private static final String DELETE_LOCATION = "UPDATE tblLocation SET status = '0' WHERE locationID = ?";
    private static final String SEARCH_LOCATION = "SELECT locationID, locationName, status FROM tblLocation WHERE ufn_removeMark(locationName) like ufn_removeMark(?) OR locationName like ?";
    private static final String CREATE_LOCATION = "INSERT INTO tblLocation(locationName, status) VALUES (?, ?)";
    private static final String UPDATE_LOCATION = "UPDATE tblLocation SET locationName = ?, status = ? WHERE locationID = ?";

        public boolean updateLocation(Location location) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_LOCATION );
                ptm.setString(1, location.getLocationName());
                ptm.setBoolean(2, location.isStatus());
                ptm.setInt(3, location.getLocationID());
                
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

    
    public boolean createLocation(Location location) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_LOCATION );
                ptm.setString(1, location.getLocationName());
                ptm.setBoolean(2, location.isStatus());
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

    public List<Location> searchLocationName(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Location> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_LOCATION);
                ptm.setString(1, "%" + search + "%");
                ptm.setString(2, "%" + search + "%");

                rs = ptm.executeQuery();
                while (rs.next()) {
                    int locationID = rs.getInt("locationID");
                    String locationName = rs.getString("locationName");
                    boolean status = rs.getBoolean("status");

                    Location location = new Location(locationID, locationName, status);
                    list.add(location);
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

    public boolean deleteLocation(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_LOCATION);
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

    public List<Location> getListLocation() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Location> listLocation = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ALL_LOCATION);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int locationID = rs.getInt("locationID");
                    String locationName = rs.getString("locationName");
                    boolean status = rs.getBoolean("status");

                    Location location = new Location(locationID, locationName, status);
                    listLocation.add(location);
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
        return listLocation;
    }

}
