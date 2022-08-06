<%@page import="sample.users.ManagerDTO"%>
<%@page import="sample.ticket.TicketDTO"%>
<!DOCTYPE html>
<html lang="en">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <head>
        <meta charset="UTF-8">
        <title>F.E.M - TICKET</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/all.min.css">
        <link rel="stylesheet" href="assets/css/icofont.min.css">
        <link rel="stylesheet" href="assets/css/lightcase.css">
        <link rel="stylesheet" href="assets/css/swiper.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link href='https://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css' />
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>
        <script type="text/javascript">

            function testConfirmDialog() {

                var result = confirm("XÁC NHẬN THAM GIA !!!");

                if (result) {
                    alert("OK Next lesson!");
                } else {
                    alert("Bye!");
                }
            }

        </script>
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Staatliches&display=swap");
            @import url("https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap");
            @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@500;600&display=swap');


            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body,
            html {
                height: 100vh;
                display: grid;
                font-family: "Staatliches", cursive;
                background: #965bdf;
                color: black;
                font-size: 14px;
                letter-spacing: 0.1em;
            }

            .ticket {
                margin: auto;
                display: flex;
                background: white;
                box-shadow: rgba(0, 0, 0, 0.3) 0px 19px 38px, rgba(0, 0, 0, 0.22) 0px 15px 12px;
                border-radius: 20px;
            }

            .left {
                display: flex;
            }
            <%TicketDTO dto = new TicketDTO();
                dto = (TicketDTO) request.getAttribute("participantsConfirm");%>
            .image {
                height: 250px;
                width: 250px;
                <%if (dto.getAvatarURL().contains("Image//")) {%>
                background-image: url("	http://localhost:8080/EventManagement/<%=dto.getAvatarURL()%>");
                <%} else {%>
                background-image: url("<%=dto.getAvatarURL()%>");
                <%}%>
                background-size: contain;
                opacity: 0.85;
                border-radius: 20px;
            }

            .admit-one {
                position: absolute;
                color: rgb(255, 255, 255);
                height: 250px;
                padding: 0 10px;
                letter-spacing: 0.15em;
                display: flex;
                text-align: center;
                justify-content: space-around;
                writing-mode: vertical-rl;
                transform: rotate(-180deg);
            }

            .admit-one span:nth-child(2) {
                color: white;
                font-weight: 700;
            }

            .left .ticket-number {
                height: 250px;
                width: 250px;
                display: flex;
                justify-content: flex-end;
                align-items: flex-end;
                padding: 5px;
            }

            .ticket-info {
                padding: 10px 30px;
                display: flex;
                flex-direction: column;
                text-align: center;
                justify-content: space-between;
                align-items: center;
            }

            .date {
                border-top: 1px solid gray;
                border-bottom: 1px solid gray;
                padding: 5px 0;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: space-around;
            }

            .date span {
                width: 100px;
            }

            .date span:first-child {
                text-align: left;
            }

            .date span:last-child {
                text-align: center;
            }

            .date .june-29 {
                color: #d83565;
                font-size: 20px;
            }

            .show-name {
                font-size: 32px;
                font-family: "Nanum Pen Script", cursive;
                color: #d83565;
            }

            .show-name h1 {
                font-size: 30px;
                font-weight: 700;
                letter-spacing: 0.1em;
                color: #4a437e;
            }

            .time {
                padding: 10px 0;
                color: #4a437e;
                text-align: center;
                display: flex;
                flex-direction: column;
                gap: 10px;
                font-weight: 700;
            }

            .time span {
                font-weight: 400;
                color: gray;
            }

            .left .time {
                font-size: 16px;
            }


            .location {
                display: flex;
                justify-content: space-around;
                align-items: center;
                width: 100%;
                padding-top: 8px;
                border-top: 1px solid gray;
            }

            .location .separator {
                font-size: 20px;
            }

            .right {
                width: 180px;
                border-left: 1px dashed #404040;
            }

            .right .admit-one {
                color: darkgray;
            }

            .right .admit-one span:nth-child(2) {
                color: gray;
            }

            .right .right-info-container {
                height: 250px;
                padding: 10px 10px 10px 35px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .right .show-name h1 {
                font-size: 18px;
            }

            .barcode {
                height: 100px;
            }

            .barcode img {
                height: 100%;
            }

            .right .ticket-number {
                color: gray;
            }

            #c {
                display: none;
            }

            #upload_app {
                display: block;
                /* position: absolute; */
                top: 50%;
                right: 0;
                left: 0;
                margin: -18px 137px;
                margin-top: 10px;
                width: 120px;
                height: 42px;
                transform: translateY(-50%);
                transition: 0.3s ease width;
                cursor: pointer;
            }

            #app {
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                background-color: #fff;
                border: 2px solid #d83565;
                overflow: hidden;
                z-index: 2;
            }

            #app:before {
                content: "Xác Nhận";
                font-family: 'Open Sans', serif;
                position: absolute;
                top: 0;
                right: 0;
                padding: 12px;
                left: 0;
                color: #143240;
                font-size: 12px;
                line-height: 14px;
                font-weight: bolder;
                z-index: 1;
            }

            #arrow {
                position: absolute;
                top: 0;
                right: 0;
                width: 38px;
                height: 38px;
                background-color: #fff;
                z-index: 2;
            }

            #arrow:before,
            #arrow:after {
                content: "";
                position: absolute;
                top: 18px;
                width: 10px;
                height: 2px;
                background-color: #143240;
            }

            #arrow:before {
                right: 17px;
                transform: rotateZ(-45deg);
            }

            #arrow:after {
                right: 11px;
                transform: rotateZ(45deg);
            }

            #success {
                position: absolute;
                top: 0;
                right: 0;
                width: 54px;
                height: 54px;
                margin: -8px;
                background-color: #965bdf;
                transform: scale(0);
                border-radius: 50%;
                z-index: 3;
            }

            #success i {
                font-size: 20px;
                color: #fff;
                display: block;
                width: 20px;
                height: 20px;
                margin: 17px auto;
                transform: scale(0);
            }

            #c:checked + #upload_app {
                width: 42px;
            }

            #c:checked + #upload_app #arrow:before {
                animation: _a 0.1s ease 0.2s forwards, _incHeight 0.1s ease 1s forwards;
            }

            #c:checked + #upload_app #arrow:after {
                animation: _b 0.1s ease 0.4s forwards, _incHeight 0.1s ease 1s forwards;
            }

            #c:checked + #upload_app #success {
                animation: _success 0.4s cubic-bezier(0, 0.74, 0.32, 1.21) 2s forwards;
            }

            #c:checked + #upload_app #success i {
                animation: _success 0.3s cubic-bezier(0, 0.74, 0.32, 1.21) 2s forwards;
            }

            @keyframes _a {
                0% {
                    top: 18px;
                    right: 17px;
                    width: 10px;
                    transform: rotateZ(-45deg);
                    background-color: #143240;
                }
                100% {
                    top: 36px;
                    right: 19px;
                    width: 39px;
                    transform: rotateZ(0deg);
                    background-color: #d83565;
                }
            }

            @keyframes _b {
                0% {
                    top: 18px;
                    right: 11px;
                    width: 10px;
                    transform: rotateZ(45deg);
                    background-color: #143240;
                }
                100% {
                    top: 36px;
                    right: 0;
                    width: 19px;
                    transform: rotateZ(0deg);
                    background-color: #d83565;
                }
            }

            @keyframes _incHeight {
                0% {
                    top: 36px;
                    height: 2px;
                }
                25% {
                    top: 31px;
                    height: 8px;
                }
                50% {
                    top: 21px;
                    height: 18px;
                }
                80% {
                    top: 11px;
                    height: 28px;
                }
                100% {
                    top: 0;
                    height: 39px;
                }
            }

            @keyframes _success {
                0% {
                    transform: scale(0);
                }
                100% {
                    transform: scale(1);
                }
            }
            .primary1 {
                display: inline-block;
                line-height: 30px;
                padding: 0 18px;
                background: #fff;
                color: #df01ae;
                font-family: "Vollkorn";
                font-style: italic;
                font-size: 20px;
                text-transform: capitalize;
                -webkit-transition: all 0.3s ease;
                -moz-transition: all 0.3s ease;
                transition: all 0.3s ease;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                box-shadow: 4px 4px 0 0 currentColor;
                border-color: #df01ae;
            }
        </style>
    </head>

    <body>
        <!-- partial:index.partial.html -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

        <div class="ticket">
            <div class="left">
                <div class="image">
                    <p class="admit-one">
                        <span>F.E.M</span>
                        <span>F.E.M</span>
                        <span>F.E.M</span>
                    </p>

                </div>
                <div class="ticket-info">
                    <p class="date">

                        <span class="june-29"><%=dto.getTakePlaceDate()%></span>

                    </p>
                    <div class="show-name">
                        <h1 style="font-family: 'Open Sans', serif;"><%=dto.getTitle()%></h1>
                    </div>
                    <div class="time">
                        <p><%=dto.getSlotTime()%></p>
                    </div>
                    <p class="location" style="font-family: 'Open Sans', serif; color: #000;"><span><%=dto.getLocationName()%></span>
                    </p>
                </div>
            </div>
            <div class="right">
                <p class="admit-one">
                    <span>F.E.M</span>
                    <span>F.E.M</span>
                    <span>F.E.M</span>
                </p>
                <div class="right-info-container">
                    <div class="show-name">
                        <h1 style="font-family: 'Open Sans', serif; font-size: 13px;"><%=dto.getFullName()%></h1>
                    </div>
                    <div class="time">
                    </div>
                    <form action="MainController" method="POST">
                        <input type="hidden" name="userID" value="<%=dto.getUserID()%>">
                        <input type="hidden" name="eventID" value="<%=dto.getEventID()%>">     
                        <input type="hidden" name="orgID" value="<%=dto.getOrgid()%>">                      

                        <%if ("TRUE".equals(request.getAttribute("CONFIRM"))) {
                        %>

                        <button disabled="" class="btn btn-primary primary1" style="font-family: 'Open Sans', serif; ">
                            <span style="font-weight: bold; ">Checked</span>
                        </button>

                        <%
                        } else {
                        %>
                        <button type="submit" name="action" value="TicketConfirm" class="btn btn-primary primary1" style="font-family: 'Open Sans', serif; ">
                            <span style="font-weight: bold; ">Checkin</span>
                        </button>
                        <%
                            }
                        %>



                    </form>

                </div>
            </div>
        </div>
        <!-- partial -->
        <script src="./script.js"></script>

    </body>

</html>