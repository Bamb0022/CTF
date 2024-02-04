<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>ezsql</title>
</head>

<body bgcolor="#FFFFFF">
<div style=" margin-top:20px;color:#000000; font-size:24px; text-align:center"> 点击查询Flag&nbsp;&nbsp;<font color="#FF0000"> Hacker </font><br></div>

<div  align="center" style="margin:10px 0px 0px 520px;border:20px; background-color:#FFA488; text-align:center; width:400px; height:150px;">

<div style="padding-top:10px; font-size:15px;">


<form action="" name="form1" method="post">
	<div style="margin-top:15px; height:30px;">Username : &nbsp;&nbsp;&nbsp;
	    <input type="text"  name="uname" value=""/>
	</div>  
	<div> Flag  : &nbsp;&nbsp;&nbsp;
		<input type="text" name="passwd" value=""/>
	</div></br>
	<div style=" margin-top:9px;margin-left:90px;">
		<input type="submit" name="submit" value="Submit" />
	</div>
</form>

</div></div>

<div style=" margin-top:-55px;color:#FFF; font-size:23px; text-align:center">
<font size="6" color="#FFFF00">





<?php

//including the Mysql connect parameters.
include("sql-connect.php");
error_reporting(0);
if(!isset($_POST['uname']) && !isset($_POST['passwd']))
{
	echo "<br>";
	echo "<br>";
	echo '<img src="images/injection.jpg" />';
	echo "</font>";
}
// take the variables
if(isset($_POST['uname']) && isset($_POST['passwd']))
{
	$uname=$_POST['uname'];
	$passwd=$_POST['passwd'];
	$uname = preg_replace("/\*|;|union|select|ascii|mid|ord|substr|like|substring|if|file|extractvalue|updatexml|floor|or|and|#|=|%23|-|<|>|\^|\|\|/i", '', $uname);
	$passwd = preg_replace("/\*|;|union|select|ascii|mid|ord|substr|like|substring|if|file|extractvalue|updatexml|floor|or|and|#|=|%23|-|<|>|\^|\|\|/i", '', $passwd);
	echo "<br>";
	echo '<font color= "#000000" font size = 4>';
	echo 'your Username:';
	echo $uname;
	echo "<br>";
	echo 'your Flag:';
	echo $passwd;
	
	// connectivity 
	$sql="SELECT username, trueflag FROM fflllaaaagggg WHERE username='$uname' and trueflag='$passwd' LIMIT 0,1";
	
	$result=mysqli_query($con, $sql);
	$row = mysqli_fetch_array($result);

	if($row)
	{
  		//echo '<font color= "#0000ff">';
  		
  		echo "<br>";
		echo '<font color= "#FFFF00" font size = 4>';
		//echo " You Have successfully logged in\n\n " ;
		echo '<font size="3" color="#0000ff">';	
		echo "<br>";
		echo 'Your Login name:'. $row['username'];
		echo "<br>";
		echo 'Your Password:' .$row['password'];
		echo "<br>";
		echo "</font>";
		echo "<br>";
		echo '<img src="images/success.jpg"  />';	
		
  		echo "</font>";
  	}
	else  
	{
		echo '<font color= "#0000ff" font size="3">';
		//echo "Try again looser";
		echo "</br>";
		echo "</br>";
		echo "</br>";
		print_r(mysqli_error($con));
		echo "</br>";
		echo "</br>";
		echo '<img src="images/hack.jpg" />';	
		echo "</font>";  
	}
}

?>



</font>
</div>
</body>
</html>
