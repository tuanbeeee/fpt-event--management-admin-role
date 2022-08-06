/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.posts.EventDAO;
import sample.posts.EventPost;
import sample.posts.NotificationDAO;
import sample.users.ManagerDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "EventListByClubController", urlPatterns = {"/EventListByOrgController"})
public class EventListByOrgController extends HttpServlet {

    private static final String CLB_PAGE = "FilterEventController";
    private static final String MOD_PAGE = "EventTypeAndLocationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        UserDAO userDao = new UserDAO();
        List<EventPost> listEvent;
        String url = "error.jsp";
        String checkSearch = (String) request.getAttribute("checkSearch");
        try {
            EventDAO evtDao = new EventDAO();
            ManagerDTO manager = userDao.getManagerInfoByID(user.getId());

            if (checkSearch == null) {
                listEvent = evtDao.getAllOrgEvent(manager.getOrgID());
                request.setAttribute("listEvent", listEvent);

            } else {
                listEvent = (List<EventPost>) request.getAttribute("listTitleSearch");
                request.setAttribute("listEvent", listEvent);
            }
            for (EventPost eventPost : listEvent) {
                EventPost event = evtDao.getAnEventByID(eventPost.getId());
                request.setAttribute("event_" + event.getId(), event);
            }
            
            if (manager.getRoleID().equals("MOD")) {
                url = MOD_PAGE;
            } else if (manager.getRoleID().equals("CLB")) {
                url = CLB_PAGE;
            }

        } catch (SQLException ex) {
            Logger.getLogger(EventListController.class.getName()).log(Level.SEVERE, null, ex);
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
