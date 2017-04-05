<#import "template/main.ftl" as temp>
<@temp.body title="LNCSA - BBS">
<div class="row">
    <div class="col-sm-8">
        <div id="recent_post_list" style="padding: 0; margin: 0"></div>
        <div class="text-center">
            <ul id="recent_post_pager" class="pagination pagination-sm"></ul>
        </div>
    </div>
    <div class="col-sm-4">
        <#if message?? >
            <#if message == "register">
                <div class="alert alert-success">Sign up success</div>
            <#elseif message == "logout">
                <div class="alert alert-success">Logout success</div>
            </#if>
        </#if>
        <div class="panel panel-default">
            <div class="panel-heading">
                <#if Session.session_user??>
                    <div class="media" id="m_user_card" data-user-id="${Session.session_user.id}">
                        <div class="media-left">
                            <img data-role="m_user_head_pic" width="48" height="48" src="${def_head_pic}">
                        </div>
                        <div class="media-body">
                            <div><b data-role="m_user_nickname">...</b><br>
                                <small data-role="m_username">...</small>
                            </div>
                            <div>User group : <label class="label label-info" data-role="m_user_group">...</label></div>
                        </div>
                    </div>
                <#else >
                    Welcome, guest
                </#if>
            </div>
            <div class="list-group">
                <#if Session.session_user??>
                    <a class="list-group-item" href="/index/self">Self info</a>
                    <a class="list-group-item" href="/index/article/post">Post article</a>

                <#else >
                    <a class="list-group-item" href="/index/login">Sign in</a>
                    <a class="list-group-item" href="/index/register">Sign up</a>
                </#if>
                <a class="list-group-item" href="/index/article">Articles</a>
            </div>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        var recentPostList = $("#recent_post_list");
        var recentPostPager = $("#recent_post_pager");

        loadPostList(recentPostList, 0, recentPostPager);

        var userInfoCard = $("#m_user_card");
        var userId = $(userInfoCard).data("user-id");
        if (userId != undefined && userId != null) {
            $.get("/user/id/" + userId, function (content, status, xhr) {
                if (status == "success") {
                    var userModel = content;
                    $(userInfoCard).find("[data-role]").each(function (i, obj) {
                        switch ($(obj).data("role")) {
                            case "m_user_nickname":
                                $.ajax("/user/" + userId + "/nickname", {
                                    type: "GET",
                                    complete: function (xhr, status) {
                                        switch (status) {
                                            case "success":
                                                $(obj).text(JSON.parse(xhr.responseText).data);
                                                break;
                                            default:
                                                $(obj).text(userModel.data.username);
                                                break;
                                        }
                                    }
                                });
                                break;
                            case "m_username":
                                $(obj).text("@" + userModel.data.username);
                                break;
                            case "m_user_head_pic":
                                $.ajax("/user/" + userModel.data.id + "/head_pic", {
                                    type: "GET",
                                    complete: function (xhr, status) {
                                        switch (status) {
                                            case "success":
                                                $(obj).attr("src", JSON.parse(xhr.responseText).data);
                                                break;
                                            default :
                                                break;
                                        }
                                    }
                                });
                                break;
                            case "m_user_group":
                                $(obj).text(userModel.data.groupName == null ? "null" : userModel.data.groupName);
                                break;
                        }
                    });
                }
            });
        }
    });

    function loadPostList(listNode, page, pager, complete) {
        $(pager).addClass("disabled");
        $(listNode).html('<div class="summary-thumbnail spin"></div>');
        $(listNode).load("/index/articles.html?page=" + page, function (content, status, xhr) {
            if (status == "success") {
                rendPostList(listNode);
                updatePager(listNode,pager);
            }
        });
    }

    function updatePager(listNode,pager) {
        var $pageNode = $($(listNode).find("[data-role='article_list']").first());
        var currentPage = $pageNode.data("page");
        console.debug(currentPage);
        $(pager).twbsPagination('destroy');
        $(pager).twbsPagination({
            totalPages: $pageNode.data("page-total"),
            visiblePages: 10,
            startPage: currentPage,
            hideOnlyOnePage: true
        }).on("page",function (event, page) {
            loadPostList(listNode,page - 1,pager);
        });
        $(pager).removeClass("disabled");
    }

    function rendPostList(recentPostList) {
        $(recentPostList).find("[data-author]").each(function (i, obj) {
            var authorId = $(obj).data("author");
            var picNode = $(obj).find("[data-role='author_head_pic']");
            $.get("/user/" + authorId + "/head_pic", function (content, status, xhr) {
                switch (status) {
                    case "success":
                        $(picNode).attr("src", content.data);
                        break;
                    case "error":
                        $(picNode).attr("src", "${def_head_pic}");
                        break;
                }
            });
        });
    }
</script>