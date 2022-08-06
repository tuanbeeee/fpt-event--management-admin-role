
<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.posts.Blog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>F.E.M - Create A Blog</title> 
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
        <link rel="stylesheet" href="./css_FormCreate/style.css">
        <link rel="stylesheet" href="./css_FormCreate/css/all.css">
        <script src="https://your-site-or-cdn.com/fontawesome/v5.15.4/js/all.js" data-auto-replace-svg></script>
        <script src="https://use.fontawesome.com/releases/vVERSION/js/all.js" data-auto-replace-svg="nest"></script>

    </head>

    <%
        Blog blog = (Blog) request.getAttribute("blog");
        ManagerDTO manager = (ManagerDTO) session.getAttribute("LOGIN_USER");
        if (manager == null) {
            response.sendRedirect("index.jsp");
            return;
        }
    %>

    <body>
        <!-- partial:index.partial.html -->
        <div  class="container">
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <div style="text-align: center">
                    <h1 class="Information ">Update Blog</h1>
                </div>

                <div class="row">
                    <input type="hidden" name="blogID" value="<%=blog.getId()%>">
                    <h4><i class="fa-solid fa-users" style="width: 25px"></i>Blog's Information</h4>


                    <%
                        if (manager.getOrgID().equals(blog.getOrgID()) && "MOD".equals(manager.getRoleID())) {
                    %>
                    <input type="hidden" name="activity" value="Update" />


                    <div class="input-group input-group-icon">
                        <input required="" type="text" value="<%=blog.getTitle()%>" name="title" placeholder="Title"/>
                        <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                    </div>

                </div>              

                <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Blog Summary</h4>
                <div class="update-content">
                    <textarea required="" name="summary" id="role" cols="30" rows="9" style="width: 480px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                              placeholder="Enter Blog's Summary Here*"><%=blog.getSummary()%></textarea>
                </div>
                <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Blog Description</h4>
                <div class="update-content">
                    <textarea required="" name="content" id="role" cols="30" rows="9" style="width: 480px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                              placeholder="Enter Blog's Description Here*"><%=blog.getContent()%></textarea>
                </div>



                <div class="flex-row-reverse">
                    <div class="">
                        <h4>Status</h4>
                        <%
                            if (blog.isStatus() == false) {
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

                <% } else if ("CLB".equals(manager.getRoleID())) {%>
                <input type="hidden" name="activity" value="Update" />


                <div class="input-group input-group-icon">
                    <input required="" type="text" value="<%=blog.getTitle()%>" name="title" placeholder="Title"/>
                    <div class="input-icon"><i class="fa-solid fa-id-card"></i></div>
                </div>


        </div>              

        <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Blog Summary</h4>
        <div class="update-content">
            <textarea required="" name="summary" id="role" cols="30" rows="9" style="width: 480px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                      placeholder="Enter Blog's Summary Here*"><%=blog.getSummary()%></textarea>
        </div>
        <h4><i class="fa-solid fa-file-pen" style="width: 25px;"></i>Blog Description</h4>
        <div class="update-content">
            <textarea required="" name="content" id="role" cols="30" rows="9" style="width: 480px; height:300px; border-color: #dddada; font-family: 'Open Sans','Helvetica Neue',Helvetica, Arial, sans-serif;"
                      placeholder="Enter Blog's Description Here*"><%=blog.getContent()%></textarea>
        </div>



        <% } else { %>

        <input type="hidden" name="activity" value="Update" />
        <input type="hidden" name="type" value="FPT" />

        <div class="flex-row-reverse">
            <div class="">
                <h4>Status</h4>
                <%
                    if (blog.isStatus() == false) {
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


        <% }%>

        <div class="row">
            <h4><i class="fa-solid fa-link" style="width: 25px"></i>Image</h4>
            <div class="input-group input-group-icon">
                <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                <div class="input-icon"><i class="fa-solid fa-link"></i></div>
            </div>
        </div>

        <button type="submit" style="cursor: pointer" class="login-box" name="action" value="UpdateBlog">
            Update
        </button>
        <div class=" btn btn-danger" style="text-align: center">
            <a href="MainController?action=ListBlog">Cancel</a>
        </div>


    </form>
</div>
<!-- partial -->


<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script><script  src="./css_FormCreate/script.js"></script>

</body>
</html>
