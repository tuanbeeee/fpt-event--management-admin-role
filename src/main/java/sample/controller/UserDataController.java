/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
 * @author light
 */
@WebServlet(name = "UserDataController", urlPatterns = {"/UserDataController"})
public class UserDataController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String AD_US_FORM = "Admin_UserForm.jsp";
    private static final String AD_MAN_FORM = "Admin_ManagerForm.jsp";
    private static final String AD_PROFILE = "DisplayNotificationController";


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        ArrayList<UserDTO> listType = new ArrayList<>();
        ArrayList<ManagerDTO> listOrg = new ArrayList<>();

        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession();
        
        
        try {
            listType = dao.getAllUserType();
            request.setAttribute("listUserType", listType);

            String page = request.getParameter("page");

            if (AD_US_FORM.equals(page)) {
                url = AD_US_FORM;

            } else if (AD_MAN_FORM.equals(page)) {
                listOrg = dao.getAllOrg();
                request.setAttribute("listOrg", listOrg);
                url = AD_MAN_FORM;

            } else if ("Admin_Profile.jsp".equals(page)) {
                session.setAttribute("LOGIN_USER", new UserDAO().checkManagerExist(  ((ManagerDTO)(session.getAttribute("LOGIN_USER"))).getId()   ));
                                                                                                    // Lấy ID từ session ra rồi gán lại
                                                                                                    //UPDATE lại session
                url = AD_PROFILE;
            }
        } catch (Exception e) {
            log("Error at UserDataController " + e.toString());
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
