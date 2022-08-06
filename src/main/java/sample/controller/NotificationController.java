/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.organization.OrganizationDAO;
import sample.posts.EventDAO;
import sample.users.UserDAO;
import sample.users.UserNotification;

/**
 *
 * @author light
 */
@WebServlet(name = "NotificationController", urlPatterns = {"/NotificationController"})
public class NotificationController extends HttpServlet {

    private static final String ERROR = "";
    private static final String SUCCESS = "DetailController";
    private static final String APPROVE = "ApproveEvent";
    private static final String DECLINE = "DeclineEvent";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserDAO userDao = new UserDAO();
        List<String> listManagerID = null;
        List<String> listFollower = null;
        EventDAO eveDao = new EventDAO();
        UserNotification userNoti = new UserNotification();
        try {
            String action = request.getParameter("action");
            String eventID = request.getParameter("eventID");
            String declineDescription = request.getParameter("declineDescription");

            if (APPROVE.equals(action)) {
                listManagerID = userDao.getAllManagerIDByEvent(eventID); //lấy danh sách ManagerID
                for (String managerID : listManagerID) {
                    String content = "#" + eventID + " has been APPROVED!!";
                    long millis = System.currentTimeMillis();
                    java.sql.Date notiDate = new java.sql.Date(millis);
                    
                    userNoti = new UserNotification(managerID, eventID, notiDate.toString(), content);
                    userDao.addNoti(userNoti);
                }

                listFollower = userDao.getAllFollower(eventID); // lấy danh sách Follơer
                String orgName = new OrganizationDAO().getOrgNameByEventID(eventID);           //lấy tên org       
                for (String followerID : listFollower) {
                    String content = orgName + " has new Event! Check it out!"; //content
                    long millis = System.currentTimeMillis();
                    java.sql.Date notiDate = new java.sql.Date(millis);
                    
                    userNoti = new UserNotification(followerID, eventID, notiDate.toString(), content);
                    userDao.addNoti(userNoti);
                }

                url = SUCCESS;

            } else if (DECLINE.equals(action)) {
                listManagerID = userDao.getAllManagerIDByEvent(eventID); //lấy danh sách ManagerID
                for (String managerID : listManagerID) {
                    String content = "#" + eventID + " has been DECLINED!!";
                    long millis = System.currentTimeMillis();
                    java.sql.Date notiDate = new java.sql.Date(millis);
                    
                    userNoti = new UserNotification(managerID, eventID, notiDate.toString(), content);
                    userDao.addNoti(userNoti);
                }

                eveDao.addDeclineDescription(eventID, declineDescription);

                url = SUCCESS;
            }

        } catch (Exception e) {
            log("Error at NotificationController " + e.toString());
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
