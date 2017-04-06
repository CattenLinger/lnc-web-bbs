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
            <div><@temp.listPostTags post = post/></div>
        </div>
        <div class="pull-right"><a class="btn btn-primary" href="/index">Back</a></div>
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
            <form data-toggle="validator" id="comment_form">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Create commit
                    </div>
                    <div class="panel-body" align="center"
                         style="display: ${(!Session.session_user??)?string("block","none")}">
                        <div class="page-header">
                            <h3>You haven't login yet...</h3>
                        </div>
                        <a href="/index/login" class="btn btn-primary">Go login</a>
                    </div>
                    <div style="display: ${(Session.session_user??)?string("block","none")}">
                        <input type="hidden" id="fc_relateTo">
                        <textarea class="form-control" id="fc_content" name="data[content]"
                                  data-toggle="validator" required></textarea>
                        <div class="panel-footer">
                            <input id="fc_submit_btn" type="submit" class="btn btn-primary" value="Submit">
                            <button id="fc_clear_relate" type="button" class="btn btn-warning hidden">Cancel reply</button>
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
            btnSubmit : $("#fc_submit_btn")
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
                console.debug($(formView.form).serializeJSON());
                $.post(
                        "/article/${post.id}/comments.html",
                        $(formView.form).serializeJSON(),
                        function (content, status, xhr) {
                            switch (status){
                                case "success":
                                    console.debug(content);
                                    loadComments(formView,0);
                                    break;
                                case "error":
                                    console.debug(xhr.status);
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