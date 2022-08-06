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
import sample.ticket.TicketDAO;
import sample.ticket.TicketDTO;
import sample.users.ManagerDTO;

/**
 *
 * @author Tuan Be
 */
@WebServlet(name = "ReadQRCodeController", urlPatterns = {"/ReadQRCodeController"})
public class ReadQRCodeController extends HttpServlet {

    public static final String SUCCCESS = "User_Ticket_Confirm.jsp";
    public static final String ERROR = "index.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        try {
            String userID;
            String eventID;
            String orgID;
            String check = "GET";
            if ("TRUE".equals(request.getAttribute("TICKET_CONFIRM"))) {
                eventID = (String) request.getAttribute("eventID");
                userID = (String) request.getAttribute("userID");
                orgID = (String) request.getAttribute("orgID");
                request.setAttribute("CONFIRM", "TRUE");
                check = "CONFIRM";
            } else {
                userID = request.getParameter("userID");
                eventID = request.getParameter("eventID");
                orgID = request.getParameter("orgID");
            }

            if (userID == null && eventID == null) {
                userID = (String) request.getAttribute("USERID");
                eventID = (String) request.getAttribute("EVENTID");
                orgID = (String) request.getAttribute("ORGID");
            }
            ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");

            if (user == null) {
                request.setAttribute("USERID", userID);
                request.setAttribute("EVENTID", eventID);
                request.setAttribute("ORGID", orgID);
                url = ERROR;
            } else if (user.getOrgID().equals(orgID)) {

                TicketDTO dto = new TicketDTO();
                TicketDAO dao = new TicketDAO();
                dto = dao.getInfoForTiket(eventID, userID, check);
                request.setAttribute("participantsConfirm", dto);
                url = SUCCCESS;
            } else if (!user.getOrgID().equals(orgID)) {
                request.setAttribute("USERID", userID);
                request.setAttribute("EVENTID", eventID);
                request.setAttribute("ORGID", orgID);
                request.setAttribute("ERROR", "You dont have permission to access this site !");
                url = ERROR;
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
