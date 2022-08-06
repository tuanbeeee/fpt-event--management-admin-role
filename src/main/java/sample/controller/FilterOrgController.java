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
import sample.organization.OrganizationDTO;
import sample.users.ManagerDTO;
import sample.users.UserDAO;

/**
 *
 * @author light
 */
@WebServlet(name = "FilterOrgController", urlPatterns = {"/FilterOrgController"})
public class FilterOrgController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String PENDING_PAGE = "Pending";
    private static final String APPROVED_PAGE = "Approved";
    private static final String DECLINED_PAGE = "Declined";
    private static final String ON_GOING_PAGE = "OnGoing";
    private static final String ORG_PAGE = "Admin_Org.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        OrganizationDAO orgDAO = new OrganizationDAO();
        List<OrganizationDTO> listOrg = null;
        try {
            String type = request.getParameter("type");

            if (PENDING_PAGE.equals(type)) {
                listOrg = orgDAO.filterOrg("PE");
                request.setAttribute("LIST_ORG", listOrg);

            } else if (APPROVED_PAGE.equals(type)) {
                listOrg = orgDAO.filterOrg("AP");
                request.setAttribute("LIST_ORG", listOrg);
                if (listOrg != null) {
                    for (OrganizationDTO org : listOrg) {
                        List<ManagerDTO> listMan = new UserDAO().getManagerByOrg(org.getOrgID());
                        request.setAttribute("LIST_MANAGER_" + org.getOrgID(), listMan);
                    }
                }

            } else if (DECLINED_PAGE.equals(type)) {
                listOrg = orgDAO.filterOrg("DE");
                request.setAttribute("LIST_ORG", listOrg);

            } else if (ON_GOING_PAGE.equals(type)) {
                listOrg = orgDAO.filterOrg("ON");
                request.setAttribute("LIST_ORG", listOrg);
                if (listOrg != null) {
                    for (OrganizationDTO org : listOrg) {
                        List<ManagerDTO> listMan = new UserDAO().getManagerByOrg(org.getOrgID());
                        request.setAttribute("LIST_MANAGER_" + org.getOrgID(), listMan);
                    }
                }
            }
            
            url = ORG_PAGE;
            
        } catch (Exception e) {
            log("Error at Filter Org Controller " + e.toString());
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
