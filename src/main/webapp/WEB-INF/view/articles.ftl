<#import "template/main.ftl" as temp>
<@temp.body title="Articles">
<div class="row">
    <div class="col-sm-8">
        <#if message?? >
            <#if message == "edit">
                <div class="alert alert-success">Posting success!</div>
            <#elseif message == "logout">
                <div class="alert alert-success">Logout success</div>
            </#if>
        </#if>
        <div class="panel panel-default">
            <div class="panel-heading">
                <#if rend_type?? >
                    <#switch rend_type>
                        <#case "recent">
                        <#default >
                            <h2>Recent Articles</h2>
                            <#break >
                    </#switch>
                </#if>
            </div>
            <div class="list-group">
                <#if (pageObj?? && pageObj.content?size > 0)>
                    <#list pageObj.content as post>
                        <a href="/index/article/${post.id}" class="list-group-item">
                            <div class="media">
                                <div class="media-left"></div>
                                <div class="media-body">
                                    <h4>${post.title}</h4>
                                    <p>${post.subtitle!""}</p>
                                    <small>create at ${post.createDate?string('yyyy-MM-dd hh:mm:ss')}</small>
                                    <small>latest modified at ${post.modifiedDate?string('yyyy-MM-dd hh:mm:ss')}</small>
                                    <div><@temp.listPostTags post=post/></div>
                                </div>
                            </div>
                        </a>
                    </#list>
                <#else >
                    <div class="list-group-item disabled">No content...</div>
                </#if>
            </div>
            <#if (pageObj?? && pageObj.content?size > 0)>
                <div class="panel-body">
                    <@temp.defaultPager total=pageObj.totalPages current=pageObj.number length=10 path="?page="></@temp.defaultPager>
                </div>
            </#if>
            <div class="panel-footer">
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2" style="margin-top: 10px">
                        <a class="btn btn-primary btn-block" href="/">Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</@temp.body>