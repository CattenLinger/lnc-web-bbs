<#import "template/main.ftl" as temp>
<@temp.body title="话题">
<div class="row">
    <div class="col-md-8">
        <#if current_topic??>
            <div id="post_list" style="padding: 0; margin: 0"></div>
            <div class="text-center">
                <ul id="post_pager" class="pagination pagination-sm"></ul>
            </div>
        <#else >
            <h3>
                <#if (topics ?? && topics?size > 0)>
                    <#list topics as topic>
                        <a href="/index/articles/topics/${topic}" style="display: inline-block" class="label label-primary">
                        ${topic}
                        </a>
                    </#list>
                <#else >
                    <label>无话题</label>
                </#if>
            </h3>
        </#if>
    </div>
    <div class="col-sm-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <@temp.userCard/>
            </div>
            <@temp.shortcutItems/>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        $("#m_user_card").userCard();
        <#if current_topic??>
            loadListPage($("#post_list"), 0, $("#post_pager"), "/index/articles/topics/${current_topic}/list.html?page=",function (listNode) {
                rendPostList(listNode);
            });
        </#if>
    });
</script>