/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.comment.CommentDAO;
import sample.comment.CommentDTO;
import sample.posts.EventDAO;
import sample.posts.EventPost;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "DetailController", urlPatterns = {"/DetailController"})
public class EventDetailController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "EventTypeAndLocationController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        EventPost event;
        EventDAO evtDao = new EventDAO();
        List<CommentDTO> listComment = null;      
        CommentDAO cmtDao = new CommentDAO();
        int participants;
        try {
            String eventID = request.getParameter("eventID");
            event = evtDao.getAnEventByID(eventID);
            participants = evtDao.getNumberOfParticipants(eventID);
            request.setAttribute("participants", participants);
            request.setAttribute("event", event);
            
            //GET ALL COMMENT
            
            listComment = cmtDao.getAllComment(eventID);
            if(listComment != null)
                request.setAttribute("LIST_COMMENT", listComment);
  
            //=============
            
            url = SUCCESS;
            
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
