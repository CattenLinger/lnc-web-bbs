<#import "template/main.ftl" as temp>
<ul class="list-group"
    data-type="page-content" data-page="${page.number}"
    data-page-total="${page.totalPages}" data-page-size="${page.size}">
<#if (page.content?? && page.content?size > 0)>
    <#list page.content as item>
        <#assign headPic = def_head_pic/>
        <#assign nickname = ""/>
        <#-- Read single comment profile -->
        <#if item.author.profile??>
            <#list item.author.profile as proItem>
                <#switch proItem.key>
                    <#case pkey_head_pic>
                        <#assign headPic = proItem.value/>
                        <#break >
                    <#case pkey_nickname>
                        <#assign nickname = proItem.value/>
                        <#break >
                </#switch>
            </#list>
        </#if>
        <#if nickname == ""><#assign nickname=item.author.username/></#if>

        <li class="list-group-item" data-comment-id="${item.id}">
            <div class="media">
            <#-- Head pic -->
                <div class="media-left">
                    <img src="${headPic}" width="32" height="32">
                </div>
                <div class="media-body">
                    <div>
                        <div class="pull-left">
                            <div><b>${nickname}</b></div>
                            <div><small>create at ${item.createDate?string('yyyy-MM-dd hh:mm:ss')}</small></div>
                        </div>
                        <div class="btn-group btn-group-sm pull-right">
                            <button class="btn btn-primary" data-role="c_reply">
                                <span class="glyphicon glyphicon-share-alt"></span> Reply</button>
                            <#if Session.session_user??>
                                <#if Session.session_user.id == item.author.id>
                                    <button class="btn btn-warning" data-role="c_delete">
                                        <span class="glyphicon glyphicon-trash"></span> Delete</button>
                                </#if>
                            </#if>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <#if item.relateTo??>
                        <p>reply to @${item.relateTo.author.username} : </p>
                    </#if>
                    <p class="lnc-md-content" data-role="markdown-content">${item.content!""}</p>
                </div>
            </div>
        </li>
    </#list>
<#else >
    <li class="list-group-item disabled">Empty..</li>
</#if>
</ul>