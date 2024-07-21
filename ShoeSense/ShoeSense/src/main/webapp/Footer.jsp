<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Custom styles */
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 30px 0;
        }

        .footer-content {
            margin-bottom: 30px;
        }

        .footer-content h3 {
            font-size: 1.2rem;
            margin-bottom: 15px;
            color: #ffffff;
        }

        .footer-content p {
            font-size: 0.9rem;
            line-height: 1.6;
            color: #ffffff;
        }

        .footer-content ul {
            list-style-type: none;
            padding: 0;
        }

        .footer-content ul li a {
            color: #ffffff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .footer-content ul li a:hover {
            text-decoration: underline;
        }

        .social-icons {
            list-style-type: none;
            padding: 0;
        }

        .social-icons li {
            display: inline-block;
            margin-right: 10px;
        }

        .social-icons li a {
            color: #ffffff;
            font-size: 1.2rem;
        }

        .social-icons li a:hover {
            color: #007bff;
        }

        /* Responsive iframe */
        .map-container {
            position: relative;
            overflow: hidden;
            padding-top: 56.25%; /* 16:9 Aspect Ratio */
        }

        .map-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0;
        }
        
    </style>
</head>
<body>
<!--Footer-->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="footer-content">
                    <h3>Contact Us</h3>
                    <p>Email: ShoeSense@gmail.com</p>
                    <p>Phone: 0909808778</p>
                    <p>Address: 123DuongLeLoi,Quan1,TpHoChiMinh.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="footer-content">
                    <h3>Quick Links</h3>
                    <ul class="list">
                        <li><a href="/ShoeSense/">Home</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="/ShoeSense/">Products</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-3">
                <div class="footer-content">
                    <h3>Follow Us</h3>
                    <ul class="social-icons">
                        <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                        <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                        <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                        <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-3">
                <div class="footer-content">
                    <h3>Location</h3>
                    <div class="map-container">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15743722.79496086!2d95.23367880582101!3d15.555151669615718!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31157a4d736a1e5f%3A0xb03bb0c9e2fe62be!2zVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1720428710482!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
        integrity="sha384-pdkgJmtCEkqaS8tE7/QKpv5A+bfrbpvO3+GZwFpd9Q63V5UFS1Flp7YppIWaG0kA"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-SyXFXqKfBwKpWagTiuZG3zISe8dAqBZmfBG8s4SD9s6s2JBqoM0lF25a6JC7tlJA"
        crossorigin="anonymous"></script>
</body>
</html>
