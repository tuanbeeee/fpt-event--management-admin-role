/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.posts.NotificationDAO;
import sample.users.ManagerDTO;
import sample.users.UserDTO;
import sample.users.UserNotification;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "DisplayNotificationController", urlPatterns = {"/DisplayNotificationController"})
public class DisplayNotificationController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String MOD_PAGE = "Mod_Event.jsp";
    private static final String CLB_PAGE = "Club_Event.jsp";
    private static final String CLB_BLOG_PAGE = "Club_Blog.jsp";
    private static final String EVENT_DETAIL_PAGE = "Club_Event_Detail.jsp";
    private static final String BLOG_DETAIL_PAGE = "Club_Blog_Detail.jsp";
    private static final String ADM_PROFILE = "Admin_Profile.jsp";
    private static final String ADM_LOCATION = "Mod_Location.jsp";
    private static final String MOD_EVENT_TYPE = "Mod_EventType.jsp";
    private static final String EVENT_STATISTIC = "Club_Statistic.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<UserNotification> listNoti = null;
        HttpSession session = request.getSession();
        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        String url = ERROR;
        try {
            listNoti = NotificationDAO.getAllNotification(user.getId());
            request.setAttribute("USER_NOTIFICATION", listNoti);
            String action = request.getParameter("action");
            if ("MOD".equals(user.getRoleID())) {
                if ("ListEvent".equals(action)
                        || "SearchEvent".equals(action)
                        || "CreateEvent".equals(action)
                        || "UpdateEvent".equals(action)
                        || "DeleteEvent".equals(action)
                        || "FilterEvent".equals(action)
                        || "ListOrgEvent".equals(action)
                        || "SearchDate".equals(action)) {
                    url = MOD_PAGE;
                } else if ("EventDetail".equals(action) || "ApproveEvent".equals(action)
                        || "DeclineEvent".equals(action) || "Comment".equals(action)
                        || "ReplyComment".equals(action) || "DeleteComment".equals(action)) {
                    url = EVENT_DETAIL_PAGE;
                } else if ("ListBlog".equals(action)
                        || "UpdateBlog".equals(action)
                        || "SearchBlog".equals(action)
                        || "DeleteBlog".equals(action)
                        || "CreateBlog".equals(action)) {
                    url = CLB_BLOG_PAGE;
                } else if ("BlogDetail".equals(action)) {
                    url = BLOG_DETAIL_PAGE;
                } else if ("AdminProfile".equals(action) || "UpdateAdminProfile".equals(action)) {
                    url = ADM_PROFILE;
                } else if ("ListLocation".equals(action) || "DeleteLocation".equals(action)
                        || "SearchLocation".equals(action) || "CreateLocation".equals(action)
                        || "UpdateLocation".equals(action)) {
                    url = ADM_LOCATION;

                } else if ("ListEventType".equals(action) || "DeleteEventType".equals(action)
                        || "SearchEventType".equals(action) || "CreateEventType".equals(action)
                        || "UpdateEventType".equals(action)) {
                    url = MOD_EVENT_TYPE;
                } else if ("ClubStatistic".equals(action)) {
                    url = EVENT_STATISTIC;
                }

            } else if ("CLB".equals(user.getRoleID())) {
                if ("ListOrgEvent".equals(action) || "SearchOrgEvent".equals(action)
                        || "CreateEvent".equals(action)
                        || "UpdateEvent".equals(action)
                        || "DeleteEvent".equals(action)
                        || "FilterEvent".equals(action)
                        || "SearchDate".equals(action)) {
                    url = CLB_PAGE;
                } else if ("EventDetail".equals(action) || "Comment".equals(action)
                        || "ReplyComment".equals(action) || "DeleteComment".equals(action)) {
                    url = EVENT_DETAIL_PAGE;
                } else if ("ListBlog".equals(action)
                        || "CreateBlog".equals(action)
                        || "UpdateBlog".equals(action)
                        || "DeleteBlog".equals(action)
                        || "SearchBlog".equals(action)) {
                    url = CLB_BLOG_PAGE;
                } else if ("BlogDetail".equals(action)) {
                    url = BLOG_DETAIL_PAGE;

                } else if ("AdminProfile".equals(action) || "UpdateAdminProfile".equals(action)) {
                    url = ADM_PROFILE;
                } else if ("ClubStatistic".equals(action)) {
                    url = EVENT_STATISTIC;
                }

            } else if ("ADM".equals(user.getRoleID())) {
                url = ADM_PROFILE;
            }

        } catch (Exception e) {
            log("Error at DisplayNotificationController " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
