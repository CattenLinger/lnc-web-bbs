<#import "template/main.ftl" as temp>
<@temp.body title="用户">
<div class="row">
    <div class="col-md-8">
        <div id="user_list_wrapper"></div>
        <div class="text-center">
            <ul id="recent_post_pager" class="pagination pagination-sm"></ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <b>快捷方式</b>
            </div>
            <@temp.managerPageShortcuts/>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        loadListPage($("#user_list_wrapper"),0,$("#recent_post_pager"),"/index/manage/user_list.html?page=");
    });
</script>