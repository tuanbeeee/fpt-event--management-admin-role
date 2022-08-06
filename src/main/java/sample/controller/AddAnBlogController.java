/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.concurrent.ThreadLocalRandom;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.posts.Blog;
import sample.posts.BlogDAO;
import sample.users.ManagerDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "AddAnBlogController", urlPatterns = {"/AddAnBlogController"})
public class AddAnBlogController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "BlogListController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        long millis = System.currentTimeMillis();
        java.sql.Date nowDate = new java.sql.Date(millis);
        String url = ERROR;
        String id;
        BlogDAO blogDao = new BlogDAO();
        UserDAO userDao = new UserDAO();
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
        ManagerDTO manager = new ManagerDTO();
        try {
            while (true) {
                id = "BLG" + ThreadLocalRandom.current().nextInt(1, 100000);
                if (!blogDao.checkBlogIDDuplicate(id)) {
                    break;
                }
            }

            manager = userDao.getManagerInfoByID(user.getId());

            String orgID = manager.getOrgID();
            String content = request.getParameter("content");
            String title = request.getParameter("title");
            int numberOfView = 0;
            String summary = request.getParameter("summary");
            Date createDate = nowDate;
            boolean status;

            if ("MOD".equals(manager.getRoleID())) {
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

            Blog blog = new Blog(id, orgID, title, content, createDate.toString(), path, numberOfView, summary, status);
            boolean checkCreate = blogDao.createABlog(blog);
            if (checkCreate == true) {
                url = SUCCESS;

            }

        } catch (Exception e) {
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
