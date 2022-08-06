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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.posts.EventDAO;
import sample.posts.EventPost;
import sample.users.UserDTO;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "UpdateEventController", urlPatterns = {"/UpdateEventController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateEventController extends HttpServlet {

    private static final String CLB_PAGE = "EventListByOrgController";
    private static final String MOD_PAGE = "EventListController";

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        boolean check = false;
        HttpSession session = request.getSession();
        UserDTO user = new UserDTO();
        EventDAO evtDao = new EventDAO();
        String takePlaceDate = null;
        String content = null;
        String title = null;
        String location = null;
        String imgUrl = null;
        String eventType = null;
        String speaker = null;
        String summary = null;
        try {
            user = (UserDTO) session.getAttribute("LOGIN_USER");
            String id = request.getParameter("eventID");
            String FPT = request.getParameter("FPT");
            String page = request.getParameter("page");
            if ("CLB".equals(user.getRoleID())) {

                takePlaceDate = request.getParameter("takePlaceDate");
               

                content = request.getParameter("content");
                title = request.getParameter("title");
                location = request.getParameter("location");
                eventType = request.getParameter("eventType");
                speaker = request.getParameter("speaker");
                summary = request.getParameter("summary");
                int participationLimit = Integer.parseInt(request.getParameter("participationLimit"));

                Part filePart = request.getPart("image");
                String realPath = request.getServletContext().getRealPath("/Image");
                String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (!Files.exists(Paths.get(realPath))) {
                    Files.createDirectory(Paths.get(realPath));
                }

                String path;
                if (!"".equals(filename)) {
                    Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    filePart.write(realPath + "/" + filename);
                    path = "Image\\" + filename;
                } else {
                    path = evtDao.getAnEventByID(id).getImgUrl();
                }

                List<UserDTO> listParti = evtDao.getAllParticipantsByEventID(id);
                if (listParti.size() > participationLimit) {
                    check = false;
                }

                int slotID = Integer.parseInt(request.getParameter("slotID"));

                EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, "", "", "", "", "", id, "", "", title, content, "", path, 0, summary, true, 0, participationLimit, slotID, "");

                if (evtDao.checkAvailableSlot(event)) {
                    check = evtDao.updateAnEvent(event);
                    if (check) {
                        request.setAttribute("SUCCESS", "success");
                        if ("Club_Event.jsp".equals(page)) {
                            url = CLB_PAGE;
                        } else {
                            url = "MainController?action=EventDetail&eventID=" + id;
                        }
                    } else {
                        request.setAttribute("FAILED", "failed");
                    }

                } else {
                    request.setAttribute("DUP_SLOT", "dupSlot");
                    if ("Club_Event.jsp".equals(page)) {
                        url = CLB_PAGE;
                    } else {
                        url = "MainController?action=EventDetail&eventID=" + id;
                    }
                }

            } else if ("MOD".equals(user.getRoleID())) {
                if ("FPT".equals(FPT)) {
                    takePlaceDate = request.getParameter("takePlaceDate");
                   

                    content = request.getParameter("content");
                    title = request.getParameter("title");
                    location = request.getParameter("location");
                    eventType = request.getParameter("eventType");
                    speaker = request.getParameter("speaker");
                    summary = request.getParameter("summary");
                    int participationLimit = Integer.parseInt(request.getParameter("participationLimit"));
                    boolean status = Boolean.parseBoolean(request.getParameter("status"));

                    Part filePart = request.getPart("image");
                    String realPath = request.getServletContext().getRealPath("/Image");
                    String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    if (!Files.exists(Paths.get(realPath))) {
                        Files.createDirectory(Paths.get(realPath));
                    }

                    String path;
                    if (!"".equals(filename)) {
                        Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        filePart.write(realPath + "/" + filename);
                        path = "Image\\" + filename;
                    } else {
                        path = evtDao.getAnEventByID(id).getImgUrl();
                    }

                    int slotID = Integer.parseInt(request.getParameter("slotID"));
                    EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, "", "", "", "", "", id, "", "", title, content, "", path, 0, summary, status, 0, participationLimit, slotID, "");

                    if (evtDao.checkAvailableSlot(event)) {
                        if (evtDao.updateAnEventByAdmin(event)) {
                            check = true;
                        }
                    } else {
                        request.setAttribute("DUP_SLOT", "dupSlot");
                        if ("Mod_Event.jsp".equals(page)) {
                            url = MOD_PAGE;
                        } else {
                            url = "MainController?action=EventDetail&eventID=" + id;
                        }
                    }

                    List<UserDTO> listParti = evtDao.getAllParticipantsByEventID(id);
                    if (listParti.size() > participationLimit) {
                        check = false;
                    }

                } else {
                    boolean status = Boolean.parseBoolean(request.getParameter("status"));
                    check = evtDao.updateStatusEventByID(id, status);
                }

                if (check == true) {
                    request.setAttribute("SUCCESS", "success");
                    if ("Mod_Event.jsp".equals(page)) {
                        url = MOD_PAGE;
                    } else {
                        url = "MainController?action=EventDetail&eventID=" + id;
                    }
                } else {
                    if(request.getAttribute("DUP_SLOT") == null)
                    request.setAttribute("FAILED", "failed");
                }

            }

        } catch (SQLException ex) {
            ex.toString();
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
