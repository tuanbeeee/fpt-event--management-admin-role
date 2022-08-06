/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import sample.organization.OrganizationDAO;
import sample.organization.OrganizationDTO;
import sample.organization.OrganizationError;
import sample.users.ManagerDTO;
import sample.users.UserDAO;

/**
 *
 * @author light
 */
@WebServlet(name = "CreateOrgController", urlPatterns = {"/CreateOrgController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class CreateOrgController extends HttpServlet {

    private static final String ERROR = "Admin_OrgForm.jsp";
    private static final String SUCCESS = "AdminOrgPageController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = ERROR;
        boolean check = true;
        OrganizationDTO orgDTO = null;
        OrganizationDAO orgDAO = new OrganizationDAO();
        OrganizationError orgError = new OrganizationError();
        ManagerDTO manager = new ManagerDTO();
        UserDAO userDAO = new UserDAO();

        try {
            String orgID = request.getParameter("orgID");
            String orgName = request.getParameter("orgName");
            String description = request.getParameter("description");
            String email = request.getParameter("email");
            Boolean status = Boolean.parseBoolean(request.getParameter("status"));
            long millis = System.currentTimeMillis();
            java.sql.Date createDate = new java.sql.Date(millis);

            //=================CHECK==================== 
            if (orgDAO.getOrganization(orgID) != null) {
                orgError.setOrgIDError("The ID has been exist");
                check = false;
            } else if (orgID.length() != 3) {
                orgError.setOrgIDError("The ID must have 3 character!!");
                check = false;
            }

            Part filePart = request.getPart("image");
            String realPath = request.getServletContext().getRealPath("/Image");
            String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (!Files.exists(Paths.get(realPath))) {
                Files.createDirectory(Paths.get(realPath));
            }
            String path = "";
            if (!"".equals(filename)) {
                filePart.write(realPath + "/" + filename);
                path = "Image\\" + filename;
            }

            //==========================================
            if (check) {
                orgDTO = new OrganizationDTO(orgID.toUpperCase(), orgName, createDate.toString(), description, path, email, "AP", "", status);
                if (orgDAO.createOrg(orgDTO)) {
                    manager.setName(orgName);
                    manager.setPassword("1");
                    manager.setStatus(true);
                    manager.setTypeID("STU");
                    manager.setRoleID("CLB");
                    manager.setOrgID(orgID);
                    for (int i = 0; i < 3; i++) {
                        manager.setId(orgID + "_0" + (i + 1));
                        userDAO.createClubMemberWhenApprovedOrg(manager);
                        userDAO.signUpByManager(manager);
                    }
                    request.setAttribute("SUCCESS", "CREATE SUCCESSFULLY!!");
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("ERROR", orgError);
            }

        } catch (Exception e) {
            log("Error at CreateOrgController " + e.toString());
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
