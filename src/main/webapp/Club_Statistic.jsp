<%@page import="sample.users.UserNotification"%>
<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.posts.EventPost"%>
<%@page import="sample.users.UserDTO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>F.E.M - FPT Event Admin</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="./css_Statistic/images/Bi?u-t??ng-kh�ng-ch?.png.png">
        <link rel="stylesheet" href="./css_Statistic/vendor/chartist/css/chartist.min.css">
        <link href="./css_Statistic/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
        <link href="./css_Statistic/vendor/owl-carousel/owl.carousel.css" rel="stylesheet">
        <link href="./css_Statistic/css/style.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&family=Roboto:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">

    </head>

    <% List<UserDTO> listFollower = (List<UserDTO>) request.getAttribute("listFollower");
        List<EventPost> listEvent = (List<EventPost>) request.getAttribute("listEvent");
        int listEventSize = listEvent.size(); //TH1: 13 
        if (listEvent.size() < 5) {
            listEventSize = 0;
        } else {
            listEventSize = listEvent.size() - 5;
        }
        ManagerDTO user = (ManagerDTO) session.getAttribute("LOGIN_USER");
        List<UserNotification> listNoti = (List) request.getAttribute("USER_NOTIFICATION");
        int totalParticipants = (int)(Double.parseDouble(request.getAttribute("totalParticipants").toString())) ;
        
        double participationPercentage = (Double.parseDouble(request.getAttribute("participationPercentage").toString()));

        int totalActualParticipants = (int)(Double.parseDouble(request.getAttribute("totalActualParticipants").toString()));
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

                <a href="MainController?action=ClubStatistic&orgID=<%=user.getOrgID()%>" class="brand-logo">
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
                                    Club Statistic
                                </div>
                            </div>
                            <ul class="navbar-nav header-right">
                                <li class="nav-item">


                                </li>

                                <!--notification-->

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
                                        <a class="all-notification" href="javascript:void(0)">See all notifications <i
                                                class="ti-arrow-right"></i></a>
                                    </div>
                                </li>

                                <!--profile-->

                                <li class="nav-item dropdown header-profile">
                                    <a class="nav-link" href="javascript:void(0)" role="button" data-toggle="dropdown">
                                        <img src="<%=user.getPicture()%>" width="20" alt="" />
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
                                            <span class="ml-2">Profile</span>
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
                                <%
                                    if ("CLB".equals(user.getRoleID())) {
                                %>
                                <li><a href="MainController?action=ListOrgEvent">Event</a></li>                                        
                                    <% } else { %>

                                <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">Event</a>
                                    <ul aria-expanded="false">
                                        <li><a href="MainController?action=ListEvent">List Event</a></li>
                                        <li><a href="MainController?action=ListLocation">Location</a></li>
                                        <li><a href="MainController?action=ListEventType">Event Type</a></li>
                                        </br>
                                    </ul>
                                </li>


                                <% }%>
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
                    <div class="row">
                        <div class="col-xl-3 col-xxl-4">
                            <div class="row">
                                <div class="col-xl-12 col-md-6">
                                    <div class="card">
                                        <div class="card-body pb-0 dz-scroll height250 loadmore-content"
                                             id="latestSalesContent">
                                            <p class="font-w600"><a href="event.html" class="text-black">Club Follower</a>
                                            </p>
                                            <%for (int i = 0; i < listFollower.size(); i++) {
                                            %>

                                            <div class="pb-3 mb-3">
                                                <div class="">
                                                    <img src="<%=listFollower.get(i).getPicture()%>" alt="" width="42"
                                                         class="rounded-circle mr-2">


                                                    <%=listFollower.get(i).getName()%>
                                                </div>
                                            </div>

                                            <%
                                                }
                                            %>                                         

                                        </div>
                                        <div class="card-footer text-center border-0">
                                            <a class="btn btn-primary btn-sm"
                                               href="MainController?action=ClubFollower&orgID=<%=user.getOrgID()%>" >View More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-9 col-xxl-8">
                            <div class="row">
                                <div class="col-xl-4 col-xxl-6 col-lg-4 col-sm-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-end">
                                                <div>
                                                    <p class="fs-14 mb-1">Total event</p>
                                                    <span class="fs-35 text-black font-w600">                                                        
                                                        <%=listEvent.size()%>
                                                        <svg class="ml-1" width="19" height="12" viewBox="0 0 19 12"
                                                             fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M2.00401 11.1924C0.222201 11.1924 -0.670134 9.0381 0.589795 7.77817L7.78218 0.585786C8.56323 -0.195262 9.82956 -0.195262 10.6106 0.585786L17.803 7.77817C19.0629 9.0381 18.1706 11.1924 16.3888 11.1924H2.00401Z"
                                                            fill="#33C25B" />
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-4 col-xxl-6 col-lg-4 col-sm-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-end">
                                                <div>
                                                    <p class="fs-14 mb-1">Total Participants</p>
                                                    <span class="fs-35 text-black font-w600"><%=totalParticipants%>
                                                        <svg class="ml-1" width="19" height="12" viewBox="0 0 19 12"
                                                             fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M2.00401 11.1924C0.222201 11.1924 -0.670134 9.0381 0.589795 7.77817L7.78218 0.585786C8.56323 -0.195262 9.82956 -0.195262 10.6106 0.585786L17.803 7.77817C19.0629 9.0381 18.1706 11.1924 16.3888 11.1924H2.00401Z"
                                                            fill="#33C25B" />
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-4 col-xxl-6 col-lg-4 col-sm-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-end">
                                                <div>
                                                    <p class="fs-14 mb-1">Actual Participants</p>
                                                    <span class="fs-35 text-black font-w600"><%=totalActualParticipants%>
                                                        <svg class="ml-1" width="19" height="12" viewBox="0 0 19 12"
                                                             fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M2.00401 11.1924C0.222201 11.1924 -0.670134 9.0381 0.589795 7.77817L7.78218 0.585786C8.56323 -0.195262 9.82956 -0.195262 10.6106 0.585786L17.803 7.77817C19.0629 9.0381 18.1706 11.1924 16.3888 11.1924H2.00401Z"
                                                            fill="#33C25B" />
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-4 col-xxl-6 col-lg-4 col-sm-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="fs-14 mb-1">Participation percentage</p>                                                   
                                                    <span class="fs-35 text-black font-w600"> <%=participationPercentage%> % 
                                                        <svg class="ml-1" width="19" height="12" viewBox="0 0 19 12"
                                                             fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M2.00401 11.1924C0.222201 11.1924 -0.670134 9.0381 0.589795 7.77817L7.78218 0.585786C8.56323 -0.195262 9.82956 -0.195262 10.6106 0.585786L17.803 7.77817C19.0629 9.0381 18.1706 11.1924 16.3888 11.1924H2.00401Z"
                                                            fill="#33C25B" />
                                                        </svg>
                                                    </span>
                                                </div>
                                                <div class="d-inline-block ml-auto position-relative donut-chart-sale">
                                                    <span class="donut"
                                                          data-peity='{ "fill": ["rgb(254, 99, 78)", "rgba(244, 244, 244, 1)"],   "innerRadius": 31, "radius": 10}'>6/8</span>
                                                    <small class="text-secondary"></small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-12">
                            <div class="card">
                                <div class="card-header border-0 pb-sm-0 pb-5">
                                    <h4 class="fs-20">Recent Event Post List</h4>
                                </div>
                                <div class="card-body ">
                                    <div class="event-bx owl-carousel">

                                        <%for (int i = listEvent.size() - 1; i >= listEventSize; i--) {
                                        %>                                     

                                        <div class="items">
                                            <div class="image-bx ">
                                                <img style="width: 100%; height: 450px" src="<%=listEvent.get(i).getImgUrl()%>" alt="">
                                                <div class="info">
                                                    <p class="fs-18 font-w600">
                                                        <a href="MainController?action=EventDetail&eventID=<%=listEvent.get(i).getId()%>" class="text-black">
                                                            <%=listEvent.get(i).getTitle()%>
                                                        </a>
                                                    </p>
                                                    <span class="fs-14 text-black d-block mb-3"><%=listEvent.get(i).getLocationName()%></span>
                                                    <% if (listEvent.get(i).getSummary().length() < 300) {%>
                                                    <p class="fs-12"><%=listEvent.get(i).getSummary()%></p>
                                                    <% } else {%>
                                                    <p class="fs-12"><%=listEvent.get(i).getSummary().substring(0, 300)%>...</p>
                                                    <% }%>
                                                    <ul>
                                                        <li><i class="las la-calendar"></i><%=listEvent.get(i).getTakePlaceDate()%></li>

                                                        <li><i class="fa fa-eye"></i><%=listEvent.get(i).getNumberOfView()%> View</li>
                                                        <li><i class="fa fa-user-o"></i><%=listEvent.get(i).getNumberOfParticipants()%> Participants</li>

                                                    </ul>
                                                </div>                                                        
                                            </div>
                                        </div>

                                        <%
                                            }
                                        %>

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
        <script src="./css_Statistic/vendor/global/global.min.js"></script>
        <script src="./css_Statistic/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
        <script src="./css_Statistic/vendor/chart.js/Chart.bundle.min.js"></script>
        <script src="./css_Statistic/js/custom.min.js"></script>
        <script src="./css_Statistic/js/deznav-init.js"></script>
        <script src="./css_Statistic/vendor/owl-carousel/owl.carousel.js"></script>

        <!-- Chart piety plugin files -->
        <script src="./css_Statistic/vendor/peity/jquery.peity.min.js"></script>

        <!-- Apex Chart -->
        <script src="./css_Statistic/vendor/apexchart/apexchart.js"></script>

        <!-- Dashboard 1 -->
        <script src="./css_Statistic/js/dashboard/dashboard-1.js"></script>

        <script>
            function carouselReview() {
                /*  event-bx one function by = owl.carousel.js */
                jQuery('.event-bx').owlCarousel({
                    loop: true,
                    margin: 30,
                    nav: true,
                    center: true,
                    autoplaySpeed: 3000,
                    navSpeed: 3000,
                    paginationSpeed: 3000,
                    slideSpeed: 3000,
                    smartSpeed: 3000,
                    autoplay: false,
                    navText: ['<i class="fa fa-caret-left" aria-hidden="true"></i>', '<i class="fa fa-caret-right" aria-hidden="true"></i>'],
                    dots: true,
                    responsive: {
                        0: {
                            items: 1
                        },
                        720: {
                            items: 2
                        },

                        1150: {
                            items: 3
                        },

                        1200: {
                            items: 2
                        },
                        1749: {
                            items: 3
                        }
                    }
                })
            }
            jQuery(window).on('load', function () {
                setTimeout(function () {
                    carouselReview();
                }, 1000);
            });
        </script>
    </body>

</html>