<login> 
<h2>Login.</h2>
<div if={json} class="col-md-8">
    <section>
        <h4>Use a local account to log in.</h4>
        <hr />
        <div id="myForm" data-toggle="validator" role="form">
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
              <button id="submitButton" onclick={onSubmit} type="submit" class="btn btn-primary">Login</button>
            </div>

            <p each={items} >
                <a onclick={parent.route} item={this}>{this.title}</a>
            </p>
        </div>
    </section>
</div>
<div if={json} class="col-md-4">
    <section>
        <h4>Use another service to log in.</h4>
        <hr />
        <div each={login in json.loginProviders}>
            <button  class="btn btn-default" 
                            onclick="{parent.onExternalLogin}"
                            title="Log in using your {login.displayName} account">{login.displayName}</button>
        </div>
    </section>
</div>

<script>
    var self = this;
    self.mixin("forms-mixin");
    self.mixin('riotcontrol-bind-mixin');

    self.name = 'home';
    self.rememberMe = false;
    self.json = undefined;
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
        self.riotHandlers.forEach(self.bindHandler);
         
        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
        self.q = riot.route.query();

        riot.control.trigger(riot.EVT.accountStore.in.loginInfo);

    })

    self.on('unmount', function() {
        self.riotHandlers.forEach(self.unbindHandler);
    })

    self._onLoginInfoComplete = () =>{
        self.json = riot.state.loginInfo.json;
        self.update();
    }
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
    self.onExternalLogin = (evt) =>{
        let returnUrl = riot.state.returnUrl;
        let item = evt.item;
        let antiForgeryToken = riot.Cookies.get('XSRF-TOKEN');
        let body = {
          __RequestVerificationToken:antiForgeryToken,
          returnUrl:returnUrl,
          provider:item.login.authenticationScheme
        };
        self.externalPost('/Account/ExternalLogin',body);
    }
    self.externalPost = (path, params, method) => {
       method = method || "post"; // Set method to post by default, if not specified.

        var form = $(document.createElement( "form" ))
            .attr( {"method": method, "action": path} );

        $.each( params, function(key,value){
            $.each( value instanceof Array? value : [value], function(i,val){
                $(document.createElement("input"))
                    .attr({ "type": "hidden", "name": key, "value": val })
                    .appendTo( form );
            }); 
        } ); 

        form.appendTo( document.body ).submit(); 

    }
    self.generateAnError = () => {
        riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
    };
    self.riotHandlers = [
        {event:riot.EVT.accountStore.out.loginComplete,handler:self._onLoginComplete},
        {event:riot.EVT.accountStore.out.loginInfoComplete,handler:self._onLoginInfoComplete},
    ];
</script>
</login>