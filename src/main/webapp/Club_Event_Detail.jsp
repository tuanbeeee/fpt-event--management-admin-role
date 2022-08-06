<%@page import="java.time.LocalDate"%>
<%@page import="sample.slot.SlotTime"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="sample.posts.EventLocation"%>
<%@page import="sample.eventtype.EventType"%>
<%@page import="sample.comment.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.users.UserNotification"%>
<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@page import="sample.posts.EventPost"%>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>F.E.M - Event Detail Page</title>
        <!-- Favicon icon -->
        <link rel="stylesheet" href="./css_FormCreate/style.css">
        <link rel="stylesheet" href="./css_FormCreate/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="./css_ModComment/style.css" />
        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />-->
        <!--        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>-->
        <!--        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>-->

        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />-->

        <link rel="icon" type="image/png" sizes="16x16" href="./css_Admin/images/Biểu-tượng-không-chữ.png">
        <!--<link rel="stylesheet" href="./css_Admin/vendor/chartist/css/chartist.min.css">-->
        <!--<link href="./css_Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">-->
        <!--<link href="./css_Admin/vendor/owl-carousel/owl.carousel.css" rel="stylesheet">-->
        <link href="./css_Admin/css/style.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    </head>

    <%EventPost evt = (EventPost) request.getAttribute("event");
        int participants = (Integer) request.getAttribute("participants");
        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        List<UserNotification> listNoti = (List) request.getAttribute("USER_NOTIFICATION");
        List<CommentDTO> listCmt = (List) request.getAttribute("LIST_COMMENT");
        List<EventType> listEvtType = (List<EventType>) request.getAttribute("listEventTypes");
        List<EventLocation> listEvtLocation = (List<EventLocation>) request.getAttribute("listEventLocations");
        List<SlotTime> listSlotTime = (List<SlotTime>) request.getAttribute("listSlotTime");
    %>



    <body>

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
                <%
                    if (user.getRoleID().equals("CLB")) {
                %>
                <a href="MainController?action=ListOrgEvent" class="brand-logo">
                    <img class="brand-title" src="./css_Admin/images/femLogo.png" alt="">
                </a>
                <% } else { %>
                <a href="MainController?action=ListEvent" class="brand-logo">
                    <img class="brand-title" src="./css_Admin/images/femLogo.png" alt="">
                </a>
                <% }%>


                <div class="nav-control">
                    <div class="hamburger">
                        <span class="line"></span><span class="line"></span><span class="line"></span>
                    </div>
                </div>
            </div>
            <!--**********************************
                Nav header end
            ***********************************-->
            <!--**********************************
        Header start
    ***********************************-->
            <div class="header">
                <div class="header-content">
                    <nav class="navbar navbar-expand">
                        <div class="collapse navbar-collapse justify-content-between">
                            <div class="header-left">
                                <div class="dashboard_bar">
                                    Event Detail
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">                                
                                <li class="nav-item dropdown notification_dropdown">
                                    <a class="nav-link  ai-icon" href="javascript:void(0)" role="button" data-toggle="dropdown">
                                        <svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12.8333 5.91732V3.49998C12.8333 2.85598 13.356 2.33331 14 2.33331C14.6428 2.33331 15.1667 2.85598 15.1667 3.49998V5.91732C16.9003 6.16698 18.5208 6.97198 19.7738 8.22498C21.3057 9.75681 22.1667 11.8346 22.1667 14V18.3913L23.1105 20.279C23.562 21.1831 23.5142 22.2565 22.9822 23.1163C22.4513 23.9761 21.5122 24.5 20.5018 24.5H15.1667C15.1667 25.144 14.6428 25.6666 14 25.6666C13.356 25.6666 12.8333 25.144 12.8333 24.5H7.49817C6.48667 24.5 5.54752 23.9761 5.01669 23.1163C4.48469 22.2565 4.43684 21.1831 4.88951 20.279L5.83333 18.3913V14C5.83333 11.8346 6.69319 9.75681 8.22502 8.22498C9.47919 6.97198 11.0985 6.16698 12.8333 5.91732ZM14 8.16664C12.4518 8.16664 10.969 8.78148 9.87469 9.87581C8.78035 10.969 8.16666 12.453 8.16666 14V18.6666C8.16666 18.8475 8.12351 19.026 8.04301 19.1881C8.04301 19.1881 7.52384 20.2265 6.9755 21.322C6.88567 21.5028 6.89501 21.7186 7.00117 21.8901C7.10734 22.0616 7.29517 22.1666 7.49817 22.1666H20.5018C20.7037 22.1666 20.8915 22.0616 20.9977 21.8901C21.1038 21.7186 21.1132 21.5028 21.0234 21.322C20.475 20.2265 19.9558 19.1881 19.9558 19.1881C19.8753 19.026 19.8333 18.8475 19.8333 18.6666V14C19.8333 12.453 19.2185 10.969 18.1242 9.87581C17.0298 8.78148 15.547 8.16664 14 8.16664Z" fill="#FE634E"/>
                                        </svg>
                                        <div class="pulse-css"></div>
                                    </a>
                                    <div class="dropdown-menu rounded dropdown-menu-right">
                                        <div id="DZ_W_Notification1" class="widget-media dz-scroll p-3 height380">
                                            <ul class="timeline">
                                                <%for (int i = 0; i < listNoti.size(); i++) {
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
                                        <a class="all-notification" href="javascript:void(0)">See all notifications <i class="ti-arrow-right"></i></a>
                                    </div>
                                </li>
                                <li class="nav-item dropdown header-profile">
                                    <a class="nav-link" href="javascript:void(0)" role="button" data-toggle="dropdown">
                                        <img src="<%=user.getPicture()%>" width="20" alt=""/>
                                        <div class="header-info">
                                            <span class="text-black"><strong><%=user.getName()%></strong></span>
                                            <p class="fs-12 mb-0"><%=user.getRoleID()%></p>
                                        </div>
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
            <div class="deznav">
                <div class="deznav-scroll">

                    <ul class="metismenu" id="menu">
                        <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
                                <i class="flaticon-381-networking"></i>
                                <span class="nav-text">Dashboard</span>
                            </a>
                            <ul aria-expanded="false">
                                <%if ("MOD".equals(user.getRoleID())) {
                                %>

                                <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">Event</a>
                                    <ul aria-expanded="false">
                                        <li><a href="MainController?action=ListEvent">List Event</a></li>
                                        <li><a href="MainController?action=ListLocation">Location</a></li>
                                        <li><a href="MainController?action=ListEventType">Event Type</a></li>
                                        </br>
                                    </ul>
                                </li>

                                <li><a href="MainController?action=ListBlog">Blog</a></li>	
                                    <%
                                    } else {
                                    %>
                                <li><a href="MainController?action=ListOrgEvent">Event</a></li>
                                <li><a href="MainController?action=ListBlog">Blog</a></li>
                                    <%
                                        }
                                    %>
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

                    <div class="row">
                        <div class="col-xl-7">
                            <div class="row">
                                <div class="col-xl-12">
                                    <div class="card event-detail-bx overflow-hidden">
                                        <div class="card-media">
                                            <img src="images/ESL_International_Pan-1-1200x490.jpg" alt="" class="w-100">
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex flex-wrap align-items-center mb-4">
                                                <h2 class="text-black col-md-6 p-0 col-md-12 mr-auto title mb-3"><%=evt.getTitle()%></h2>
                                                <div class="d-flex align-items-center">

                                                    <div class="media bg-light p-3 rounded align-items-center mr-3">
                                                        <div class="media-body mr-2">
                                                            <span class="fs-12 d-block mb-1"><i class="fa fa-check-circle" aria-hidden="true"></i> Approval status</span>
                                                            <%
                                                                if (evt.getStatusTypeName().equals("Approved")) {
                                                            %>
                                                            <span style="color: green; font-weight: bold" class="text-center"><%=evt.getStatusTypeName()%></span>
                                                            <%
                                                            } else if (evt.getStatusTypeName().equals("Declined")) {
                                                            %>
                                                            <span style="color: red; font-weight: bold" class="text-center"><%=evt.getStatusTypeName()%></span>
                                                            <%
                                                            } else {
                                                            %>
                                                            <span style="color: #ffcc33; font-weight: bold" class="text-center"><%=evt.getStatusTypeName()%></span>
                                                            <% }%>
                                                        </div>                                                       
                                                    </div>


                                                    <div class="media bg-light p-3 rounded align-items-center mr-3">
                                                        <div class="media-body mr-2">
                                                            <span class= "fs-12 d-block mb-1"><i class="fa fa-check-circle" aria-hidden="true"></i> Status</span>               
                                                            <%if (evt.isStatus()) {
                                                            %>
                                                            <span style="color: green; font-weight: bold">Active</span>
                                                            <%
                                                            } else {
                                                            %>
                                                            <span style="color: red; font-weight: bold">Inactive</span>
                                                            <%
                                                                }
                                                            %>  
                                                        </div>                                                       
                                                    </div>



                                                    <div class="media bg-light p-3 rounded align-items-center mr-3">
                                                        <div class="media-body mr-2">
                                                            <span class="fs-12 d-block mb-1"><i class="fa fa-user" aria-hidden="true"></i>
                                                                Speaker</span>
                                                            <span class="fs-16 text-black"><%=evt.getSpeaker()%></span>
                                                        </div>                                                       
                                                    </div>





                                                    <%
                                                        if (user.getRoleID().equals("MOD") && evt.getStatusTypeID().equals("PE")) {
                                                    %>                                                        


                                                    <div class="align-items-center mr-3 ">
                                                        <span class=""><a style="padding: 15px 40px" href="MainController?action=ApproveEvent&eventID=<%=evt.getId()%>"
                                                                          class="btn btn-outline-success ">Approve</a></span>


                                                        <button style="padding: 15px 40px" class="btn btn-outline-danger" 
                                                                data-toggle="modal" data-target="#exampleModalCenter">
                                                            Decline
                                                        </button>

                                                    </div>

                                                    <%  }%>

                                                    <!-- Button trigger modal -->



                                                    <!-- Modal -->
                                                    <div  class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered" role="document">

                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalCenterTitle">Reason</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>

                                                                <form action="MainController" method="POST">
                                                                    <div style="margin: 10px; color: black" class="form-group">
                                                                        <label for="message-text" class="col-form-label">Message:</label>
                                                                        <textarea style="color: black"  name="declineDescription" rows="4" class="form-control"></textarea>
                                                                    </div>

                                                                    <input name="eventID" type="hidden" value="<%=evt.getId()%>" >

                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                        <button type="submit" name="action" value="DeclineEvent" type="submit" class="btn btn-primary">Submit</button>
                                                                    </div>
                                                                </form>

                                                            </div>
                                                        </div>
                                                    </div>




                                                    <div class="dropdown">
                                                        <div class="share-icon" role="button" data-toggle="dropdown" aria-expanded="false">
                                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M12 13C12.5523 13 13 12.5523 13 12C13 11.4477 12.5523 11 12 11C11.4477 11 11 11.4477 11 12C11 12.5523 11.4477 13 12 13Z" stroke="#FE634E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M12 6C12.5523 6 13 5.55228 13 5C13 4.44772 12.5523 4 12 4C11.4477 4 11 4.44772 11 5C11 5.55228 11.4477 6 12 6Z" stroke="#FE634E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M12 20C12.5523 20 13 19.5523 13 19C13 18.4477 12.5523 18 12 18C11.4477 18 11 18.4477 11 19C11 19.5523 11.4477 20 12 20Z" stroke="#FE634E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                            </svg>
                                                        </div>
                                                        <div class="dropdown-menu dropdown-menu-right">

                                                            <a type="button" class="dropdown-item" data-toggle="modal" data-target="#updateEvent">Edit</a>
                                                            <a onclick="return check();" class="dropdown-item" href="MainController?action=DeleteEvent&eventID=<%=evt.getId()%>">Delete</a>
                                                            <a class="dropdown-item" href="MainController?action=ListParticipants&eventID=<%=evt.getId()%>">List Participants</a>
                                                            <a class="dropdown-item" href="MainController?action=ListFeedbacks&eventID=<%=evt.getId()%>">List Feedback</a>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!--============ UPDATE EVENT ============-->                                           
                                            <%    if (evt != null) {
                                                    Date now = new Date(System.currentTimeMillis());
                                                    Date takePlaceDate = Date.valueOf(evt.getTakePlaceDate());
                                                    if (takePlaceDate.after(now)) { //  ĐƯỢC EDIT
                                            %>

                                            <div class="modal fade bd-example-modal-lg" id="updateEvent">
                                                <div class="modal-dialog modal-lg" role="document">
                                                    <div class="modal-content">

                                                        <div class="modal-header">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Update Event</h5>
                                                                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                </button>
                                                            </div>
                                                        </div>

                                                        <form action="MainController" method="POST" enctype="multipart/form-data">


                                                            <div class="modal-body" style="padding: 0px 60px;">                                                                            
                                                                <div style="text-align: center">
                                                                    <h1 class="Information ">Update Event</h1>
                                                                </div>

                                                                <input type="hidden" name="eventID" value="<%=evt.getId()%>">

                                                                <% if (("PE".equals(evt.getStatusTypeID()) && "CLB".equals(user.getRoleID()))
                                                                            || (user.getOrgID().equals(evt.getOrgID()) && "MOD".equals(user.getRoleID()))) {%>

                                                                <h4><i class="fa fa-info-circle" aria-hidden="true"></i> Event's Information</h4>

                                                                <div class="row form-group">

                                                                    <div class="input-group input-group-icon">
                                                                        <input required="" type="text" value="<%=evt.getTitle()%>" name="title" placeholder=""/>
                                                                        <div class="input-icon"><i class="fa fa-font" aria-hidden="true"></i>
                                                                        </div>
                                                                    </div>

                                                                    <div class="input-group input-group-icon">
                                                                        <input type="text" value="<%=evt.getSpeaker()%>" name="speaker" placeholder=""/>
                                                                        <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                    </div>

                                                                    <div class="input-group input-group-icon">
                                                                        <input type="number" value="<%=evt.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="5"/>
                                                                        <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                    </div> 

                                                                </div>
                                                                <h4><i class="fa fa-map-marker" aria-hidden="true"></i> Event's Type, Slot  Location</h4>

                                                                <div class="row form-group">
                                                                    <select name="slotID" class="md-6">
                                                                        <option hidden="" selected="" value="<%=evt.getSlotID()%>"><%=evt.getSlotTime()%></option>
                                                                        <%for (int j = 0; j < listSlotTime.size(); j++) {
                                                                        %>
                                                                        <option value="<%=listSlotTime.get(j).getSlotID()%>"><%=listSlotTime.get(j).getSlotTime()%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                    <select name="eventType" class="md-6">
                                                                        <option hidden="" selected="" value="<%=evt.getEventType()%>"><%=evt.getEventTypeName()%></option>
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
                                                                        <option hidden="" selected="" value="<%=evt.getLocation()%>"><%=evt.getLocationName()%></option>
                                                                        <%for (int j = 0; j < listEvtLocation.size(); j++) {
                                                                        %>
                                                                        <option value="<%=listEvtLocation.get(j).getLocationID()%>"><%=listEvtLocation.get(j).getLocaitonName()%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                </div>

                                                                <h4 style="margin-top: 20px"><i class="fa fa-calendar" aria-hidden="true"></i> Take Place Date</h4>

                                                                <div class="row form-group">
                                                                    <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                                                                        <input required="" type="date" min="<%= LocalDate.now().plusDays(5)%>" value="<%=evt.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
                                                                        <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                                                                    </div>
                                                                </div>

                                                                <div class="row">     
                                                                    <h4><i class="fa fa-file-text" aria-hidden="true"></i> Event Summary</h4>
                                                                    <div class="form-group">

                                                                        <div class="update-content form-group">
                                                                            <textarea required="" name="summary" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                      placeholder="Enter Event's Summary Here*"><%=evt.getSummary()%></textarea>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <h4><i class="fa fa-file-text" aria-hidden="true"></i> Event Description</h4>
                                                                        <div class="update-content">
                                                                            <textarea required="" name="content" id="role" rows="9" style="width: 710px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                      placeholder="Enter Event's Description Here*"><%=evt.getContent()%></textarea>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <input type="hidden" name="FPT" value="FPT"/>

                                                                <div class="row">
                                                                    <h4><i class="fa fa-file-image-o" aria-hidden="true"></i> Image</h4>
                                                                    <div class="input-group input-group-icon">
                                                                        <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                                                                        <div class="input-icon"><i class="fa-solid fa-link"></i></div>
                                                                    </div>
                                                                </div>

                                                                <% if ("MOD".equals(user.getRoleID())) { %>

                                                                <div class="row">
                                                                    <h4>Status</h4>
                                                                    <%
                                                                        if (evt.isStatus() == false) {
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
                                                                        <inp id="status-true" type="radio" checked="" name="status" value="true"/>
                                                                        <label for="status-true">Active</label>

                                                                        <inputs  id="status-false" type="radio" name="status" value="false"/>
                                                                        <label for="status-false">Inactive</label>
                                                                    </div>
                                                                    <%                     }
                                                                    %>
                                                                </div>
                                                                <% } %>


                                                            </div>

                                                            <div class="row modal-footer justify-content-center">
                                                                <button type="submit" style="cursor: pointer" class="login-box" name="action" value="UpdateEvent">
                                                                    Update Event
                                                                </button>
                                                                <button  class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                            </div>

                                                            <% } else if (!"PE".equals(evt.getStatusTypeID()) && "CLB".equals(user.getRoleID())) {%>
                                                            <h4><i class="fa fa-info-circle" aria-hidden="true"></i> Event's Information</h4>

                                                            <div class="row form-group">


                                                                <div class="input-group input-group-icon">
                                                                    <input disabled="" style="padding: 14px;
                                                                           padding-left: 4.4em;" type="text" value="<%=evt.getTitle()%>" name="title" placeholder=""/>
                                                                    <div class="input-icon"><i class="fa fa-font" aria-hidden="true"></i>
                                                                    </div>
                                                                </div>

                                                                <div class="input-group input-group-icon">
                                                                    <input disabled="" style="padding: 14px;
                                                                           padding-left: 4.4em;" type="text" value="<%=evt.getSpeaker()%>" name="speaker" placeholder="Speaker"/>
                                                                    <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                </div>

                                                                <div class="input-group input-group-icon">
                                                                    <input disabled="" type="number" value="<%=evt.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="5"/>
                                                                    <div class="input-icon"><i class="fa fa-user"></i></div>
                                                                </div> 
                                                            </div>
                                                            <h4><i class="fa fa-map-marker" aria-hidden="true"></i> Event's Type, Slot  Location</h4>

                                                            <div class="row form-group">  
                                                                <select disabled="" name="slotID" class="md-6">
                                                                    <option hidden="" selected="" value="<%=evt.getSlotID()%>"><%=evt.getSlotTime()%></option>
                                                                    <%for (int j = 0; j < listSlotTime.size(); j++) {
                                                                    %>
                                                                    <option value="<%=listSlotTime.get(j).getSlotID()%>"><%=listSlotTime.get(j).getSlotTime()%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                                <select disabled="" name="eventType" class="md-6">
                                                                    <option hidden="" selected="" value="<%=evt.getEventType()%>"><%=evt.getEventTypeName()%></option>
                                                                    <%for (int j = 0; j < listEvtType.size(); j++) {
                                                                    %>
                                                                    <option value="<%=listEvtType.get(j).getEventTypeID()%>"><%=listEvtType.get(j).getEventTypeName()%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>

                                                            </div>

                                                            <div class="row">
                                                                <select disabled="" style="width: 100%" name="location">
                                                                    <option hidden="" selected="" value="<%=evt.getLocation()%>"><%=evt.getLocationName()%></option>
                                                                    <%for (int j = 0; j < listEvtLocation.size(); j++) {
                                                                    %>
                                                                    <option value="<%=listEvtLocation.get(j).getLocationID()%>"><%=listEvtLocation.get(j).getLocaitonName()%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </div>

                                                            <h4 style="margin-top: 20px"><i class="fa fa-calendar" aria-hidden="true"></i> Take Place Date</h4>
                                                            <div class="row form-group">

                                                                <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                                                                    <input disabled="" type="date" min="<%= LocalDate.now().plusDays(5)%>" value="<%= evt.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
                                                                    <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                                                                </div>

                                                            </div>

                                                            <div class="row">                   
                                                                <h4><i class="fa fa-file-text" aria-hidden="true"></i> Event Summary</h4>                                                                        
                                                                <div class="form-group">
                                                                    <textarea disabled="" name="summary" id="role" rows="9" style="width: 710px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                              placeholder="Enter Event's Summary Here*"><%=evt.getSummary()%></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <h4><i class="fa fa-file-text" aria-hidden="true"></i> Event Description</h4>
                                                                <div class="update-content">
                                                                    <textarea disabled="" name="content" id="role" rows="9" style="width: 710px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                              placeholder="Enter Event's Description Here*"><%=evt.getContent()%></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="flex-row-reverse">
                                                                <div class="row">
                                                                    <h4>Status</h4>
                                                                    <%
                                                                        if (evt.isStatus() == false) {
                                                                    %>
                                                                    <div class="input-group">
                                                                        <input disabled="" id="status-true" type="radio" name="status" value="true"/>
                                                                        <label for="status-true">Active</label>

                                                                        <input disabled="" id="status-false" type="radio" name="status" checked="" value="false"/>
                                                                        <label for="status-false">Inactive</label>
                                                                    </div>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <div class="input-group">
                                                                        <input disabled="" id="status-true" type="radio" checked="" name="status" value="true"/>
                                                                        <label for="status-true">Active</label>

                                                                        <input disabled=""   id="status-false" type="radio" name="status"  value="false"/>
                                                                        <label for="status-false">Inactive</label>
                                                                    </div>
                                                                    <%                     }
                                                                    %>
                                                                </div>
                                                            </div>
                                                            <div class="row modal-footer justify-content-center">
                                                                <button  class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                            </div>
                                                    </div>


                                                    <% } else { // NHUNG THANG CON LAI %>

                                                    <div class="flex-row-reverse">
                                                        <div class="row">
                                                            <h4>Status</h4>
                                                            <%
                                                                if (evt.isStatus() == false) {
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
                                                </div>
                                                <div class="row modal-footer justify-content-center">
                                                    <button type="submit" style="cursor: pointer" class="login-box" name="action" value="UpdateEvent">
                                                        Update Event
                                                    </button>
                                                    <button  class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                </div>

                                                <% }%>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <% } else {%>
                                    <div class="modal fade bd-example-modal-lg" id="updateEvent">
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

                                                        <input type="hidden" name="eventID" value="<%=evt.getId()%>"> 



                                                        <h4><i class="fa fa-info-circle" aria-hidden="true"></i> Event's Information</h4>

                                                        <div class="row form-group">

                                                            <input type="hidden" name="FPT" value="FPT"/>

                                                            <div class="input-group input-group-icon">
                                                                <input disabled="" style="padding: 14px;
                                                                       padding-left: 4.4em;" type="text" value="<%=evt.getTitle()%>" name="title" placeholder=""/>
                                                                <div class="input-icon"><i class="fa fa-font" aria-hidden="true"></i>
                                                                </div>
                                                            </div>

                                                            <div class="input-group input-group-icon">
                                                                <input disabled="" style="padding: 14px;
                                                                       padding-left: 4.4em;" type="text" value="<%=evt.getSpeaker()%>" name="speaker" placeholder="Speaker"/>
                                                                <div class="input-icon"><i class="fa fa-user"></i></div>
                                                            </div>

                                                            <div class="input-group input-group-icon">
                                                                <input disabled="" type="number" value="<%=evt.getParticipationLimit()%>" name="participationLimit" placeholder="Number of Participant" min="5"/>
                                                                <div class="input-icon"><i class="fa fa-user"></i></div>
                                                            </div> 
                                                        </div>

                                                        <h4><i class="fa fa-map-marker" aria-hidden="true"></i> Event's Type, Slot  Location</h4>
                                                        <div class="row form-group">


                                                            <select disabled="" name="slotID" class="md-6">
                                                                <option hidden="" selected="" value="<%=evt.getSlotID()%>"><%=evt.getSlotTime()%></option>
                                                                <%for (int j = 0; j < listSlotTime.size(); j++) {
                                                                %>
                                                                <option value="<%=listSlotTime.get(j).getSlotID()%>"><%=listSlotTime.get(j).getSlotTime()%></option>
                                                                <%
                                                                    }
                                                                %>
                                                            </select>
                                                            <select disabled="" name="eventType" class="md-6">
                                                                <option hidden="" selected="" value="<%=evt.getEventType()%>"><%=evt.getEventTypeName()%></option>
                                                                <%for (int j = 0; j < listEvtType.size(); j++) {
                                                                %>
                                                                <option value="<%=listEvtType.get(j).getEventTypeID()%>"><%=listEvtType.get(j).getEventTypeName()%></option>
                                                                <%
                                                                    }
                                                                %>
                                                            </select>

                                                        </div>
                                                        <div class="row">
                                                            <select disabled="" style="width: 100%" name="location">
                                                                <option hidden="" selected="" value="<%=evt.getLocation()%>"><%=evt.getLocationName()%></option>
                                                                <%for (int j = 0; j < listEvtLocation.size(); j++) {
                                                                %>
                                                                <option value="<%=listEvtLocation.get(j).getLocationID()%>"><%=listEvtLocation.get(j).getLocaitonName()%></option>
                                                                <%
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <h4 style="margin-top: 20px"><i class="fa fa-calendar" aria-hidden="true"></i> Take Place Date</h4>
                                                        <div class="row form-group">

                                                            <div class="input-group input-group-icon" style="font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;">
                                                                <input disabled="" type="date" min="<%= LocalDate.now().plusDays(5)%>" value="<%= evt.getTakePlaceDate()%>" name="takePlaceDate" class="font-color"/>
                                                                <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                                                            </div>

                                                        </div>

                                                        <div class="row">
                                                            <div class="form-group">
                                                                <h4><i class="fa fa-file-text" aria-hidden="true"></i> Event Summary</h4>
                                                                <div class="update-content form-group">
                                                                    <div class="update-content">
                                                                        <textarea disabled="" name="summary" id="role" rows="9" style="width: 710px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                  placeholder="Enter Event's Summary Here*"><%=evt.getSummary()%></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <h4><i class="fa fa-file-text" aria-hidden="true"></i> Event Description</h4>
                                                                <div class="update-content form-group">
                                                                    <div class="update-content">
                                                                        <textarea disabled="" name="content" id="role" rows="9" style="width: 710px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                                                                                  placeholder="Enter Event's Description Here*"><%=evt.getContent()%></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex-row-reverse">
                                                            <div class="row">
                                                                <h4>Status</h4>
                                                                <%
                                                                    if (evt.isStatus() == false) {
                                                                %>
                                                                <div class="input-group">
                                                                    <input disabled="" id="status-true" type="radio" name="status" value="true"/>
                                                                    <label for="status-true">Active</label>

                                                                    <input disabled="" id="status-false" type="radio" name="status" checked="" value="false"/>
                                                                    <label for="status-false">Inactive</label>
                                                                </div>
                                                                <%
                                                                } else {
                                                                %>
                                                                <div class="input-group">
                                                                    <input disabled="" id="status-true" type="radio" checked="" name="status" value="true"/>
                                                                    <label for="status-true">Active</label>

                                                                    <input disabled="" id="status-false" type="radio" name="status"  value="false"/>
                                                                    <label for="status-false">Inactive</label>
                                                                </div>
                                                                <%                     }
                                                                %>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="row justify-content-center modal-footer">                                                                   
                                                    <button  class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                            }
                                        }%>


                                    <!--================================================================-->

                                    <!--===============================-->


                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-xxl-4 mb-3">
                                            <div class="media bg-light p-3 rounded align-items-center">	
                                                <div class="media-body">
                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-eye" aria-hidden="true"></i>  Viewer</span>
                                                    <span class="fs-16 text-black"><%=evt.getNumberOfView()%> View</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xxl-4 mb-3">
                                            <div class="media bg-light p-3 rounded align-items-center">	
                                                <div class="media-body">

                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-users" aria-hidden="true"></i>  Participants</span>
                                                    <span class="fs-16 text-black"><%=participants%>/<%=evt.getParticipationLimit()%>
                                                        People</span>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xxl-4 mb-3">
                                            <div class="media bg-light p-3 rounded align-items-center">	
                                                <div class="media-body">

                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-address-book" aria-hidden="true"></i>
                                                        Club</span>
                                                    <span class="fs-16 text-black"><%=evt.getOrgName()%></span>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xxl-4 mb-3">
                                            <div class="media bg-light p-3 rounded align-items-center">	

                                                <div class="media-body">
                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-map-marker" aria-hidden="true"></i>  Location</span>
                                                    <span class="fs-16 text-black"><%=evt.getLocationName()%></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xxl-4 mb-3">
                                            <div class="media bg-light p-3 rounded align-items-center">	

                                                <div class="media-body">
                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-calendar" aria-hidden="true"></i>  Date</span>
                                                    <span class="fs-16 text-black"><%=evt.getTakePlaceDate()%></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xxl-4 mb-3">
                                            <div class="media bg-light p-3 rounded align-items-center">	

                                                <div class="media-body">
                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-clock-o" aria-hidden="true"></i>
                                                        Time</span>
                                                    <span class="fs-16 text-black"><%=evt.getSlotTime()%></span>
                                                </div>
                                            </div>
                                        </div>


                                        <%if ("CLB".equals(user.getRoleID()) && "DE".equals(evt.getStatusTypeID())) {
                                        %>
                                        <div class="col-lg-12 col-md-12 col-xxl-12 mb-12">
                                            <div class="media bg-light p-3 rounded align-items-center">

                                                <div class="media-body">
                                                    <span class="fs-12 d-block mb-1"><i class="fa fa-exclamation-circle" aria-hidden="true"></i>
                                                        Decline Description</span>
                                                    <span class="fs-16 text-black"><%=evt.getApprovalDes()%></span>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                            }
                                        %>   
                                    </div>

                                    <h4 style="margin-top: 10px" class="fs-20 text-black font-w600">Event Summary</h4>
                                    <p class="fs-14 mb-0"><%=evt.getSummary()%>
                                    </p>

                                    <br>

                                    <h4 class="fs-20 text-black font-w600">Event Description </h4>
                                    <p class="fs-14 mb-0"><%=evt.getContent()%>
                                    </p>
                                </div>
                            </div>
                        </div>                               
                    </div>



                    <div class="row">
                        <div class="col-xl-12">
                            <div class="card event-detail-bx overflow-hidden ">
                                <div class="card-body">
                                    <div class="comments">

                                        <!-- Phần Mình Sẽ Comment -->
                                        <div class="comment-box add-comment header-right">
                                            <span>
                                                <img src="<%= user.getPicture()%>" style="border-radius: 1.25rem;" width="40" height="40">
                                            </span>
                                            <span class="commenter-name">
                                                <form action="MainController" method="POST">
                                                    <input type="hidden" name="eventID" value="<%= evt.getId()%>" />
                                                    <input type="text" placeholder="Add a public comment" name="content">
                                                    <button type="submit" name="action" value="Comment" class="btn btn-primary">Comment</button>
                                                    <button type="Reset" class="btn btn-default">Cancel</button>
                                                </form>

                                            </span>
                                        </div>

                                        <div class="comments-details">
                                            <span class="total-comments comments-sort"><%= listCmt.size()%> Comments</span>
                                        </div>

                                        <div class="accordion" id="myaccordion" />
                                        <%
                                            int count = 0;

                                            if (listCmt
                                                    != null) {
                                                for (CommentDTO cmt : listCmt) {
                                                    if (cmt.getReplyID() == null) {
                                                        String countString = "reply" + count;
                                                        count++;
                                        %>


                                        <div class="comment-box header-right">
                                            <span class="commenter-pic header-profile">
                                                <img src="<%= cmt.getAvatarUrl()%>">
                                            </span>
                                            <span class="commenter-name">
                                                <a href="#"><%= cmt.getUserName()%> (<%= cmt.getUserRoleName()%>)</a> <span class="comment-time"><%= cmt.getTime()%></span>
                                            </span>

                                            <!-- +================ DeleteCOmment ============= -->

                                            <button class="commenter-edit" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                                    aria-haspopup="true" aria-expanded="false"><i class="fa-solid fa-bars"></i></button>

                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <form action="MainController" method="POST">                                                
                                                    <input type="hidden" name="eventID" value="<%= evt.getId()%>"/>
                                                    <input type="hidden" name="commentID" value="<%= cmt.getCommentID()%>"/>
                                                    <button  onclick="return checkCmt();" name="action" value="DeleteComment" type="submit" class="dropdown-item" href="">Delete</button>
                                                </form>
                                            </div>

                                            <!-- ================================== -->


                                            <p class="comment-txt more"><%= cmt.getContent()%></p>
                                            <div class="comment-meta">
                                                <span>
                                                    <a class="btn btn-outline-primary" data-toggle="collapse"
                                                       href="#<%= countString%>" aria-expanded="false" data-parent="#myaccordion"
                                                       >Reply</a>
                                                </span>
                                            </div>


                                            <!-- REPLY COMMENT KHI ẤN REPLY -->
                                            <!-- mỗi ID có một popup khác nhau -->

                                            <div  class="collapse" id="<%= countString%>">
                                                <form action="MainController" method="POST" >
                                                    <input type="hidden" name="eventID" value="<%= evt.getId()%>" />
                                                    <input type="hidden" name="replyCommentID" value="<%= cmt.getCommentID()%>" />

                                                    <div class="form-group">
                                                        <label style="font-weight: bold" for="comment"><%= user.getName()%> (<%= user.getRoleID()%>)</label>
                                                        <textarea name="content" class="form-control" rows="3"></textarea>
                                                    </div>
                                                    <button type="submit" name="action" value="ReplyComment" class="btn btn-outline-info">Send</button>
                                                </form>

                                            </div>
                                        </div>


                                        <%   for (CommentDTO cmtRep : listCmt) {
                                                if (cmt.getCommentID() != cmtRep.getCommentID()) {
                                                    if ((cmt.getCommentID()).equals(cmtRep.getReplyID())) {
                                        %>

                                        <div class="comment-box replied header-right">
                                            <span class="commenter-pic header-profile">
                                                <img src="<%= cmtRep.getAvatarUrl()%>" class="img-fluid">
                                                <% if (cmtRep.getAvatarUrl().contains("Image")) {%>
                                                <span>
                                                    <img src="http://localhost:8080/event-management/<%= cmtRep.getAvatarUrl()%>" class="img-fluid">
                                                </span>
                                                <%} else {%>
                                                <img src="<%= cmtRep.getAvatarUrl()%>" class="img-fluid">
                                                <% }%>
                                            </span>
                                            <span class="commenter-name">
                                                <a href="#"><%= cmtRep.getUserName()%> (<%= cmtRep.getUserRoleName()%>)</a> <span class="comment-time"><%= cmtRep.getTime()%></span>
                                            </span>

                                            <!-- +================ DeleteCOmment ============= -->

                                            <button class="commenter-edit" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                                    aria-haspopup="true" aria-expanded="false"><i class="fa-solid fa-bars"></i></button>

                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <form action="MainController" method="POST">                                                
                                                    <input type="hidden" name="eventID" value="<%= evt.getId()%>"/>
                                                    <input type="hidden" name="commentID" value="<%= cmtRep.getCommentID()%>"/>
                                                    <button name="action" value="DeleteComment" type="submit" class="dropdown-item" href="">Delete</button>
                                                </form>
                                            </div>

                                            <!-- ================================== -->

                                            <p class="comment-txt more"><%= cmtRep.getContent()%></p>
                                            <div class="comment-meta">
                                            </div>
                                        </div>

                                        <%
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 


            </div>



            <div class="col-xl-5">
                <div class="row">
                    <div class="col-xl-12 col-sm-6">
                        <img class="card-img img-fluid" src="<%= evt.getImgUrl()%>">
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

    function checkCmt() {
        if (confirm("Are you sure to remove this comment?") === false) {
            return false;
        } else {
            return true;
        }
    }
</script>

<script src="./css_Admin/vendor/global/global.min.js"></script>
<!--    <script src="./css_Admin/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script src="./css_Admin/vendor/chart.js/Chart.bundle.min.js"></script>-->
<script src="./css_Admin/js/custom.min.js"></script>
<script src="./css_Admin/js/deznav-init.js"></script>


<script type="text/javascript" src="//js.nicedit.com/nicEdit-latest.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>

<!--     Chart piety plugin files 
    <script src="./css_Admin/vendor/peity/jquery.peity.min.js"></script>

     Apex Chart 
    <script src="./css_Admin/vendor/apexchart/apexchart.js"></script>

     Dashboard 1 
    <script src="./css_Admin/js/dashboard/event-detail.js"></script>-->

<script type="text/javascript" src="//js.nicedit.com/nicEdit-latest.js"></script> 

<%
    String success = (String) request.getAttribute("SUCCESS");
    String failed = (String) request.getAttribute("FAILED");
    String dupSlot = (String) request.getAttribute("DUP_SLOT");

    if ("success".equals(success)) {
%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>

<script>
    toastr.options = {
        "closeButton": true,
        "debug": true,
        "newestOnTop": false,
        "progressBar": true,
        "preventDuplicates": false,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "2000",
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
        "timeOut": "2000",
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