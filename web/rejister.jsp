<%-- 
    Document   : rejister
    Created on : Feb 11, 2025, 10:32:28 PM
    Author     : ramsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/allCss.jsp"%>
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>
        <div class="continer-fluid">
            <div class="row p-5">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="text-center text-success">Registartion Page</h4>
                            
                            <% String sucssMsg=(String)session.getAttribute("sucssMsg");
                            String errorMsg=(String)session.getAttribute("errorMsg");
                            if(sucssMsg!=null){
                            %>
                            <p class="text-success text-center"><%=sucssMsg %></p>
                            <%
                            session.removeAttribute("sucssMsg");
                            }
                            if(errorMsg!=null)
                            {
                            %>
                            <p class="text-danger text-center"><%=errorMsg %></p>
                            <%
                            session.removeAttribute("errorMsg");
                            }
                            %>
                            
                            <form action="register" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">User Name</label>
                                    <input name="name" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Address</label>
                                    <input name="Address" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">NIC</label>
                                    <input name="NIC" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="password" type="password" class="form-control" id="exampleInputPassword1">
                                        <div class="text-center mt-4">
                                            <button type="submit" class="btn btn-primary">Register</button>
                                        </div>
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
