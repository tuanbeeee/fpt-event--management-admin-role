<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.organization.OrganizationDTO"%>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>F.E.M - FPT Event Admin</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="./css_Admin/images/Biểu-tượng-không-chữ.png">
        <!--        <link rel="stylesheet" href="./css_Admin/vendor/chartist/css/chartist.min.css">
                <link href="./css_Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">-->
        <link href="./css_Admin/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="./css_Admin/css/style.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">

        <style>
            .status {
                vertical-align: middle;
                font-size: 35px;
            }

            .approved {
                font-weight: bold;
                color: green;
            }
            .pending {
                font-weight: bold;
                color: orange;
            }
            .declined {
                font-weight: bold;
                color: red;
            }
            /*            .tooltip {
                            position: relative;
                            display: inline-block;
                        }
            
                        .tooltip .tooltiptext {
                            visibility: hidden;
                            width: 140px;
                            background-color: #555;
                            color: #fff;
                            text-align: center;
                            border-radius: 6px;
                            padding: 5px;
                            position: absolute;
                            z-index: 1;
                            bottom: 150%;
                            left: 50%;
                            margin-left: -75px;
                            opacity: 0;
                            transition: opacity 0.3s;
                        }
            
                        .tooltip .tooltiptext::after {
                            content: "";
                            position: absolute;
                            top: 100%;
                            left: 50%;
                            margin-left: -5px;
                            border-width: 5px;
                            border-style: solid;
                            border-color: #555 transparent transparent transparent;
                        }
            
                        .tooltip:hover .tooltiptext {
                            visibility: visible;
                            opacity: 1;*/
        </style>
    </head>

    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || !user.getRoleID().equals("ADM")) {
                response.sendRedirect("index.jsp");
                return;
            }
            List<OrganizationDTO> listOrg = (List) request.getAttribute("LIST_ORG");
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
                <a href="AdminOrgPageController" class="brand-logo">
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
        Header start
    ***********************************-->
            <div class="header">
                <div class="header-content">
                    <nav class="navbar navbar-expand">
                        <div class="collapse navbar-collapse justify-content-between">
                            <div class="header-left">
                                <div class="dashboard_bar">
                                    Club Information
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">
                                <li class="nav-item">
                                    <form action="MainController" method="POST">
                                        <div class="input-group search-area d-xl-inline-flex d-none">
                                            <input type="text" class="form-control" name="search" placeholder="Search here...">
                                            <div class="input-group-append">
                                                <button class="input-group-text" name="action" value="SearchOrg"><i class="flaticon-381-search-2"></i></button>
                                            </div>
                                        </div>
                                    </form>
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
                                <li><a href="MainController?action=AdminManagerPage">Club's Members</a></li>
                                <li><a href="MainController?action=AdminOrgPage">Club Information</a></li>
                                <li><a href="MainController?action=AdminUserPage">Account Information</a></li>
                            </ul>
                        </li>

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
                            <h6 class="fs-16 text-black font-w600 mb-0"><%= listOrg.size()%> Total Clubs</h6>
                            <span class="fs-14">Based your preferences</span>
                        </div>
                        <div class="event-tabs mb-3">
                            <ul class="nav nav-tabs" role="tablist">
                                <%
                                    String type = request.getParameter("type");
                                %>

                                <li class="nav-item">
                                    <%
                                        if (type == null) {
                                    %>
                                    <a class="nav-link active"  href="MainController?action=AdminOrgPage" >
                                        All
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=AdminOrgPage" >
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
                                    <a class="nav-link active"  href="MainController?action=FilterOrg&type=Pending" >
                                        Pending
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterOrg&type=Pending" >
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
                                    <a class="nav-link active"  href="MainController?action=FilterOrg&type=Approved" >
                                        Approved
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterOrg&type=Approved" >
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
                                    <a class="nav-link active"  href="MainController?action=FilterOrg&type=Declined" >
                                        Declined
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterOrg&type=Declined" >
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
                                    <a class="nav-link active" href="MainController?action=FilterOrg&type=OnGoing" >
                                        On-Going
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a class="nav-link" href="MainController?action=FilterOrg&type=OnGoing" >
                                        On-Going
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>


                            </ul>
                        </div>
                        <div class="mb-3 d-flex">

                            <a href="Admin_OrgForm.jsp" class="btn btn-primary text-nowrap"><i
                                    class="fa fa-file-text scale5 mr-3" aria-hidden="true"></i>Create new Club</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xl-12">
                            <div class="tab-content">
                                <div id="All" class="tab-pane active">
                                    <div class="table-responsive fs-14">
                                        <table class="table mb-4 dataTablesCard no-hover card-table fs-14" id="example5">
                                            <thead>
                                                <tr>

                                                    <th style="width:350px;">Club</th>
                                                    <th style="width: 100px">ID</th>
                                                    <th>Information Cub</th>
                                                    <th>Email</th>
                                                    <th>Type</th>
                                                    <th>Status</th>
                                                    <th class="text-center">Action</th>
                                                    <th class="text-center"></th>

                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%
                                                    if (listOrg != null) {
                                                        for (OrganizationDTO list : listOrg) {
                                                %> 


                                                <tr>

                                                    <td>
                                                        <div class="media align-items-center">
                                                            <img class="img-fluid rounded mr-3 d-none d-xl-inline-block"
                                                                 width="70" src="<%= list.getImgUrl()%>"
                                                                 alt="DexignZone">
                                                            <div class="media-body">
                                                                <h4 class="font-w600 mb-1 wspace-no"><a
                                                                        href="javascript:void(0)" class="text-black"> <%= list.getOrgName()%></a></h4>
                                                                <span>Create Date: <%= list.getCreateDate()%></span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="d-none d-lg-table-cell"><%= list.getOrgID()%></td>
                                                    <td>                   
                                                        <p class="mb-0 d-none d-xl-inline-block"><%= list.getDescription()%></p>
                                                    </td>

                                                    <td>                   
                                                        <p class="mb-0 d-none d-xl-inline-block"><%= list.getEmail()%></p>
                                                    </td>

                                                    <td>
                                                        <%
                                                            if ("PE".equals(list.getStatusTypeID())) {
                                                        %>
                                                        <p class="pending mb-0 d-none d-xl-inline-block"><%= list.getStatusTypeName()%></p>
                                                        <%
                                                        } else if ("AP".equals(list.getStatusTypeID())) {
                                                        %>
                                                        <p class="approved mb-0 d-none d-xl-inline-block"><%= list.getStatusTypeName()%></p>
                                                        <%
                                                        } else if ("DE".equals(list.getStatusTypeID())) {
                                                        %>
                                                        <p class="declined mb-0 d-none d-xl-inline-block"><%= list.getStatusTypeName()%></p>
                                                        <% } %>
                                                    </td>

                                                    <td>

                                                        <%
                                                            if (list.isStatus() == true) {
                                                        %>
                                                        <span class="status text-success">&bull;</span>
                                                        <%
                                                        } else {
                                                        %>
                                                        <span class="status text-danger">&bull;</span>
                                                        <% }%>

                                                        <%if (list.isStatus()) {
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
                                                        <div class="d-flex">
                                                            <a href="MainController?action=UpdateOrg&id=<%= list.getOrgID()%>"
                                                               class="btn btn-info btn-sm light px-4">Update</a>
                                                            <a onclick="return check();" href="MainController?action=DeleteOrg&id=<%= list.getOrgID()%>"
                                                               class="btn btn-danger  btn-sm light ml-2 px-4">Delete</a>
                                                        </div>
                                                    </td>

                                                    <td>
                                                        <div class="d-flex">
                                                            <% if ("PE".equals(list.getStatusTypeID())) {%>
                                                            <a href="MainController?action=ApproveOrg&id=<%= list.getOrgID()%>&type=AP"
                                                               class="btn btn-outline-success btn-sm light px-4">Approve</a>
                                                            <a href="MainController?action=ApproveOrg&id=<%= list.getOrgID()%>&type=DE"
                                                               class="btn btn-outline-danger btn-sm light ml-2 px-4">Decline</a>

                                                            <% } else if ("AP".equals(list.getStatusTypeID())) {%>
                                                            <a href="javascript:void(0)" class="btn btn-primary btn-sm light px-4" data-toggle="modal" 
                                                               data-target="#<%= list.getOrgID()%>" >View</a>

                                                            <!--====================================================-->

                                                            <div class="modal fade" id="<%= list.getOrgID()%>">
                                                                <div class="modal-dialog" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">List Account</h5>
                                                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <div class="form-group">
                                                                                <p style="font-weight: bold"><%= list.getOrgName()%> (<%= list.getOrgID()%>)</p>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label style="margin-bottom: -6px" class="text-black font-w500">User Name</label>
                                                                                <p style="font-size: 13px;
                                                                                   opacity: 0.5;">(All the new account have Password: 1)</p>
                                                                                <% List<ManagerDTO> listMan = (List) request.getAttribute("LIST_MANAGER_" + list.getOrgID()); %>

                                                                                <textarea readonly="" style="color: black" class="form-control" id="myInput" rows="10" cols="50">
                                                                                    <% if (listMan != null) { %><% for (ManagerDTO man : listMan) {%><%= man.getId()%> 
                                                                                    <% } %><% } %>                                                                                                    
                                                                                </textarea>     
                                                                            </div>

                                                                            <!--                                                                                                    <div class="tooltip">
                                                                                                                                                                                <button onclick="myFunction()" onmouseout="outFunc()">
                                                                                                                                                                                <span class="tooltiptext" id="myTooltip">Copy to clipboard</span>
                                                                                                                                                                                Copy
                                                                                                                                                                                </button>
                                                                                                                                                                                </div>-->
                                                                            <!--===========================-->

                                                                            <!--========================-->

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <% } %>
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


        <!--**********************************
        Main wrapper end
    ***********************************-->

        <!--**********************************
        Scripts
    ***********************************-->
        <!-- Required vendors -->
        
        <script>
            function check() {
                if (confirm("Are you sure to remove this club?") === false) {
                    return false;
                } else {
                    return true;
                }
            }
        </script>

        <script src="./css_Admin/vendor/global/global.min.js"></script>
        <!--                                    <script src="./css_Admin/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
                                            <script src="./css_Admin/vendor/chart.js/Chart.bundle.min.js"></script>-->
        <script src="./css_Admin/js/custom.min.js"></script>
        <script src="./css_Admin/js/deznav-init.js"></script>
        <!--<script src="./css_Admin/vendor/owl-carousel/owl.carousel.js"></script>-->
        <!-- Datatable -->
        <script src="./css_Admin/vendor/datatables/js/jquery.dataTables.min.js"></script>
        <script>
//                                                                                                            function myFunction() {
//                                                                                                                var copyText = document.getElementById("myInput");
//                                                                                                                copyText.select();
//                                                                                                                copyText.setSelectionRange(0, 99999);
//                                                                                                                navigator.clipboard.writeText(copyText.value);
//
//                                                                                                                var tooltip = document.getElementById("myTooltip");
//                                                                                                                tooltip.innerHTML = "Copied Successfully";
//                                                                                                            }
//
//                                                                                                            function outFunc() {
//                                                                                                                var tooltip = document.getElementById("myTooltip");
//                                                                                                                tooltip.innerHTML = "Copy to clipboard";
//                                                                                                            }

            (function ($) {
                var table = $('#example5').DataTable({
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
                var table = $('#example2').DataTable({
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
                $('#example tbody').on('click', 'tr', function () {
                    var data = table.row(this).data();

                });
            })(jQuery);
        </script>
    </body>

</html>