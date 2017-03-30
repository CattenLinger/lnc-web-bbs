<#import "template/main.ftl" as temp>
<@temp.body title="LNCSA - register">
<div class="row">
    <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h2>Register</h2>
            </div>
            <div class="panel-body" id="register-form-wrapper">
                <#if error??>
                    <div class="alert alert-error">User exist!</div>
                </#if>
                <form id="register-form" data-toggle="validator" method="post" action="/index/register">
                    <div class="form-group">
                        <label for="form-username" class="control-label"> Username </label>
                        <input type="text" pattern="^[_A-Za-z0-9\-]{6,}$" data-remote="/user/exist" required maxlength="32"
                               id="form-username" name="username" class="form-control"
                               placeholder="6 - 32 chars, can use _ and -" data-error="Not a valid username">
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label for="form-password" class="control-label"> Password </label>
                        <input type="password" required minlength="6" maxlength="32"
                               id="form-password" name="password" class="form-control"
                               placeholder="6 - 32 chars">
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label for="form-d-password" class="control-label"> Input password again </label>
                        <input type="password" id="form-d-password" class="form-control" data-match="#form-password"
                               required data-match-error="Password not match..." placeholder="duplicate your password">
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-2">
                            <button type="submit" class="btn btn-success btn-block"> Sign up </button>
                            <a href="/" class="btn btn-default btn-block">Back</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</@temp.body>