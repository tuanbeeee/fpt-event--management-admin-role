<%@page import="sample.eventtype.EventType"%>
<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.posts.EventPost"%>
<%@page import="sample.posts.EventPostError"%>
<%@page import="sample.posts.EventLocation"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>F.E.M - Update An Event</title> 
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
        <link rel="stylesheet" href="./css_FormCreate/style.css">
        <link rel="stylesheet" href="./css_FormCreate/css/all.css">
        <script src="https://your-site-or-cdn.com/fontawesome/v5.15.4/js/all.js" data-auto-replace-svg></script>
        <script src="https://use.fontawesome.com/releases/vVERSION/js/all.js" data-auto-replace-svg="nest"></script>

    </head>

    <%  List<EventType> listEvtType = (List<EventType>) request.getAttribute("listEventTypes");
        List<EventLocation> listEvtLocation = (List<EventLocation>) request.getAttribute("listEventLocations");

        EventPost event = (EventPost) request.getAttribute("event");
        event.setTakePlaceDate(event.getTakePlaceDate().replace(' ', 'T'));
        
        EventPostError evtError = (EventPostError) request.getAttribute("ERROR");
        if (evtError == null) {
            evtError = new EventPostError();
        }

        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        String pageType = (String) request.getAttribute("page");
    %>



    <body>
        <!-- partial:index.partial.html -->
        <div  class="container">
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="page" value="<%=pageType%>">
                <input type="hidden" name="eventID" value="<%=event.getId()%>">

                <div style="text-align: center">
                    <h1 class="Information ">Update Event</h1>
                </div>

                <div class="row">
                    <h4><i class="fa-solid fa-users" style="width: 25px"></i>Event's Information</h4>


                    <% if (user.getRoleID().equals("CLB")) {%>


                    <div class="input-group input-group-icon">
                        <input required="" type="text" value="<%=event.getTitle()%>" name="title" placeholder=""/>
                        <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                    </div>

                    <div class="input-group input-group-icon">
                        <input type="text" value="<%=event.getSpeaker()%>" name="speaker" placeholder=""/>
                        <div class="input-icon"><i class="fa fa-user"></i></div>
                    </div>

                    <div class="input-group input-group-icon">
                        <input type="number" value="<%=event.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="0"/>
                        <div class="input-icon"><i class="fa fa-user"></i></div>
                    </div> 

                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event's Type and Location</h4>

                    <select name="location">
                        <option hidden="" selected="" value="<%=event.getLocation()%>"><%=event.getLocationName()%></option>
                        <%for (int i = 0; i < listEvtLocation.size(); i++) {
                        %>
                        <option value="<%=listEvtLocation.get(i).getLocationID()%>"><%=listEvtLocation.get(i).getLocaitonName()%></option>
                        <%
                            }
                        %>
                    </select>
                    <select name="eventType">
                        <option hidden="" selected="" value="<%=event.getEventType()%>"><%=event.getEventTypeName()%></option>
                        <%for (int i = 0; i < listEvtType.size(); i++) {
                        %>
                        <option value="<%=listEvtType.get(i).getEventTypeID()%>"><%=listEvtType.get(i).getEventTypeName()%></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <h4><i class="fa-solid fa-calendar-days" style="width: 25px;"></i>Take Place Date</h4>

                <%= evtError.getTakePlaceDate()%>
                <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                    <input required="" type="date" value="<%=event.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
                    <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                </div>

                <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Summary</h4>
                <div class="update-content">
                    <textarea required="" name="summary" id="role" cols="30" rows="9" style="width: 480px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                              placeholder="Enter Event's Summary Here*"><%=event.getSummary()%></textarea>
                </div>
                <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Description</h4>
                <div class="update-content">
                    <textarea required="" name="content" id="role" cols="30" rows="9" style="width: 480px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                              placeholder="Enter Event's Description Here*"><%=event.getContent()%></textarea>
                </div>



                <div class=" btn btn-danger" style="text-align: center">
                    <a href="MainController?action=ListOrgEvent">Cancel</a>
                </div>



                <% } else if (event.getOrgID().equals(user.getOrgID())) {%>



                <input type="hidden" name="FPT" value="FPT"/>

                <div class="input-group input-group-icon">
                    <input required="" type="text" value="<%=event.getTitle()%>" name="title" placeholder=""/>
                    <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                </div>

                <div class="input-group input-group-icon">
                    <input type="text" value="<%=event.getSpeaker()%>" name="speaker" placeholder=""/>
                    <div class="input-icon"><i class="fa fa-user"></i></div>
                </div>

                <div class="input-group input-group-icon">
                    <input type="number" value="<%=event.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="0"/>
                    <div class="input-icon"><i class="fa fa-user"></i></div>
                </div> 

                <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event's Type and Location</h4>

                <select name="location">
                    <option hidden="" selected="" value="<%=event.getLocation()%>"><%=event.getLocationName()%></option>
                    <%for (int i = 0; i < listEvtLocation.size(); i++) {
                    %>
                    <option value="<%=listEvtLocation.get(i).getLocationID()%>"><%=listEvtLocation.get(i).getLocaitonName()%></option>
                    <%
                        }
                    %>
                </select>
                <select name="eventType">
                    <option hidden="" selected="" value="<%=event.getEventType()%>"><%=event.getEventTypeName()%></option>
                    <%for (int i = 0; i < listEvtType.size(); i++) {
                    %>
                    <option value="<%=listEvtType.get(i).getEventTypeID()%>"><%=listEvtType.get(i).getEventTypeName()%></option>
                    <%
                        }
                    %>
                </select>
        </div>
        <h4><i class="fa-solid fa-calendar-days" style="width: 25px;"></i>Take Place Date</h4>

        <%= evtError.getTakePlaceDate()%>
        <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
            <input required="" type="datetime-local" value="<%= event.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
            <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
        </div>

        <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Summary</h4>
        <div class="update-content">
            <textarea required="" name="summary" id="role" cols="30" rows="9" style="width: 480px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                      placeholder="Enter Event's Summary Here*"><%=event.getSummary()%></textarea>
        </div>
        <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Description</h4>
        <div class="update-content">
            <textarea required="" name="content" id="role" cols="30" rows="9" style="width: 480px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                      placeholder="Enter Event's Description Here*"><%=event.getContent()%></textarea>
        </div>




        <div class="flex-row-reverse">
            <div class="">
                <h4>Status</h4>
                <%
                    if (event.isStatus() == false) {
                %>
                <div class="input-group">
                    <input id="status-true" type="radio" name="status" value="true"/>
                    <label for="status-true">Active</label>
                    <input id="status-false" type="radio" name="status" checked="" value="false"/>
                    <label for="status-false">Inactive</label>
                </div>
                <%
                } else {
                %>
                <div class="input-group">
                    <input id="status-true" type="radio" checked="" name="status" value="true"/>
                    <label for="status-true">Active</label>
                    <input id="status-false" type="radio" name="status"  value="false"/>
                    <label for="status-false">Inactive</label>
                </div>
                <%                     }
                %>
            </div>
        </div>

        <div class=" btn btn-danger" style="text-align: center">
            <a href="MainController?action=ListEvent">Cancel</a>
        </div>

        <% } else { %>

        <div class="flex-row-reverse">
            <div class="">
                <h4>Status</h4>
                <%
                    if (event.isStatus() == false) {
                %>
                <div class="input-group">
                    <input id="status-true" type="radio" name="status" value="true"/>
                    <label for="status-true">Active</label>
                    <input id="status-false" type="radio" name="status" checked="" value="false"/>
                    <label for="status-false">Inactive</label>
                </div>
                <%
                } else {
                %>
                <div class="input-group">
                    <input id="status-true" type="radio" checked="" name="status" value="true"/>
                    <label for="status-true">Active</label>
                    <input id="status-false" type="radio" name="status"  value="false"/>
                    <label for="status-false">Inactive</label>
                </div>
                <%                     }
                %>
            </div>
        </div>


        <div class=" btn btn-danger" style="text-align: center">
            <a href="MainController?action=ListEvent">Cancel</a>
        </div>

        <% }%>
        <div class="row">
            <h4><i class="fa-solid fa-link" style="width: 25px"></i>Image</h4>
            <div class="input-group input-group-icon">
                <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                <div class="input-icon"><i class="fa-solid fa-link"></i></div>
            </div>
        </div>

        <button type="submit" style="cursor: pointer" class="login-box" name="action" value="UpdateEvent">
            Update Event
        </button>

    </form>
</div>
<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script><script  src="./css_FormCreate/script.js"></script>

</body>
</html>
