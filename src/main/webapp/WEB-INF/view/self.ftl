<#import "template/main.ftl" as temp>
<@temp.body title="个人信息">
    <@temp.centerWarpper width=8>
        <#if message??>
            <#switch message>
                <#case "pSaved">
                <div class="alert alert-success">保存成功</div>
                    <#break >
                <#case "pDeleted">
                <div class="alert alert-success">删除成功</div>
                    <#break >
            </#switch>
        </#if>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>${user.username} - 个人信息</h2>
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
                            <td>用户名</td>
                            <td>${user.username}</td>
                        </tr>
                        <tr>
                            <td>用户 Id</td>
                            <td>${user.id}</td>
                        </tr>
                        <tr>
                            <td>用户组</td>
                            <td><#if user.userGroup??>${user.userGroup.name}<#else>无记录</#if></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <form method="post" action="/index/self/profile" data-toggle="validator">
            <table class="table" id="p_table">
                <thead>
                <tr>
                    <td align="center">个人信息项</td>
                    <td align="center" width="50%">值</td>
                    <td align="center">操作</td>
                </tr>
                </thead>
                <#if (user.profile?? && user.profile?size > 0)>
                    <#list user.profile as profile>
                        <tr>
                            <td align="center">${pkey_list[profile.key]!"${profile.key}"}</td>
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
                                    <span class="glyphicon glyphicon-remove"> </span> 删除
                                </a>
                            </td>
                        </tr>
                    </#list>
                </#if>
                <tr>
                    <td>
                        <select id="p_tb_picker" name="key" required class="selectpicker">
                            <option value="head_pic">头像</option>
                            <option value="gender">性别</option>
                            <option value="phone">电话号码</option>
                            <option value="email">邮箱</option>
                            <option value="qq">QQ</option>
                            <option value="birth">生日</option>
                            <option value="nickname">昵称</option>
                        </select>
                    </td>
                    <td><input id="p_tb_value" name="value" required type="text" class="form-control"></td>
                    <td align="center">
                        <button type="submit" class="btn btn-success btn-block" id="p_tb_add"><span
                                class="glyphicon glyphicon-plus"></span> 添加
                        </button>
                    </td>
                </tr>
            </table>
        </form>
        <div class="panel-footer">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2" style="margin-top: 10px">
                    <a class="btn btn-primary btn-block" href="/">返回主页</a>
                    <a class="btn btn-default btn-block" href="/index/self/password">修改密码</a>
                    <a class="btn btn-warning btn-block" href="/index/logout">退出登录</a>
                </div>
            </div>
        </div>
    </div>
    </@temp.centerWarpper>
</@temp.body>
<script>
    $(document).ready(function () {
        var valTypePicker = $("#p_tb_picker");
        var valInput = $("#p_tb_value");
        var valBtnAdd = $("#p_tb_add");

        $(valTypePicker).selectpicker();

    });
</script>