<#import "template/main.ftl" as temp>
<div class="list-group fadeIn animated" data-role="pager_list" data-page="${pageObj.number + 1}" data-page-total="${pageObj.totalPages}" data-page-size="${pageObj.size}">
<#if (pageObj?? && pageObj.content?size > 0)>
    <#list pageObj.content as post>
        <a href="/index/article/${post.id}" class="list-group-item" data-author="${post.author.id}">
            <div class="media">
                <div class="media-left">
                    <img data-role="author_head_pic" src="${def_head_pic}" width="48" height="48">
                </div>
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