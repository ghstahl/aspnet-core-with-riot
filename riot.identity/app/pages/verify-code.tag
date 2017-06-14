import '../components/validation-summary.tag'
<verify-code>
<h2>Verify.</h2>

<form id="myForm" data-toggle="validator" role="form">
    <hr /> 
    <div class="form-group">
        <input type="hidden" data-val="true" data-val-required="" 
                    id="RememberMe" name="RememberMe" value="{rememberMe}" />
        <input type="hidden" 
            data-val="true" data-val-required="" id="Provider" 
                            name="Provider" value="{provider}" />    	
        <validation-summary status={ status }></validation-summary>
        <label for="Code" class="control-label">Code</label>
        <input 	class="form-control" 
        		name="Code" 
        		type="text" 
        		id="Code" 
        		data-error="The Code field is required." 
        		required>
        <div class="help-block with-errors"></div>
    </div>
    <div class="form-group">
        <div class="checkbox">
          <label>
            <input onclick={ onRememberBrowser } type="checkbox" id="rememberBrowser" name="RememberBrowser" value="{rememberBrowser}" >
            Remember this browser.
          </label>
          <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group">
      <button id="submitButton" type="submit" class="btn btn-primary">Submit</button>
    </div>

</form>


<script>
	var self = this;
    self.mixin("forms-mixin");
	self.name = 'verify-code';
    self.rememberBrowser = false;
    self.rememberMe = false;
	self.status = {};

    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.verifyCode,data);

        }else{
            console.log('invalid');
        }
    }
    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };

    self.on('before-mount', function() {
        self.provider = riot.state.verificationCode.status.provider;
        self.rememberMe = riot.state.verificationCode.status.rememberMe;
    })
    self.onRememberBrowser = (evt) =>{
        self.rememberBrowser = !self.rememberBrowser;
        self.update();
    }
	self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.verifyCodeComplete,
      		self._onVerifyCodeComplete);

        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
        riot.state.register = {
        	status:{
        		errors:null
        	}
        };
        
    })

	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.verifyCodeComplete,
      		self._onVerifyCodeComplete);
    })

    self._onVerifyCodeComplete = () =>{
	    self.status = riot.state.verifyCode.status;
    	self.update();
    	if(self.status.ok){
            let returnUrl = '/';
            if (riot.state.returnUrl) {
              returnUrl = riot.state.returnUrl;
            }
            riot.state.returnUrl = undefined;
            riot.control.trigger(riot.EVT.accountStore.in.redirect,returnUrl);
    	}else{
    		if(self.status.IsLockedOut){
    			riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/locked-out');
    		}
    	}
    }

	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};

</script>
</verify-code>

