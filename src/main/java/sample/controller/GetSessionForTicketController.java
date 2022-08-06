/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.ManagerDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Tuan Be
 */
@WebServlet(name = "GetSessionForTicketController", urlPatterns = {"/GetSessionForTicketController"})
public class GetSessionForTicketController extends HttpServlet {

    private static final String ERROR = "index.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String userName = null;
        String password = null;
        String url = ERROR;

        if (request.getParameter("username") != null && request.getParameter("password") != null) {
            userName = request.getParameter("username");
            password = request.getParameter("password");
        } else {
            UserDTO userData = (UserDTO) request.getAttribute("userGmail");
            userName = userData.getId();
            password = userData.getId();
        }
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();
        ManagerDTO manager = new ManagerDTO();
        try {
            String userID = request.getParameter("userID");
            String eventID = request.getParameter("eventID");
            String orgID = request.getParameter("orgID");
            System.out.println(userID + eventID);

            manager = dao.checkManagerExist(userName);
            session.setAttribute("LOGIN_USER", manager);
            request.setAttribute("USERID", userID);
            request.setAttribute("EVENTID", eventID);
            request.setAttribute("ORGID", orgID);
            url = "ReadQRCodeController";

        } catch (Exception ex) {
            ex.printStackTrace();
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
