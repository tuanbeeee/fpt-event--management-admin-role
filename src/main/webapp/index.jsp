<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./css_Login/style.css" />
        <title>Sign in & Sign up Form</title>
    </head>

    <body>
        <div class="container">
            <div class="forms-container">
                <div class="signin-signup">
                    <form action="MainController" method="POST" class="sign-in-form">
                        <h2 class="title">Sign in</h2>
                        <%
                            String error = (String) request.getAttribute("ERROR");
                            if (error == null)
                                error = "";
                        %>
                        <%
                            String userID = (String) request.getAttribute("USERID");
                            String eventID = (String) request.getAttribute("EVENTID");
                            String orgID = (String) request.getAttribute("ORGID");%>
                        <p style="font-weight: bold; color: red"><%= error%></p>
                        <div class="input-field">
                            <i class="fas fa-user"></i>
                            <input type="text" placeholder="Username" name="username"/>
                        </div>
                        <div class="input-field" >
                            <i class="fas fa-lock"></i>
                            <input id="pass"  type="password" name="password" placeholder="Password" />
                            <i onclick="show('pass')"  class="fas fa-eye"></i>
                        </div>
                        <div style="display: flex;">
                            <label style="margin-right: 100px; color: rgb(255, 166, 0);">
                                <input type="checkbox" checked>
                                Remember me
                            </label>
                        </div>
                        <input type="hidden" name="eventID" value="<%=eventID%>"/>
                        <input type="hidden" name="userID" value="<%=userID%>"/>
                        <input type="hidden" name="orgID" value="<%=orgID%>"/>
                        <%if (userID == null && eventID == null && orgID == null) {%>
                        <input type="submit" name="action" value="Login" class="btn solid" />
                        <%} else {%>
                        <input type="submit" name="action" value="LoginToCheckTicket" class="btn solid" />
                        <%}%>
                    </form>
                </div>
            </div>

            <div class="panels-container">
                <div class="panel left-panel">
                    <img width="200px" src="./css_Login/img/register.svg" class="image" alt="" />
                </div>
            </div>

            <script src="/css_Login/Fapp.js"></script>
    </body>

</html>