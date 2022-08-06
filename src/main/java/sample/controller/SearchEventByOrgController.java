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
import javax.servlet.http.HttpSession;
import sample.posts.EventDAO;
import sample.posts.EventPost;
import sample.users.ManagerDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "SearchEventByOrgController", urlPatterns = {"/SearchEventByOrgController"})
public class SearchEventByOrgController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SEARCH = "EventListByOrgController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
        ManagerDTO manager = new ManagerDTO();
        UserDAO userDao = new UserDAO();

        String url = ERROR;
        EventDAO evtDao = new EventDAO();
        List<EventPost> listEvent = new ArrayList<>();
        try {
            manager = userDao.getManagerInfoByID(user.getId());
            String search = request.getParameter("search");
            listEvent = evtDao.getOrgListEventByTitle(search, manager.getOrgID());
            request.setAttribute("listTitleSearch", listEvent);
            request.setAttribute("checkSearch", "search");
            url = SEARCH;
        } catch (Exception e) {
            log(e.toString());
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
