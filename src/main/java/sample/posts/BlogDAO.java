package sample.posts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sample.util.DBUtils;

public class BlogDAO {

    private static final String GET_ALL_BLOG = "SELECT blogID, tblBlog.orgID, orgName, tblBlog.status, title, tblBlog.createDate, content, tblBlog.imgUrl, numberOfView, summary\n"
            + "FROM tblBlog, tblOrgPage WHERE tblBlog.orgID = tblOrgPage.orgID";
    private static final String GET_A_BLOG_BY_ID = "SELECT blogID, tblBlog.orgID, orgName, tblBlog.status, title, tblBlog.createDate, content, tblBlog.imgUrl, numberOfView, summary \n"
            + "FROM tblBlog, tblOrgPage WHERE blogID = ? AND tblOrgPage.orgID = tblBlog.orgID";

    private static final String GET_ALL_BLOG_BY_ORG = "SELECT blogID, tblBlog.orgID, orgName, tblBlog.status, title, tblBlog.createDate, content, tblBlog.imgUrl, numberOfView, summary\n"
            + " FROM tblBlog, tblOrgPage WHERE tblBlog.orgID = tblOrgPage.orgID AND tblBlog.orgID = ?";

    private static final String GET_ALL_BLOG_BY_TITLE = "SELECT blogID, tblBlog.orgID, tblBlog.status, title, tblBlog.createDate, content, tblBlog.imgUrl, numberOfView, summary, orgName \n"
            + "FROM tblBlog, tblOrgPage WHERE (ufn_removeMark(title) LIKE ufn_removeMark(?) OR title LIKE ? or ufn_removeMark(orgName) like ufn_removeMark(?) or orgName like ?) AND tblBlog.orgID = tblOrgPage.orgID";

    private static final String CHECK_BLOG_DUPLICATE = "SELECT blogID FROM tblBlog where blogID = ?";

    private static final String ADD_A_BLOG = "INSERT INTO public.tblblog(\n"
            + "	blogid, orgid, status, title, createdate, content, imgurl, numberofview, summary)\n"
            + "	VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";

    private static final String UPDATE_A_BLOG = "UPDATE tblBlog\n"
            + "   SET title = ?\n"
            + "      ,content = ?\n"
            + "      ,imgUrl = ?\n"
            + "      ,summary = ?\n"
            + " WHERE blogID = ?";

    private static final String UPDATE_A_BLOG_BY_MOD = "UPDATE tblBlog\n"
            + "   SET title = ?\n"
            + "      ,content = ?\n"
            + "      ,imgUrl = ?\n"
            + "      ,summary = ?\n"
            + "      ,status = ?\n"
            + " WHERE blogID = ?";

    private static final String DELETE_A_BLOG = "UPDATE tblBlog\n"
            + "   SET status = ?\n"
            + " WHERE blogID = ?";

    private static final String GET_ALL_ORG_BLOG_BY_TITLE = "SELECT blogID, tblBlog.orgID, tblBlog.status, title, tblBlog.createDate, content, tblBlog.imgUrl, numberOfView, summary, orgName \n"
            + "FROM tblBlog, tblOrgPage WHERE (ufn_removeMark(title) LIKE ufn_removeMark(?) OR title LIKE ? or ufn_removeMark(orgName) like ufn_removeMark(?) or orgName like ?) AND tblBlog.orgID = ? AND tblBlog.orgID = tblOrgPage.orgID";

    private static final String UPDATE_BLOG_STATUS = "UPDATE tblBlog\n"
            + " SET status = ?\n"
            + " WHERE blogID = ?";

