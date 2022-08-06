/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
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
import sample.organization.OrganizationDAO;
import sample.users.ManagerDTO;
import sample.users.UserDAO;

/**
 *
 * @author light
 */
@WebServlet(name = "DeleteOrgController", urlPatterns = {"/DeleteOrgController"})
public class DeleteOrgController extends HttpServlet {

    private static final String ERROR = "AdminOrgPageController";
    private static final String SUCCESS = "AdminOrgPageController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        OrganizationDAO orgDAO = new OrganizationDAO();
        UserDAO userDAO = new UserDAO();
        try {
            String orgID = request.getParameter("id");
            if(orgDAO.deleteOrg(orgID)) {
                List<ManagerDTO> listMan = userDAO.getManagerByOrg(orgID);
                for (ManagerDTO man : listMan) {
                    userDAO.deleteUser(man.getId());
                }
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at DeleteOrgController " + e.toString());
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
