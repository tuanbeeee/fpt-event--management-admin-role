/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.organization;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.users.UserDTO;
import sample.util.DBUtils;

/**
 *
 * @author light
 */
public class OrganizationDAO {

    private static final String GET_ALL_ORGANIZATION = "SELECT orgID, orgName, createDate, description, imgUrl, email, status, tblOrgPage.statusTypeID, tblStatusType.statusTypeName\n"
            + "FROM tblOrgPage, tblStatusType\n"
            + "WHERE tblStatusType.statusTypeID = tblOrgPage.statusTypeID";

    private static final String SEARCH_ORGANIZATION = "SELECT  orgID, orgName, createDate, description, imgUrl, email, status, tblOrgPage.statusTypeID, tblStatusType.statusTypeName\n"
            + "             FROM tblOrgPage, tblStatusType\n"
            + "             WHERE (ufn_removeMark(orgName) like ufn_removeMark(?) or orgName like ? or orgID like ?) AND tblStatusType.statusTypeID = tblOrgPage.statusTypeID";

    private static final String CREATE_ORGANIZATION = "INSERT INTO tblOrgPage (orgID, status, orgName, createDate, description, email, statusTypeID, imgUrl)\n"
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_ID_ORGANIZATION = "SELECT orgID, orgName, createDate, email, description, imgUrl, status\n"
            + "FROM tblOrgPage\n"
            + "WHERE orgID = ?";

    private static final String DELETE_ORGANIZATION = "UPDATE tblOrgPage SET status = '0' WHERE orgID = ?";

    private static final String UPDATE_ORGANIZATION = "UPDATE tblOrgPage "
            + "SET orgID = ?, orgName = ?, description = ?, status = ? "
            + "WHERE orgID = ?";

    private static final String GET_ORG_NAME_BY_EVENT_ID = "SELECT org.orgName "
            + "FROM tblOrgPage org, tblEventPost eve "
            + "WHERE eve.eventID = ? AND eve.orgID = org.orgID";

    private static final String UPLOAD_IMAGE = "UPDATE tblOrgPage SET imgUrl = ? WHERE orgID = ?";

    private static final String APPROVE_ORG = "UPDATE tblOrgPage\n"
            + "SET statusTypeID = ?\n"
            + "WHERE orgID = ?";

//    private static final String GET_ON_GOING_ORGANIZARTION = "SELECT orgID, orgName, createDate, description, imgUrl, email, status, tblOrgPage.statusTypeID, tblStatusType.statusTypeName\n"
//            + "FROM tblOrgPage, tblStatusType\n"
//            + "WHERE tblStatusType.statusTypeID = tblOrgPage.statusTypeID AND tblOrgPage.statusTypeID = 'AP'";
    private static final String FILTER_ORG = "SELECT orgID, orgName, createDate, description, imgUrl, email, status, tblOrgPage.statusTypeID, tblStatusType.statusTypeName\n"
            + "FROM tblOrgPage, tblStatusType\n"
            + "WHERE tblStatusType.statusTypeID = tblOrgPage.statusTypeID AND tblOrgPage.statusTypeID = ?";

    private static final String ON_GOING_ORG = "SELECT orgID, orgName, createDate, description, imgUrl, email, status, tblOrgPage.statusTypeID, tblStatusType.statusTypeName\n"
            + "FROM tblOrgPage, tblStatusType\n"
            + "WHERE tblStatusType.statusTypeID = tblOrgPage.statusTypeID AND tblOrgPage.statusTypeID = ? AND status = '1'";

    private static final String GET_ALL_ORG_FOLLOWER = "select tblUsers.userID, fullName, gender, email, phone, avatarUrl, tblUserTypes.typeName from tblOrg_Follower, tblUsers, tblUserTypes\n"
            + "where tblOrg_Follower.userID = tblUsers.userID and tblUsers.typeID = tblUserTypes.typeID and tblOrg_Follower.orgID = ?";

