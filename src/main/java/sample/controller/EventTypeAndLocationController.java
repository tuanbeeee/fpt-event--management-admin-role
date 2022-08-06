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
import sample.eventtype.EventType;
import sample.posts.EventDAO;
import sample.posts.EventLocation;
import sample.posts.EventPost;
import sample.slot.SlotTime;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "EventTypeAndLocationController", urlPatterns = {"/EventTypeAndLocationController"})
public class EventTypeAndLocationController extends HttpServlet {

    private static final String UPDATE = "DisplayNotificationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = "error.jsp";
        List<EventType> listTypes;
        List<EventLocation> listLocations;
        List<SlotTime> listSlotTime;
        EventPost event;
        EventDAO evtDao = new EventDAO();
        String eventID;
        try {
            listSlotTime = evtDao.getAllSlotTime();
            listTypes = evtDao.getAllEventType();
            listLocations = evtDao.getAllEventLocation();
            String page = request.getParameter("page");
            
            request.setAttribute("listSlotTime", listSlotTime);
            request.setAttribute("listEventTypes", listTypes);
            request.setAttribute("listEventLocations", listLocations);
            request.setAttribute("page", page);
            url = UPDATE;

        } catch (Exception e) {
            log("Error at EventTypeAndLocationController " + e.toString());
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
