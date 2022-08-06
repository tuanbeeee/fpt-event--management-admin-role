/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import javax.naming.NamingException;
import sample.util.DBUtils;

/**
 *
 * @author light
 */
public class UserDAO {

    private static final String GET_ALL_INFO_WITH_USERID = "SELECT userID, fullName, password, email, status, tblUserTypes.typeID, tblUserTypes.typeName, roleID, gender, phone, avatarUrl FROM tblUsers, tblUserTypes WHERE tblUsers.typeID = tblUserTypes.typeID AND userID=? ";
    private static final String GET_ALL_INFO_WITH_EMAIL = "SELECT userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl FROM tblUsers WHERE email=?";
    private static final String GET_ROLE = "SELECT roleID FROM tblUsers WHERE userID= ? AND password = ? AND status = '1'";
    private static final String SIGN_UP = "INSERT INTO tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_ALL_TYPE = "SELECT typeID, typeName FROM tblUserTypes";
    private static final String GET_ALL_ORG = "SELECT orgID, orgName FROM tblOrgPage WHERE status = '1'";
    private static final String UPDATE_USER_PROFILE = "UPDATE tblUsers SET fullName = ?, email=?, typeID =?, gender=?, phone=?, avatarUrl=? WHERE userID=?";
    private static final String GET_ALL_INFO_MANAGER = "SELECT userID, fullName, password, tblUsers.email, tblUsers.status, tblUsers.roleID, tblRoles.roleName, gender, phone, avatarURL, tblManagers.orgID, tblOrgPage.orgName,tblUserTypes.typeID, tblUserTypes.typeName\n"
            + "FROM tblUsers, tblManagers, tblUserTypes, tblRoles, tblOrgPage\n"
            + "WHERE tblOrgPage.orgID = tblManagers.orgID AND tblUsers.userID = tblManagers.managerID AND tblManagers.managerID = ? AND tblUsers.typeID = tblUserTypes.typeID AND tblRoles.roleID = tblUsers.roleID";

    private static final String GET_ALL_USERS = "SELECT userID, fullName, password, email, status, roleID, gender, phone, avatarUrl, tblUserTypes.typeID, tblUserTypes.typeName "
            + "FROM tblUsers, tblUserTypes "
            + "WHERE tblUsers.typeID = tblUserTypes.typeID AND roleID = 'US'";

    private static final String GET_ALL_MANAGERS = "SELECT userID, fullName, password, tblUsers.email, tblUsers.status, roleID, gender, phone, avatarURL, tblOrgPage.orgID, tblUserTypes.typeID, tblUserTypes.typeName, tblOrgPage.orgName\n"
            + "FROM tblUsers, tblManagers, tblUserTypes, tblOrgPage\n"
            + "WHERE tblUsers.userID = tblManagers.managerID AND tblUsers.typeID = tblUserTypes.typeID AND tblOrgPage.orgID = tblManagers.orgID AND tblUsers.roleID != 'ADM'";

    private static final String SEARCH_USER = "SELECT userID, fullName, password, email, status, roleID, gender, phone, avatarUrl, tblUserTypes.typeID, tblUserTypes.typeName \n"
            + "FROM tblUsers, tblUserTypes\n"
            + "WHERE (ufn_removeMark(fullName) like ufn_removeMark(?) or fullName like ? or userID like ? or tblUsers.typeID like ? or tblUserTypes.typeName like ?) AND tblUsers.typeID = tblUserTypes.typeID AND roleID = 'US'";

    private static final String SEARCH_MANAGER = "SELECT userID, fullName, password, tblUsers.email, tblUsers.status, roleID, gender, phone, avatarURL, tblOrgPage.orgID, tblUserTypes.typeID, tblUserTypes.typeName, tblOrgPage.orgName\n"
            + "from tblUsers, tblManagers, tblUserTypes, tblOrgPage\n"
            + "WHERE tblUsers.userID = tblManagers.managerID AND tblUsers.typeID = tblUserTypes.typeID AND tblOrgPage.orgID = tblManagers.orgID AND tblUsers.roleID != 'ADM' AND (ufn_removeMark(fullName) like ufn_removemark(?) or fullName like ? or tblUsers.userID like ? or ufn_removeMark(tblOrgPage.orgName) like ufn_removeMark(?) or tblOrgPage.orgName like ? or tblOrgPage.orgID like ?)";

