<%@page import="sample.organization.OrganizationDTO"%>
<%@page import="sample.organization.OrganizationError"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>F.E.M - FPT Event Management</title>
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
        <link rel="stylesheet" href="./css_FormCreate/style.css">
        <link rel="stylesheet" href="./css_FormCreate/css/all.css">
        <script src="https://your-site-or-cdn.com/fontawesome/v5.15.4/js/all.js" data-auto-replace-svg></script>
        <script src="https://use.fontawesome.com/releases/vVERSION/js/all.js" data-auto-replace-svg="nest"></script>

        <style>
            .text-danger {
                color: red;
                font-size: 12px;
                font-weight: bold;
            }
        </style>

    </head>
    <body>
        <!-- partial:index.partial.html -->
        <%
            OrganizationDTO org = (OrganizationDTO) request.getAttribute("ORG");

            OrganizationError error = (OrganizationError) request.getAttribute("ERROR");
            if (error == null) {
                error = new OrganizationError();
            }

            String success = (String) request.getAttribute("SUCCESS");
            if (success == null) {
                success = "";
            }
        %>
        <div class="container">
            <h3 style="font-weight: 900" class="text-danger"><%= success%></h3>


            <div class="row">
                <h1 style="font-size: 20px" class="Information">Organization Information</h1>

                <%
                    if (org == null) {
                        org = new OrganizationDTO();
                    } else {
                %>
                <div style="text-align: center">
                    <img style="max-width: 25%; border-radius: 20px" src="<%= org.getImgUrl()%>">
                </div>

                <!--       //          <form action="UploadImageController" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" name="page" value="Admin_OrgForm.jsp" />
                                    <input type="hidden" name="id" value="<%= org.getOrgID()%>"/>
                                    <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                                    <button style="width: 150px; font-size: 12px; cursor: pointer" type="submit" class="login-box" >
                                        Upload Image
                                    </button>
                                </form> -->
                <% }%>

                <form action="MainController" method="POST" enctype="multipart/form-data">
                    <h4><i class="fa-solid fa-id-card" style="width: 25px"></i>Organization</h4>
                    <div class="input-group input-group-icon">
                        <input type="text" required="" name="orgID" value="<%= org.getOrgID()%>" placeholder="Organization ID"/>
                        <div class="input-icon"><i class="fa fa-user"></i></div>
                        <p class="text-danger"><%= error.getOrgIDError()%></p>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="text" required="" name="orgName" value="<%= org.getOrgName()%>" placeholder="Organization Name"/>
                        <div class="input-icon"><i class="fa-solid fa-file-signature"></i></div>
                        <p class="text-danger"><%= error.getOrgNameError()%></p>

                    </div>


                    <div class="input-group input-group-icon">
                        <input type="email" required="" name="email" value="<%= org.getEmail()%>" placeholder="Email"/>
                        <div class="input-icon"><i class="fa fa-envelope"></i></div>
                    </div>

                    <div class="input-group input-group-icon">
                        <input type="text" required="" name="description" value="<%= org.getDescription()%>" placeholder="Description"/>
                        <div class="input-icon"><i class="fa fa-file-text-o"></i></div>
                        <p class="text-danger"><%= error.getDescriptionError()%></p>

                    </div>

            </div>
            <div class="flex-row-reverse">
                <div class="">

                    <h4>Status</h4>
                    <%
                        if (org.isStatus() == false) {
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
                        <input id="status-true" type="radio" name="status" checked="" value="true"/>
                        <label for="status-true">Active</label>
                        <input id="status-false" type="radio" name="status"  value="false"/>
                        <label for="status-false">Inactive</label>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <!--    <div class="row">
                  <h4>Type</h4>
                  <div>
                    <div class="input-group">
                      <select class="center">
                        <option>EMP</option>
                        <option>STU</option>
                      </select>
                    </div>
                  </div>
                </div>-->
            
            <div class="row">
                <h4><i class="fa-solid fa-link" style="width: 25px"></i>Image</h4>
                <div class="input-group input-group-icon">
                    <input type="file" accept=".jpg, .jpeg, .png" name="image" />
                    <div class="input-icon"><i class="fa-solid fa-link"></i></div>
                </div>
            </div>

            <%
                if (org.getOrgID() == "") {
            %>
            <button style="cursor: pointer" class="login-box" type="submit" name="action" value="CreateOrg"> Submit </button>
            <%
            } else {
            %>
            <button style="cursor: pointer" class="login-box" type="submit" name="action" value="UpdateOrg"> Submit </button>
            <input type="hidden" name="oldOrgID" value="<%= org.getOrgID()%>">
            <%
                }
            %>

            <div style="text-align: center;margin-top: 15px; font-size: 13px"><a href="AdminOrgPageController">Cancel</a> </div> 
        </form>
    </div>
    <!-- partial -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="./css_FormCreate/script.js"></script>

</body>
</html>
