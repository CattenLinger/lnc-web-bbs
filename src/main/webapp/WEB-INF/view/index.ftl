<#import "template/main.ftl" as temp>
<@temp.body title="LNCSA - BBS">
    <@temp.warpper8>
        <#if message?? >
            <#if message == "register">
            <div class="alert alert-success">Sign up success</div>
            <#elseif message == "logout">
            <div class="alert alert-success">Logout success</div>
            </#if>
        </#if>
        <#if Session.session_user??>
        <div class="alert-success alert">Welcome ${Session.session_user.username}</div>
        </#if>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>Operates</h2>
        </div>
        <div class="list-group">
            <#if Session.session_user??>
                <a class="list-group-item" href="/index/self">Self info</a>
                <a class="list-group-item" href="/index/article/post">Post article</a>
                
            <#else >
                <a class="list-group-item" href="/index/login">Sign in</a>
                <a class="list-group-item" href="/index/register">Sign up</a>
            </#if>
            <a class="list-group-item" href="/index/article">Articles</a>
        </div>
    </div>
    </@temp.warpper8>
</@temp.body>