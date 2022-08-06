<%@page import="sample.eventtype.EventType"%>
<%@page import="sample.location.Location"%>
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
        <!-- Favicon icon -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="icon" type="image/png" sizes="16x16" href="./css_Admin/images/Biểu-tượng-không-chữ.png">
        <!--        <link rel="stylesheet" href="./css_Admin/vendor/chartist/css/chartist.min.css">
                <link href="./css_Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">-->
        <!-- Datatable -->
        <link href="./css_Admin/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="./css_Admin/css/style.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">

        <link rel="stylesheet" href="./css_StatusLocation/styleOfStatus.css">

        <style>
            .status {
                vertical-align: middle;
                font-size: 35px;
            }
            .btn-edit {
                padding: 10px 40px;
                border: 1px solid;
                border-radius: 10px;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <% List<EventType> listEvtType = (List) request.getAttribute("LIST_EVENT_TYPE");

            ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
            if (user == null || !user.getRoleID().equals("MOD")) {
                response.sendRedirect("index.jsp");
                return;
            }

            List<UserNotification> listNoti = (List) request.getAttribute("USER_NOTIFICATION");
        %>
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


            Header start
            ***********************************-->
            <div class="header">
                <div class="header-content">
                    <nav class="navbar navbar-expand">
                        <div class="collapse navbar-collapse justify-content-between">
                            <div class="header-left">
                                <div class="dashboard_bar">
                                    Event Type
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">
                                <li class="nav-item">
                                    <form action="MainController" method="POST" class="input-group search-area d-xl-inline-flex d-none">
                                        <input type="text" name="search" class="form-control" placeholder="Search here...">
                                        <div class="input-group-append">
                                            <button type="submit" name="action" value="SearchEventType" class="input-group-text"><i
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
                                                <%
                                                    for (int i = 0; i < listNoti.size(); i++) {
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
            <div class="deznav">
                <div class="deznav-scroll">
                    <!--<a href="MainController?action=CreateLocation" class="add-menu-sidebar">New Location</a>-->
                    <a href="javascript:void(0)" class="add-menu-sidebar" data-toggle="modal" data-target="#addOrderModalside" >+ New Event Type</a>
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

                    <!--===================== LOCATION POP-UP =======================-->
                    <!-- Add Order -->
                    <div class="modal fade" id="addOrderModalside">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Add New Event Type</h5>
                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="MainController" method="POST">
                                        <div class="form-group">
                                            <label class="text-black font-w500">Event Type Name</label>
                                            <input type="text" required="" name="eventTypeName" class="form-control">
                                        </div>
                                        <!--===========================-->
                                        <div class="body-status">
                                            <div class="container-status">
                                                <div class="toggle">
                                                    <input type="radio" id="choice1" name="status" value="true">
                                                    <label style="margin: 0;" for="choice1">Active</label>

                                                    <input type="radio" id="choice2" name="status" value="false">
                                                    <label style="margin: 0;" for="choice2">Inactive</label>

                                                    <div id="flap"><span class="content">productive</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        </br>
                                        <!--========================-->
                                        <div class="form-group">
                                            <button style="padding: 12px 190px" type="submit" value="CreateEventType" name="action" class="btn btn-primary">Create</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!--==============================================-->

                    <div class="d-flex flex-wrap mb-2 align-items-center justify-content-between">

                        <div class="event-tabs mb-3 mr-3">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">                                                              
                                    <a class="nav-link active" href="MainController?action=ListEventType" >
                                        All
                                    </a>
                                </li>

                            </ul>
                        </div>

                        <div class="d-flex mb-3">


                        </div>
                        <div class="mb-3 mr-3">
                            <h6 class="fs-16 text-black font-w600 mb-0"><%= listEvtType.size()%> Event Type Has Added</h6>
                            <span class="fs-14">All Event Type</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="tab-content">
                                <div id="All" class="tab-pane active fade show">
                                    <div class="table-responsive">
                                        <table id="example2" class="table card-table display dataTablesCard">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Event Type ID</th>
                                                    <th class="text-center">Event Type Name</th>    
                                                    <th class="text-center">Status</th>                                                   
                                                    <th class="text-center">Action</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int count = 0;
                                                    for (int i = 0; i < listEvtType.size(); i++) {
                                                %>

                                                <tr>
                                                    <td class="text-center">#<%= listEvtType.get(i).getEventTypeID()%></td>
                                                    <td class="text-center"><%= listEvtType.get(i).getEventTypeName()%></td>

                                                    <td class="text-center">                                                       
                                                        <%
                                                            if (listEvtType.get(i).isStatus() == true) {
                                                        %>
                                                        <span class="status text-success">&bull;</span>
                                                        <%
                                                        } else {
                                                        %>
                                                        <span  class="status text-danger">&bull;</span>
                                                        <% }%>


                                                        <%if (listEvtType.get(i).isStatus()) {
                                                        %>
                                                        <span style="color: green">Active</span>
                                                        <%
                                                        } else {

                                                        %>
                                                        <span style="color: red">Inactive</span>
                                                        <%                                                                                        }
                                                        %>                                                    

                                                    </td>

                                                    <td>
                                                        <div class="d-flex justify-content-center">


                                                            <a href="javascript:void(0)" class="btn btn-info btn-sm light px-4" data-toggle="modal" 
                                                               data-target="#id<%= listEvtType.get(i).getEventTypeID()%>" >Update</a>

                                                            <!--====================================================-->

                                                            <div class="modal fade" id="id<%= listEvtType.get(i).getEventTypeID()%>">
                                                                <div class="modal-dialog" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Update Event Type</h5>
                                                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="MainController" method="POST">
                                                                                <div class="form-group">
                                                                                    <label class="text-black font-w500">Event Type ID</label>
                                                                                    <input type="text" name="eventTypeID" readonly="" value="<%= listEvtType.get(i).getEventTypeID()%>" class="form-control">
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label class="text-black font-w500">Event Type Name</label>
                                                                                    <input type="text" name="eventTypeName" required="" value="<%= listEvtType.get(i).getEventTypeName()%>" class="form-control">
                                                                                </div>
                                                                                <!--===========================-->

                                                                                <div class="text-center mt-3 mb-3">
                                                                                    <div class="btn-group">
                                                                                        <%
                                                                                            if (listEvtType.get(i).isStatus() == true) {
                                                                                        %>
                                                                                        <input type="radio" class="btn-check" name="status" value="true" id="option<%= count%>" checked />
                                                                                        <label style="margin-right: 10px;" class="btn-edit btn-outline-success" for="option<%= count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input type="radio" class="btn-check" name="status" value="false" id="option<%= count%>" />
                                                                                        <label class="btn-edit btn-outline-danger" for="option<%= count%>">Inactive</label>
                                                                                        <% count++; %>
                                                                                        <% } else if (listEvtType.get(i).isStatus() == false) {%>
                                                                                        <input type="radio" class="btn-check" name="status" value="true" id="option<%= count%>" />
                                                                                        <label style="margin-right: 10px;" class="btn-edit btn-outline-success" for="option<%= count%>">Active</label>
                                                                                        <% count++;%>
                                                                                        <input type="radio" class="btn-check" name="status" value="false" id="option<%= count%>" checked="" />
                                                                                        <label class="btn-edit btn-outline-danger" for="option<%= count%>">Inactive</label>
                                                                                        <% count++; %>
                                                                                        <% }%>

                                                                                    </div>
                                                                                </div>



                                                                                <!--========================-->
                                                                                <div class="form-group">
                                                                                    <button style="padding: 12px 190px" type="submit" value="UpdateEventType" name="action" class="btn btn-primary">Update</button>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!--======================================-->




                                                            <a onclick="return check();" href="MainController?action=DeleteEventType&id=<%= listEvtType.get(i).getEventTypeID()%>"
                                                               class="btn btn-danger  btn-sm light ml-2 px-4">Delete</a>
                                                        </div>
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
                if (confirm("Are you sure to remove this event type?") === false) {
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
        <script src="./css_StatusLocation/script.js"></script>
        <!-- Datatable -->
        <script src="./css_Admin/vendor/datatables/js/jquery.dataTables.min.js"></script>
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
    </body>

</html>