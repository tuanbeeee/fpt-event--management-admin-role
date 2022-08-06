<%-- 
    Document   : List_Feedbacks.jsp
    Created on : Jul 4, 2022, 3:42:11 PM
    Author     : tvfep
--%>
<%@page import="sample.feedback.EventFeedback"%>
<%@page import="java.util.List"%>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <style>
            table {
                border-collapse: collapse;
                width: 60%;
                text-align: center;

            }

            th, td {
                text-align: left;
                padding: 8px;
            }

            tr{background-color: #f2f2f2; border-bottom: 1px solid white}

            th {
                background-color: #FC8272;
                color: white;
            }
            a:hover{

                opacity: 0.8;
            }
        </style>
        <title>F.E.M - List Feedbacks</title>
    </head>

    <%List<EventFeedback> listFeedbacks = (List) request.getAttribute("listFeedbacks");
        String eventID = (String) request.getAttribute("eventID");

    %>

    <body>
        <div style="text-align: center" >
            <h2 class="mb-3 mt-2" >Feedbacks Table</h2>

            <div class="mt-3">
                <a class="btn" href="MainController?action=EventDetail&eventID=<%=eventID%>" class="brand-logo" style="font-size: 15pt; color: white; background-color: #FC8272">
                    Back!
                </a>

                <button class="btn"  onclick="exportData()" class="brand-logo" style="font-size: 15pt; color: white; background-color: #FC8272">
                    Export To Excel!
                </button> 
            </div>
            </br>

            <table class="m-md-auto" id="tblFeedbacks" style="border-radius: 10px;">
                <tr>
                    <th>Feedback ID</th>
                    <th>Event ID</th>
                    <th>Content</th>
                </tr>

                <%for (int i = 0; i < listFeedbacks.size(); i++) {
                %>

                <tr>
                    <td><%=listFeedbacks.get(i).getFeedbackID()%> </td>
                    <td><%=listFeedbacks.get(i).getEventID()%></td>
                    <td><%=listFeedbacks.get(i).getContent()%></td>
                </tr>
                <%
                    }
                %>
            </table>

        </div>
        <br>

        <script>
            function exportData() {
                /* Get the HTML data using Element by Id */
                var table = document.getElementById("tblFeedbacks");

                /* Declaring array variable */
                var rows = [];

                //iterate through rows of table
                for (var i = 0, row; row = table.rows[i]; i++) {
                    //rows would be accessed using the "row" variable assigned in the for loop
                    //Get each cell value/column from the row
                    column1 = row.cells[0].innerText;
                    column2 = row.cells[1].innerText;
                    column3 = row.cells[2].innerText;
                    column4 = row.cells[3].innerText;
                    column5 = row.cells[4].innerText;

                    /* add a new records in the array */
                    rows.push(
                            [
                                column1,
                                column2,
                                column3,
                                column4,
                                column5
                            ]
                            );

                }
                csvContent = "data:text/csv;charset=utf-8,\ufeff";
                /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
                rows.forEach(function (rowArray) {
                    row = rowArray.join(",");
                    csvContent += row + "\r\n";
                });

                /* create a hidden <a> DOM node and set its download attribute */
                var encodedUri = encodeURI(csvContent);
                var link = document.createElement("a");
                link.setAttribute("href", encodedUri);
                link.setAttribute("download", "List_Feedbacks.csv");
                document.body.appendChild(link);
                /* download the data file named "Stock_Price_Report.csv" */
                link.click();
            }
        </script>

    </body>
</html>
