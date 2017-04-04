<#import "template/main.ftl" as temp>
<@temp.body title="${post.title}">
<div class="container">
    <div class="page-header">
        <h1>${post.title}</h1>
        <div class="pull-left">
            <p>author : ${post.authorName}</p>
            <div>
                <small>create at  ${post.createDate?string('yyyy-MM-dd hh:mm:ss')}, latest modified
                    at  ${post.modifiedDate?string('yyyy-MM-dd hh:mm:ss')}</small>
            </div>
            <div>
                <#if (post.topics?? && post.topics?size > 0)>
                    <#list post.topics as topic>
                        <label class="label label-primary">${topic}</label>
                    </#list>
                </#if>
            </div>
        </div>
        <div class="pull-right"><a class="btn btn-primary" href="/index/article">Back</a></div>
        <div class="clearfix"></div>
    </div>
    <section id="post_body"></section>
    <hr>
    <div class="page-header">
        <h3>Recent Comments</h3>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div id="comment_area">
            </div>
        </div>
        <div class="col-md-4">
            <form method="post" action="/index/article/${post.id}/comment" id="comment-form">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Create commit
                    </div>
                    <div class="panel-body">
                    <#--<div class="alert alert-info">Reply to : ...</div>-->
                        <textarea class="form-control" data-role="f-commit-content"></textarea>
                    </div>
                    <div class="panel-footer">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        var converter = new showdown.Converter();
        $("#post_body").html(converter.makeHtml($("#origin_post").text()));

        var commentList = $("#comment_area");

        $(commentList).load("/index/article/${post.id}/comments", function (content, status, xhr) {

        });
    });
</script>
<script id="origin_post" type="text/html">
${post.postContent.content}
</script>