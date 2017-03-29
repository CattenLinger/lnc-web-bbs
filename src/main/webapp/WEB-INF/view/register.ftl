<#import "template/main.ftl" as temp>
<@temp.body title="LNCSA - register">
<div class="container">
    <div class="page-header">
        <h1>Lingnan College Software Association</h1>
    </div>
    <div class="row">
        <div class="col-md-6 col-md-offset-3 col-sm-10 col-sm-offset-1">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h2>Register</h2>
                </div>
                <div class="panel-body" id="register-form-wrapper">

                </div>
            </div>
        </div>
    </div>
</div>
</@temp.body>
<script>
    $(document).ready(function () {
        initForm();
    });

    function initForm() {
        var regFormWrapper = $("#register-form-wrapper");
        $(regFormWrapper).html($("#template-form"));

        var regForm = $("#register-form");
        $(regForm).submit(function (e) {
            e.preventDefault();
            console.log($(regForm).serializeJSON());
            $(regFormWrapper).html($("#template-loadingPage").html());
            $(regFormWrapper).html($("#template-success").html());
        });
        $(regForm).validator();
    }
</script>
<script type="text/html" id="template-loadingPage">
    <div align="center">
        <div class="summary-thumbnail spin"></div>
        <h1>Please wait...</h1>
    </div>
</script>
<script type="text/html" id="template-success">
    <div align="center">
        <h1>Sign success!</h1>
        <div class="col-md-8 col-md-offset-2">
            <a class="btn btn-success btn-block" href="/">Go login</a>
        </div>
    </div>
</script>
<script type="text/html" id="template-form">
    <form id="register-form" data-toggle="validator">
        <div class="form-group">
            <label for="form-username" class="control-label"> Username </label>
            <input type="text" pattern="^[_A-Za-z0-9\-]{6,}$" required maxlength="32"
                   id="form-username" name="username" class="form-control"
                   placeholder="6 - 32 chars, can use _ and -">
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
            <div class="col-md-8 col-md-offset-2">
                <button type="submit" class="btn btn-success btn-block"> Sign up </button>
            </div>
        </div>
    </form>
</script>