<!DOCTYPE html>
<html>
<style>
body, html {
  height: 100%;
  margin: 0;
}

.bgimg {
  background-image: url('assets/images/welcome.jpg');
  height: 100%;
  opacity:0.4;
  background-position: center;
  background-size: cover;
  position: relative;
  color: #999;
  font-family: "Courier New", Courier, monospace;
  font-size: 25px;
}

.topleft {
  position: absolute;
  top: 0;
  left: 16px;
}

.bottomleft {
  position: absolute;
  bottom: 0;
  left: 16px;
}

.middle {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}

hr {
  margin: auto;
  width: 40%;
}
</style>
<body>

<div class="bgimg">
  <div class="topleft">
    <p></p>
  </div>
  <!--div class="middle">
    <h1>اهلا وسهلا بكم</h1>
    <br>
    <h3>لوحة الادارة</h3>
  </div-->
  <div class="bottomleft">
    <p></p>
  </div>
</div>

</body>
</html>

