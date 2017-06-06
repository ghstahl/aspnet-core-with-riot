import '../components/itemlist.tag';

<home> 

<div class="col-md-8">
        <section>
            <form method="post" class="form-horizontal" action="/Account/Login">
                <h4>Use a local account to log in.</h4>
                <hr />
                <div class="text-danger validation-summary-valid" data-valmsg-summary="true"><ul><li style="display:none"></li>
</ul></div>
                <div class="form-group">
                    <label class="col-md-2 control-label" for="Email">Email</label>
                    <div class="col-md-10">
                        <input class="form-control" type="email" data-val="true" data-val-email="The Email field is not a valid e-mail address." data-val-required="The Email field is required." id="Email" name="Email" value="" />
                        <span class="text-danger field-validation-valid" data-valmsg-for="Email" data-valmsg-replace="true"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label" for="Password">Password</label>
                    <div class="col-md-10">
                        <input class="form-control" type="password" data-val="true" data-val-required="The Password field is required." id="Password" name="Password" />
                        <span class="text-danger field-validation-valid" data-valmsg-for="Password" data-valmsg-replace="true"></span>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <div class="checkbox">
                            <label for="RememberMe">
                                <input data-val="true" data-val-required="The Remember me? field is required." id="RememberMe" name="RememberMe" type="checkbox" value="true" />
                                Remember me?
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit" class="btn btn-default">Log in</button>
                    </div>
                </div>
                <p>
                    <a href="/Account/Register">Register as a new user?</a>
                </p>
                <p>
                    <a href="/Account/ForgotPassword">Forgot your password?</a>
                </p>
            <input name="__RequestVerificationToken" type="hidden" value="CfDJ8HLzZJi1M_NEljseINrlzRYG6_dHrNGZuHZlVmpdcz9WTFirx4TIOCxzWqo9VMsCIWwcMQa0NilhY1RDO_l8eyTDShkyKpiUp_FXdlDIQRKNLMxgWPbxoJCwvNbd5vUJrjBvJS495NQ9aCNV8f7FSSs" /><input name="RememberMe" type="hidden" value="false" /></form>
        </section>
    </div>
    <div class="col-md-4">
        <section>
            <h4>Use another service to log in.</h4>
            <hr />
                    <div>
                        <p>
                            There are no external authentication services configured. See <a href="https://go.microsoft.com/fwlink/?LinkID=532715">this article</a>
                            for details on setting up this ASP.NET application to support logging in via external services.
                        </p>
                    </div>
        </section>
    </div>



<script>
	var self = this;
	self.name = 'home';

	self.times = [0,1,2,3,4,5,6,7,8,9];
	self.buttonS = [0,1,2,3,4,5,6];
	self.buttonClasses = [
		"btn-default",
		"btn-primary",
		"btn-success",
		"btn-info",
		"btn-warning",
		"btn-danger",
		"btn-link"
		];

	self.a = 0;
	self.b = 0;
	self.c = 0;

	self.tick = () => {

	
		var arrayLength = self.times.length;
		for (var i = 0; i < arrayLength; i++) {
		    self.times[i] = Math.floor(Math.random() * (100 - 0) + 0);
		}

		arrayLength = self.buttonS.length;
		for (var i = 0; i < arrayLength; i++) {
		    self.buttonS[i] = Math.floor(Math.random() * (6 - 0) + 0);
		}

		self.a = self.times[0];
		self.b = Math.random() * (100 - self.a) + self.a;
		self.c = 100 - self.a - self.b;
	
  		self.update();
  	};
	
	
	self.on('mount', function() {
		self.tick();
    	self.timer =  setInterval(this.tick,400)
    })
	self.on('unmount', function() {
    	clearInterval(self.timer)
    })

	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>

</home>