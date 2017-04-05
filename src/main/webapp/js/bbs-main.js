/**
 * Created by catten on 3/29/17.
 */

function loadPostList(listNode, page, pager) {
    $(pager).addClass("disabled");
    $(listNode).html('<div class="summary-thumbnail spin"></div>');
    $(listNode).load("/index/articles.html?page=" + page, function (content, status, xhr) {
        if (status == "success") {
            rendPostList(listNode);
            updatePager(listNode,pager);
        }
    });
}

function updatePager(listNode,pager) {
    var $pageNode = $($(listNode).find("[data-role='pager_list']").first());
    var currentPage = $pageNode.data("page");
    console.debug(currentPage);
    $(pager).twbsPagination('destroy');
    $(pager).twbsPagination({
        totalPages: $pageNode.data("page-total"),
        visiblePages: 10,
        startPage: currentPage,
        hideOnlyOnePage: true
    }).on("page",function (event, page) {
        loadPostList(listNode,page - 1,pager);
    });
    $(pager).removeClass("disabled");
}

function rendPostList(recentPostList) {
    $(recentPostList).find("[data-author]").each(function (i, obj) {
        var authorId = $(obj).data("author");
        var picNode = $(obj).find("[data-role='author_head_pic']");
        $.get("/user/" + authorId + "/head_pic", function (content, status, xhr) {
            switch (status) {
                case "success":
                    $(picNode).attr("src", content.data);
                    break;
                case "error":
                    $(picNode).attr("src", "${def_head_pic}");
                    break;
            }
        });
    });
}

//UserCard jquery plugins
(function($) {
    $.fn.userCard = function() {
        var that = this;
        var userId = $(that).data("user-id");
        if (userId != undefined && userId != null) {
            $.get("/user/id/" + userId, function (content, status, xhr) {
                if (status == "success") {
                    var userModel = content;
                    $(that).find("[data-role]").each(function (i, obj) {
                        switch ($(obj).data("role")) {
                            case "m_user_nickname":
                                $.ajax("/user/" + userId + "/nickname", {
                                    type: "GET",
                                    complete: function (xhr, status) {
                                        switch (status) {
                                            case "success":
                                                $(obj).text(JSON.parse(xhr.responseText).data);
                                                break;
                                            default:
                                                $(obj).text(userModel.data.username);
                                                break;
                                        }
                                    }
                                });
                                break;
                            case "m_username":
                                $(obj).text("@" + userModel.data.username);
                                break;
                            case "m_user_head_pic":
                                $.ajax("/user/" + userModel.data.id + "/head_pic", {
                                    type: "GET",
                                    complete: function (xhr, status) {
                                        switch (status) {
                                            case "success":
                                                $(obj).attr("src", JSON.parse(xhr.responseText).data);
                                                break;
                                            default :
                                                break;
                                        }
                                    }
                                });
                                break;
                            case "m_user_group":
                                $(obj).text(userModel.data.groupName == null ? "null" : userModel.data.groupName);
                                break;
                        }
                    });
                }
            });
        }
    };
})(jQuery);