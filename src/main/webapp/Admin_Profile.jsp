<%@page import="sample.users.UserError"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.users.UserNotification"%>
<%@page import="java.util.List"%>
<%@page import="sample.users.ManagerDTO"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="stylesheet" href="./css_AdminProfile/Admin_profile.css">

        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>F.E.M - FPT Event Admin</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="./css_Admin/images/femLogo.png">
        <!--<link rel="stylesheet" href="./css_Admin/vendor/chartist/css/chartist.min.css">-->

        <!--<link href="./css_Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">-->
        <!-- Datatable -->
        <!--<link href="./css_Admin/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">-->
        <link href="./css_Admin/css/style.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">
    </head>

    <body>
        <%
            ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            List<UserNotification> listNoti = (List) request.getAttribute("USER_NOTIFICATION");
            if (listNoti == null) {
                listNoti = new ArrayList<UserNotification>();
            }

            UserError error = (UserError) request.getAttribute("ERROR");
            if (error == null) {
                error = new UserError();
            }

            String success = (String) request.getAttribute("SUCCESS");
            if (success == null) {
                success = "";
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
                <%                    if ("ADM".equals(user.getRoleID())) {
                %>

                <a href="MainController?action=AdminManagerPage" class="brand-logo">
                    <img class="brand-title" src="./css_Admin/images/femLogo.png" alt="">
                </a>
                <%
                } else if ("MOD".equals(user.getRoleID())) {
                %>

                <a href="MainController?action=ListEvent" class="brand-logo">
                    <img class="brand-title" src="./css_Admin/images/femLogo.png" alt="">
                </a>
                <%
                } else if ("CLB".equals(user.getRoleID())) {
                %>
                <a href="MainController?action=ListOrgEvent" class="brand-logo">
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
        Chat box start
    ***********************************-->

            <!--**********************************
        Chat box End
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
                                    Profile
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">

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

                                        <a href="LogoutController" class="dropdown-item ai-icon">
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
                                <%
                                    if ("ADM".equals(user.getRoleID())) {
                                %>
                                <li><a href="MainController?action=AdminManagerPage">Club's Members</a></li>
                                <li><a href="MainController?action=AdminOrgPage">Club Information</a></li>
                                <li><a href="MainController?action=AdminUserPage">Account Information</a></li>
                                    <%
                                    } else if ("MOD".equals(user.getRoleID())) {
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
                                <li><a href="MainController?action=ClubStatistic&orgID=<%=user.getOrgID()%>">Statistic</a></li>
                                    <%
                                    } else if ("CLB".equals(user.getRoleID())) {
                                    %>
                                <li><a href="MainController?action=ListOrgEvent">Event</a></li>
                                <li><a href="MainController?action=ListBlog">Blog</a></li>
                                <li><a href="MainController?action=ClubStatistic&orgID=<%=user.getOrgID()%>">Statistic</a></li>
                                    <% }%>
                            </ul>
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




                    <div class="container rounded bg-white mt-5 mb-5">
                        <div class="row">
                            <div class="col-md-3 border-right">
                                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                    <img
                                        class="mt-5" style="width: 120px; height: 120px ;border-radius: 100%"
                                        src="<%= user.getPicture()%>">
                                    </br>
                                    <span
                                        class="font-weight-bold"><%= user.getName()%></span><span
                                        class="text-black-50"><%= user.getEmail()%></span><span> </span></div>

                                <div class="text-center">
                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            data-target="#exampleModal">
                                        Upload Image
                                    </button>
                                </div>


                                <!-- Modal -->
                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Upload Image</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form action="UploadImageController" method="POST" enctype="multipart/form-data">
                                                <div class="modal-body">
                                                    <input type="hidden" name="page" value="Admin_Profile.jsp" />
                                                    <input type="hidden" name="id" value="<%= user.getId()%>"/>
                                                    <input type="file" accept=".jpg, .jpeg, .png" name="image" />


                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary">Save changes</button>
                                                </div>
                                            </form> 
                                        </div>
                                    </div>
                                </div>

                            </div>      


                            <form class="col-md-7" action="MainController" method="POST" enctype="multipart/form-data">        
                                <div >
                                    <div class="p-3 py-5">
                                        <p class="text-danger"><%= success%></p>
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h4 class="text-right">Profile Settings</h4>
                                        </div>

                                        <div class="row mt-3">
                                            <div class="col-md-12"><label class="labels">User Name</label><input type="text" readonly="" name="username"
                                                                                                                 class="form-control" value="<%= user.getId()%>"></div>

                                        </div>

                                        <div class="row mt-3">
                                            <div class="col-md-12"><label class="labels">Password</label><input type="password" name="password"
                                                                                                                class="form-control" value=""></div>
                                            <div class="col-md-12"><label class="labels">Re-password</label><input type="password" name="confirm"
                                                                                                                   class="form-control" value=""></div>
                                            <p class="text-danger"><%= error.getPasswordConfirmError()%></p>

                                            <div class="col-md-12"><label class="labels">Full Name</label><input type="text" name="fullName" required=""
                                                                                                                 class="form-control" value="<%= user.getName()%>"></div>
                                                <% if (user.getEmail() == null || user.getEmail() == "" || user.getEmail().isEmpty()) {
                                                        user.setEmail("");
                                                    }
                                                %>
                                            <div class="col-md-12"><label class="labels">Email</label><input type="email" name="email" required=""
                                                                                                             class="form-control" value="<%= user.getEmail()%>"></div>
                                            <p class="text-danger"><%= error.getEmailError()%></p>
                                            <div class="col-md-12"><label class="labels">Role</label><input type="text" readonly=""
                                                                                                            class="form-control" value="<%= user.getRoleID()%>"></div>
                                            <div class="col-md-12"><label class="labels">Organization</label><input type="text" readonly="" name="orgName"
                                                                                                                    class="form-control" value="<%= user.getOrgName()%>"></div>
                                            <input type="hidden" value="<%= user.getTypeID()%>" name="userType"/>
                                            <input type="hidden" value="<%= user.getOrgID()%>" name="orgID"/>
                                            <input type="hidden" value="<%= user.isStatus()%>" name="status"/>
                                            <input type="hidden" value="<%= user.getPhoneNumber()%>" name="phone"/>
                                            <input type="hidden" value="<%= user.getRoleID()%>" name="roleID"/>





                                        </div>
                                        </br>
                                        <input type="hidden" value="Admin_Profile.jsp" name="page"/>
                                        <div class="row"> 
                                            <input type="hidden" name="page" value="Admin_Profile.jsp"/>
                                            <div class="col-md-6 text-center"><a style="border: 1px solid #FE634E; color: #FE634E" class="btn" href="MainController?action=AdminProfile"
                                                                                 type="button">Cancel</a></div>
                                            <div class="col-md-6 text-center"><button class="btn btn-primary profile-button" name="action" value="UpdateAdminProfile"
                                                                                      type="submit">Save Profile</button></div>
                                        </div>
                                    </div>
                                </div>
                            </form>

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
        <script src="./css_Admin/vendor/global/global.min.js"></script>
<!--        <script src="./css_Admin/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
        <script src="./css_Admin/vendor/chart.js/Chart.bundle.min.js"></script>-->
        <script src="./css_Admin/js/custom.min.js"></script>
        <script src="./css_Admin/js/deznav-init.js"></script>

        <!-- Datatable -->
        <!--<script src="./css_Admin/vendor/datatables/js/jquery.dataTables.min.js"></script>-->
<!--        <script>
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
        </script>-->
    </body>

</html>