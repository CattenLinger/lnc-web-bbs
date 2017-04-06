<#import "template/main.ftl" as temp>
<div class="list-group" data-role="pager_list" data-page="${page.number + 1}" data-page-total="${page.totalPages}">
<#if (page.content ?? && page.content?size > 0)>
    <#list page.content as group>
        <a href="/index/manage/groups/${group.id}" class="list-group-item">
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