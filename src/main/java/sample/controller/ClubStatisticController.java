/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.organization.OrganizationDAO;
import sample.posts.EventDAO;
import sample.posts.EventPost;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "ClubStatisticController", urlPatterns = {"/ClubStatisticController"})
public class ClubStatisticController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String SUCCESS = "DisplayNotificationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<UserDTO> listFollower = new ArrayList<>();
        List<EventPost> listEvent = new ArrayList<>();
        List<UserDTO> listParticipants = new ArrayList<>();
        List<UserDTO> listActualParticipants = new ArrayList<>();

        OrganizationDAO orgDAO = new OrganizationDAO();
        EventDAO evtDAO = new EventDAO();
        String url = "error.jsp";
        try {
            String orgID = request.getParameter("orgID");
            double totalParticipants = 0;
            double totalActualParticipants = 0;
            listFollower = orgDAO.getAllOrgFollowers(orgID);
            listEvent = evtDAO.getAllOrgEvent(orgID);
            request.setAttribute("listFollower", listFollower);
            request.setAttribute("listEvent", listEvent);

            for (EventPost evt : listEvent) {
                listParticipants = evtDAO.getAllParticipantsByEventID(evt.getId());
                listActualParticipants = evtDAO.getAllActualParticipantsByEventID(evt.getId());

                totalParticipants += listParticipants.size();
                totalActualParticipants += listActualParticipants.size();
            }

            double participationPercentage = (totalActualParticipants / totalParticipants) * 100;
            if (totalParticipants == 0) {
                participationPercentage = 0;
            }

            request.setAttribute("participationPercentage", participationPercentage);
            request.setAttribute("totalParticipants", totalParticipants);
            request.setAttribute("totalActualParticipants", totalActualParticipants);

            url = SUCCESS;
        } catch (Exception e) {
            log("Error at ListLocationController " + e.toString());
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
