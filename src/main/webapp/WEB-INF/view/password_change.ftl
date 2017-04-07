<#import "template/main.ftl" as temp>
<@temp.body title="修改密码">
<@temp.centerWarpper width=6>
<div class="panel panel-default">
    <div class="panel-heading">
        修改密码
    </div>
    <div class="panel-body">
        <form method="post" action="/index/self/password" data-toggle="validator">
            <div class="form-group">
                <label for="cpf_origin">旧密码</label>
                <input id="cpf_origin" name="originpw" type="password" class="form-control" minlength="6" maxlength="32" required>
            </div>
            <div class="form-group">
                <label for="cpf_new">新密码</label>
                <input id="cpf_new" name="newpw" type="password" class="form-control" minlength="6" maxlength="32" required>
            </div>
            <div class="form-group">
                <label for="cpf_newrp">再次输入新密码</label>
                <input id="cpf_newrp" type="password" class="form-control" required minlength="6" maxlength="32" data-match="#cpf_new">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-success btn-block"> 修改并重新登录 </button>
                <a class="btn btn-default btn-block" href="/index/self">返回</a>
            </div>
        </form>
    </div>
</div>
</@temp.centerWarpper>
</@temp.body>