<%@page import="sample.users.UserDTO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>F.E.M - FPT Event Admin</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="./css_Admin/images/Biểu-tượng-không-chữ.png">
        <!--        <link rel="stylesheet" href="./css_Admin/vendor/chartist/css/chartist.min.css">
                <link href="./css_Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">-->
        <!-- Datatable -->
        <link href="./css_Admin/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="./css_Admin/css/style.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    </head>


    <style>
        .status {
            vertical-align: middle;
            font-size: 35px;
        }
    </style>

    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || !user.getRoleID().equals("ADM")) {
                response.sendRedirect("index.jsp");
                return;
            }
            List<UserDTO> listUser = (List) request.getAttribute("LIST_USERS");
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
                <a href="AdminUserPageController" class="brand-logo">
                    <!-- <img class="logo-abbr" src="./images/logo.png" alt="">
                    <img class="logo-compact" src="./images/logo-text.png" alt=""> -->
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

            <!--**********************************
        Chat box start
    ***********************************-->

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
                                    Account Member
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">
                                <li class="nav-item">
                                    <form action="MainController" method="POST">
                                        <div class="input-group search-area d-xl-inline-flex d-none">
                                            <input type="text" class="form-control" name="search" placeholder="Search here...">
                                            <div class="input-group-append">
                                                <button class="input-group-text" name="action" value="SearchUser"><i class="flaticon-381-search-2"></i></button>
                                            </div>
                                        </div>
                                    </form>
                                </li>

                                <!-- ===============NOTIFICATION =====================-->


                                <li class="nav-item dropdown header-profile">
                                    <a class="nav-link" href="javascript:void(0)" role="button" data-toggle="dropdown">
                                        <img src="<%= user.getPicture()%>" width="20" alt=""/>
                                        <div class="header-info">
                                            <span class="text-black"><strong><%= user.getName()%></strong></span>
                                            <p class="fs-12 mb-0"><%= user.getRoleID()%></p>
                                        </div>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a href="MainController?action=AdminProfile" class="dropdown-item ai-icon">
                                            <svg id="icon-user1" xmlns="http://www.w3.org/2000/svg" class="text-primary" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                            <span class="ml-2">Profile </span>
                                        </a>

                                        <a href="MainController?action=Logout" class="dropdown-item ai-icon">
                                            <svg id="icon-logout" xmlns="http://www.w3.org/2000/svg" class="text-danger" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
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
                                <li><a href="MainController?action=AdminManagerPage">Club's Members</a></li>
                                <li><a href="MainController?action=AdminOrgPage">Club Information</a></li>
                                <li><a href="MainController?action=AdminUserPage">Account Information</a></li>
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

                    <div class="d-flex flex-wrap mb-2 align-items-center justify-content-between">
                        <div class="mb-3">
                            <h6 class="fs-16 text-black font-w600 mb-0"><%= listUser.size()%> Total Users</h6>
                            <span class="fs-14">Based your preferences</span>
                        </div>
                        <div class="event-tabs mb-3">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#All" role="tab"
                                       aria-selected="true">
                                        All
                                    </a>
                                </li>

                            </ul>
                        </div>
                        <div class="mb-3 d-flex flex-row-reverse">
                            <a href="MainController?action=dataType&page=Admin_UserForm.jsp" class="btn btn-primary text-nowrap"><i
                                    class="fa fa-file-text scale5 mr-3" aria-hidden="true"></i>Create User Account</a>
                        </div>
                    </div>


                    <!--=================== CREATE CLUB'S MEMBER ====================-->


                    <!--===================================================================--> 

                    <div class="row">
                        <div class="col-xl-12">
                            <div class="table-responsive">
                                <table id="example2" class="table card-table display dataTablesCard">
                                    <thead>
                                        <tr>

                                            <th>UserID</th>
                                            <th>Full Name</th>
                                            <th>Type</th>
                                            <th>Gender</th>
                                            <th>Email</th>
                                            <th>Phone Number</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            if (listUser != null) {
                                                for (UserDTO list : listUser) {
                                        %> 

                                        <tr>                                            
                                            <td><%= list.getId()%></td>
                                            <td><%= list.getName()%></td>
                                            <td><%= list.getTypeName()%></td>
                                            <td>
                                                <span class="text-nowrap"><%= list.getGender()%></span>
                                            </td>
                                            <td><%= list.getEmail()%></td>
                                            <td><%= list.getPhoneNumber()%></td>
                                            <td>
                                                <%
                                                    if (list.isStatus() == true) {
                                                %>
                                                <span class="status text-success">&bull;</span>
                                                <%
                                                } else {
                                                %>
                                                <span  class="status text-danger">&bull;</span>
                                                <% } %>


                                                <%
                                                    if (list.isStatus()) {
                                                %>
                                                <span style="color: green">Active</span>
                                                <%
                                                } else {
                                                %>
                                                <span style="color: red">Inactive</span>
                                                <%
                                                    }
                                                %> 

                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <a href="MainController?action=UpdateUser&id=<%= list.getId()%>&page=Admin_UserForm.jsp" class="mr-4">
                                                        <i class="las la-pencil-alt scale-2"></i>
                                                    </a>
                                                    <a onclick="return check();" href="MainController?action=DeleteUser&id=<%= list.getId()%>">
                                                        <i class="las la-trash-alt scale-2 text-danger"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            }
                                        %>

                                    </tbody>
                                </table>
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
                if (confirm("Are you sure to remove this user?") === false) {
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
        <!--<script src="./css_Admin/vendor/owl-carousel/owl.carousel.js"></script>-->

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
                $('#example tbody').on('click', 'tr', function () {
                    var data = table.row(this).data();

                });
            })(jQuery);
        </script>
    </body>
</html>