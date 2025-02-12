<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/allCss.jsp"%>
        <style type="text/css">
            section {
                padding: 100px 17% 90px;
            }
            .home{
                position: relative;
                height: 100vh;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                text-align: center;
                background: url(img/bg.jpg);
                background-size: cover;
                background-position: center;
            }
            .home-content{
                padding-top: 170px;
            }
            .home-img{
                position: relative;
            }
            .home-img img{
                margin-top: 50px;
                max-width: 850px;
                width: 100%;
                height: 100%;
                object-fit: contain;
            }
            .home-content h5{
                font-size: 18px;
                font-weight: 600;
                color: yellow;
                text-transform:uppercase;
                margin-top: 9px;
                letter-spacing:7px;
            }
            .home-content h1{
                font-size: 60px;
                font-weight: 900;
                color: white;
                line-height: 1.2;
            }
            .info-box{
                position: absolute;
                background-color: #ffffff1a;
                border: 1px solid #ffffff33;
                border-radius: 30px;
                padding: 35px 20px 25px;
                max-width: 190px;
                right: 20px;
                top: 90px;
            }
            .count{
                color: yellow;
                font-size: 45px;
                font-weight: 600;
                margin-bottom: 5px;
            }
            .info-text{
                font-size: 15px;
                line-height: 28px;
                color: white;
                text-transform: uppercase;
            }
            .socail-icons{
                position: absolute;
                top: 60%;
                left: 5%;
                transform: translateY(-50%);
                
            }
            .socail-icons i{
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                width: 40px;
                height: 40px;
                color: white;
                border: 1px solid #5a5a5b;
                margin-bottom: 15px;
                background: transparent;
                transition: all .7s ease;
            }
            .socail-icons i:hover{
                transform: scale(1.1) translate(-4px);
                color: white;
                background: white;
            }
            .arrow{
                position: absolute;
                bottom: 8%;
                right: 5%;
            }
            .arrow i{
                display: inline-flex;
                align-items: center;
                justify-content: center;
                height: 50px;
                width: 50px;
                background: yellow;
                color: white;
                border: 1px solid transparent;
                border-radius: 50%;
                font-size: 30px;
                transition: all .7s ease;
            }
            .arrow i:hover{
                background: transparent;
                color: black;
                transform: scale(0.9);
            }
            .about{
                display: grid;
                grid-template-columns: repeat(2,1fr);
                align-items: center;
                gap: 2rem;
            }
            .about-img{
                position: relative;
            }
            .about-img img{
                max-width: 520px;
                width: 100%;
                height: 100%;
                object-fit: contain;
            }
            .ab-img img{
                position: absolute;
                top: -170px;
                right: -20px;
                max-width: 230px;
                width: 100%;
                height: 100%;
                object-fit: contain;
                cursor: pointer;
            }
            .about-text h2{
                font-size: 50px;
                font-weight: 700;
                line-height: 1.2;
                margin: 15px 0;
            }
            .about-text h5{
                font-size: 20px;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 7px;
            }
            .about-text p{
                font-size: 17px;
                font-weight: 500;
                line-height: 30px;
                color: #5a5a5b;
                margin-top: 25px;
            }
            .about-text h4{
                font-size: 17px;
                font-weight: 700;
                margin-bottom: 35px;
                line-height: 1.8;
            }
            .outer{
                margin-bottom: 40px;
                display: flex;
                flex-direction: column;
                gap: 5px
            }
            .f-block{
                font-size: 18px;
                font-weight: 800;
            }
            .f-block i{
                font-size: 30px;
                margin-right: 10px;
            }
            .btn1{
                display: inline-block;
                font-size: 16px;
                padding: 18px 60px 15px 40px;
                font-weight: 700;
                color: black;
                background: yellow;
                border-radius: 20px 0;
                transition: all .7s ease;
            }
            .btn1:hover{
                border-radius: 0 20px 0 0;
                background: black;
                color: white;
            }
            .text-center{
                text-align: center;
            }
            .text-center h5{
                font-size: 17px;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: .7px;
                margin-bottom: 5px;    
            }
            .text-center h2{
                font-size: 50px;
                font-weight: 700;
                line-height: 1.2;
            }
            .services-content{
                display: grid;
                grid-template-columns: repeat(auto-fill,minmax(300px, auto));
                gap: 2rem;
                margin-top: 3rem;
                text-align: center;
            }
            .s-img{
                margin-bottom: 10px;
                overflow: hidden;
                clip-path: polygon(0 27.5%, 100% 0, 100% 74%, 0 99%);
                -webkit-transition: all 300ms ease;
                transition: all 300ms ease;
            }
            .s-img img{
                display: block;
                width: 100%;
                transition: transform 0.6s;
                cursor: pointer;
            }
            .s-img img:hover{
                transform: scale(1.2);
            }
            .row h3{
                font-size: 30px;
                font-weight: 600;
                margin-bottom: 10px;
                
            }
            .row p{
                font-size: 15px;
                font-weight: 600;
                line-height: 30px;
                color: gray;
            }
        </style>
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>      
        <!-- home -->
        <section class="home" id="home">
            <div class="home-content">
                <div class="home-text">
                    <h5>Welcome to Mega City Cab </h5>
                    <h1>Securely Booking your Taxi today <br> From Any Location</h1>
                </div>
                <div class="home-img">
                    <img src="img/home.png">
                    <div class="info-box">
                        <div class="count">80+</div>
                        <div class="info-text">Available taxi for booking</div>
                    </div>
                </div>
                <div class="socail-icons">
                    <a href="#"><i class="ri-facebook-fill"></i></a>
                    <a href="#"><i class="ri-instagram-fill"></i></a>
                    <a href="#"><i class="ri-twitter-fill"></i></a>
                    <a href="#"><i class="ri-dribbble-line"></i></a>
                </div>
                
                <div class="arrow">
                    <a href="#about"><i class="ri-arrow-down-s-line"></i></a>
                </div>
            </div>
        </section>
        <!-- 2nd layout -->
        <section class="about" id="about">
            <div class="about-img">
                <img src="img/about1.jpg">
                
                <div class="ab-img">
                    <img src="img/about2.png">   
                </div>
            </div>
            <div class="about-text">
                <h5>Welcome to our Mega City Cab</h5>
                <h2>We provide Trusted Cab Services</h2>
                <p>We successfully cope with tasks of varying complexity, provide long-term guarantees and regularly master new technologies</p>
                <h4>Our portfolio includes doaens of successfully completed projects of houses of different storeys,</h4>
                
                <div class="outer">
                <div class="f-block">
                    <i class="ri-calendar-line"></i>
                    Online Booking
                </div>
                <div class="f-block">
                    <i class="ri-customer-service-line"></i>
                    24 / 7 Support
                </div>
            </div>
            <a href="AddBooking.jsp" class="btn1">Book a Cab</a>
           </div>
        </section>
        <!-- Services -->
        <section class="services" id="services">
            <div class="text-center">
                <h5>Latest Services</h5>
                <h2>Check out all time <br> Best Services</h2>
            </div>
            <div class="services-content">
                <div class="row">
                    <div class="s-img">
                        <img src="img/s1.jpg">
                    </div>
                    <h3>Business Transfer</h3>
                    <p>We successfully cope with task of varying complexity,long-term guarantees and regularly master. Provide trusted Cab Service in the World</p>
                </div>
                
                <div class="row">
                    <div class="s-img">
                        <img src="img/s2.jpg">
                    </div>
                    <h3>Online Booking</h3>
                    <p>We successfully cope with task of varying complexity, provide long-term guarantees and regularly master.We provide trusted Cab Service in the World</p>
                </div>
                
                <div class="row">
                    <div class="s-img">
                        <img src="img/s3.jpg">
                    </div>
                    <h3>City Transport</h3>
                    <p>We successfully cope with task of varying complexity, provide long-term guarantees and regularly master.We provide trusted Cab Service in the World</p>
                </div> 
            </div>
        </section>
        <%@include file="component/footer.jsp" %>
</html
