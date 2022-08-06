/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "ApproveOrgController", urlPatterns = {"/ApproveOrgController"})
public class ApproveOrgController extends HttpServlet {

    private static final String ERROR = "AdminOrgPageController";
    private static final String SUCCESS = "AdminOrgPageController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        OrganizationDAO orgDAO = new OrganizationDAO();
        UserDAO userDAO = new UserDAO();
        ManagerDTO manager = new ManagerDTO();
        List<ManagerDTO> list = new ArrayList<>();
        try {
            String orgID = request.getParameter("id");
            OrganizationDTO orgObject = new OrganizationDAO().getOrganization(orgID);
            
            String type = request.getParameter("type");
            if (orgDAO.approveOrg(type, orgID)) {
                manager.setName(orgObject.getOrgName());
                manager.setPassword("1");
                manager.setStatus(true);
                manager.setTypeID("STU");
                manager.setRoleID("CLB");
                manager.setOrgID(orgID);
                manager.setPicture(orgObject.getImgUrl());
                for (int i = 0; i < 3; i++) {
                    manager.setId(orgID + "_0" + (i + 1));
                    userDAO.createClubMemberWhenApprovedOrg(manager);
                    userDAO.signUpByManager(manager);
                }
                
                url = SUCCESS;
            }

        } catch (Exception e) {
            log("Error at Approve Org Controller " + e.toString());
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
