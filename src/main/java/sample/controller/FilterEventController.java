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
import javax.servlet.http.HttpSession;
import sample.posts.EventDAO;
import sample.posts.EventPost;
import sample.users.ManagerDTO;

/**
 *
 * @author light
 */
@WebServlet(name = "FilterEventController", urlPatterns = {"/FilterEventController"})
public class FilterEventController extends HttpServlet {

    private static final String ERROR = "";
    private static final String PENDING_PAGE = "Pending";
    private static final String APPROVED_PAGE = "Approved";
    private static final String DECLINED_PAGE = "Declined";
    private static final String ON_GOING_PAGE = "OnGoing";
    private static final String EVENT_TYPE_AND_LOCATION = "EventTypeAndLocationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        List<EventPost> listEvent = null;
        EventDAO eveDao = new EventDAO();
        try {
            HttpSession session = request.getSession();
            ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");

            String type = request.getParameter("type");

            if (PENDING_PAGE.equals(type)) {
                listEvent = eveDao.getAllEventByType("PE", user.getRoleID(), user.getOrgID());
                request.setAttribute("listEvent", listEvent);

            } else if (APPROVED_PAGE.equals(type)) {
                listEvent = eveDao.getAllEventByType("AP", user.getRoleID(), user.getOrgID());
                request.setAttribute("listEvent", listEvent);

            } else if (DECLINED_PAGE.equals(type)) {
                listEvent = eveDao.getAllEventByType("DE", user.getRoleID(), user.getOrgID());
                request.setAttribute("listEvent", listEvent);

            } else if (ON_GOING_PAGE.equals(type)) {
                listEvent = eveDao.getAllEventByType("ON", user.getRoleID(), user.getOrgID());
                request.setAttribute("listEvent", listEvent);
            }

            if (listEvent != null) {
                for (EventPost eventPost : listEvent) {
                    EventPost event = eveDao.getAnEventByID(eventPost.getId());
                    request.setAttribute("event_" + event.getId(), event);
                }
            }
            
            url = EVENT_TYPE_AND_LOCATION;

        } catch (Exception e) {
            log("Error at FilterController " + e.toString());
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
