<#global webroot=""/>
<#global pkey_head_pic = "headPic",
pkey_secret="secret",
pkey_nickname="nickname"/>
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

<#macro cutString text length suffix>
    <#if (text?length > length)>
    ${text?html?replace("\n"," ")?substring(0,length - 1)}${suffix!""}
    <#else >
    ${text?html?replace("\n"," ")}
    </#if>
</#macro>

<#macro defaultPager total current length path>
<div class="container-fluid">
    <nav style="text-align: center">
        <ul class="pagination">
        <#-- Left side -->
            <#if current == 0>
                <li class="disabled"><a href="#">&laquo;</a></li>
                <li class="disabled"><a href="#">&lsaquo;</a></li>
            <#else>
                <li><a href="${path + 0}">&laquo;</a></li>
                <li><a href="${path + (current - 1)}">&lsaquo;</a></li>
            </#if>

        <#-- Middle page list -->
            <#if (total <= length)>
                <@listPagerMiddle
                start=0
                end=(total - 1)
                current=current path=path/>

            <#elseif (total > length)>
                <#if (current <= (length / 2)?floor)>
                    <@listPagerMiddle
                    start=0
                    end=(length - 1)
                    current=current path=path/>

                <#elseif ((current > (length / 2)?floor) && (current < (total - length / 2)?floor)) >
                    <@listPagerMiddle
                    start=current + 1 - (length / 2)?ceiling
                    end=current + (length / 2)?floor
                    current=current path=path/>

                <#elseif (current + (length / 2)?floor >= total - 1)>
                    <@listPagerMiddle
                    start=(total-length)
                    end=(total - 1)
                    current=current path=path/>
                </#if>
            </#if>

        <#-- Right side -->
            <#if current == (total - 1)>
                <li class="disabled"><a href="#">&rsaquo;</a></li>
                <li class="disabled"><a href="#">&raquo;</a></li>
            <#else >
                <li><a href="${path + (current + 1)}">&rsaquo;</a></li>
                <li><a href="${path + (total - 1)}">&raquo;</a></li>
            </#if>
        </ul>
    </nav>
</div>
</#macro>

<#macro listPagerMiddle start end current path>
    <#list start..end as i>
    <li ${(i == current)?string('class="active"','')}><a href=${path + i}>${i + 1}</a></li>
    </#list>
</#macro>

<#macro _import_css>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<!--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">-->
<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/animate.css/3.5.2/animate.css">
<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/bootstrap-markdown/2.10.0/css/bootstrap-markdown.min.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.min.css"/>
<link href="//cdn.bootcss.com/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.css" rel="stylesheet">
<#--<link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/bootstrap-material-design/4.0.2/bootstrap-material-design.css">-->
<link rel="stylesheet" type="text/css" href="/css/bbs-main.css"/>
<style>
    body {
        margin-top: 30px;
    }
</style>
<#--<link rel="stylesheet" type="text/css" href="css/main.css">-->
</#macro>

<#macro _import_js>
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdn.bootcss.com/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<script src="//cdn.bootcss.com/1000hz-bootstrap-validator/0.11.9/validator.js"></script>
<script src="//cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.js"></script>
<script src="//cdn.bootcss.com/bootstrap-markdown/2.10.0/js/bootstrap-markdown.js"></script>
<script src="//cdn.bootcss.com/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>
<script src="//cdn.bootcss.com/showdown/1.6.4/showdown.min.js"></script>
<script src="/js/bbs-main.js"></script>
</#macro>