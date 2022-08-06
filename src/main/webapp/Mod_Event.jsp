<%@page import="java.time.LocalDate"%>
<%@page import="sample.slot.SlotTime"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="sample.posts.EventPostError"%>
<%@page import="sample.posts.EventLocation"%>
<%@page import="sample.eventtype.EventType"%>
<%@page import="sample.users.UserNotification"%>
<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.posts.EventPost"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>F.E.M - FPT Event Admin</title>

        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
        <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js'>

        <link rel="stylesheet" href="./css_FormCreate/style.css">
        <link rel="stylesheet" href="./css_FormCreate/css/all.css">
        <!--<script src="https://your-site-or-cdn.com/fontawesome/v5.15.4/js/all.js" data-auto-replace-svg></script>-->
        <!--<script src="https://use.fontawesome.com/releases/vVERSION/js/all.js" data-auto-replace-svg="nest"></script>-->

        <!-- Favicon icon -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="icon" type="image/png" sizes="16x16" href="./css_Admin/images/Biểu-tượng-không-chữ.png">
        <!--        <link rel="stylesheet" href="./css_Admin/vendor/chartist/css/chartist.min.css">
                <link href="./css_Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">-->
        <!-- Datatable -->
        <link href="./css_Admin/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="./css_Admin/css/style.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>


        <style>
            .status {
                vertical-align: middle;
                font-size: 35px;
            }

            .search-date {
                border: none;
                padding: 12px 30px;
                border-radius: 15px;
                font-size: 16px;
                color: #B1B1B1;
                cursor: pointer;
            }
        </style>


    </head>

    <body>
        <% List<EventPost> listEvent = (List) request.getAttribute("listEvent");

            ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
            if (user == null || !user.getRoleID().equals("MOD")) {
                response.sendRedirect("index.jsp");
                return;
            }

            String beginDate = (String) request.getAttribute("fromdate");
            String endDate = (String) request.getAttribute("enddate");
            if (beginDate == null || endDate == null) {
                beginDate = (java.time.LocalDate.now().toString());
                endDate = (java.time.LocalDate.now().toString());
            }
            List<UserNotification> listNoti = (List) request.getAttribute("USER_NOTIFICATION");

            List<EventType> listEvtType = (List<EventType>) request.getAttribute("listEventTypes");
            List<EventLocation> listEvtLocation = (List<EventLocation>) request.getAttribute("listEventLocations");
            List<SlotTime> listSlotTime = (List<SlotTime>) request.getAttribute("listSlotTime");
            EventPostError evtError = (EventPostError) request.getAttribute("ERROR");
            if (evtError == null) {
                evtError = new EventPostError();
            }

            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            }


        %>


        <!--*******************
        Preloader start
    ********************-->
        <div id="preloader">
            <div class="sk-three-bounce">
                <div class="sk-child sk-bounce1"></div>
                <div class="sk-child sk-bounce2"></div>
                <div class="sk-child sk-bounce3"></div>
            </div>
        </div>
        <!--*******************
        Preloader end
    ********************-->

        <!--**********************************
        Main wrapper start
    ***********************************-->
        <div id="main-wrapper">

            <!--**********************************
        Nav header start
    ***********************************-->
            <div class="nav-header">
                <a href="MainController?action=ListEvent" class="brand-logo">
                    <img class="brand-title" src="./css_Admin/images/femLogo.png" alt="">
                </a>

                <div class="nav-control">
                    <div class="hamburger">
                        <span class="line"></span><span class="line"></span><span class="line"></span>
                    </div>
                </div>
            </div>
            <!--**********************************
        Nav header end
    ***********************************-->


            <div class="header">
                <div class="header-content">
                    <nav class="navbar navbar-expand">
                        <div class="collapse navbar-collapse justify-content-between">
                            <div class="header-left">
                                <div class="dashboard_bar">
                                    Event
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">
                                <li class="nav-item">
                                    <form action="MainController" method="POST" class="input-group search-area d-xl-inline-flex d-none">
                                        <input type="text" name="search" class="form-control" placeholder="Search here...">
                                        <div class="input-group-append">
                                            <button type="submit" name="action" value="SearchEvent" class="input-group-text"><i
                                                    class="flaticon-381-search-2"></i></button>
                                        </div>
                                    </form>
                                </li>
                                <li class="nav-item dropdown notification_dropdown">
                                    <a class="nav-link  ai-icon" href="javascript:void(0)" role="button"
                                       data-toggle="dropdown">
                                        <svg width="28" height="28" viewBox="0 0 28 28" fill="none"
                                             xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                              d="M12.8333 5.91732V3.49998C12.8333 2.85598 13.356 2.33331 14 2.33331C14.6428 2.33331 15.1667 2.85598 15.1667 3.49998V5.91732C16.9003 6.16698 18.5208 6.97198 19.7738 8.22498C21.3057 9.75681 22.1667 11.8346 22.1667 14V18.3913L23.1105 20.279C23.562 21.1831 23.5142 22.2565 22.9822 23.1163C22.4513 23.9761 21.5122 24.5 20.5018 24.5H15.1667C15.1667 25.144 14.6428 25.6666 14 25.6666C13.356 25.6666 12.8333 25.144 12.8333 24.5H7.49817C6.48667 24.5 5.54752 23.9761 5.01669 23.1163C4.48469 22.2565 4.43684 21.1831 4.88951 20.279L5.83333 18.3913V14C5.83333 11.8346 6.69319 9.75681 8.22502 8.22498C9.47919 6.97198 11.0985 6.16698 12.8333 5.91732ZM14 8.16664C12.4518 8.16664 10.969 8.78148 9.87469 9.87581C8.78035 10.969 8.16666 12.453 8.16666 14V18.6666C8.16666 18.8475 8.12351 19.026 8.04301 19.1881C8.04301 19.1881 7.52384 20.2265 6.9755 21.322C6.88567 21.5028 6.89501 21.7186 7.00117 21.8901C7.10734 22.0616 7.29517 22.1666 7.49817 22.1666H20.5018C20.7037 22.1666 20.8915 22.0616 20.9977 21.8901C21.1038 21.7186 21.1132 21.5028 21.0234 21.322C20.475 20.2265 19.9558 19.1881 19.9558 19.1881C19.8753 19.026 19.8333 18.8475 19.8333 18.6666V14C19.8333 12.453 19.2185 10.969 18.1242 9.87581C17.0298 8.78148 15.547 8.16664 14 8.16664Z"
                                              fill="#FE634E" />
                                        </svg>
                                        <div class="pulse-css"></div>
                                    </a>
                                    <div class="dropdown-menu rounded dropdown-menu-right">
                                        <div id="DZ_W_Notification1" class="widget-media dz-scroll p-3 height380">
                                            <ul class="timeline">
                                                <%                                                    for (int i = 0; i < listNoti.size(); i++) {
                                                %>

                                                <li>
                                                    <div class="timeline-panel">
                                                        <div class="media mr-2">
                                                            <img alt="image" width="50" src="<%=listNoti.get(i).getNotiImg()%>">
                                                        </div>
                                                        <div class="media-body">
                                                            <a href="MainController?action=EventDetail&eventID=<%=listNoti.get(i).getEventID()%>">
                                                                <h6 class="mb-1"><%=listNoti.get(i).getContent()%></h6>
                                                                <small class="d-block"><%=listNoti.get(i).getNotiDate()%></small>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>

                                                <%
                                                    }
                                                %>
                                            </ul>
                                        </div>
                                        <a class="all-notification" href="javascript:void(0)">See all notifications <i
                                                class="ti-arrow-right"></i></a>
                                    </div>
                                </li>

                                <li class="nav-item dropdown header-profile">
                                    <a class="nav-link" href="javascript:void(0)" role="button" data-toggle="dropdown">
                                        <img src="<%= user.getPicture()%>" width="20" alt="" />
                                        <div class="header-info">
                                            <span class="text-black"><strong><%= user.getName()%></strong></span>
                                            <p class="fs-12 mb-0"><%= user.getRoleID()%></p>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a href="MainController?action=AdminProfile" class="dropdown-item ai-icon">
                                            <svg id="icon-user1" xmlns="http://www.w3.org/2000/svg" class="text-primary"
                                                 width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                            <circle cx="12" cy="7" r="4"></circle>
                                            </svg>
                                            <span class="ml-2">Profile </span>
                                        </a>

                                        <a href="MainController?action=Logout" class="dropdown-item ai-icon">
                                            <svg id="icon-logout" xmlns="http://www.w3.org/2000/svg" class="text-danger"
                                                 width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                            <polyline points="16 17 21 12 16 7"></polyline>
                                            <line x1="21" y1="12" x2="9" y2="12"></line>
                                            </svg>
                                            <span class="ml-2">Logout </span>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <!--**********************************
        Header end ti-comment-alt
    ***********************************-->

            <!--**********************************
        Sidebar start
    ***********************************-->

            <!--========== MODAL NEW EVENT ==============--> 

            <div class="modal fade bd-example-modal-lg" id="modalNewEvent">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title">New Event</h5>
                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                            </button>
                        </div>

                        <div class="modal-body" style="padding: 0px 60px;">
                            <form action="MainController" method="POST" enctype="multipart/form-data">                               
                                <div style="text-align: center">
                                    <h1 class="Information ">Add Event</h1>
                                </div>

                                <div class="row form-group">
                                    <h4><i class="fa-solid fa-users" style="width: 25px"></i>Event's Information</h4>
                                    <div class="input-group input-group-icon">
                                        <input required="" type="text" value="" name="title" placeholder="Title"/>
                                        <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                                    </div>

                                    <div class="input-group input-group-icon">
                                        <input type="text" value="" name="speaker" placeholder="Speaker"/>
                                        <div class="input-icon"><i class="fa fa-user"></i></div>
                                    </div>                   

                                    <div class="input-group input-group-icon">
                                        <input type="number" value="" name="participationLimit" placeholder="Number of Participant" min="5"/>
                                        <div class="input-icon"><i class="fa fa-user"></i></div>
                                    </div> 
                                </div>

                                <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event's Type and Location</h4>



                                <div class="row">
                                    <select name="slotID" class="md-6">
                                        <option hidden="" selected="" disabled="">Select Slot Time</option>
                                        <%for (int j = 0; j < listSlotTime.size(); j++) {
                                        %>
                                        <option value="<%=listSlotTime.get(j).getSlotID()%>"><%=listSlotTime.get(j).getSlotTime()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <select name="eventType" class="md-6" required="">
                                        <option hidden="" value="" selected="" disabled="">Select Event Type</option>
                                        <%for (int j = 0; j < listEvtType.size(); j++) {
                                        %>
                                        <option value="<%=listEvtType.get(j).getEventTypeID()%>"><%=listEvtType.get(j).getEventTypeName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>

                                </div>
                                <div class="row">
                                    <select style="width: 100%" name="location" required="">
                                        <option hidden="" value="" selected="" disabled="">Select Event Location</option>
                                        <%for (int j = 0; j < listEvtLocation.size(); j++) {
                                        %>
                                        <option value="<%=listEvtLocation.get(j).getLocationID()%>"><%=listEvtLocation.get(j).getLocaitonName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>




                                <div class="form-group row">
                                    <h4><i class="fa-solid fa-calendar-days" style="width: 25px;"></i>Take Place Date</h4>
                                    <p style="color: red"><%= evtError.getTakePlaceDate()%></p>
                                    <div class="input-group input-group-icon " style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                                        <!--<input required="" type="date" value="" name="takePlaceDate" class="font-color"/>-->
                                        <input required="" type="date" min="<%= LocalDate.now().plusDays(5)%>" name="takePlaceDate" class="font-color"/>

                                        <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                                    </div>
                                </div>

                                <div class="row">
                                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Summary</h4>
                                    <div class="update-content form-group">
                                        <textarea required="" name="summary" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                  placeholder="Enter Event's Summary Here*"></textarea>
                                    </div>

                                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Description</h4>
                                    <div class="update-content">
                                        <textarea required="" name="content" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                  placeholder="Enter Event's Description Here*"></textarea>
                                    </div>
                                </div>


                                <div class="row form-group">
                                    <h4><i class="fa-solid fa-link" style="width: 25px"></i>Image</h4>
                                    <div class="input-group input-group-icon">
                                        <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                                        <div class="input-icon"><i class="fa-solid fa-link"></i></div>
                                    </div>
                                </div>

                                <div class="row">
                                    <h4>Status</h4>
                                    <div class="input-group">
                                        <input id="status-true-new" type="radio" name="status" value="true"/>
                                        <label for="status-true-new">Active</label>
                                        <input id="status-false-new" type="radio" name="status" checked="" value="false"/>
                                        <label for="status-false-new">Inactive</label>
                                    </div>
                                </div>

                                <div class="row modal-footer justify-content-center">
                                    <button type="submit" style="cursor: pointer" class="login-box" name="action" value="CreateEvent">
                                        Create Event
                                    </button>

                                    <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>

                            </form>


                        </div>
                    </div>
                </div>
            </div>


            <!--================CLOSE MODAL NEW EVENT ====================-->


            <div class="deznav">
                <div class="deznav-scroll">
                    <!--<a href="MainController?action=EventTypeAndLocation" class="add-menu-sidebar">New Event</a>-->

                    <a style="color: white" type="button" class="add-menu-sidebar" data-toggle="modal" data-target="#modalNewEvent">+ New Event</a>

                    <ul class="metismenu" id="menu">
                        <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
                                <i class="flaticon-381-networking"></i>
                                <span class="nav-text">Dashboard</span>
                            </a>
                            <ul aria-expanded="false">
                                <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">Event</a>
                                    <ul aria-expanded="false">
                                        <li><a href="MainController?action=ListEvent">List Event</a></li>
                                        <li><a href="MainController?action=ListLocation">Location</a></li>
                                        <li><a href="MainController?action=ListEventType">Event Type</a></li>
                                        </br>
                                    </ul>
                                </li>

                                <li><a href="MainController?action=ListBlog">Blog</a></li>
                                <li><a href="MainController?action=ClubStatistic&orgID=<%=user.getOrgID()%>">Statistic</a></li>
                            </ul>
                        </li>
                        <li>
                        </li>
                    </ul>
                    <div class="copyright">
                        <p><strong>FPT Event Management</strong> © 2022 F.E.M</p>

                    </div>
                </div>
            </div>
            <!--**********************************
        Sidebar end
    ***********************************-->

            <!--**********************************
        Content body start
    ***********************************-->
            <div class="content-body">
                <!-- row -->
                <div class="container-fluid">
                    <!-- Add Order -->

                    <div class="d-flex flex-wrap mb-2 align-items-center justify-content-between">
                        <div class="event-tabs mb-3 mr-3">
                            <ul class="nav nav-tabs" role="tablist">
                                <%
                                    String type = request.getParameter("type");
                                %>

                                <li class="nav-item">
                                    <%
                                        if (type == null) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=ListEvent" >
                                        All
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=ListEvent" >
                                        All
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>


                                <li class="nav-item">
                                    <%
                                        if ("Pending".equals(type)) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=FilterEvent&type=Pending" >
                                        Pending
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterEvent&type=Pending" >
                                        Pending
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>


                                <li class="nav-item">
                                    <%
                                        if ("Approved".equals(type)) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=FilterEvent&type=Approved" >
                                        Approved
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterEvent&type=Approved" >
                                        Approved
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>


                                <li class="nav-item">
                                    <%
                                        if ("Declined".equals(type)) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=FilterEvent&type=Declined" >
                                        Declined
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterEvent&type=Declined" >
                                        Declined
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>


                                <li class="nav-item">
                                    <%
                                        if ("OnGoing".equals(type)) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=FilterEvent&type=OnGoing" >
                                        On-Going
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterEvent&type=OnGoing" >
                                        On-Going
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>

                                <li class="nav-item">
                                    <%
                                        if ("FPTU".equals(type)) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=ListOrgEvent&type=FPTU" >
                                        FPTU
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=ListOrgEvent&type=FPTU" >
                                        FPTU
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>

                            </ul>
                        </div>

                        <div class="d-flex mb-3">                          


                        </div>


                        <div class="mb-3 mr-3">
                            <h6 class="fs-16 text-black font-w600 mb-0"><%=listEvent.size()%> Event Has Posted</h6>
                            <span class="fs-14">Based your activate</span>
                        </div>
                    </div>

                    <div>

                        <form action="MainController" method="POST" >
                            <div class="row">
                                <div class="col-md-5">
                                    <input type="date" value="<%= beginDate%>" name="fromdate" class="search-date">

                                </div>
                                <div class="col-md-1"><span style="font-size: 15px; font-weight: bold; display: flex; justify-content: center; padding-top: 15px ">to</span></div>

                                <div class="col-md-5"><input type="date"  value="<%= endDate%>" name="enddate" class="search-date"> </div>
                                <div class="col-md-1"><button style="padding: 10px 20px; margin-left: 15px" class="btn btn-primary" type="submit" name="action" value="SearchDate">Search</button></div>

                            </div>

                        </form>

                    </div>

                    <br>            
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="tab-content">
                                <div id="All" class="tab-pane active fade show">
                                    <div class="table-responsive">
                                        <table id="example2" class="table card-table display dataTablesCard">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">EventID</th>
                                                    <th class="text-center">Created</th>
                                                    <th class="text-center">Take Place Date</th>
                                                    <th class="text-center">Time</th>
                                                    <th class="text-center">Club</th>
                                                    <th style="width: 250px" class="text-center">Event Title</th>
                                                    <th class="text-center">Event Type</th>
                                                    <th class="text-center">Status</th>                                                    
                                                    <th class="text-center">Type</th>
                                                    <th class="text-center">View Detail</th>
                                                    <th class="text-center">Action</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int count = 0;
                                                    for (int i = 0; i < listEvent.size(); i++) {
                                                %>

                                                <tr>
                                                    <td class="text-center">#<%=listEvent.get(i).getId()%></td>
                                                    <td class="text-center"><%=listEvent.get(i).getCreateDate()%></td>
                                                    <td class="text-center"><%=listEvent.get(i).getTakePlaceDate()%></td>
                                                    <td class="text-center"><%=listEvent.get(i).getSlotTime()%></td>
                                                    <td class="text-center"><%=listEvent.get(i).getOrgID()%></td>

                                                    <td class="text-left"><span class="text-wrap"><%=listEvent.get(i).getTitle()%></span>
                                                    </td>

                                                    <td class="text-center"><%=listEvent.get(i).getEventTypeName()%></td>
                                                    <td class="text-center">                                                       
                                                        <%
                                                            if (listEvent.get(i).isStatus() == true) {
                                                        %>
                                                        <span class="status text-success">&bull;</span>
                                                        <%
                                                        } else {
                                                        %>
                                                        <span  class="status text-danger">&bull;</span>
                                                        <% }%>


                                                        <%if (listEvent.get(i).isStatus()) {
                                                        %>
                                                        <span style="color: green">Active</span>
                                                        <%
                                                        } else {

                                                        %>
                                                        <span style="color: red">Inactive</span>
                                                        <%                                                                                        }
                                                        %>                                                    

                                                    </td>



                                                    <%
                                                        if (listEvent.get(i).getStatusTypeName().equals("Approved")) {
                                                    %>
                                                    <td style="color: green; font-weight: bold" class="text-center"><%=listEvent.get(i).getStatusTypeName()%></td>
                                                    <%
                                                    } else if (listEvent.get(i).getStatusTypeName().equals("Declined")) {
                                                    %>
                                                    <td style="color: red; font-weight: bold" class="text-center"><%=listEvent.get(i).getStatusTypeName()%></td>
                                                    <%
                                                    } else {
                                                    %>
                                                    <td style="color: #ffcc33; font-weight: bold" class="text-center"><%=listEvent.get(i).getStatusTypeName()%></td>

                                                    <% }%>


                                                    <td class="text-center"><a href="MainController?action=EventDetail&eventID=<%=listEvent.get(i).getId()%>"
                                                                               class="btn btn-primary btn-sm light">View</a></td>

                                                    <td>
                                                        <div class="text-center">

<!--                                                            <a href="MainController?action=EventTypeAndLocation&eventID=<%= listEvent.get(i).getId()%>&page=Club_Event.jsp" class="mr-4">
                                                                <i class=" las la-pencil-alt scale-2"></i>
                                                            </a>-->

                                                            <a type="button" class="mr-4" data-toggle="modal" data-target="#<%=listEvent.get(i).getId()%>"><i class=" las la-pencil-alt scale-2"></i></a>

                                                            <a onclick="return check();" href="MainController?action=DeleteEvent&eventID=<%=listEvent.get(i).getId()%>&page=Club_Event.jsp">
                                                                <i class="las la-trash-alt scale-2 text-danger"></i>
                                                            </a>
                                                        </div>   

                                                        <!--===================== UPDATE MODAL FORM=========================-->

                                                        <%
                                                            EventPost event = (EventPost) request.getAttribute("event_" + listEvent.get(i).getId());
                                                            if (event != null) {

                                                                Date now = new Date(System.currentTimeMillis());
                                                                Date takePlaceDate = Date.valueOf(event.getTakePlaceDate());
                                                                if (takePlaceDate.after(now)) { //  ĐƯỢC EDIT
                                                        %>

                                                        <div class="modal fade bd-example-modal-lg" id="<%=listEvent.get(i).getId()%>">
                                                            <div class="modal-dialog modal-lg" role="document">
                                                                <div class="modal-content">

                                                                    <div class="modal-header">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Update Event</h5>
                                                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                            </button>
                                                                        </div>

                                                                    </div>

                                                                    <div class="modal-body" style="padding: 0px 60px;">                                                                            
                                                                        <form action="MainController" method="POST" enctype="multipart/form-data">
                                                                            <div style="text-align: center">
                                                                                <h1 class="Information ">Update Event</h1>
                                                                            </div>

                                                                            <input type="hidden" name="eventID" value="<%=event.getId()%>">


                                                                            <% if (event.getOrgID().equals(user.getOrgID())) {%>


                                                                            <div class="row form-group">
                                                                                <h4><i class="fa-solid fa-users" style="width: 25px"></i>Event's Information</h4>

                                                                                <input type="hidden" name="FPT" value="FPT"/>

                                                                                <div class="input-group input-group-icon">
                                                                                    <input required="" style="padding: 14px;
                                                                                           padding-left: 4.4em;" type="text" value="<%=event.getTitle()%>" name="title" placeholder=""/>
                                                                                    <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                                                                                </div>

                                                                                <div class="input-group input-group-icon">
                                                                                    <input required="" style="padding: 14px;
                                                                                           padding-left: 4.4em;" type="text" value="<%=event.getSpeaker()%>" name="speaker" placeholder="Speaker"/>
                                                                                    <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                                </div>

                                                                                <div class="input-group input-group-icon">
                                                                                    <input type="number" value="<%=event.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="5"/>
                                                                                    <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                                </div> 
                                                                            </div>

                                                                            <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event's Type, Slot  Location</h4>
                                                                            <div class="row">                                                                                
                                                                                <select name="slotID" class="md-6">
                                                                                    <option hidden="" selected="" value="<%=event.getSlotID()%>"><%=event.getSlotTime()%></option>
                                                                                    <%for (int j = 0; j < listSlotTime.size(); j++) {
                                                                                    %>
                                                                                    <option value="<%=listSlotTime.get(j).getSlotID()%>"><%=listSlotTime.get(j).getSlotTime()%></option>
                                                                                    <%
                                                                                        }
                                                                                    %>
                                                                                </select>
                                                                                <select name="eventType" class="md-6">
                                                                                    <option hidden="" selected="" value="<%=event.getEventType()%>"><%=event.getEventTypeName()%></option>
                                                                                    <%for (int j = 0; j < listEvtType.size(); j++) {
                                                                                    %>
                                                                                    <option value="<%=listEvtType.get(j).getEventTypeID()%>"><%=listEvtType.get(j).getEventTypeName()%></option>
                                                                                    <%
                                                                                        }
                                                                                    %>
                                                                                </select>

                                                                            </div>
                                                                            <div class="row">
                                                                                <select style="width: 100%" name="location">
                                                                                    <option hidden="" selected="" value="<%=event.getLocation()%>"><%=event.getLocationName()%></option>
                                                                                    <%for (int j = 0; j < listEvtLocation.size(); j++) {
                                                                                    %>
                                                                                    <option value="<%=listEvtLocation.get(j).getLocationID()%>"><%=listEvtLocation.get(j).getLocaitonName()%></option>
                                                                                    <%
                                                                                        }
                                                                                    %>
                                                                                </select>
                                                                            </div>

                                                                            <div class="row form-group">
                                                                                <h4><i class="fa-solid fa-calendar-days" style="width: 25px;"></i>Take Place Date</h4>
                                                                                <%= evtError.getTakePlaceDate()%>
                                                                                <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                                                                                    <input required="" type="date" min="<%= LocalDate.now().plusDays(5)%>" value="<%= event.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
                                                                                    <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                                                                                </div>

                                                                            </div>

                                                                            <div class="row">                                                                                   
                                                                                <div class="form-group">
                                                                                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Summary</h4>
                                                                                    <div class="update-content form-group">
                                                                                        <textarea required="" name="summary" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                                  placeholder="Enter Event's Summary Here*"><%=event.getSummary()%></textarea>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Description</h4>
                                                                                    <div class="update-content">
                                                                                        <textarea required="" name="content" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                                  placeholder="Enter Event's Description Here*"><%=event.getContent()%></textarea>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="flex-row-reverse">
                                                                                <div class="row">
                                                                                    <h4>Status</h4>
                                                                                    <%
                                                                                        if (event.isStatus() == false) {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input id="status-true-<%=count%>" type="radio" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input id="status-false-<%=count%>" type="radio" name="status" checked="" value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%
                                                                                    } else {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input id="status-true-<%=count%>" type="radio" checked="" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input id="status-false-<%=count%>" type="radio" name="status"  value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%                     }
                                                                                    %>
                                                                                </div>
                                                                            </div>



                                                                            <% } else { %>

                                                                            <div class="flex-row-reverse">
                                                                                <div class="row">
                                                                                    <h4>Status</h4>
                                                                                    <%
                                                                                        if (event.isStatus() == false) {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input id="status-true-<%=count%>" type="radio" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input id="status-false-<%=count%>" type="radio" name="status" checked="" value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%
                                                                                    } else {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input id="status-true-<%=count%>" type="radio" checked="" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input id="status-false-<%=count%>" type="radio" name="status"  value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%                     }
                                                                                    %>
                                                                                </div>
                                                                            </div>

                                                                            <% }%>
                                                                            <div class="row">
                                                                                <h4><i class="fa-solid fa-link" style="width: 25px"></i>Image</h4>
                                                                                <div class="input-group input-group-icon">
                                                                                    <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                                                                                    <div class="input-icon"><i class="fa-solid fa-link"></i></div>
                                                                                </div>
                                                                            </div>

                                                                            <input type="hidden" name="page" value="Mod_Event.jsp">
                                                                            <div class="row modal-footer justify-content-center ">
                                                                                <button type="submit" style="cursor: pointer" class="login-box" name="action" value="UpdateEvent">
                                                                                    Update Event
                                                                                </button>

                                                                                <button  class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <% } else { //KHONG DUOC SUA%>
                                                        <div class="modal fade bd-example-modal-lg" id="<%=listEvent.get(i).getId()%>">
                                                            <div class="modal-dialog modal-lg" role="document">
                                                                <div class="modal-content">

                                                                    <div class="modal-header">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Update Event</h5>
                                                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                            </button>
                                                                        </div>

                                                                    </div>

                                                                    <div class="modal-body" style="padding: 0px 60px;">                                                                            
                                                                        <form action="MainController" method="POST" enctype="multipart/form-data">
                                                                            <div style="text-align: center">
                                                                                <h1 class="Information ">Update Event</h1>
                                                                            </div>

                                                                            <input type="hidden" name="eventID" value="<%=event.getId()%>">

                                                                            <% if (event.getOrgID().equals(user.getOrgID())) {%>

                                                                            <div class="row form-group">
                                                                                <h4><i class="fa-solid fa-users" style="width: 25px"></i>Event's Information</h4>

                                                                                <input type="hidden" name="FPT" value="FPT"/>

                                                                                <div class="input-group input-group-icon">
                                                                                    <input disabled="" style="padding: 14px;
                                                                                           padding-left: 4.4em;" type="text" value="<%=event.getTitle()%>" name="title" placeholder=""/>
                                                                                    <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                                                                                </div>

                                                                                <div class="input-group input-group-icon">
                                                                                    <input disabled="" style="padding: 14px;
                                                                                           padding-left: 4.4em;" type="text" value="<%=event.getSpeaker()%>" name="speaker" placeholder="Speaker"/>
                                                                                    <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                                </div>

                                                                                <div class="input-group input-group-icon">
                                                                                    <input disabled="" type="number" value="<%=event.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="5"/>
                                                                                    <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                                </div> 
                                                                            </div>

                                                                            <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event's Type and Location</h4>
                                                                            <div class="row">                                                                                
                                                                                <select disabled="" name="location" class="md-6">
                                                                                    <option hidden="" selected="" value="<%=event.getLocation()%>"><%=event.getLocationName()%></option>
                                                                                    <%for (int j = 0; j < listEvtLocation.size(); j++) {
                                                                                    %>
                                                                                    <option value="<%=listEvtLocation.get(j).getLocationID()%>"><%=listEvtLocation.get(j).getLocaitonName()%></option>
                                                                                    <%
                                                                                        }
                                                                                    %>
                                                                                </select>
                                                                                <select disabled="" name="eventType" class="md-6">
                                                                                    <option hidden="" selected="" value="<%=event.getEventType()%>"><%=event.getEventTypeName()%></option>
                                                                                    <%for (int j = 0; j < listEvtType.size(); j++) {
                                                                                    %>
                                                                                    <option value="<%=listEvtType.get(j).getEventTypeID()%>"><%=listEvtType.get(j).getEventTypeName()%></option>
                                                                                    <%
                                                                                        }
                                                                                    %>
                                                                                </select>
                                                                            </div>

                                                                            <div class="row form-group">
                                                                                <h4><i class="fa-solid fa-calendar-days" style="width: 25px;"></i>Take Place Date</h4>
                                                                                <%= evtError.getTakePlaceDate()%>
                                                                                <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                                                                                    <input disabled="" type="date" min="<%= LocalDate.now().plusDays(5)%>" value="<%= event.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
                                                                                    <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                                                                                </div>

                                                                            </div>

                                                                            <div class="row">                                                                                   
                                                                                <div class="form-group">
                                                                                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Summary</h4>
                                                                                    <div class="update-content form-group">
                                                                                        <textarea disabled="" name="summary" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                                  placeholder="Enter Event's Summary Here*"><%=event.getSummary()%></textarea>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Event Description</h4>
                                                                                    <div class="update-content">
                                                                                        <textarea disabled="" name="content" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                                  placeholder="Enter Event's Description Here*"><%=event.getContent()%></textarea>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="flex-row-reverse">
                                                                                <div class="row">
                                                                                    <h4>Status</h4>
                                                                                    <%
                                                                                        if (event.isStatus() == false) {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input disabled="" id="status-true-<%=count%>" type="radio" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input disabled="" id="status-false-<%=count%>" type="radio" name="status" checked="" value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%
                                                                                    } else {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input disabled="" id="status-true-<%=count%>" type="radio" checked="" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input disabled="" id="status-false-<%=count%>" type="radio" name="status"  value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%                     }
                                                                                    %>
                                                                                </div>
                                                                            </div>



                                                                            <% } else { %>

                                                                            <div class="flex-row-reverse">
                                                                                <div class="row">
                                                                                    <h4>Status</h4>
                                                                                    <%
                                                                                        if (event.isStatus() == false) {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input disabled="" id="status-true-<%=count%>" type="radio" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input disabled="" id="status-false-<%=count%>" type="radio" name="status" checked="" value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%
                                                                                    } else {
                                                                                    %>
                                                                                    <div class="input-group">
                                                                                        <input disabled="" id="status-true-<%=count%>" type="radio" checked="" name="status" value="true"/>
                                                                                        <label for="status-true-<%=count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input disabled="" id="status-false-<%=count%>" type="radio" name="status"  value="false"/>
                                                                                        <label for="status-false-<%=count%>">Inactive</label>
                                                                                    </div>
                                                                                    <%                     }
                                                                                    %>
                                                                                </div>
                                                                            </div>

                                                                            <% }%>

                                                                            <div class="modal-footer justify-content-center">
                                                                                <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                            </div>
                                                                    </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        </div>
                                                        <% }
                                                            } %>
                                                        <!--================================================================-->
                                                    </td>
                                                </tr>
                                                <%                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--**********************************
        Content body end
    ***********************************-->

            <!--**********************************
        Footer start
    ***********************************-->
            <div class="footer">
                <div class="copyright">
                    <p>© Best For Event Management Schedule
                        &amp; Developed by <a href="http://dexignzone.com/" target="_blank">F.E.M</a> 2022</p>
                </div>
            </div>


            <!--**********************************
        Footer end
    ***********************************-->

            <!--**********************************
       Support ticket button start
    ***********************************-->

            <!--**********************************
       Support ticket button end
    ***********************************-->


        </div>

        <!--**********************************
        Main wrapper end
    ***********************************-->

        <!--**********************************
        Scripts
    ***********************************-->
        <!-- Required vendors -->

        <script>
            function check() {
                if (confirm("Are you sure to remove this event?") === false) {
                    return false;
                } else {
                    return true;
                }
            }
        </script>

        <script src="./css_Admin/vendor/global/global.min.js"></script>
        <!--        <script src="./css_Admin/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
                <script src="./css_Admin/vendor/chart.js/Chart.bundle.min.js"></script>-->
        <script src="./css_Admin/js/custom.min.js"></script>
        <script src="./css_Admin/js/deznav-init.js"></script>

        <!-- Datatable -->
        <script src="./css_Admin/vendor/datatables/js/jquery.dataTables.min.js"></script>

        <!--<script src="./css_FormCreate/script.js"></script>-->
        <!--<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>-->

        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>

        <!--        <script>
                    var now = new Date();
                    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
                    document.getElementById('curdate').min = now.toISOString().slice(0, 16);
                </script>-->

        <%  %>
        <script>
            (function ($) {
                var table = $('#example2').DataTable({
                    searching: false,
                    paging: true,
                    select: false,
                    //info: false,         
                    lengthChange: false

                });
                var table = $('#example3').DataTable({
                    searching: false,
                    paging: true,
                    select: false,
                    //info: false,         
                    lengthChange: false

                });
                var table = $('#example4').DataTable({
                    searching: false,
                    paging: true,
                    select: false,
                    //info: false,         
                    lengthChange: false

                });
                var table = $('#example5').DataTable({
                    searching: false,
                    paging: true,
                    select: false,
                    //info: false,         
                    lengthChange: false

                });
                $('#example tbody').on('click', 'tr', function () {
                    var data = table.row(this).data();

                });
            })(jQuery);

        </script>

        <%
            String success = (String) request.getAttribute("SUCCESS");
            String failed = (String) request.getAttribute("FAILED");
            String dupSlot = (String) request.getAttribute("DUP_SLOT");

            if ("success".equals(success)) {
        %>
        <script>
            toastr.options = {
                "closeButton": true,
                "debug": true,
                "newestOnTop": false,
                "progressBar": true,
                "preventDuplicates": false,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "5000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut",
                "position-class": "toast-top-full-width"
            }
            toastr["success"]("Successfully!!").css("height", "50px");
        </script>
        <% } else if ("failed".equals(failed)) { %>
        <script>
            toastr.options = {
                "closeButton": true,
                "debug": true,
                "newestOnTop": false,
                "progressBar": true,
                "preventDuplicates": false,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "5000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut",
                "position-class": "toast-top-full-width"
            }
            toastr["error"]("Failed!!!").css("height", "50px");
        </script>
        <% } else if ("dupSlot".equals(dupSlot)) { %>
        <script>
            toastr.options = {
                "closeButton": true,
                "debug": true,
                "newestOnTop": false,
                "progressBar": true,
                "preventDuplicates": false,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "5000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut",
                "position-class": "toast-top-full-width"
            }
            toastr["error"]("Location has been occupied!!").css("height", "50px");
        </script>
        <% }%>


    </body>

</html>