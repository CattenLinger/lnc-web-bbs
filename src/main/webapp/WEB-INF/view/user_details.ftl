<#import "template/main.ftl" as temp>
<@temp.body title="用户详情">
<div class="row">
    <div class="col-md-8">
        <form method="post" action="/index/manage/user/${user.username}/group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h2>${user.username} - 信息</h2>
                </div>
                <div class="panel-body">
                    <div class="media">
                        <div class="media-left">
                            <#assign userHeadPic=def_head_pic>
                            <#if user.profile??>
                                <#if (user.profile?size > 0)>
                                    <#list user.profile as profile>
                                        <#if profile.key == pkey_head_pic>
                                            <#assign userHeadPic = profile.value/>
                                            <#break >
                                        </#if>
                                    </#list>
                                </#if>
                            </#if>
                            <img width="128" height="128" src="${userHeadPic}">
                        </div>
                        <div class="media-body">
                            <label>用户名</label>
                            <div class="form-control">${user.username}</div>
                            <label>用户 Id</label>
                            <div class="form-control">${user.id}</div>
                            <label>用户组</label>
                            <div>
                                <select class="selectpicker" name="userGroup">
                                    <#if (userGroups?? && userGroups?size > 0)>
                                        <#list userGroups as userGroup>
                                            <option value="${userGroup}"<#if user.userGroup??>
                                                <#if user.userGroup.name == userGroup>
                                                    selected
                                                </#if>
                                            </#if>>${userGroup}</option>
                                        </#list>
                                    </#if>
                                </select>
                                <input type="submit" value="更新" class="btn btn-success">
                            </div>
                            <label>注册日期</label>
                            <div><#if user.registerDate??>${user.registerDate?string("yyyy-mm-dd")}<#else >
                                无记录</#if></div>
                            <table class="table" id="p_table">
                                <thead>
                                <tr>
                                    <td align="center">个人信息项</td>
                                    <td align="left" width="80%">值</td>
                                </tr>
                                </thead>
                                <#if (user.profile?? && user.profile?size > 0)>
                                    <#list user.profile as profile>
                                        <tr>
                                            <td align="center">${pkey_list[profile.key]!"${profile.key}"}</td>
                                            <td align="left">
                                                <@temp.cutString text=profile.value length=50 suffix="..." />
                                            </td>
                                        </tr>
                                    </#list>
                                </#if>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
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