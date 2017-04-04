<#import "template/main.ftl" as temp>
<@temp.body title="Users">
    <@temp.warpper8>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3>Users</h3>
        </div>
        <div class="list-group">
            <#if (page.content?? && page.content?size > 0)>
                <#list page.content as user>
                    <#assign headPic = def_head_pic/>
                    <#assign nickname = ""/>
                <#-- Read single comment profile -->
                    <#if user.profile??>
                        <#list user.profile as proItem>
                            <#switch proItem.key>
                                <#case pkey_head_pic>
                                    <#assign headPic = proItem.value/>
                                    <#break >
                                <#case pkey_nickname>
                                    <#assign nickname = proItem.value/>
                                    <#break >
                            </#switch>
                        </#list>
                    </#if>
                    <#if nickname == ""><#assign nickname=user.username/></#if>
                    <a class="list-group-item" href="/index/manage/user/${user.username}">
                        <div class="media">
                            <div class="media-left">
                                <img src="${headPic}" width="48" height="48">
                            </div>
                            <div class="media-body">
                                <div><b>${nickname}(@${user.username})</b></div>
                                <div>Group : <#if user.userGroup??>${user.userGroup.name}<#else>[null]</#if></div>
                            </div>
                        </div>
                    </a>
                </#list>
            <#else >
                <a class="list-group-item disabled">No data</a>
            </#if>
        </div>
    </div>
    </@temp.warpper8>
</@temp.body>