/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;

/**
 *
 * @author light
 */
@WebServlet(name = "UpdateManagerController", urlPatterns = {"/UpdateManagerController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB

public class UpdateManagerController extends HttpServlet {

    private static final String ERROR = "UserDataController";
    private static final String SUCCESS = "UserDataController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        UserDAO dao = new UserDAO();
        UserError error = new UserError();
        boolean check = true;
        try {

            String id = request.getParameter("id");
            if (id == null) {
                String userName = request.getParameter("username");
                UserDTO oldUser = dao.checkManagerExist(userName);

                String fullName = request.getParameter("fullName");

                String email = request.getParameter("email");
                UserDTO checkEmailExist = dao.checkEmailExist(email);
                if (checkEmailExist != null) {
                    if (!checkEmailExist.getEmail().toUpperCase().equals(oldUser.getEmail().toUpperCase())) {
                        error.setEmailError("Email is existed!");
                        check = false;
                    }
                }

                String type = request.getParameter("userType");

                if (type == null) {
                    error.setTypeIDError("This field CAN NOT be EMPTY!!!");
                    check = false;
                }

                String role = "CLB";

                String gender = request.getParameter("gender");
                String phone = request.getParameter("phone");
                if (dao.checkInputPhoneNumber(phone) == false) {
                    error.setPhoneNumberError("Wrong input phone number!");
                    check = false;
                }
                String password = request.getParameter("password");

                String repass = request.getParameter("confirm");
                if ("".equals(password) && "".equals(repass)) {
                    password = oldUser.getPassword();
                } else {
                    if (!password.equals(repass)) {
                        error.setPasswordConfirmError("Wrong confirm password!");
                        check = false;
                    }
                }
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
//            if (page.equals("Admin_UserForm.jsp")) {
//                status = Boolean.parseBoolean(request.getParameter("status"));
//            } else {
//                status = true;
//            }

//UPLOAD IMAGE
//                String fileName = filePart.getSubmittedFileName();
//                 String path = "";
//                if (!fileName.isEmpty()) {
//                    for (Part part : request.getParts()) {
//                        part.write("D:\\Document\\Semester 5 FPT\\SWP391\\event-management-java-web-develop\\web\\Image\\" + fileName);
//                    }
//                    path = "Image\\" + fileName;
//                } else {
//                    path = oldUser.getPicture();
//                }
                String path = oldUser.getPicture();
                Part filePart = request.getPart("image");
                if (filePart != null) {
                    String realPath = request.getServletContext().getRealPath("/Image");
                    String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    if (!Files.exists(Paths.get(realPath))) {
                        Files.createDirectory(Paths.get(realPath));
                    }
                    if (!"".equals(filename)) {
                        filePart.write(realPath + "/" + filename);
                        path = "Image\\" + filename;
                    } 
                }

                if (check == false) {
                    request.setAttribute("ERROR", error);
                    request.setAttribute("MANAGER", oldUser);
                } else {
                    UserDTO dto = new UserDTO(userName, fullName, password, email, status, type, role, gender, phone);
                    if (dao.updateUserProfileByAdmin(dto)) {
                        dao.updateImage(path, userName);
                        request.setAttribute("SUCCESS", "UPDATE ACCOUNT SUCCESSFULLY!");
                        request.setAttribute("MANAGER", dao.checkManagerExist(userName));
                        url = SUCCESS;
                    }
                }

            } else {
                request.setAttribute("MANAGER", dao.checkManagerExist(id));
            }
        } catch (Exception e) {
            log("Error at UpdateManagerContrller " + e.toString());
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
            Logger.getLogger(UpdateManagerController.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (NamingException ex) {
            Logger.getLogger(UpdateManagerController.class
                    .getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UpdateManagerController.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (NamingException ex) {
            Logger.getLogger(UpdateManagerController.class
                    .getName()).log(Level.SEVERE, null, ex);
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
