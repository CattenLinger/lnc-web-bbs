<#import "template/main.ftl" as temp>
<@temp.body title="User Details">
<@temp.warpper8>
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
                            <#if profile.key == pkey_head_pic>
                                <#assign userHeadPic = profile.value/>
                                <#break >
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
                    <tr>
                        <td>Sign up Date</td>
                        <td><#if user.registerDate??>${user.registerDate?string("yyyy-mm-dd")}<#else >Null</#if></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <table class="table" id="p_table">
        <thead>
        <tr>
            <td align="center">Profile name</td>
            <td align="left" width="80%">Value</td>
        </tr>
        </thead>
        <#if (user.profile?? && user.profile?size > 0)>
            <#list user.profile as profile>
                <tr>
                    <td align="center">${profile.key}</td>
                    <td align="left">
                        <@temp.cutString text=profile.value length=100 suffix="..." />
                    </td>
                </tr>
            </#list>
        </#if>
    </table>
    <div class="panel-footer">
        <div class="row">
            <div class="col-sm-8 col-sm-offset-2" style="margin-top: 10px">
                <a class="btn btn-primary btn-block" href="/index/manage/users">Back</a>
            </div>
        </div>
    </div>
</div>
</@temp.warpper8>
</@temp.body>