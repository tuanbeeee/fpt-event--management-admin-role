/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sample.posts.Blog;
import sample.posts.BlogDAO;
import sample.users.ManagerDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "BlogListController", urlPatterns = {"/BlogListController"})
public class BlogListController extends HttpServlet {

    private static final String SUCCESS = "DisplayNotificationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        UserDAO userDao = new UserDAO();

        String url = "error.jsp";
        List<Blog> listBlog;
        String checkSearch = (String) request.getAttribute("checkSearch");
        try {
            BlogDAO blogDao = new BlogDAO();
            String type = request.getParameter("type");

            if (checkSearch == null) {
                if ("FPTU".equals(type)) {
                    listBlog = blogDao.getAllBlog(user.getOrgID(), "CLB");
                } else {
                    listBlog = blogDao.getAllBlog(user.getOrgID(), user.getRoleID());
                }
                request.setAttribute("listBlog", listBlog);
            } else {
                listBlog = (List<Blog>) request.getAttribute("listTitleSearch");
                request.setAttribute("listBlog", listBlog);
            }
            url = SUCCESS;
        } catch (SQLException ex) {
            Logger.getLogger(EventListController.class.getName()).log(Level.SEVERE, null, ex);
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
