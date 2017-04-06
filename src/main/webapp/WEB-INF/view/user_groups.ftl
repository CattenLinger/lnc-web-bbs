<#import "template/main.ftl" as temp>
<@temp.body title="User Groups">
<div class="row">
    <div class="col-md-8">
        <div id="user_group_wrapper"></div>
        <div class="text-center">
            <ul id="user_group_pager" class="pagination pagination-sm"></ul>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <b>Shortcuts</b>
            </div>
            <@temp.managerPageShortcuts/>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <b>Operates</b>
            </div>
            <div class="list-group">
                <a class="list-group-item" href="#" id="btn_create_group"><span class="glyphicon glyphicon-plus"></span> Create new user group</a>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="m_create_group" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Create user group</h4>
            </div>
            <form id="f_create_group" data-toggle="validator">
                <div class="modal-body">
                    <div class="alert alert-danger hidden">Failed, maybe you have no permission.</div>
                    <div class="form-group">
                        <label for="gf_name" class="control-label">Group Name</label>
                        <input id="gf_name" name="data[name]" type="text" maxlength="20" required class="form-control" pattern="[A-Za-z0-9_-]{3,20}">
                    </div>
                    <div class="form-group">
                        <label for="gf_description">Description</label>
                        <textarea id="gf_description" name="data[description]" class="form-control" rows="5" style="resize: none"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create</button>
                </div>
            </form>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {

        loadListPage($("#user_group_wrapper"),0,$("#user_group_pager"),"/index/manage/group_list.html?page=");

        var $createModal = $("#m_create_group");
        var $createForm = $("#f_create_group");
        $("#btn_create_group").click(function () {
            $createModal.modal({
                backdrop : "static"
            });
        });

        $createModal.on("hide.bs.modal",function (e) {
            $createForm.find(".form-control").each(function (i, obj) {
                $(obj).val("");
            });
            $createForm.find(".alert").first().addClass("hidden");
        });

        $createForm.validator().on("submit",function (e) {
            if(!e.isDefaultPrevented()) {
                $.ajax("/manage/group", {
                    type: "PATCH",
                    data: $createForm.serializeJSON(),
                    contentType: "application/json"
                }).complete(function (xhr, status) {
                    switch (status) {
                        case "error":
                            $createForm.find(".alert").first().removeClass("hidden");
                            break;
                        case "success":
                            $createModal.modal('hide');
                            loadListPage($("#user_group_wrapper"),0,$("#user_group_pager"),"/index/manage/group_list.html?page=");
                            break;
                    }
                });
            }
        });
    });
</script>