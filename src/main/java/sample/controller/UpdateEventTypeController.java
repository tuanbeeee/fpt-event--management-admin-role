/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.eventtype.EventType;
import sample.eventtype.EventTypeDAO;


/**
 *
 * @author light
 */
@WebServlet(name = "UpdateEventTypeController", urlPatterns = {"/UpdateEventTypeController"})
public class UpdateEventTypeController extends HttpServlet {

    private static final String ERROR = "DisplayNotificationController";
    private static final String SUCCESS = "DisplayNotificationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        EventType evtType = null;
        EventTypeDAO dao = new EventTypeDAO();
        
        try {
            int locationID = Integer.parseInt(request.getParameter("eventTypeID"));
            String locationName = request.getParameter("eventTypeName");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            evtType = new EventType(locationID, locationName, status);
            if(dao.updateEventType(evtType)) {
                url = SUCCESS;
                request.setAttribute("LIST_EVENT_TYPE", dao.getListEventType());   
            }
            
        } catch (Exception e) {
            e.printStackTrace();
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
