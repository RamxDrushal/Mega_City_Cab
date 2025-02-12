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
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="text-center text-success">Login Page</h4>
                            <form>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">User Name</label>
                                        <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                        <input type="password" class="form-control" id="exampleInputPassword1">
                                        <div class="text-center mt-4">
                                            <button type="submit" class="btn btn-primary">Login</button>
                                        </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="margin-top: 130px">
            
        </div>
    </body>
</html>

