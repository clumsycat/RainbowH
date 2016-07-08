<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>
</head>
<body>
<script>
function  pseth() {
    var iObj = parent.parent.document.getElementById('impala-frame');//A和main同域，所以可以访问节点
    iObjH = parent.parent.frames["impala-frame"].frames["blank-frame"].location.hash;//访问自己的location对象获取hash值
    iObj.style.height = iObjH.split("#")[1]+"px";//操作dom
}
pseth();
</script>
</body>
</html>