    private static final String DELETE_USER = "UPDATE tblUsers SET status = '0' WHERE userID = ?";

    private static final String UPDATE_USER_PROFILE_BY_ADMIN = "UPDATE tblUsers SET fullName = ?, email=?, typeID =?, gender=?, phone=?, password = ?, status = ?\n"
            + "WHERE userID = ?";

    private static final String SIGN_UP_BY_MANAGER = "INSERT INTO tblManagers (managerID, orgID) VALUES (?, ?)";

    private static final String GET_ALL_MANAGER_ID_BY_EVENT = "SELECT managerID \n"
            + "FROM tblEventPost eve, tblOrgPage org, tblManagers man \n"
            + "WHERE eve.orgID = org.orgID AND org.orgID = man.orgID AND eve.eventID = ?";

    private static final String ADD_NOTIFICATION = "INSERT INTO tblUserNotification (userID, eventID, notiDate, content) VALUES (?, ?, ?, ?)";

    private static final String GET_USER_ID_FOLLOWER = "SELECT fl.userID "
            + "FROM tblEventPost eve, tblOrgPage org, tblOrg_Follower fl "
            + "WHERE eve.orgID = org.orgID AND org.orgID = fl.orgID AND eve.eventID = ? AND fl.status = '1'";

    private static final String GET_MANAGER_BY_ID = "SELECT userID, fullName, password, email, tblUsers.status, roleID, gender, phone, avatarURL, orgID, tblUserTypes.typeID, tblUserTypes.typeName\n"
            + "FROM tblUsers, tblManagers, tblUserTypes\n"
            + "WHERE tblManagers.managerID = ? AND tblUsers.userID = tblManagers.managerID AND tblUsers.typeID = tblUserTypes.typeID";

    private static final String UPLOAD_IMAGE = "UPDATE tblUsers SET avatarUrl = ? WHERE userID = ?";

    private static final String GET_ALL_MANAGERS_BY_ROLE = "SELECT userID, fullName, password, tblUsers.email, tblUsers.status, roleID, gender, phone, avatarURL, tblOrgPage.orgID, tblUserTypes.typeID, tblUserTypes.typeName, tblOrgPage.orgName\n"
            + "FROM tblUsers, tblManagers, tblUserTypes, tblOrgPage\n"
            + "WHERE tblUsers.userID = tblManagers.managerID AND tblUsers.typeID = tblUserTypes.typeID AND tblOrgPage.orgID = tblManagers.orgID AND tblUsers.roleID = ?";

    private static final String CREATE_CLUB_MEMBER_WHEN_APPROVED_ORG = "INSERT INTO tblUsers (userID, fullName, password, status, typeID, roleID, email, gender, phone, avatarUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_CLUB_MEMBER_BY_ORG = "SELECT userID, fullName, password, tblUsers.email, tblUsers.status, roleID, gender, phone, avatarURL, tblOrgPage.orgID, tblUserTypes.typeID, tblUserTypes.typeName, tblOrgPage.orgName\n"
            + "FROM tblUsers, tblManagers, tblUserTypes, tblOrgPage\n"
            + "WHERE tblUsers.userID = tblManagers.managerID AND tblUsers.typeID = tblUserTypes.typeID AND tblOrgPage.orgID = tblManagers.orgID AND tblManagers.orgID = ?";

    public List<ManagerDTO> getManagerByOrg(String orgID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ManagerDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_CLUB_MEMBER_BY_ORG);
            ptm.setString(1, orgID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");

                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                String roleID = rs.getString("roleID");
                String orgName = rs.getString("orgName");
                boolean status = rs.getBoolean("status");

                list.add(new ManagerDTO(orgID, orgName, userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl));
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

    public boolean createClubMemberWhenApprovedOrg(ManagerDTO manager) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_CLUB_MEMBER_WHEN_APPROVED_ORG);
                ptm.setString(1, manager.getId());
                ptm.setString(2, manager.getName());
                ptm.setString(3, manager.getPassword());
                ptm.setBoolean(4, manager.isStatus());
                ptm.setString(5, manager.getTypeID());
                ptm.setString(6, manager.getRoleID());
                ptm.setString(7, "");
                ptm.setString(8, "");
                ptm.setString(9, "");
                ptm.setString(10, manager.getPicture());

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

    public boolean updateImage(String path, String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPLOAD_IMAGE);
                ptm.setString(1, path);
                ptm.setString(2, userID);

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

