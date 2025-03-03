<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/allCss.jsp"%>
        <%@include file="component/script.jsp" %>
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

            const ratePerDistance = 100; 

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

            
            function validateForm() {
                let isValid = true;

               
                const errorMessages = document.querySelectorAll('.error');
                errorMessages.forEach(msg => msg.remove());

               
                const name = document.getElementById("name").value;
                if (!name) {
                    isValid = false;
                    const nameField = document.getElementById("name");
                    const errorMsg = document.createElement("p");
                    errorMsg.textContent = "Name is required.";
                    errorMsg.classList.add("error", "text-danger");
                    nameField.after(errorMsg);
                }

                
                const email = document.getElementById("email").value;
                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!email || !emailRegex.test(email)) {
                    isValid = false;
                    const emailField = document.getElementById("email");
                    const errorMsg = document.createElement("p");
                    errorMsg.textContent = "Please enter a valid email address.";
                    errorMsg.classList.add("error", "text-danger");
                    emailField.after(errorMsg);
                }

                
                const phone = document.getElementById("phone").value;
                const phoneRegex = /^[0-9]{10}$/; 
                if (!phone || !phoneRegex.test(phone)) {
                    isValid = false;
                    const phoneField = document.getElementById("phone");
                    const errorMsg = document.createElement("p");
                    errorMsg.textContent = "Please enter a valid 10-digit phone number.";
                    errorMsg.classList.add("error", "text-danger");
                    phoneField.after(errorMsg);
                }

                
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
        
        <style type="text/css">
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
            
            .form-control {
                border-radius: 8px;
                border: 1px solid #FFC107;
                padding: 10px;
                transition: all 0.3s;
            }
            
            .form-control:focus {
                border-color: #FF9800;
                box-shadow: 0px 0px 5px rgba(255, 152, 0, 0.5);
            }
            
            .btn-primary {
                background: #FF9800;
                border: none;
                padding: 12px 25px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                text-transform: uppercase;
                transition: all 0.3s;
                width: 100%;
            }
            
            .btn-primary:hover {
                background: #E65100;
            }
            
            .cab-icon {
                font-size: 50px;
                color: #FF9800;
                display: block;
                text-align: center;
                margin-bottom: 15px;
            }
            
            .error {
                font-size: 16px;
                margin-top: 5px;
            }
            .alert {
                border-radius: 8px; 
                padding: 15px; 
                font-weight: bold;
                transition: opacity 0.5s ease-in-out;
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .close {
                font-size: 1.5rem;
                color: #000;
                opacity: 0.5;
                transition: opacity 0.3s ease;
            }

            .close:hover {
                opacity: 1;
            }

            .alert.fade.show {
                opacity: 1 !important;
            }
        </style>
    </head>
    <body>
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
                            <h4 class="text-center">Add booking</h4>
                             <% 
                                String sucssMsg = (String) session.getAttribute("succMsg");
                                String errorMsg = (String) session.getAttribute("failedMsg");

                                if (sucssMsg != null) { 
                            %>
                                <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                                    <%= sucssMsg %>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            <%
                                    session.removeAttribute("succMsg");
                                    }
                                    if (errorMsg != null) { 
                                %>
                            <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
                                <%= errorMsg %>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        <%
                            session.removeAttribute("failedMsg");
                            }
                        %> 

                            <form action="addBooking" method="post" onsubmit="return validateForm()">
                                <% if (user != null) { %>
                                    <input type="hidden" value="<%= user.getID() %>" name="userid">
                                <% }%>
                                <div class="form-group">
                                    <label for="name">Enter Name</label>
                                    <input name="name" type="text" class="form-control" id="name">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input name="email" type="text" class="form-control" id="email">
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input name="address" type="text" class="form-control" id="address">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Enter Phone Number</label>
                                    <input name="phno" type="text" class="form-control" id="phone">
                                </div>
                                <div class="form-group">
                                    <label for="bookingDate">Booking Date</label>
                                    <input name="bookingDate" type="date" class="form-control" id="bookingDate" required>
                                </div>

                                <div class="form-group">
                                    <label for="startLocation">Trip Start Location</label>
                                    <select name="start" class="form-control" id="startLocation" onchange="filterLocations()">
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
                                    <select name="end" class="form-control" id="endLocation" onchange="filterLocations()">
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
                                    <input name="about" type="text" class="form-control" id="notes">
                                </div>

                                <div class="form-group">
                                    <label for="amount">Amount(LKR)</label>
                                    <input type="text" class="form-control" id="amount" name="amount" readonly>
                                </div>
                                

                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-primary">Save</button>
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
