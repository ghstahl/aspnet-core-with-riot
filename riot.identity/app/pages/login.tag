<login> 
<h2>Login.</h2>
<div class="col-md-8">
    <section>
        <h4>Use a local account to log in.</h4>
        <hr />
        <form id="myForm" data-toggle="validator" role="form">
            <input type="hidden" data-val="true" data-val-required=""                     
                id="returnUrl" name="ReturnUrl" value="{returnUrl}" />
            <div class="form-group">
                <label for="inputEmail" class="control-label">Email</label>
                <input name="email" type="email" class="form-control" id="inputEmail" placeholder="Email" data-error="Bruh, that email address is invalid" required>
                <div class="help-block with-errors"></div>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="control-label">Password</label>
                <input name="password" type="password" data-minlength="6" class="form-control" id="inputPassword" placeholder="Password" required>
                <div class="help-block">Minimum of 6 characters</div>
            </div>
            <div class="form-group">
                <div class="checkbox">
                  <label>
                    <input onclick={ onRememberMe } type="checkbox" id="rememberMe" name="RememberMe" value="{rememberMe}" >
                    Remember me.
                  </label>
                  <div class="help-block with-errors"></div>
                </div>
            </div>
            <div class="form-group">
              <button id="submitButton" type="submit" class="btn btn-primary">Login</button>
            </div>

            <p each={items} >
                <a onclick={parent.route} item={this}>{this.title}</a>
            </p>
     	</form>
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
    self.mixin("forms-mixin");
	self.name = 'home';
    self.rememberMe = false;
    self.returnUrl = 
    self.items =  [
          { title: 'Register as a new user?', route: '/account/register'},
          { title: 'Forgot your password?', route: '/account/forgot'}
      ];
 
    self.submitTrigger = riot.EVT.accountStore.in.login;
    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(self.submitTrigger,data);

        }else{
            console.log('invalid');
        }
    }
    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };
    
    self.onRememberMe = (evt) =>{
        self.rememberMe = !self.rememberMe;
        self.update();
    }
    self.on('before-mount', function() {
       riot.state.returnUrl = '%2F';
       let q = riot.route.query();
       if(q.returnurl){
           riot.state.returnUrl = q.returnurl;
       }
       riot.state.returnUrl = decodeURIComponent(riot.state.returnUrl);
    })

	self.on('mount', function() {
        riot.control.on(riot.EVT.accountStore.out.loginComplete,
            self._onLoginComplete);
        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
        self.q = riot.route.query();
    })

	self.on('unmount', function() {
        riot.control.off(riot.EVT.accountStore.out.loginComplete,
            self._onLoginComplete);
    })

    self._onLoginComplete = () => {
        if(riot.state.login.status.ok){
            let returnUrl = '/';
            if (riot.state.returnUrl) {
              returnUrl = riot.state.returnUrl;
            }
            riot.state.returnUrl = undefined;
            riot.control.trigger(riot.EVT.accountStore.in.redirect,returnUrl);
        }else{
            if(riot.state.login.status.requiresTwoFactor){
                riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/send-verification-code');
            }else if(riot.state.login.status.isLockedOut){   
                riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/locked-out');
            }else{
                riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'login-143523'});
            }
        }
    };

	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>
</login>