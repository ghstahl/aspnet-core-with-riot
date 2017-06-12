import '../components/validation-summary.tag'
<reset-password>
<h2>Reset Password.</h2>

<form id="myForm" data-toggle="validator" role="form">
    <h4>Reset your password.</h4>
    <hr /> 
    <div class="form-group">
    	<validation-summary status={ status }></validation-summary>
        <label for="inputEmail" class="control-label">Email</label>
        <input 	class="form-control" 
        		name="email" 
        		type="email" 
        		id="inputEmail" 
        		placeholder="Email" 
        		data-error="The Email field is required." 
        		required>
        <div class="help-block with-errors"></div>
    </div>
    <div class="form-group">
        <label for="inputPassword" class="control-label">Password</label>
        <input  class="form-control" 
        		name="password" 
        		type="password" 
        		data-minlength="6" 
        		id="inputPassword" 
        		placeholder="Password" 
        		required>
        <div class="help-block">Minimum of 6 characters</div>
    </div>
    <div class="form-group">
        <label for="inputPasswordConfirm" class="control-label">Confirm Password</label>
        <input  class="form-control" 
        		name="confirmPassword" 
        		type="password" 
        		data-minlength="6" 
        		id="inputPasswordConfirm" 
        		data-match="#inputPassword"
        		data-match-error="The password and confirmation password do not match."
        		required>
        <div class="help-block">Minimum of 6 characters</div>
    </div>
    <div class="form-group">
      <button id="submitButton" type="submit" class="btn btn-primary">Reset</button>
    </div>
	<input name="code" ref="code" type="hidden"/>
</form>


<script>
	var self = this;
	self.mixin("forms-mixin");
	self.name = 'reset-password';
	self.status = {};

	self.email = "";
    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.reset,data);
        }else{
            console.log('invalid');
        }
    }

    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };
      
	self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.resetComplete,
      		self._onResetComplete);
      	this.refs.code.value = riot.state.resetPassword.code;

        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
        riot.state.resetPassword.status  = {
        	errors:null
        };     
    })

	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.resetComplete,
      		self._onResetComplete);
    })

    self._onResetComplete = () =>{
	    self.status.errors = riot.state.resetPassword.status.errors;
    	self.update();
    }

</script>
</reset-password>