    public ManagerDTO getManagerInfoByID(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ManagerDTO manager = new ManagerDTO();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_MANAGER_BY_ID);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            if (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                String orgID = rs.getString("orgID");
                boolean status = rs.getBoolean("status");
                manager = new ManagerDTO(orgID, userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl);
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
        return manager;
    }

    public List<String> getAllFollower(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_ID_FOLLOWER);
                ptm.setString(1, eventID);
                rs = ptm.executeQuery();

                while (rs.next()) {
                    String userID = rs.getString("userID");

                    list.add(userID);
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

    public boolean addNoti(UserNotification userNoti) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(ADD_NOTIFICATION);
                ptm.setString(1, userNoti.getUserID());
                ptm.setString(2, userNoti.getEventID());
              //  ptm.setString(3, userNoti.getNotiDate());
                ptm.setObject(3, LocalDate.parse(userNoti.getNotiDate()));
                ptm.setString(4, userNoti.getContent());

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

    public List<String> getAllManagerIDByEvent(String eventID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ALL_MANAGER_ID_BY_EVENT);
                ptm.setString(1, eventID);
                rs = ptm.executeQuery();

                while (rs.next()) {
                    String managerID = rs.getString("managerID");
                    list.add(managerID);
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

    public UserDTO checkUserExist(String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        UserDTO user = null;
        UserDTO getInfoUser = null;
        try {
            String sql = GET_ALL_INFO_WITH_USERID;
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, userID);
            rs = ptm.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String email = rs.getString("email");
                boolean status = rs.getBoolean("status");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phone = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");

                user = new UserDTO(userID, fullName, password, email, status, typeID, typeName, roleID, gender, phone, avatarUrl);
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
        return user;

    }

    public ManagerDTO checkManagerExist(String managerID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ManagerDTO getInfoManager = null;
        try {
            String sql = GET_ALL_INFO_MANAGER;
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, managerID);
            rs = ptm.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String email = rs.getString("email");
                boolean status = rs.getBoolean("status");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String roleName = rs.getString("roleName");
                String gender = rs.getString("gender");
                String phone = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");

                getInfoManager = new ManagerDTO(orgID, orgName, managerID, fullName, password, email, status, typeID, typeName, roleID, gender, phone, avatarUrl);
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
        return getInfoManager;

    }

    public UserDTO checkEmailExist(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        UserDTO user = null;
        try {
            String sql = GET_ALL_INFO_WITH_EMAIL;
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, email);
            rs = ptm.executeQuery();

            if (rs.next()) {
                String userID = rs.getString("userID");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                boolean status = rs.getBoolean("status");
                String typeID = rs.getString("typeID");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phone = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");

                user = new UserDTO(userID, fullName, password, email, status, typeID, roleID, gender, gender, phone, avatarUrl);

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
        return user;

    }

    public boolean updateUserProfile(UserDTO user) throws SQLException, NamingException {
        Connection conn = null;
        PreparedStatement ptm = null;
        String sql = UPDATE_USER_PROFILE;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(sql);

                ptm.setString(1, user.getName());
                ptm.setString(2, user.getEmail());
                ptm.setString(3, user.getTypeID());
                ptm.setString(4, user.getGender());
                ptm.setString(5, user.getPhoneNumber());
                ptm.setString(6, user.getPicture());
                ptm.setString(7, user.getId());

                ptm.executeUpdate();

                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    public boolean updateUserProfileByAdmin(UserDTO user) throws SQLException, NamingException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_USER_PROFILE_BY_ADMIN);

                ptm.setString(1, user.getName());
                ptm.setString(2, user.getEmail());
                ptm.setString(3, user.getTypeID());
                ptm.setString(4, user.getGender());
                ptm.setString(5, user.getPhoneNumber());
                ptm.setString(6, user.getPassword());
                ptm.setBoolean(7, user.isStatus());
                ptm.setString(8, user.getId());

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

    public String authenticateUser(String userID, String password) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            String sql = GET_ROLE;
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, userID);
            ptm.setString(2, password);

            rs = ptm.executeQuery();

            if (rs.next()) {
                String roleDB = rs.getString("roleID");

                if (roleDB.equals("CLB")) {
                    return "CLB";
                } else if (roleDB.equals("MOD")) {
                    return "MOD";
                } else if (roleDB.equals("US")) {
                    return "US";
                } else if (roleDB.equals("ADM")) {
                    return "ADM";
                }
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

        return "Invalid user !";
    }

    public ArrayList<UserDTO> getAllUserType() throws Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String sql = GET_ALL_TYPE;

        ArrayList<UserDTO> lst = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(sql);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String typeID = rs.getString("typeID");
                    String typeName = rs.getString("typeName");

                    UserDTO cb = new UserDTO(typeID, typeName);

                    lst.add(cb);
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
        return lst;
    }

    public ArrayList<ManagerDTO> getAllOrg() throws Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String sql = GET_ALL_ORG;

        ArrayList<ManagerDTO> lst = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(sql);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String orgID = rs.getString("orgID");
                    String orgName = rs.getString("orgName");

                    ManagerDTO cb = new ManagerDTO(orgID, orgName);

                    lst.add(cb);
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
        return lst;
    }

