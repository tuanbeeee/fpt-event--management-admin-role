/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author light
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class MainController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String TICKET_CONFIRM = "TicketConfirm";
    private static final String TICKET_CONFIRM_CONTROLLER = "TicketConfirmController";

    private static final String READ_QR_CODE = "readQRCode";
    private static final String READ_QR_CODE_CONTROLLER = "ReadQRCodeController";

    private static final String GET_SESSION_FOR_TICKET = "LoginToCheckTicket";
    private static final String GET_SESSION_FOR_TICKET_CONTROLLER = "GetSessionForTicketController";

    private static final String SEARCH_DATE = "SearchDate";
    private static final String SEARCH_DATE_CONTROLLER = "SearchDateController";

    private static final String UPLOAD_IMAGE = "UploadImage";
    private static final String UPLOAD_IMAGE_CONTROLLER = "UploadImageController";

    private static final String FILTER_ORG = "FilterOrg";
    private static final String FILTER_ORG_CONTROLLER = "FilterOrgController";

    private static final String LIST_EVENT = "ListEvent";
    private static final String LIST_EVENT_CONTROLLER = "EventListController";

    private static final String LIST_LOCATION = "ListLocation";
    private static final String LIST_LOCATION_CONTROLLER = "ListLocationController";

    private static final String LIST_ORG_EVENT = "ListOrgEvent";
    private static final String LIST_ORG_EVENT_CONTROLLER = "EventListByOrgController";

    private static final String SEARCH_EVENT = "SearchEvent";
    private static final String SEARCH_CONTROLLER = "SearchController";

    private static final String EVENT_DETAIL = "EventDetail";
    private static final String DETAIL_CONTROLLER = "DetailController";

    private static final String CREATE_EVENT = "CreateEvent";
    private static final String CREATE_EVENT_CONTROLLER = "AddAnEventController";

    private static final String UPDATE_EVENT = "UpdateEvent";
    private static final String UPDATE_EVENT_CONTROLLER = "UpdateEventController";

    private static final String DELETE_AN_EVENT = "DeleteEvent";
    private static final String DELETE_AN_EVENT_CONTROLLER = "DeleteAnEventController";

    private static final String EVT_TYPE_AND_LOCALTION = "EventTypeAndLocation";
    private static final String EVT_TYPE_AND_LOCALTION_CONTROLLER = "EventTypeAndLocationController";

    private static final String LIST_BLOG = "ListBlog";
    private static final String LIST_BLOG_CONTROLLER = "BlogListController";

    private static final String BLOG_DETAIL = "BlogDetail";
    private static final String BLOG_DETAIL_CONTROLLER = "BlogDetailController";

    private static final String SEARCH_BLOG = "SearchBlog";
    private static final String SEARCH_BLOG_CONTROLLER = "SearchBlogController";

    private static final String CREATE_BLOG = "CreateBlog";
    private static final String CREATE_BLOG_CONTROLLER = "AddAnBlogController";

    private static final String UPDATE_BLOG = "UpdateBlog";
    private static final String UPDATE_BLOG_CONTROLLER = "UpdateBlogController";

    private static final String DELETE_A_BLOG = "DeleteBlog";
    private static final String DELETE_BLOG_CONTROLLER = "DeleteBlogController";

    private static final String SEARCH_EVENT_BY_ORG = "SearchOrgEvent";
    private static final String SEARCH_EVENT_BY_ORG_CONTROLLER = "SearchEventByOrgController";

    private static final String ERROR = "error.jsp";
    private static final String SEARCH_ORG = "SearchOrg";
    private static final String SEARCH_ORG_CONTROLLER = "SearchOrgController";
    private static final String SEARCH_USER = "SearchUser";
    private static final String SEARCH_USER_CONTROLLER = "SearchUserController";
    private static final String SEARCH_MANAGER = "SearchManager";
    private static final String SEARCH_MANAGER_CONTROLLER = "SearchManagerController";

    private static final String CREATE_ORGANIZATION = "CreateOrg";
    private static final String CREATE_ORGANIZATION_CONTROLLER = "CreateOrgController";
    private static final String CREATE_USER = "CreateUser";
    private static final String CREATE_USER_CONTROLLER = "RegisterController";
    private static final String CREATE_MANAGER = "CreateManager";
    private static final String CREATE_MANAGER_CONTROLLER = "CreateManagerController";

    private static final String DELETE_USER = "DeleteUser";
    private static final String DELETE_USER_CONTROLLER = "DeleteUserController";
    private static final String DELETE_ORG = "DeleteOrg";
    private static final String DELETE_ORG_CONTROLLER = "DeleteOrgController";
    private static final String DELETE_MANAGER = "DeleteManager";
    private static final String DELETE_MANAGER_CONTROLLER = "DeleteManagerController";

    private static final String UPDATE_ORG = "UpdateOrg";
    private static final String UPDATE_ORG_CONTROLLER = "UpdateOrgController";
    private static final String UPDATE_USER = "UpdateUser";
    private static final String UPDATE_USER_CONTROLLER = "UpdateUserController";
    private static final String UPDATE_MANAGER = "UpdateManager";
    private static final String UPDATE_MANAGER_CONTROLLER = "UpdateManagerController";

    private static final String ADMIN_USER_PAGE = "AdminUserPage";
    private static final String ADMIN_USER_PAGE_CONTROLLER = "AdminUserPageController";
    private static final String ADMIN_MANAGER_PAGE = "AdminManagerPage";
    private static final String ADMIN_MANAGER_PAGE_CONTROLLER = "AdminManagerPageController";
    private static final String ADMIN_ORG_PAGE = "AdminOrgPage";
    private static final String ADMIN_ORG_PAGE_CONTROLLER = "AdminOrgPageController";

    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String LOGIN = "Login";
    private static final String REGISTER_CONTROLLER = "RegisterController";
    private static final String REGISTER = "Register";
    private static final String LOGIN_PAGE_CONTROLLER = "login.jsp";
    private static final String LOGIN_PAGE = "loginpage";

    private static final String DATA_TYPE_CONTROLLER = "UserDataController";
    private static final String DATA_TYPE = "dataType";

    private static final String PROFILE_PAGE_CONTROLLER = "profile.jsp";
    private static final String PROFILE_PAGE = "profilepage";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String LOGOUT = "Logout";
    private static final String HOME_PAGE_CONTROLLER = "homepage.jsp";
    private static final String HOME_PAGE = "homepage";
    private static final String USER_UPDATE_PROFILE_CONTROLLER = "UpdateProfileController";
    private static final String USER_UPDATE_PROFILE = "updateprofile";

    private static final String APPROVE_EVENT = "ApproveEvent";
    private static final String APPROVE_EVENT_CONTROLLER = "ApproveEventController";

    private static final String DECLINE_EVENT = "DeclineEvent";
    private static final String DECLINE_EVENT_CONTROLLER = "ApproveEventController";

    private static final String FILTER_EVENT = "FilterEvent";
    private static final String FILTER_EVENT_CONTROLLER = "FilterEventController";

    private static final String COMMENT = "Comment";
    private static final String COMMENT_CONTROLLER = "CommentController";

    private static final String REPLY_COMMENT = "ReplyComment";
    private static final String REPLY_COMMENT_CONTROLLER = "CommentController";

    private static final String DELETE_COMMENT = "DeleteComment";
    private static final String DELETE_COMMENT_CONTROLLER = "DeleteCommentController";

    private static final String UPDATE_ADMIN_PROFILE = "UpdateAdminProfile";
    private static final String UPDATE_ADMIN_PROFILE_CONTROLLER = "UpdateManagerController";

    private static final String ADMIN_PROFILE = "AdminProfile";
    private static final String ADMIN_PROFILE_CONTROLLER = "DisplayNotificationController";

    private static final String LIST_PARTICIPANTS = "ListParticipants";
    private static final String LIST_PARTICIPANTS_CONTROLLER = "ListParticipantsController";

    private static final String DELETE_LOCATION = "DeleteLocation";
    private static final String DELETE_LOCATION_CONTROLLER = "DeleteLocationController";

    private static final String UPDATE_LOCATION = "UpdateLocation";
    private static final String UPDATE_LOCATION_CONTROLLER = "UpdateLocationController";

    private static final String CREATE_LOCATION = "CreateLocation";
    private static final String CREATE_LOCATION_CONTROLLER = "CreateLocationController";

    private static final String SEARCH_LOCATION = "SearchLocation";
    private static final String SEARCH_LOCATION_CONTROLLER = "SearchLocationController";

    private static final String LIST_EVENT_TYPE = "ListEventType";
    private static final String LIST_EVENT_TYPE_CONTROLLER = "ListEventTypeController";

    private static final String DELETE_EVENT_TYPE = "DeleteEventType";
    private static final String DELETE_EVENT_TYPE_CONTROLLER = "DeleteEventTypeController";

    private static final String UPDATE_EVENT_TYPE = "UpdateEventType";
    private static final String UPDATE_EVENT_TYPE_CONTROLLER = "UpdateEventTypeController";

    private static final String CREATE_EVENT_TYPE = "CreateEventType";
    private static final String CREATE_EVENT_TYPE_CONTROLLER = "CreateEventTypeController";

    private static final String SEARCH_EVENT_TYPE = "SearchEventType";
    private static final String SEARCH_EVENT_TYPE_CONTROLLER = "SearchEventTypeController";

    private static final String APPROVE_ORG = "ApproveOrg";
    private static final String APPROVE_ORG_CONTROLLER = "ApproveOrgController";

    private static final String LIST_FEEDBACK = "ListFeedbacks";
    private static final String LIST_FEEDBACK_CONTROLLER = "EventFeedbackController";

    private static final String CLUB_STATISTIC = "ClubStatistic";
    private static final String CLUB_STATISTIC_CONTROLLER = "ClubStatisticController";

    private static final String CLUB_FOLLOWER = "ClubFollower";
    private static final String CLUB_FOLLOWER_CONTROLLER = "ClubFollowerController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {

            String action = request.getParameter("action");
            switch (action) {
                case (SEARCH_ORG):
                    url = SEARCH_ORG_CONTROLLER;
                    break;
                case (SEARCH_USER):
                    url = SEARCH_USER_CONTROLLER;
                    break;
                case (SEARCH_MANAGER):
                    url = SEARCH_MANAGER_CONTROLLER;
                    break;
                case (CREATE_ORGANIZATION):
                    url = CREATE_ORGANIZATION_CONTROLLER;
                    break;
                case (DELETE_USER):
                    url = DELETE_USER_CONTROLLER;
                    break;
                case (DELETE_ORG):
                    url = DELETE_ORG_CONTROLLER;
                    break;
                case (DELETE_MANAGER):
                    url = DELETE_MANAGER_CONTROLLER;
                    break;
                case (ADMIN_MANAGER_PAGE):
                    url = ADMIN_MANAGER_PAGE_CONTROLLER;
                    break;
                case (ADMIN_ORG_PAGE):
                    url = ADMIN_ORG_PAGE_CONTROLLER;
                    break;
                case (ADMIN_USER_PAGE):
                    url = ADMIN_USER_PAGE_CONTROLLER;
                    break;
                case (UPDATE_ORG):
                    url = UPDATE_ORG_CONTROLLER;
                    break;
                case (UPDATE_USER):
                    url = UPDATE_USER_CONTROLLER;
                    break;
                case (LOGIN):
                    url = LOGIN_CONTROLLER;
                    break;
                case (REGISTER):
                    url = REGISTER_CONTROLLER;
                    break;
                case (LOGIN_PAGE):
                    url = LOGIN_PAGE_CONTROLLER;
                    break;
                case (DATA_TYPE):
                    url = DATA_TYPE_CONTROLLER;
                    break;
                case (PROFILE_PAGE):
                    url = PROFILE_PAGE_CONTROLLER;
                    break;
                case (LOGOUT):
                    url = LOGOUT_CONTROLLER;
                    break;
                case (HOME_PAGE):
                    url = HOME_PAGE_CONTROLLER;
                    break;
                case (USER_UPDATE_PROFILE):
                    url = USER_UPDATE_PROFILE_CONTROLLER;
                    break;
                case (CREATE_USER):
                    url = CREATE_USER_CONTROLLER;
                    break;
                case (CREATE_MANAGER):
                    url = CREATE_MANAGER_CONTROLLER;
                    break;
                case (UPDATE_MANAGER):
                    url = UPDATE_MANAGER_CONTROLLER;
                    break;
                case (SEARCH_EVENT):
                    url = SEARCH_CONTROLLER;
                    break;
                case (EVENT_DETAIL):
                    url = DETAIL_CONTROLLER;
                    break;
                case (CREATE_EVENT):
                    url = CREATE_EVENT_CONTROLLER;
                    break;
                case (EVT_TYPE_AND_LOCALTION):
                    url = EVT_TYPE_AND_LOCALTION_CONTROLLER;
                    break;
                case (LIST_EVENT):
                    url = LIST_EVENT_CONTROLLER;
                    break;
                case (LIST_BLOG):
                    url = LIST_BLOG_CONTROLLER;
                    break;
                case (BLOG_DETAIL):
                    url = BLOG_DETAIL_CONTROLLER;
                    break;
                case (SEARCH_BLOG):
                    url = SEARCH_BLOG_CONTROLLER;
                    break;
                case (APPROVE_EVENT):
                    url = APPROVE_EVENT_CONTROLLER;
                    break;
                case (DECLINE_EVENT):
                    url = DECLINE_EVENT_CONTROLLER;
                    break;
                case (FILTER_EVENT):
                    url = FILTER_EVENT_CONTROLLER;
                    break;
                case (UPDATE_EVENT):
                    url = UPDATE_EVENT_CONTROLLER;
                    break;
                case (DELETE_AN_EVENT):
                    url = DELETE_AN_EVENT_CONTROLLER;
                    break;
                case (CREATE_BLOG):
                    url = CREATE_BLOG_CONTROLLER;
                    break;
                case (UPDATE_BLOG):
                    url = UPDATE_BLOG_CONTROLLER;
                    break;
                case (DELETE_A_BLOG):
                    url = DELETE_BLOG_CONTROLLER;
                    break;
                case (SEARCH_EVENT_BY_ORG):
                    url = SEARCH_EVENT_BY_ORG_CONTROLLER;
                    break;
                case (LIST_ORG_EVENT):
                    url = LIST_ORG_EVENT_CONTROLLER;
                    break;
                case (COMMENT):
                    url = COMMENT_CONTROLLER;
                    break;
                case (REPLY_COMMENT):
                    url = REPLY_COMMENT_CONTROLLER;
                    break;
                case (DELETE_COMMENT):
                    url = DELETE_COMMENT_CONTROLLER;
                    break;
                case (UPDATE_ADMIN_PROFILE):
                    url = UPDATE_ADMIN_PROFILE_CONTROLLER;
                    break;
                case (ADMIN_PROFILE):
                    url = ADMIN_PROFILE_CONTROLLER;
                    break;
                case (LIST_PARTICIPANTS):
                    url = LIST_PARTICIPANTS_CONTROLLER;
                    break;
                case (LIST_LOCATION):
                    url = LIST_LOCATION_CONTROLLER;
                    break;
                case (DELETE_LOCATION):
                    url = DELETE_LOCATION_CONTROLLER;
                    break;
                case (UPDATE_LOCATION):
                    url = UPDATE_LOCATION_CONTROLLER;
                    break;
                case (CREATE_LOCATION):
                    url = CREATE_LOCATION_CONTROLLER;
                    break;
                case (SEARCH_LOCATION):
                    url = SEARCH_LOCATION_CONTROLLER;
                    break;
                case (LIST_EVENT_TYPE):
                    url = LIST_EVENT_TYPE_CONTROLLER;
                    break;
                case (DELETE_EVENT_TYPE):
                    url = DELETE_EVENT_TYPE_CONTROLLER;
                    break;
                case (UPDATE_EVENT_TYPE):
                    url = UPDATE_EVENT_TYPE_CONTROLLER;
                    break;
                case (CREATE_EVENT_TYPE):
                    url = CREATE_EVENT_TYPE_CONTROLLER;
                    break;
                case (SEARCH_EVENT_TYPE):
                    url = SEARCH_EVENT_TYPE_CONTROLLER;
                    break;
                case (APPROVE_ORG):
                    url = APPROVE_ORG_CONTROLLER;
                    break;
                case (LIST_FEEDBACK):
                    url = LIST_FEEDBACK_CONTROLLER;
                    break;
                case (CLUB_STATISTIC):
                    url = CLUB_STATISTIC_CONTROLLER;
                    break;

                case (FILTER_ORG):
                    url = FILTER_ORG_CONTROLLER;
                    break;
                case (UPLOAD_IMAGE):
                    url = UPLOAD_IMAGE_CONTROLLER;
                    break;
                case (CLUB_FOLLOWER):
                    url = CLUB_FOLLOWER_CONTROLLER;
                    break;
                case (SEARCH_DATE):
                    url = SEARCH_DATE_CONTROLLER;
                    break;

                case (READ_QR_CODE):
                    url = READ_QR_CODE_CONTROLLER;
                    break;
                case (GET_SESSION_FOR_TICKET):
                    url = GET_SESSION_FOR_TICKET_CONTROLLER;
                    break;

                case (TICKET_CONFIRM):
                    url = TICKET_CONFIRM_CONTROLLER;
                    break;
            }
        } catch (Exception e) {
            log("Error at MainController" + e.toString());
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
