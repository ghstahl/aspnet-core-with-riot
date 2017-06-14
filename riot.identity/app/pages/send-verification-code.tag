import '../components/validation-summary.tag'
<send-verification-code>

<h2>Send Verification Code.</h2>

<form id="myForm" data-toggle="validator" role="form">
   
    <hr /> 
    <div class="form-group">
    	<validation-summary status={ status }></validation-summary>
        <input type="hidden" data-val="true" data-val-required="" 
                id="RememberMe" name="RememberMe" value="{rememberMe}" />
        <label for="inputEmail" class="control-label">Select Two-Factor Authentication Provider:</label>
		<select class="form-control"
				id="SelectedProvider" 
				name="SelectedProvider">
            <option each={ factorOptions } if={!this.disabled} value="{this.value}">{this.text}</option>

		</select>
 
        <div class="help-block with-errors"></div>
    </div>
   
    <div class="form-group">
      <button id="submitButton" type="submit" class="btn btn-primary">Submit</button>
    </div>

</form>
 
<script>
	var self = this;
    self.mixin("forms-mixin");
	self.name = 'send-verification-code';
    self.factorOptions = [];
 	self.submitTrigger = riot.EVT.accountStore.in.sendVerificationCode;

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
    self.on('before-mount', () =>{
        self.factorOptions = riot.state.login.status.factorOptions;
        self.rememberMe = riot.state.login.status.rememberMe;
        riot.state.verificationCode = {};
    });
	self.on('mount', function() {  
   		riot.control.on(riot.EVT.accountStore.out.sendVerificationCodeComplete,
      		self._onSendVerificationCodeComplete );

        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
    })

	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.sendVerificationCodeComplete,
      		self._onSendVerificationCodeComplete);
    })

    self._onSendVerificationCodeComplete = () =>{
        self.status = riot.state.verificationCode.status;
        if(self.status.ok){
            riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/verify-code');
        }else{
            riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'sendVerificationCode-143523'});
        }
    	
    }

</script>
</send-verification-code>