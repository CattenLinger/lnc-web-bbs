<#import "template/main.ftl" as temp>
<@temp.body title="Self">
    <@temp.warpper8>

        <#if message??>
            <#switch message>
                <#case "pSaved">
                <div class="alert alert-success">Profile saved</div>
                    <#break >
                <#case "pDeleted">
                <div class="alert alert-success">Profile Deleted</div>
                    <#break >
            </#switch>
        </#if>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>${user.username} - Profile</h2>
        </div>
        <div class="panel-body">
            <div class="media">
                <div class="media-left">
                    <#assign userHeadPic=def_head_pic>
                    <#if user.profile??>
                        <#if (user.profile?size > 0)>
                            <#list user.profile as profile>
                                <#if profile.key == "head_pic">
                                    <#assign userHeadPic=profile.value/>
                                </#if>
                            </#list>
                        </#if>
                    </#if>
                    <img width="128" height="128" src="${userHeadPic}">
                </div>
                <div class="media-body" align="center">
                    <table class="table">
                        <tr>
                            <td>Username</td>
                            <td>${user.username}</td>
                        </tr>
                        <tr>
                            <td>User Id</td>
                            <td>${user.id}</td>
                        </tr>
                        <tr>
                            <td>User Group</td>
                            <td><#if user.userGroup??>${user.userGroup.name}<#else>Null</#if></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <form method="post" action="/index/self/profile" data-toggle="validator">
            <table class="table" id="p_table">
                <thead>
                <tr>
                    <td align="center">Profile name</td>
                    <td align="center" width="50%">Value</td>
                    <td align="center">Operate</td>
                </tr>
                </thead>
                <#if (user.profile?? && user.profile?size > 0)>
                    <#list user.profile as profile>
                        <tr>
                            <td align="center">${profile.key}</td>
                            <td align="center">
                                <#if (profile.value?length > 30)>
                                ${profile.value?substring(0,30)}...
                                <#else >
                                ${profile.value}
                                </#if>
                            </td>
                            <td align="center">
                                <a class="btn btn-danger btn-block"
                                   href="/index/self/profile/delete?key=${profile.key}">
                                    <span class="glyphicon glyphicon-remove"> </span> Delete
                                </a>
                            </td>
                        </tr>
                    </#list>
                </#if>
                <tr>
                    <td>
                        <select id="p_tb_picker" name="key" required class="selectpicker">
                            <option value="head_pic">Head Pic</option>
                            <option value="gender">Gender</option>
                            <option value="phone">Phone</option>
                            <option value="email">Email</option>
                            <option value="qq">QQ</option>
                            <option value="birth">Birth</option>
                            <option value="nickname">Nickname</option>
                        </select>
                    </td>
                    <td><input id="p_tb_value" name="value" required type="text" class="form-control"></td>
                    <td align="center">
                        <button type="submit" class="btn btn-success btn-block" id="p_tb_add"><span
                                class="glyphicon glyphicon-plus"></span> Add
                        </button>
                    </td>
                </tr>
            </table>
        </form>
        <div class="panel-footer">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2" style="margin-top: 10px">
                    <a class="btn btn-primary btn-block" href="/">Back</a>
                    <a class="btn btn-warning btn-block" href="/index/logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
    </@temp.warpper8>
</@temp.body>
<script>
    $(document).ready(function () {
        var valTypePicker = $("#p_tb_picker");
        var valInput = $("#p_tb_value");
        var valBtnAdd = $("#p_tb_add");

        $(valTypePicker).selectpicker();

    });
</script>