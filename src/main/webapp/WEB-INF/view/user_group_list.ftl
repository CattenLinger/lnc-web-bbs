<#import "template/main.ftl" as temp>
<@temp.body title="User Groups">
    <@temp.warpper8>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3>User groups</h3>
        </div>
        <div class="list-group">
            <#if (page.content ?? && page.content?size > 0)>
                <#list page.content as group>
                    <a href="/index/manage/groups/${group.name}" class="list-group-item">
                        <div>
                            <b>${group.name}</b>
                            <p><#if group.description??>${group.description}<#else >No descriptions...</#if></p>
                        </div>
                    </a>
                </#list>
            <#else >
                <a class="list-group-item disabled">No data...</a>
            </#if>
        </div>
    </div>
    </@temp.warpper8>
</@temp.body>