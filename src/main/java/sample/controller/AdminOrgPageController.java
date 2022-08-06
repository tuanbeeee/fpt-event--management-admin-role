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
import sample.organization.OrganizationDAO;
import sample.organization.OrganizationDTO;
import sample.users.ManagerDTO;
import sample.users.UserDAO;

/**
 *
 * @author light
 */
@WebServlet(name = "AdminOrgPageController", urlPatterns = {"/AdminOrgPageController"})
public class AdminOrgPageController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "Admin_Org.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        List<OrganizationDTO> listOrg = null;
        OrganizationDAO orgDAO = new OrganizationDAO();
        try {
            listOrg = new OrganizationDAO().getAllOrganization();
            request.setAttribute("LIST_ORG", listOrg);

            List<OrganizationDTO> listOnGoingOrg = orgDAO.filterOrg("AP");
            if (listOnGoingOrg != null) {
                for (OrganizationDTO org : listOnGoingOrg) {
                    List<ManagerDTO> listMan = new UserDAO().getManagerByOrg(org.getOrgID());
                    request.setAttribute("LIST_MANAGER_" + org.getOrgID(), listMan);
                }
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at Admin Org Page Controller" + e.toString());
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
