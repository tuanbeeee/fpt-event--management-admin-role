/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
import sample.posts.EventDAO;
import sample.posts.EventPost;
import sample.users.ManagerDTO;

/**
 *
 * @author light
 */
@WebServlet(name = "SearchDateController", urlPatterns = {"/SearchDateController"})
public class SearchDateController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "EventTypeAndLocationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        EventDAO evtDao = new EventDAO();
        try {
            String beginDate = request.getParameter("fromdate");
            String endDate = request.getParameter("enddate");
            HttpSession session = request.getSession();
            ManagerDTO man = (ManagerDTO) session.getAttribute("LOGIN_USER");

            List<EventPost> evt = evtDao.searchEventByDate(beginDate, endDate, man.getOrgID());
            if (evt != null) {
                for (EventPost eventPost : evt) {
                    EventPost event = evtDao.getAnEventByID(eventPost.getId());
                    request.setAttribute("event_" + event.getId(), event);
                }
                request.setAttribute("listEvent", evt);
                request.setAttribute("fromdate", beginDate);
                request.setAttribute("enddate", endDate);

                url = SUCCESS;
            }

        } catch (Exception e) {
            log("Error at Search Date Controller " + e.toString());
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
