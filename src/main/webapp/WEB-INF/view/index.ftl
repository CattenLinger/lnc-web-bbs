<#import "template/main.ftl" as temp>
<@temp.body title="首页">
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
                <div class="alert alert-success">登录成功</div>
            <#elseif message == "logout">
                <div class="alert alert-success">登出成功</div>
            </#if>
        </#if>
        <div class="panel panel-default">
            <div class="panel-heading">
                <@temp.userCard/>
            </div>
            <@temp.shortcutItems/>
        </div>
        <@temp.indexManagerShortcutPanel />
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        var recentPostList = $("#recent_post_list");
        var recentPostPager = $("#recent_post_pager");

        $("#m_user_card").userCard();
        loadListPage(recentPostList, 0, recentPostPager, "/index/articles.html?page=",function (listNode) {
            rendPostList(listNode);
        });
    });
</script>