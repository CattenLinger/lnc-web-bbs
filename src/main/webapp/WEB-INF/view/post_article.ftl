<#import "template/main.ftl" as temp>
<@temp.body title="Post article">
<div class="row">
    <div class="col-sm-8 col-sm-offset-2">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h2>Editing Post</h2>
            </div>
            <div class="panel-body">
                <form method="post" data-toggle="validator" action="/index/article">
                    <div class="form-group">
                        <label for="f_title">Title</label>
                        <input name="title" class="form-control" type="text" maxlength="64" required id="f_title">
                    </div>
                    <div class="form-group">
                        <label for="f_subtitle">Sub Title</label>
                        <input name="subtitle" class="form-control" type="text" maxlength="200" id="f_subtitle">
                    </div>
                    <div class="form-group">
                        <label for="f_topics" class="control-label">Topics</label><br>
                        <select multiple name="topics" id="f_topics" data-role="tagsinput"></select>
                    </div>
                    <div class="form-group">
                        <textarea id="f_content" name="content" required class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-2">
                            <button type="submit" class="btn btn-success btn-block"> Post </button>
                            <a href="/" class="btn btn-default btn-block">Back</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        window.markdownRender = new showdown.Converter();
        window.markdownArea = "";
        $("#f_content").markdown({
            height : 500,
            onPreview: function(e) {

                if (e.isDirty()) {
                    var originalContent = e.getContent();

                    window.markdownArea = window.markdownRender.makeHtml(originalContent);
                }

                return window.markdownArea;
            }
        });
    });
</script>