<%@page import="com.entity.User"%>
<%@page import="com.conn.DbConnect"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/allCss.jsp"%>
        <style type="text/css">
            .about-home {
                background-image: url(img/aboutbg.png);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover; 
                width: 100%;
                min-height: 92vh; 
                display: flex;
                align-items: center;
            }
            .about-content{
                padding: 0 4rem;                
            }
            .about-content h3{
                font-size: 40px;
                font-weight: 600;
                color: white;
                text-transform:uppercase;
                margin-top: 9px;
                letter-spacing:5px;
                margin-left: 15px;
            }
            .about-content h1{
                color: white;
                font-size: 50px;
                font-weight: 700;
                margin-top: 15px;
                margin-left: 15px;
            }
            .about-content h1 span{
                background: yellow;
                color: black;
                padding: 0.2rem;
                transform: skew(-20deg);
                display: inline-block;
            }
            .aboutUs-container h1{
                font-size: 50px;
                margin-top: 100px;
                
            }
            .about-1 {
                padding: 60px 20px;
                color: #333;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .about-1::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.1);
                z-index: 1;
                pointer-events: none;
            }

            .about-1 h1 {
                font-size: 3em;
                margin-bottom: 20px;
                position: relative;
                z-index: 2;
                text-shadow: 2px 2px 6px rgba(0,0,0,0.4);
            }

            .about-1 p {
                font-size: 1.2em;
                line-height: 1.6;
                position: relative;
                z-index: 2;
                max-width: 800px;
                margin: 0 auto;
                text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
            }

            .about-1 h1::before {
                content: '🌟';
                margin-right: 10px;
                animation: sparkle 2s infinite;
            }
            .content-box-lg {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .about-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }
            
            .about-row {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 30px;
            }

            .about-col-md-4 {
                flex: 1 1 30%;
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.3s ease-in-out;
            }

            .about-col-md-4:hover {
                transform: translateY(-10px);
                background-color: #f0e102;
                color: #fff;
            }

            .about-item-text-center i {
                font-size: 40px;
                color: #ebde31;
                margin-bottom: 20px;
            }

            .about-item-text-center h3 {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }

            .about-item-text-center p {
                font-size: 16px;
                line-height: 1.5;
                color: #777;
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
        
        <div class="about-home">
            <div class="about-inner-contect">
                <div class="about-content">
                    <h3>Hire the best Service</h3>
                    <h1>Trusted and <span>Cheapest Cab</span> <br>
                    Company Service
                    </h1>
                </div>
            </div>    
        </div>
        <section>
            <div class="about-1">
                <h1>About Us</h1>
                <p>Welcome to Mega City Cab,Your trusted partner for safe, reliable, and convenient transportation.
                "Ride with Comfort, Arrive with Confidence!" We are dedicated to providing top-notch cab services that cater to your travel needs with comfort, efficiency, and affordability.
                Whether you're heading to the airport, commuting to work, or planning a city tour, our well-maintained fleet and experienced drivers ensure a smooth and punctual ride. 
                Our services are available 24/7, with advanced booking options, real-time tracking, and flexible payment methods to make your journey stress-free.
                Experience the difference with our customer-focused approach, where your safety and satisfaction are our top priorities.</p>
            </div>
            <div id="about-2">
                <div class="content-box-lg">
                    <div class="about-container">
                        <div class="about-row">
                            <div class="about-col-md-4">
                                <div class="about-item-text-center">
                                    <i class="fa fa-book"></i>
                                    <h3>Mission</h3>
                                    <br>
                                    <p>Our mission is simple: to make your journeys seamless and enjoyable, with a strong commitment to customer satisfaction at every step. 
                                    Whether you're commuting to work, heading to the airport, or exploring the city, we ensure timely pickups, professional drivers, and a smooth ride every time.</p>
                                </div>
                            </div>
                            <div class="about-col-md-4">
                                <div class="about-item-text-center">
                                    <i class="fa fa-globe"></i>
                                    <h3>Vision</h3>
                                    <br>
                                    <p>Our mission is simple: to make your journeys seamless and enjoyable, with a strong commitment to customer satisfaction at every step. 
                                    Whether you're commuting to work, heading to the airport, or exploring the city, we ensure timely pickups, professional drivers, and a smooth ride every time.</p>
                                </div>
                            </div>
                            <div class="about-col-md-4">
                                <div class="about-item-text-center">
                                    <i class="fa fa-pencil"></i>
                                    <h3>Achievements</h3>
                                    <br>
                                    <p>Our mission is simple: to make your journeys seamless and enjoyable, with a strong commitment to customer satisfaction at every step. 
                                    Whether you're commuting to work, heading to the airport, or exploring the city, we ensure timely pickups, professional drivers, and a smooth ride every time.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </section>
        <%@include file="component/footer.jsp" %>
       
    </body>
    
</html>


