/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
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
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "index.jsp";
    private static final String ADM_PAGE = "AdminManagerPageController";
    private static final String MAN_PAGE = "MainController?action=ListOrgEvent";
    private static final String MOD_PAGE = "MainController?action=ListEvent";

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
            String validateUser = dao.authenticateUser(userName, password);
            switch (validateUser) {
                case "ADM":
                    manager = dao.checkManagerExist(userName);
                    session.setAttribute("LOGIN_USER", manager);
                    url = ADM_PAGE;
                    break;
                case "CLB":
                    manager = dao.checkManagerExist(userName);
                    session.setAttribute("LOGIN_USER", manager);
                    url = MAN_PAGE;
                    break;
                case "MOD":
                    manager = dao.checkManagerExist(userName);
                    session.setAttribute("LOGIN_USER", manager);
                    url = MOD_PAGE;
                    break;
                default:
                    request.setAttribute("ERROR", "Incorrect User Name or Password");
                    break;
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
