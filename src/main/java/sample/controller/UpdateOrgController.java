/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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

/**
 *
 * @author light
 */
@WebServlet(name = "UpdateOrgController", urlPatterns = {"/UpdateOrgController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateOrgController extends HttpServlet {

    private static final String ERROR = "Admin_OrgForm.jsp";
    private static final String SUCCESS = "Admin_OrgForm.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        boolean check = true;
        OrganizationDTO orgDTO = null;
        OrganizationDTO oldOrg = null;

        OrganizationDAO orgDAO = new OrganizationDAO();
        OrganizationError orgError = new OrganizationError();
        try {
            String id = request.getParameter("id");
            String oldOrgID = request.getParameter("oldOrgID");
            if (id == null || id.isEmpty()) {
                String orgID = request.getParameter("orgID");
                String orgName = request.getParameter("orgName");
                String description = request.getParameter("description");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));

                oldOrg = orgDAO.getOrganization(orgID);
                
                if (!oldOrgID.equals(orgID)) { //cái cũ != cái mới 123vs234
                    if (oldOrg != null) { //tìm orgID
                        orgError.setOrgIDError("The ID has been exist");
                        check = false;
                    } else if (orgID.length() != 3) {
                        orgError.setOrgIDError("The ID must have 3 character!!");
                        check = false;
                    }
                }

                               Part filePart = request.getPart("image");
                String realPath = request.getServletContext().getRealPath("/Image");
                String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (!Files.exists(Paths.get(realPath))) {
                    Files.createDirectory(Paths.get(realPath));
                }
                
                String path;
                if(!"".equals(filename)) {
                Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePart.write(realPath + "/" + filename);
                   path = "Image\\" + filename;
                } else  {
                    path = oldOrg.getImgUrl();
                }

                if (check) {
                    orgDTO = new OrganizationDTO(orgID.toUpperCase(), orgName, description, status);
                    if (orgDAO.updateOrg(orgDTO, oldOrgID)) {
                        orgDAO.updateImage(path, orgID);
                        request.setAttribute("SUCCESS", "Updated Successfully!!!");
                        request.setAttribute("ORG", orgDAO.getOrganization(orgID.toUpperCase()));
                        url = SUCCESS;
                    }
                } else {
                    request.setAttribute("ERROR", orgError);
                    orgDTO = new OrganizationDAO().getOrganization(oldOrgID);
                    request.setAttribute("ORG", orgDTO);
                }

            } else {
                orgDTO = new OrganizationDAO().getOrganization(id);
                request.setAttribute("ORG", orgDTO);
            }
        } catch (Exception e) {
            log("Error at UpdateOrgController " + e.toString());
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateOrgController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateOrgController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
