<#import "template/main.ftl" as temp>
<@temp.body title="${post.title}">
<div class="container">
    <div class="page-header">
        <h1>${post.title}</h1>
        <div class="pull-left">
            <p>author : ${post.authorName}</p>
            <div>
                <small>创建于  ${post.createDate?string('yyyy-MM-dd hh:mm:ss')}, 最后修改日期 ${post.modifiedDate?string('yyyy-MM-dd hh:mm:ss')}</small>
            </div>
            <div><@temp.listPostTagsWithLink post = post/></div>
        </div>
        <div class="pull-right">
            <a class="btn btn-primary" href="/index">返回</a>
            <#if Session.session_user??>
                <#if Session.session_user.id == post.postContent.author.id >
                    <a class="btn btn-primary" href="/index/article/${post.id}/edit">编辑</a>
                    <a class="btn btn-danger" href="/index/article/${post.id}/delete">删除</a>
                </#if>
            </#if>
        </div>
        <div class="clearfix"></div>
    </div>
    <section id="post_body"></section>
    <hr>
    <div class="page-header">
        <h3>最近的评论</h3>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div id="comment_area">
            </div>
        </div>
        <div class="col-md-4">
            <form data-toggle="validator" id="comment_form">
                <div class="alert alert-warning hidden" id="fc_alert"></div>
                <div class="panel panel-primary">
                    <div class="panel-heading">创建评论</div>
                    <div class="panel-body" align="center"
                         style="display: ${(!Session.session_user??)?string("block","none")}">
                        <div class="page-header">
                            <h3>需要登录才能发表评论</h3>
                        </div>
                        <a href="/index/login" class="btn btn-primary">登录页面</a>
                    </div>
                    <div style="display: ${(Session.session_user??)?string("block","none")}">
                        <input type="hidden" id="fc_relateTo">
                        <textarea class="form-control" id="fc_content" name="data[content]"
                                  data-toggle="validator" required></textarea>
                        <div class="panel-footer">
                            <input id="fc_submit_btn" type="submit" class="btn btn-primary" value="评论">
                            <button id="fc_clear_relate" type="button" class="btn btn-warning hidden">取消回复</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        $.ajaxSetup({contentType:"application/json"});

        var converter = new showdown.Converter({
            tables:true
        });
        if (window.markdownRender == undefined || window.markdownRender == null) window.markdownRender = converter;
        $("#post_body").html(converter.makeHtml($("#origin_post").text()));

        var formView = {
            list : $("#comment_area"),
            form : $("#comment_form"),
            input : $("#fc_content"),
            relateTo : $("#fc_relateTo"),
            btnRelateTo : $("#fc_clear_relate"),
            btnSubmit : $("#fc_submit_btn"),
            alert : $("#fc_alert")
        };

        loadComments(formView,0);

        window.markdownArea = "";
        $(formView.input).markdown({
            height: 300,
            hiddenButtons: ["Bold", "Italic", "Heading"],
            onPreview: function (e) {
                if (e.isDirty()) window.markdownArea = window.markdownRender.makeHtml(e.getContent());
                return window.markdownArea;
            }
        });

        $(formView.btnRelateTo).click(function () {
            $(formView.relateTo).removeAttr("name");
            $(formView.btnRelateTo).addClass("hidden");
        });

        $(formView.form).validator().on("submit",function (e) {
            if(!e.isDefaultPrevented()){
                $(formView.btnSubmit).addClass("disabled");
//                console.debug($(formView.form).serializeJSON());
                $.post(
                        "/article/${post.id}/comments.html",
                        $(formView.form).serializeJSON(),
                        function (content, status, xhr) {
                            switch (status){
                                case "success":
//                                    console.debug(content);
                                    loadComments(formView,0);
                                    $(formView.alert).addClass("hidden");
                                    break;
                                default:
//                                    console.debug(xhr.status);
                                    $(formView.alert).text("你没有评论的权限。");
                                    $(formView.alert).removeClass("hidden");
                                    break;
                            }

                            $(formView.btnSubmit).removeClass("disabled");
                            $(formView.input).val("");
                        }
                );
                $(formView.btnRelateTo).trigger("click");
            }
        });
    });

    function loadComments(formView,page) {
        $(formView.list).load("/index/article/${post.id}/comments.html?page=" + page, function (content, status, xhr) {
            switch (status) {
                case "success":
                    $(formView.list).find("[data-comment-id]").each(function (i, obj) {
                        var commentId = $(obj).data("comment-id");
                        $(obj).find("[data-role]").each(function (i, obj) {
                            switch ($(obj).data("role")){
                                case "markdown-content":
                                    var objContent = $(obj).text();
                                    $(obj).html(markdownRender.makeHtml(objContent));
                                    break;

                                case "c_reply":
                                    $(obj).click(function () {
                                        $(formView.relateTo).attr("name","data[relateTo]");
                                        $(formView.relateTo).val(commentId);
                                        $(formView.btnRelateTo).removeClass("hidden");
                                    });
                                    break;

                                case "c_delete":
                                    $(obj).click(function () {
                                        $(obj).addClass("disabled");
                                        $.ajax("/article/comments/" + commentId, {
                                            type : "DELETE",
                                            complete : function () {
                                                loadComments(formView,0);
                                            }
                                        })
                                    });
                                    break;
                            }
                        });
                    });
                    break;
            }
        });
    }
</script>
<script id="origin_post" type="text/html">
${post.postContent.content}
</script>