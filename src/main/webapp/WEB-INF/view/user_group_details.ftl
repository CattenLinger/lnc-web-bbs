<#import "template/main.ftl" as temp>
<@temp.body title="Group Details">
    <@temp.warpper8>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3>Group ${group.name}</h3>
        </div>
        <div class="panel-body">
            <label>Description : </label>
            <p>${group.description!"No descriptions..."}</p>
        </div>
        <ul class="list-group">
            <#if (group.permissions?? && group.permissions?size > 0)>
            <#list group.permissions as permission>
                <li class="list-group-item">
                    <b>${permission.url}</b>
                    <div>Description : ${permission.description!"No descriptions..."}</div>
                    <div>Method Pattern : ${permission.methodPatterns!"No allowed methods..."}</div>
                    <div>Policy : ${permission.policyPatterns!"No policy limits."}</div>
                </li>
            </#list>
            <#else >
                <li class="list-group-item disabled">No permission available.</li>
            </#if>
        </ul>
        <div class="panel-footer">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2" style="margin-top: 10px">
                    <a class="btn btn-primary btn-block" href="/index/manage/groups">Back</a>
                </div>
            </div>
        </div>
    </div>
    </@temp.warpper8>
</@temp.body>