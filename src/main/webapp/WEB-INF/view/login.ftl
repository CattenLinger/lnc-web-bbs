<#import "template/main.ftl" as temp>
<@temp.body title="Sign in">
    <@temp.warpper8>
        <#if error??>
            <#if error == "user_not_exist">
            <div class="alert alert-warning">User doesn't exist</div>
            </#if>
            <#if error == "password_wrong">
            <div class="alert alert-warning">Password not match</div>
            </#if>
        </#if>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>Sign in</h2>
        </div>
        <div class="panel panel-body">
            <form method="post" data-toggle="validator" action="/index/login">
                <div class="form-group">
                    <label for="form-username" class="control-label"> Username </label>
                    <input type="text" pattern="^[_A-Za-z0-9\-]{6,}$" required maxlength="32"
                           id="form-username" name="username" class="form-control"
                           placeholder="username" data-error="Not a valid username">
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="form-password" class="control-label"> Password </label>
                    <input type="password" required minlength="6" maxlength="32"
                           id="form-password" name="password" class="form-control"
                           placeholder="password">
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-8 col-sm-offset-2">
                        <button type="submit" class="btn btn-success btn-block"> Sign in</button>
                        <a href="/" class="btn btn-default btn-block">Back</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    </@temp.warpper8>
</@temp.body>