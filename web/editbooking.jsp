<%-- 
    Document   : editbooking
    Created on : Feb 21, 2025, 7:53:04 PM
    Author     : ramsh
--%>

<%@page import="com.entity.Booking"%>
<%@page import="com.dao.BookingDAO"%>
<%@page import="com.conn.DbConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/allCss.jsp"%>
        <style>
            body {
            background-image: url('img/addBookingB.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
        }
        .container-fluid {
            position: relative;
            z-index: 2;
        }
        .card {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .card-body {
            background: #ffffc2;
            border-radius: 5px;
            padding: 25px;
        }
        h4 {
            font-weight: 900;
            text-transform: uppercase;
            text-align: center;
            color: #8f8a04;
            font-size: 30px;
        }
        .form-group label {
            font-weight: bold;
            color: #7d7901;
        }
            
        </style>
    </head>
    <body>
        <script>
            const locationDistances = {
                "Bambalapitiya": 1,
                "Borella": 2,
                "Cinnamon Gardens": 3,
                "Fort (Colombo)": 4,
                "Havelock Town": 5,
                "Kirulapone": 6,
                "Kollupitiya": 7,
                "Kohuwala": 8,
                "Maradana": 9,
                "Pettah": 10,
                "Wellawatte": 11,
                "Nugegoda": 12,
                "Rajagiriya": 13,
                "Dehiwala": 14,
                "Mount-Lavinia": 15,
                "Ratmalana": 16,
                "Battaramulla": 17,
                "Homagama": 18,
                "Maharagama": 19,
                "Moratuwa": 20,
                "Pannipitiya": 21,
                "Piliyandala": 22,
                "Thalawathugoda": 23
            };

            const ratePerDistance = 100; // LKR per distance unit

            function filterLocations() {
                const start = document.getElementById("startLocation").value;
                const end = document.getElementById("endLocation").value;

                if (start && end && locationDistances[start] && locationDistances[end]) {
                    const distance = Math.abs(locationDistances[start] - locationDistances[end]);
                    const amount = distance * ratePerDistance;
                    document.getElementById("amount").value = amount.toFixed(2);
                } else {
                    document.getElementById("amount").value = "";
                }
            }

            // Form Validation
            function validateForm() {
                let isValid = true;

            // Clear previous error messages
            const errorMessages = document.querySelectorAll('.error');
            errorMessages.forEach(msg => msg.remove());

            // Validate Start Location and End Location
            const startLocation = document.getElementById("startLocation").value;
            const endLocation = document.getElementById("endLocation").value;
    
            if (!startLocation || !endLocation) {
                isValid = false;
                const locationFields = document.querySelectorAll('#startLocation, #endLocation');
                locationFields.forEach(field => {
                    const errorMsg = document.createElement("p");
                    errorMsg.textContent = "Both start and end locations are required.";
                    errorMsg.classList.add("error", "text-danger");
                    field.after(errorMsg);
                });
            }

            return isValid;
            }
            </script>
            <%@include file="component/navbar.jsp" %>
            <%
            if (user == null){
                session.setAttribute("invalidMsg", "Login Please..");
                response.sendRedirect("login.jsp");
                }
            %>
        
        <div class="continer-fluid">
            <div class="row p-5">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="text-center">Edit booking</h4>
                             <% 

                            String errorMsg = (String) session.getAttribute("failedMsg");

                            // Display error message
                            if (errorMsg != null) { 
                            %>
                            <p class="text-danger text-center"><%= errorMsg %></p>
                            <%
                            session.removeAttribute("failedMsg");
                            }
                            %> 
                            <!-- Booking Form -->
                            <form action="update" method="post" onsubmit="return validateForm()">
                                <%  
                            int cid = Integer.parseInt(request.getParameter("cid"));
                            BookingDAO dao = new BookingDAO(DbConnect.getConn());
                            Booking c = dao.getContactById(cid);
                                %>
                            <input type="hidden" name="cid" value="<%= cid %>">
                                
                                <div class="form-group">
                                    <label for="name">Enter Name</label>
                                    <input value="<%=c.getName()%>" name="name" type="text" class="form-control" id="name">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input value="<%=c.getEmail()%>" name="email" type="text" class="form-control" id="email">
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input value="<%=c.getAddress()%>" name="address" type="text" class="form-control" id="address">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Enter Phone Number</label>
                                    <input value="<%=c.getPhno()%>" name="phno" type="text" class="form-control" id="phone">
                                </div>

                                <div class="form-group">
                                    <label for="startLocation">Trip Start Location</label>
                                    <select value="<%=c.getStart()%>" name="start" class="form-control" id="startLocation" onchange="filterLocations()">
                                        <option value="">Select Start Location</option>
                                        <option>Bambalapitiya</option>
                                        <option>Borella</option>
                                        <option>Cinnamon Gardens</option>
                                        <option>Fort (Colombo)</option>
                                        <option>Havelock Town</option>
                                        <option>Kirulapone</option>
                                        <option>Kollupitiya</option>
                                        <option>Kohuwala</option>
                                        <option>Maradana</option>
                                        <option>Pettah</option>
                                        <option>Wellawatte</option>
                                        <option>Nugegoda</option>
                                        <option>Rajagiriya</option>
                                        <option>Dehiwala</option>
                                        <option>Mount-Lavinia</option>
                                        <option>Ratmalana</option>
                                        <option>Battaramulla</option>
                                        <option>Homagama</option>
                                        <option>Maharagama</option>
                                        <option>Moratuwa</option>
                                        <option>Pannipitiya</option>
                                        <option>Piliyandala</option>
                                        <option>Thalawathugoda</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="endLocation">Trip End Location</label>
                                    <select value="<%=c.getEnd()%>" name="end" class="form-control" id="endLocation" onchange="filterLocations()">
                                        <option value="">Select End Location</option>
                                        <option>Bambalapitiya</option>
                                        <option>Borella</option>
                                        <option>Cinnamon Gardens</option>
                                        <option>Fort (Colombo)</option>
                                        <option>Havelock Town</option>
                                        <option>Kirulapone</option>
                                        <option>Kollupitiya</option>
                                        <option>Kohuwala</option>
                                        <option>Maradana</option>
                                        <option>Pettah</option>
                                        <option>Wellawatte</option>
                                        <option>Nugegoda</option>
                                        <option>Rajagiriya</option>
                                        <option>Dehiwala</option>
                                        <option>Mount-Lavinia</option>
                                        <option>Ratmalana</option>
                                        <option>Battaramulla</option>
                                        <option>Homagama</option>
                                        <option>Maharagama</option>
                                        <option>Moratuwa</option>
                                        <option>Pannipitiya</option>
                                        <option>Piliyandala</option>
                                        <option>Thalawathugoda</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="notes">Notes</label>
                                    <input value="<%=c.getAbout()%>" name="about" type="text" class="form-control" id="notes">
                                </div>

                                <div class="form-group">
                                    <label for="amount">Amount(LKR)</label>
                                    <input type="text" class="form-control" id="amount" name="amount" readonly>
                                </div>
                                

                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-success">Update</button>
                                </div>
                        </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <div style="margin-top: 55px">
        
    </div>
    <%@include file="component/footer.jsp" %>
    </body>
</html>
