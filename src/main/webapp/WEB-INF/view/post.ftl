<#import "template/main.ftl" as temp>
<@temp.body title="${post.title}">
<div class="container">
    <div class="page-header">
        <h1>${post.title}</h1>
        <div class="pull-left">
            <p>author : ${post.authorName}</p>
            <p>
                <small>create at  ${post.createDate?string('yyyy-MM-dd hh:mm:ss')}, latest modified at  ${post.modifiedDate?string('yyyy-MM-dd hh:mm:ss')}</small>
            </p>
            <p>
                <#if (post.topics?? && post.topics?size > 0)>
                    <#list post.topics as topic>
                        <label class="label label-primary">${topic}</label>
                    </#list>
                </#if>
            </p>
        </div>
        <div class="pull-right"><a class="btn btn-primary" href="/index/article">Back</a></div>
        <div class="clearfix"></div>
    </div>
    <section id="post_body"></section>
    <hr>
    <div id="comment_area">

    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        var converter = new showdown.Converter();
        $("#post_body").html(converter.makeHtml($("#origin_post").text()));
    });
</script>
<script id="origin_post" type="text/html">
${post.postContent.content}
</script>