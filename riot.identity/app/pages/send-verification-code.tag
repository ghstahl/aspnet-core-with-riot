import '../components/validation-summary.tag'
<send-verification-code>

 
<h2>Forgot your password?</h2>

<form id="myForm" data-toggle="validator" role="form">
    <h4>Send Verification Code.</h4>
    <hr /> 
    <div class="form-group">
    	<validation-summary status={ status }></validation-summary>
        <label for="inputEmail" class="control-label">Select Two-Factor Authentication Provider:</label>
		<select class="form-control"
				id="SelectedProvider" 
				name="SelectedProvider">
			<option value="Email">Email</option>
			<option value="Phone">Phone</option>
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

	self.on('mount', function() {
		riot.state.forgot = {};
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
    	riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/forgot-confirmation');
    }

</script>
</send-verification-code>