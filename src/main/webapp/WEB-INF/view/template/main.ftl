<#global webroot=""/>
<#macro body title>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title}</title>
    <@_import_css></@_import_css>
</head>

<body>
<#nested >
<@_import_js></@_import_js>
</body>
</html>
</#macro>

<#macro _import_css>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<!--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->
<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/animate.css/3.5.2/animate.css">
<link rel="stylesheet" type="text/css" href="/css/bbs-main.css"/>
<#--<link rel="stylesheet" type="text/css" href="css/main.css">-->
</#macro>

<#macro _import_js>
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdn.bootcss.com/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="//cdn.bootcss.com/1000hz-bootstrap-validator/0.11.9/validator.js"></script>
<script src="/js/bbs-main.js"></script>
</#macro>