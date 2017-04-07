<#import "template/main.ftl" as temp>
<@temp.body title="登录">
    <@temp.centerWarpper width=6>
        <#if error??>
            <#if error == "user_not_exist">
            <div class="alert alert-warning">用户不存在</div>
            </#if>
            <#if error == "password_wrong">
            <div class="alert alert-warning">密码错误</div>
            </#if>
        </#if>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>登录</h2>
        </div>
        <div class="panel panel-body">
            <form method="post" data-toggle="validator" action="/index/login">
                <div class="form-group">
                    <label for="form-username" class="control-label"> 用户名 </label>
                    <input type="text" pattern="^[_A-Za-z0-9\-]{6,}$" required maxlength="32"
                           id="form-username" name="username" class="form-control"
                           placeholder="username" data-error="用户名不符合格式">
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="form-password" class="control-label"> 密码 </label>
                    <input type="password" required minlength="6" maxlength="32"
                           id="form-password" name="password" class="form-control"
                           placeholder="password">
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-8 col-sm-offset-2">
                        <button type="submit" class="btn btn-success btn-block"> 登录 </button>
                        <a href="/" class="btn btn-default btn-block">返回主页</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    </@temp.centerWarpper>
</@temp.body>