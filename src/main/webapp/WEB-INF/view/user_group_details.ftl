<#import "template/main.ftl" as temp>
<@temp.body title="Group Details">
<div class="row">
    <div class="col-md-3">
        <div class="panel panel-info">
            <div class="panel-heading">
                <b>Group information</b>
            </div>
            <div class="panel-body">
                <h4>${group.name}</h4>
                <label>Description : </label>
                <p>${group.description!"No descriptions..."}</p>
            </div>
            <div class="panel-footer">
                <div class="btn-group pull-right">
                    <button class="btn btn-default"><span class="glyphicon glyphicon-pencil"></span> </button>
                    <button class="btn btn-default"><span class="glyphicon glyphicon-trash"></span> </button>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="col-md-5">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <div class="pull-left"><b>Permissions</b></div>
                <div class="pull-right">
                    <button class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus"></span> Add new rule</button>
                </div>
                <div class="clearfix"></div>
            </div>
            <ul class="list-group">
                <#if (group.permissions?? && group.permissions?size > 0)>
                    <#list group.permissions as permission>
                        <li class="list-group-item">
                            <b>${permission.url}</b>
                            <ul>
                                <li>Description : ${permission.description!"No descriptions..."}</li>
                                <li>Method Pattern : ${permission.methodPatterns!"No allowed methods..."}</li>
                                <li>Policy : ${permission.policyPatterns!"No policy limits."}</li>
                            </ul>
                            <div>
                                <div class="btn pull-right">
                                    <button class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span> </button>
                                    <button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span> </button>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </li>
                    </#list>
                <#else >
                    <li class="list-group-item disabled">No permission available.</li>
                </#if>
            </ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <b>Shortcuts</b>
            </div>
            <@temp.managerPageShortcuts/>
        </div>
    </div>
</div>
</@temp.body>