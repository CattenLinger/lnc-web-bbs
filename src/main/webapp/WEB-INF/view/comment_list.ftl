<#import "template/main.ftl" as temp>
<ul class="list-group"
    data-type="page-content" data-page="${page.number}"
    data-page-total="${page.totalPages}" data-page-size="${page.size}">
<#if (page.content?? && page.content?size > 0)>
    <#list page.content as item>
        <#assign headPic = ""/>
        <#assign nickname = ""/>
        <#-- Read single comment profile -->
        <#if (item.author.profile??)>
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
        <li class="list-group-item">
            <div class="media">
            <#-- Head pic -->
                <div class="media-left">
                    <#if headPicKey?? && headPic != "">
                        <img src="${headPic}" width="32" height="32">
                    <#else >
                        <img src="/img/placeholder-300x300.png" width="32" height="32">
                    </#if>
                </div>
                <div class="media-body">
                    <div><b>${nickname}</b></div>
                    <div data-type="markdown-content">${item.content}</div>
                    <div>
                        <div class="pull-left">
                            <small>create at ${item.createDate?string('yyyy-MM-dd hh:mm:ss')}</small>
                        </div>
                        <div class="pull-right">
                            <button class="btn btn-success">Reply</button>
                            <button class="btn btn-delete">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </#list>
<#else >
    <li class="list-group-item disabled">Empty..</li>
</#if>
</ul>