    public boolean signUpByUser(UserDTO user) throws Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;
        String sql = SIGN_UP;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, user.getId());
            ptm.setString(2, user.getName());
            ptm.setString(3, user.getPassword());
            ptm.setString(4, user.getEmail());
            ptm.setBoolean(5, user.isStatus());
            ptm.setString(6, user.getTypeID());
            ptm.setString(7, user.getRoleID());
            ptm.setString(8, user.getGender());
            ptm.setString(9, user.getPhoneNumber());
            ptm.setString(10, user.getPicture());
            if (ptm.executeUpdate() > 0) {
                check = true;
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
        return check;
    }

    public boolean signUpByManager(ManagerDTO user) throws Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;
        String sql = SIGN_UP_BY_MANAGER;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, user.getId());
            ptm.setString(2, user.getOrgID());

            if (ptm.executeUpdate() > 0) {
                check = true;
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
        return check;
    }

    public boolean checkInputPhoneNumber(String phoneNumber) {
        Pattern p = Pattern.compile("^[0-9]{10}$");
        if (p.matcher(phoneNumber).find()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean checkInputMail(String mail) {
        Pattern p = Pattern.compile("^[a-zA-Z][a-zA-Z0-9]+@[a-zA-Z]+(\\.[a-zA-Z]+){1,3}$");
        if (p.matcher(mail).find()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean checkInputUserID(String userID) {
        Pattern p = Pattern.compile("^[a-zA-Z0-9]{3,32}$");
        if (p.matcher(userID).find()) {
            return true;
        } else {
            return false;
        }
    }

    public List<UserDTO> getAllUsers() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<UserDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_ALL_USERS);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                boolean status = rs.getBoolean("status");
                list.add(new UserDTO(userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl));
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

    public List<ManagerDTO> getAllManagers() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ManagerDTO> list = new ArrayList<>();
        try {

            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_ALL_MANAGERS);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                boolean status = rs.getBoolean("status");

                list.add(new ManagerDTO(orgID, orgName, userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl));
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

    public List<UserDTO> searchUser(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<UserDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_USER);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ptm.setString(3, "%" + search + "%");
            ptm.setString(4, "%" + search + "%");
            ptm.setString(5, "%" + search + "%");

            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                boolean status = rs.getBoolean("status");
                list.add(new UserDTO(userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl));
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

    public List<ManagerDTO> searchManager(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ManagerDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_MANAGER);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ptm.setString(3, "%" + search + "%");
            ptm.setString(4, "%" + search + "%");
            ptm.setString(5, "%" + search + "%");
            ptm.setString(6, "%" + search + "%");

            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");
                String roleID = rs.getString("roleID");
                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                boolean status = rs.getBoolean("status");

                list.add(new ManagerDTO(orgID, orgName, userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl));
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

    public boolean deleteUser(String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DELETE_USER);
            ptm.setString(1, userID);
            if (ptm.executeUpdate() > 0) {
                check = true;
            } else {
                check = false;
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

    public List<ManagerDTO> getAllManagersByRole(String roleID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ManagerDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_ALL_MANAGERS_BY_ROLE);
            ptm.setString(1, roleID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String typeID = rs.getString("typeID");
                String typeName = rs.getString("typeName");

                String gender = rs.getString("gender");
                String phoneNumber = rs.getString("phone");
                String avatarUrl = rs.getString("avatarUrl");
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                boolean status = rs.getBoolean("status");

                list.add(new ManagerDTO(orgID, orgName, userID, fullName, password, email, status, typeID, typeName, roleID, gender, phoneNumber, avatarUrl));
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
