<#import "template/main.ftl" as temp>
<@temp.body title="发布文章">
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2 class="pull-left">编辑</h2>
            <div class="pull-right">
                <a href="/" class="btn btn-default">返回主页</a>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <form method="post" data-toggle="validator" action="/index/article">
                <#if post??>
                    <input type="hidden" name="id" value="${post.id}">
                    <div class="form-group">
                        <label for="f_title">标题</label>
                        <input name="title" class="form-control" type="text" maxlength="64" required id="f_title" value="${post.title}">
                    </div>
                    <div class="form-group">
                        <label for="f_subtitle">子标题（可选）</label>
                        <input name="subtitle" class="form-control" type="text" maxlength="200" id="f_subtitle" value="${post.subtitle!""}">
                    </div>
                    <div class="form-group">
                        <label for="f_topics" class="control-label">话题（可选）</label><br>
                        <select multiple name="topics" id="f_topics" data-role="tagsinput">
                            <#if post.topics??>
                            <#list post.topics as topic>
                                <option value="${topic}">topic</option>
                            </#list>
                            </#if>
                        </select>
                    </div>
                    <div class="form-group">
                    <textarea id="f_content" name="content" required class="form-control" tabindex="-1"
                              data-validate="true"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-2">
                            <button type="submit" class="btn btn-success btn-block">保存</button>
                        </div>
                    </div>
                <#else >
                    <div class="form-group">
                        <label for="f_title">标题</label>
                        <input name="title" class="form-control" type="text" maxlength="64" required id="f_title">
                    </div>
                    <div class="form-group">
                        <label for="f_subtitle">子标题（可选）</label>
                        <input name="subtitle" class="form-control" type="text" maxlength="200" id="f_subtitle">
                    </div>
                    <div class="form-group">
                        <label for="f_topics" class="control-label">话题（可选）</label><br>
                        <select multiple name="topics" id="f_topics" data-role="tagsinput"></select>
                    </div>
                    <div class="form-group">
                    <textarea id="f_content" name="content" required class="form-control" tabindex="-1"
                              data-validate="true"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-2">
                            <button type="submit" class="btn btn-success btn-block">发表</button>
                        </div>
                    </div>
                </#if>
            </form>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        window.markdownRender = new showdown.Converter();
        window.markdownArea = "";
        var $fContent = $("#f_content");
        $fContent.markdown({
            height: 500,
            onPreview: function (e) {
                if (e.isDirty()) {
                    var originalContent = e.getContent();
                    window.markdownArea = window.markdownRender.makeHtml(originalContent);
                }
                return window.markdownArea;
            }
        });
        <#if post??>
            $fContent.val($("#origin").html());
        </#if>
    });
</script>
<script type="text/html" id="origin">
<#if post??>
${post.content}
</#if>
</script>