    public List<Blog> getAllBlog(String memberOrgID, String memberRoleID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String Mod = "MOD";
        List<Blog> listBlog = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (memberRoleID.equals(Mod)) {
                ps = conn.prepareStatement(GET_ALL_BLOG);
            } else {
                ps = conn.prepareStatement(GET_ALL_BLOG_BY_ORG);
                ps.setString(1, memberOrgID);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("blogID");
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                String createDate = rs.getString("createDate");
                String content = rs.getString("content");
                String title = rs.getString("title");
                String imgUrl = rs.getString("imgUrl");
                int numberOfView = rs.getInt("numberOfView");
                String summary = rs.getString("summary");
                Boolean status = rs.getBoolean("status");

                Blog blog = new Blog(id, orgID, orgName, title, content, createDate, imgUrl, numberOfView, summary, status);
                listBlog.add(blog);
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
        return listBlog;
    }

    public Blog getAnBlogByID(String blogID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        Blog blog = new Blog();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_A_BLOG_BY_ID);
            ps.setString(1, blogID);
            rs = ps.executeQuery();
            if (rs.next()) {
                String id = rs.getString("blogID");
                String orgID = rs.getString("orgID");
                String orgName = rs.getString("orgName");
                String createDate = rs.getString("createDate");
                String content = rs.getString("content");
                String title = rs.getString("title");
                String imgUrl = rs.getString("imgUrl");
                int numberOfView = rs.getInt("numberOfView");
                String summary = rs.getString("summary");
                Boolean status = rs.getBoolean("status");

                blog = new Blog(id, orgID, orgName, title, content, createDate, imgUrl, numberOfView, summary, status);
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
        return blog;
    }

    public List<Blog> getListBlogByTitle(String search, String memberOrgID, String memberRoleID) throws SQLException {
        List<Blog> listBlog = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String Mod = "MOD";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (memberRoleID.equals(Mod)) {
                    ps = conn.prepareStatement(GET_ALL_BLOG_BY_TITLE);
                    ps.setString(1, "%" + search + "%");
                    ps.setString(2, "%" + search + "%");
                    ps.setString(3, "%" + search + "%");
                    ps.setString(4, "%" + search + "%");

                } else {
                    ps = conn.prepareStatement(GET_ALL_ORG_BLOG_BY_TITLE);
                    ps.setString(1, "%" + search + "%");
                    ps.setString(2, "%" + search + "%");
                    ps.setString(3, "%" + search + "%");
                    ps.setString(4, "%" + search + "%");

                    ps.setString(5, memberOrgID);
                }

                rs = ps.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("blogID");
                    String orgID = rs.getString("orgID");
                    String createDate = rs.getString("createDate");
                    String content = rs.getString("content");
                    String title = rs.getString("title");
                    String imgUrl = rs.getString("imgUrl");
                    int numberOfView = rs.getInt("numberOfView");
                    String summary = rs.getString("summary");
                    Boolean status = rs.getBoolean("status");
                    String orgName = rs.getString("orgName");

                    Blog blog = new Blog(id, orgID, orgName, title, content, createDate, imgUrl, numberOfView, summary, status);
                    listBlog.add(blog);
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
        return listBlog;

    }

    public boolean checkBlogIDDuplicate(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean check = true;
        String checkID = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_BLOG_DUPLICATE);
                ps.setString(1, id);
                rs = ps.executeQuery();
                while (rs.next()) {
                    checkID = rs.getString("blogID");
                }
                if (checkID == null) {
                    check = false;
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
        return check;
    }

    public boolean createABlog(Blog blog) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(ADD_A_BLOG);
                ps.setString(1, blog.getId());
                ps.setString(2, blog.getOrgID());
                ps.setBoolean(3, blog.isStatus());
                ps.setString(4, blog.getTitle());
                ps.setObject(5, LocalDate.parse(blog.getCreateDate()));
                ps.setString(6, blog.getContent());
                ps.setString(7, blog.getImgUrl());
                ps.setInt(8, blog.getNumberOfView());
                ps.setString(9, blog.getSummary());
                if (ps.executeUpdate() > 0) {
                    check = true;
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
        return check;
    }

    public boolean updateBlogStatus(String blogID, boolean status) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE_BLOG_STATUS);
                ps.setBoolean(1, status);
                ps.setString(2, blogID);

                if (ps.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public boolean updateABlog(Blog blog, String roleID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if ("MOD".equals(roleID)) {
                    ps = conn.prepareStatement(UPDATE_A_BLOG_BY_MOD);
                    ps.setBoolean(5, blog.isStatus());
                    ps.setString(6, blog.getId());
                } else {
                    ps = conn.prepareStatement(UPDATE_A_BLOG);
                    ps.setString(5, blog.getId());

                }

                ps.setString(1, blog.getTitle());
                ps.setString(2, blog.getContent());
                ps.setString(3, blog.getImgUrl());
                ps.setString(4, blog.getSummary());

                if (ps.executeUpdate() > 0) {
                    check = true;
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
        return check;
    }

    public boolean deleteABlogByID(String blogID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(DELETE_A_BLOG);
                ps.setBoolean(1, false);
                ps.setString(2, blogID);

                if (ps.executeUpdate() > 0) {
                    check = true;
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
        return check;
    }
}
