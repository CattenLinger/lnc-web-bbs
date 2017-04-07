<#import "template/main.ftl" as temp>
<@temp.body title="用户组信息">
<div class="row">
    <div class="col-md-3">
        <div class="panel panel-info">
            <div class="panel-heading">
                <b>用户组基本信息</b>
            </div>
            <div class="panel-body">
                <h4>${group.name}</h4>
                <label>描述 : </label>
                <p>${group.description!"没有描述"}</p>
            </div>
            <div class="panel-footer">
                <div class="btn-group pull-right">
                    <button class="btn btn-default" id="btn_group_alter" data-toggle="modal" data-target="#m_alter_group"><span class="glyphicon glyphicon-pencil"></span> </button>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="col-md-5">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <div class="pull-left"><b>权限</b></div>
                <div class="pull-right">
                    <button class="btn btn-success btn-xs" id="btn_add_permission"><span class="glyphicon glyphicon-plus"></span> 添加权限</button>
                </div>
                <div class="clearfix"></div>
            </div>
            <ul class="list-group" id="list_permissions">
                <#if (group.permissions?? && group.permissions?size > 0)>
                    <#list group.permissions as permission>
                        <li class="list-group-item" data-id="${permission.id}">
                            <b>${permission.url}</b>
                            <ul>
                                <li>描述 : ${permission.description!"没有描述"}</li>
                                <li>允许的请求方法 : ${permission.methodPatterns!"没有任何方法权限"}</li>
                                <li>策略（暂时没用） : ${permission.policyPatterns!"无策略限制"}</li>
                            </ul>
                            <div>
                                <div class="btn pull-right">
                                    <button class="btn btn-default btn-sm" data-role="btn-edit"><span class="glyphicon glyphicon-pencil"></span> </button>
                                    <a class="btn btn-danger btn-sm" href="/index/manage/group/${group.id}/permission/delete/${permission.id}" data-role="btn-delete"><span class="glyphicon glyphicon-trash"></span> </a>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </li>
                    </#list>
                <#else >
                    <li class="list-group-item disabled">无任何权限</li>
                </#if>
            </ul>
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
<!-- Group alter Modal -->
<div class="modal fade" id="m_alter_group" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">创建用户组</h4>
            </div>
            <form id="f_create_group" data-toggle="validator" method="post" action="/index/manage/groups/${group.id}">
                <div class="modal-body">
                    <input type="hidden" name="id" value="${group.id}">
                    <div class="form-group">
                        <label for="gf_name" class="control-label">用户组名称</label>
                        <input id="gf_name" name="name" value="${group.name}" type="text" maxlength="20" required class="form-control" pattern="[A-Za-z0-9_-]{3,20}">
                    </div>
                    <div class="form-group">
                        <label for="gf_description">描述</label>
                        <textarea id="gf_description" name="description" class="form-control" rows="5" style="resize: none">${group.description!""}</textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">创建</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Permission role add model -->
<div class="modal fade" id="m_alter_permission" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加或者更改权限</h4>
                </div>
                <form data-toggle="validator" method="post" id="f_alter_permit" action="/index/manage/groups/${group.id}/permissions">
                    <div class="modal-body">
                        <input type="hidden" name="id">
                        <div class="form-group">
                            <label for="pf_url">路径匹配（正则表达式）</label>
                            <input id="pf_url" type="text" class="form-control" name="url" max="255" required>
                        </div>
                        <div class="form-group">
                            <label for="pf_description">描述</label>
                            <input id="pf_description" type="text" class="form-control" name="description" max="255">
                        </div>
                        <div class="form-group">
                            <label for="pf_method_pattern">允许的请求方法</label>
                            <input id="pf_method_pattern" name="methodPatterns" max="255" required class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="pf_policy">策略（暂时没用）</label>
                            <input id="pf_policy" name="policyPatterns" max="255" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        var $alterPermitModal = $("#m_alter_permission");
        var $alterPermitForm = $("#f_alter_permit");
        $alterPermitModal.on("hide.bs.modal",function () {
            $alterPermitForm.find(".form-control").each(function (i, obj) {
                $(obj).val("");
            });
        });

        $("#btn_add_permission").click(function () {
            $alterPermitModal.modal('toggle');
        });

        $("#list_permissions").find("[data-id]").each(function (i, obj) {
            var permitId = $(obj).data("id");
            $(obj).find("[data-role]").each(function (i, obj) {
                switch ($(obj).data("role")){
                    case "btn-edit":
                        $(obj).click(function () {
                            $.get("/index/manage/permission/" + permitId, function (content, status, xhr) {
                                switch (status){
                                    case "success":
                                        $alterPermitForm.find("[name]").each(function (i, obj) {
                                            switch ($(obj).attr("name")){
                                                case "url":
                                                    $(obj).val(content.data.url);
                                                    break;
                                                case "description":
                                                    $(obj).val(content.data.description);
                                                    break;
                                                case "methodPatterns":
                                                    $(obj).val(content.data.methodPatterns);
                                                    break;
                                                case "policyPatterns":
                                                    $(obj).val(content.data.policyPatterns);
                                                    break;
                                                case "id":
                                                    $(obj).val(content.data.id);
                                                    break;
                                                default:
                                                    break;
                                            }
                                        });
                                        $alterPermitModal.modal('show');
                                        break;
                                    default :
                                        break;
                                }
                            })
                        });
                        break;
                    default:
                        break;
                }
            });
        });
    });
</script>