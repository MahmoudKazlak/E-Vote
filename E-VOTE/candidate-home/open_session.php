<?php
error_reporting(0);
ob_start();
session_start();
if(file_exists('../config.php'))include '../config.php';
else if(file_exists('../../config.php'))include '../../config.php';




if((!isset($_SESSION['user_name']) || !isset($_SESSION['user_password']) || !isset($_SESSION['candidate_id']))&&$_SESSION['user_level_id']=2)
{
	if(file_exists('../index.php'))echo"<script> window.top.location.href = '../index.php';</script>";
	else if(file_exists('../../index.php')) echo"<script> window.top.location.href = '../../index.php';</script>";
	exit;
}

if($_GET['action']=="logout")
{
  session_unset();
  session_destroy();
  echo "<script> window.top.location.href = '../index.php';</script>";
}

ob_end_flush();
?>
