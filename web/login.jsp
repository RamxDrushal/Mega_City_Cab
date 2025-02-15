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
                            <%
                            String inavlidMsg=(String)session.getAttribute("invalidMsg");
                                if(inavlidMsg!=null)
                            {%>
                            <p class="text-danger text-center"><%=inavlidMsg%></p>
                            <%
                            session.removeAttribute("inavlidMsg");
                            }
                            %>
                            
                            <%
                            String logMsg =(String)session.getAttribute("logMsg");
                                if(logMsg!=null)
                            {%>
                            <p class="text-success text-center"><%=logMsg%></p>
                            <%
                            session.removeAttribute("logMsg");
                            }
                            %>
                            
                            <form action="login" method="post">
                                
                                <div class="form-group">
                                    <label for="exampleInputEmail1">User Name</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                        <input name="password" type="password" class="form-control" id="exampleInputPassword1">
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

