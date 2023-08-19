<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <title>Update Profile | ConcordiaEats</title>
<style>
li {
	margin-left: 12px;
}
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="index">
            <img th:src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Concordia-eats-logo.png"  src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Concordia-eats-logo.png" width="auto" height="80" class="d-inline-block align-top" alt=""/>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
		
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto"></ul>
            <ul class="navbar-nav" style="font-size: 22px; font-weioght: bold;">
                <li class="nav-item active">
                    <a class="nav-link" th:href="@{/}" href="/index"><b>Home</b></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" th:href="@{/shop}" href="/user/products"><b>Shop</b></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" th:href="@{/cart}" href="/basket"><span th:text="${cartCount}"><b>My Basket </b>0</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/profileDisplay" ><b>Profile</b></a>
                </li>
                <li class="nav-item active">
                    <button class="nav-link" style="background-color: #fff; border-radius: 32px; border: 0px; padding-left: 18px; padding-right: 18px; border: 1px solid #222222;">
                        <a style="color: #222222;" href="/contact">Contact Us</a>
                    </button>
                </li>
                <li class="nav-item active">
                    <button class="nav-link" style="background-color: #912338; border-radius: 32px; border: 0px; padding-left: 18px; padding-right: 18px;">
                        <a style="color: #fff;" sec:authorize="isAuthenticated()" href="logout">Logout</a>
                    </button>
                </li>
            </ul>

        </div>
    </div>
</nav> 
<br>
<div class="container">
    <div class="col-sm-6">
        <h3 style="margin-top: 10px">Update your Profile Information</h3>
        <br>
        <form action="updateuser" method="post">
            <div class="form-group">
                <label for="firstName">User Name</label>
                <input type="hidden" name="userid" value="${userid }">
                <input type="text" name="username" id="firstName" required placeholder="Your Username*" value="${username }" required class="form-control form-control-lg">
            </div>
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" class="form-control form-control-lg" required minlength="6" placeholder="Email*" value="${email }" required name="email" id="email"
                       aria-describedby="emailHelp">
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with
                    anyone else.</small>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control form-control-lg" required placeholder="Password*" value="${password }" required name="password"
                       id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*?[~`!@#$%\^&*()\-_=+[\]{};:\x27.,\x22\\|/?><]).{8,}" 
                       title="Must contain: at least one number, one uppercase letter, one lowercase letter, 
                       one special character, and 8 or more characters" required>
                       <input type="checkbox" onclick="showPassword()">Show Password
            </div>
            <div class="form-group">
                <label for="Address">Address</label>
                <textarea class="form-control form-control-lg" rows="3" placeholder="Enter Your Address" name="address">${address }</textarea>
            </div>

            <input type="submit" value="Update Profile" class="btn btn-primary btn-block"><br>
            
        </form>
    </div>
</div>

<script>
    function showPassword() {
  var x = document.getElementById("password");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
</script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