    public List<OrganizationDTO> filterOrg(String type) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<OrganizationDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if ("ON".equals(type)) {
                ptm = conn.prepareStatement(ON_GOING_ORG);
                ptm.setString(1, "AP");
            } else {
                ptm = conn.prepareStatement(FILTER_ORG);
                ptm.setString(1, type);
            }
            rs = ptm.executeQuery();
            while (rs.next()) {
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                String createDate = rs.getString("createDate");
                String description = rs.getString("description");
                String imgUrl = rs.getString("imgUrl");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");
                String email = rs.getString("email");
                boolean status = rs.getBoolean("status");

                list.add(new OrganizationDTO(orgID, orgName, createDate, description, imgUrl, email, statusTypeID, statusTypeName, status));
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

//    public List<OrganizationDTO> getOnGoingOrganization() throws SQLException {
//        Connection conn = null;
//        PreparedStatement ptm = null;
//        ResultSet rs = null;
//        List<OrganizationDTO> list = new ArrayList<>();
//        try {
//            conn = DBUtils.getConnection();
//            ptm = conn.prepareStatement(GET_ON_GOING_ORGANIZARTION);
//            rs = ptm.executeQuery();
//            while (rs.next()) {
//                String orgID = rs.getString("orgID");
//                String orgName = rs.getString("orgName");
//                String createDate = rs.getString("createDate");
//                String description = rs.getString("description");
//                String imgUrl = rs.getString("imgUrl");
//                String statusTypeID = rs.getString("statusTypeID");
//                String statusTypeName = rs.getString("statusTypeName");
//                String email = rs.getString("email");
//                boolean status = rs.getBoolean("status");
//
//                list.add(new OrganizationDTO(orgID, orgName, createDate, description, imgUrl, email, statusTypeID, statusTypeName, status));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (ptm != null) {
//                ptm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return list;
//    }
    public boolean approveOrg(String type, String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(APPROVE_ORG);
                ptm.setString(1, type);
                ptm.setString(2, orgID);
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

    public boolean updateImage(String path, String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPLOAD_IMAGE);
                ptm.setString(1, path);
                ptm.setString(2, orgID);

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

    public String getOrgNameByEventID(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String orgName = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_ORG_NAME_BY_EVENT_ID);
            ptm.setString(1, eventID);
            rs = ptm.executeQuery();

            if (rs.next()) {
                orgName = rs.getString("orgName");
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
        return orgName;
    }

    public List<OrganizationDTO> getAllOrganization() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<OrganizationDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_ALL_ORGANIZATION);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                String createDate = rs.getString("createDate");
                String description = rs.getString("description");
                String imgUrl = rs.getString("imgUrl");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");
                String email = rs.getString("email");
                boolean status = rs.getBoolean("status");

                list.add(new OrganizationDTO(orgID, orgName, createDate, description, imgUrl, email, statusTypeID, statusTypeName, status));
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

    public List<OrganizationDTO> searchOrganization(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<OrganizationDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_ORGANIZATION);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ptm.setString(3, "%" + search + "%");
            rs = ptm.executeQuery();
            while (rs.next()) {
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                String createDate = rs.getString("createDate");
                String description = rs.getString("description");
                String statusTypeID = rs.getString("statusTypeID");
                String statusTypeName = rs.getString("statusTypeName");
                String email = rs.getString("email");
                String imgUrl = rs.getString("imgUrl");
                boolean status = rs.getBoolean("status");

                list.add(new OrganizationDTO(orgID, orgName, createDate, description, imgUrl, email, statusTypeID, statusTypeName, status));
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

    public OrganizationDTO getOrganization(String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        OrganizationDTO org = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ID_ORGANIZATION);
                ptm.setString(1, orgID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String orgName = rs.getString("orgName");
                    String createDate = rs.getString("createDate");
                    String description = rs.getString("description");
                    String email = rs.getString("email");
                    String imgUrl = rs.getString("imgUrl");
                    boolean status = rs.getBoolean("status");
                    org = new OrganizationDTO(orgID, orgName, createDate, description, imgUrl, email, status);
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
        return org;
    }

    public boolean createOrg(OrganizationDTO org) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_ORGANIZATION);
                ptm.setString(1, org.getOrgID());
                ptm.setBoolean(2, org.isStatus());
                ptm.setString(3, org.getOrgName());
                Date importDate = Date.valueOf(org.getCreateDate());
                ptm.setDate(4, importDate);
                ptm.setString(5, org.getDescription());
                ptm.setString(6, org.getEmail());
                ptm.setString(7, org.getStatusTypeID());
                ptm.setString(8, org.getImgUrl());

                if (ptm.executeUpdate() > 0) {
                    check = true;
                } else {
                    check = false;
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

    public boolean deleteOrg(String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_ORGANIZATION);
                ptm.setString(1, orgID);
                if (ptm.executeUpdate() > 0) {
                    check = true;
                } else {
                    check = false;
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

    public boolean updateOrg(OrganizationDTO org, String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_ORGANIZATION);
                ptm.setString(1, org.getOrgID());
                ptm.setString(2, org.getOrgName());
                ptm.setString(3, org.getDescription());
                ptm.setBoolean(4, org.isStatus());
                ptm.setString(5, orgID);

                if (ptm.executeUpdate() > 0) {
                    check = true;
                } else {
                    check = false;
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

    public List<UserDTO> getAllOrgFollowers(String OrgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<UserDTO> listFollower = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_ALL_ORG_FOLLOWER);
            ptm.setString(1, OrgID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("userID");
                String name = rs.getString("fullName");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phone");
                String picture = rs.getString("avatarUrl");
                String typeName = rs.getString("typeName");
                String gender = rs.getString("gender");
                listFollower.add(new UserDTO(id, name, "", email, true, "", typeName, "", gender, phoneNumber, picture));
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
        return listFollower;
    }

}
