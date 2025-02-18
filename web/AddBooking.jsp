<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        </script>
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
                            <h4 class="text-center text-success">Add booking</h4>
                            <form>
                                <div class="form-group">
                                    <label for="name">Enter Name</label>
                                    <input type="text" class="form-control" id="name">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="text" class="form-control" id="email">
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Enter Phone Number</label>
                                    <input type="text" class="form-control" id="phone">
                                </div>

                                <div class="form-group">
                                    <label for="startLocation">Trip Start Location</label>
                                    <select class="form-control" id="startLocation" onchange="filterLocations()">
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
                                    <select class="form-control" id="endLocation" onchange="filterLocations()">
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
                                    <input type="text" class="form-control" id="notes">
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
    </body>
</html>

