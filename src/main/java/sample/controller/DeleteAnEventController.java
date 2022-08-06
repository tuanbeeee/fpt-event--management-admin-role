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
import javax.servlet.http.HttpSession;
import sample.posts.EventDAO;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "DeleteAnEventController", urlPatterns = {"/DeleteAnEventController"})
public class DeleteAnEventController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String CLB_PAGE = "EventListByOrgController";
    private static final String MOD_PAGE = "EventListController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        EventDAO evtDao = new EventDAO();
        String url = ERROR;
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
        try {
            String eventID = request.getParameter("eventID");
            String page = request.getParameter("page");
            if ("Club_Event.jsp".equals(page)) {
                if (user.getRoleID().equals("CLB")) {
                    if (evtDao.updateStatusEventByID(eventID, false)) {
                        request.setAttribute("SUCCESS", "success");
                        url = CLB_PAGE;
                    }
                } else if (user.getRoleID().equals("MOD")) {
                    if (evtDao.updateStatusEventByID(eventID, false)) {
                        request.setAttribute("SUCCESS", "success");
                        url = MOD_PAGE;
                    }
                }

            } else {

                if (evtDao.updateStatusEventByID(eventID, false)) {
                    request.setAttribute("SUCCESS", "success");

                }

                url = "MainController?action=EventDetail&eventID=" + eventID;
            }

        } catch (Exception e) {
            log("Error at DeleteAnEventController " + e.toString());
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
