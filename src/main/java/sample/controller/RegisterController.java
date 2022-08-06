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
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
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
 * @author Tuan Be
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "UserDataController";
    private static final String SUCCESS = "UserDataController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = ERROR;
        boolean check = true;
        UserDAO dao = new UserDAO();
        UserDTO dto = new UserDTO();
        UserError error = new UserError();
        try {
            String page = request.getParameter("page");
            String userName = request.getParameter("username");
            UserDTO checkUserExist = dao.checkUserExist(userName);

            if (dao.checkInputUserID(userName) == false) {
                error.setIdError("User name must be 8-32 characters!");
                check = false;
            } else if (checkUserExist != null) {
                error.setIdError("This User Name has existed!");
                check = false;
            }

            String fullName = request.getParameter("fullName");

            String email = request.getParameter("email");
            UserDTO checkEmailExist = dao.checkEmailExist(email);

            if (checkEmailExist != null) {
                error.setEmailError("Email is exist!");
                check = false;
            }
            String type = request.getParameter("userType");

            if (type == null) {
                error.setTypeIDError("This field CAN NOT be EMPTY!!!");
                check = false;
            }

            String role = "US";
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            if (dao.checkInputPhoneNumber(phone) == false) {
                error.setPhoneNumberError("Wrong input phone number!");
                check = false;
            }
            String password = request.getParameter("password");

            String repass = request.getParameter("confirm");
            if (!password.equals(repass)) {
                error.setPasswordConfirmError("Wrong confirm password!");
                check = false;
            }

            boolean status;
            if (page.equals("Admin_UserForm.jsp")) {
                status = Boolean.parseBoolean(request.getParameter("status"));
            } else {
                status = true;
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
            
            if (check == false) {
                request.setAttribute("ERROR", error);
            } else {
                dto = new UserDTO(userName, fullName, password, email, status, type, role, gender, phone, path);
                if (dao.signUpByUser(dto)) {
                    dao.updateImage(path, userName);
                    request.setAttribute("Message", "CREATE ACCOUNT SUCCESSFULLY!");
                    url = SUCCESS;
                }
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
