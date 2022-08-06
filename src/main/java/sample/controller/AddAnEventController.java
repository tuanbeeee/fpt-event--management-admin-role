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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
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
import sample.posts.EventPostError;
import sample.users.ManagerDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserNotification;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "AddAnEventController", urlPatterns = {"/AddAnEventController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddAnEventController extends HttpServlet {

    private static final String ERROR = "EventTypeAndLocationController";
    private static final String CLB_PAGE = "EventListByOrgController";
    private static final String MOD_PAGE = "EventListController";

    private static final String MODERATOR = "MOD";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        LocalDate now = LocalDate.now();
        String url = ERROR;
        String id;
        EventPostError evtError = new EventPostError();
        EventDAO evtDao = new EventDAO();
        UserDAO userDao = new UserDAO();
        HttpSession session = request.getSession();
        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        ManagerDTO manager = new ManagerDTO();
        UserNotification userNoti = new UserNotification();
        List<ManagerDTO> listManager = new ArrayList<>();
        try {
            while (true) {
                id = "EVT" + ThreadLocalRandom.current().nextInt(1, 100000);
                if (!evtDao.checkEventIDDuplicate(id)) {
                    break;
                }
            }

            manager = userDao.getManagerInfoByID(user.getId());

            String statusTypeID;
            if (manager.getRoleID().equals(MODERATOR)) {
                statusTypeID = "AP";
            } else {
                statusTypeID = "PE";
            }
            String orgID = manager.getOrgID();
            String content = request.getParameter("content");
            String title = request.getParameter("title");
            String location = request.getParameter("location");

            String eventType = request.getParameter("eventType");
            int participationLimit = Integer.parseInt(request.getParameter("participationLimit"));
            int numberOfView = 0;
            String speaker = request.getParameter("speaker");
            String summary = request.getParameter("summary");
            LocalDate createDate = now;

            String takePlaceDate = request.getParameter("takePlaceDate");

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

            Boolean status;
            if ("MOD".equals(manager.getRoleID())) {
                status = Boolean.parseBoolean(request.getParameter("status"));
            } else {
                status = true;
            }

            int slotID = Integer.parseInt(request.getParameter("slotID"));

            EventPost event = new EventPost(takePlaceDate, location, eventType, speaker, "", "", statusTypeID, "", "", id, orgID, "", title, content, createDate.toString(), path, numberOfView, summary, status, 0, participationLimit, slotID, "");

            //HAM CHECK
            if (evtDao.checkAvailableSlot(event)) {
                boolean checkCreate = evtDao.createAnEvent(event);
                if (checkCreate == true) {
                    request.setAttribute("SUCCESS", "success");
                    if ("MOD".equals(manager.getRoleID())) {
                        url = MOD_PAGE;
                    } else {
                        String notiContent = manager.getOrgID() + " have a new post need to be approve. Check it out!";
                        listManager = userDao.getAllManagersByRole("MOD");

                        for (ManagerDTO managerNoti : listManager) {
                            userNoti = new UserNotification(managerNoti.getId(), id, createDate.toString(), notiContent);
                            userDao.addNoti(userNoti);
                        }
                        url = CLB_PAGE;
                    }
                } else {
                    request.setAttribute("FAILED", "failed");
                }
            } else {
                request.setAttribute("DUP_SLOT", "dupSlot");
                if ("MOD".equals(manager.getRoleID())) {
                    url = MOD_PAGE;
                } else {
                    url = CLB_PAGE;
                }
            }

        } catch (Exception e) {
            log("Error at Add Event Controller " + e.toString());
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
