import '../components/validation-summary.tag'
<change-password>
<h2>Change Password.</h2>

<form id="myForm" data-toggle="validator" role="form">
    <h4>Change Password Form</h4>
    <hr /> 
    <div class="form-group">
    	<validation-summary status={ status }></validation-summary>
        <label for="inputOldPassword" class="control-label">Current Password</label>
        <input 	class="form-control" 
        		name="OldPassword" 
        		type="password" 
        		data-minlength="6" 
        		id="inputOldPassword" 
        		required>
         <div class="help-block">Minimum of 6 characters</div>
    </div>
    <div class="form-group">
        <label for="inputNewPassword" class="control-label">New Password</label>
        <input  class="form-control" 
        		name="NewPassword" 
        		type="password" 
        		data-minlength="6" 
        		id="inputNewPassword" 
        		required>
        <div class="help-block">Minimum of 6 characters</div>
    </div>
    <div class="form-group">
        <label for="inputConfirmPassword" class="control-label">Confirm New Password</label>
        <input  class="form-control" 
        		name="ConfirmPassword" 
        		type="password" 
        		data-minlength="6" 
        		id="inputConfirmPassword" 
        		data-match="#inputNewPassword"
        		data-match-error="The password and confirmation password do not match."
        		required>
        <div class="help-block">Minimum of 6 characters</div>
    </div>
    <div class="form-group">
      <button id="submitButton" type="submit" class="btn btn-primary">Submit</button>
    </div>

</form>


<script>
	var self = this;
    self.mixin("forms-mixin");
	self.name = 'register';
	self.status = {};

    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.changePassword,data);

        }else{
            console.log('invalid');
        }
    }
    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };
    

	self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.changePasswordComplete,
      		self._onChangePasswordComplete);

        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
        
    })
	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.changePasswordComplete,
      		self._onChangePasswordComplete);
    })
    self._onChangePasswordComplete = () =>{
	    
	    if(riot.state.changePassword.json.status.ok){
	        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/manage');
	    }else{
            self.status.errors = riot.state.changePassword.json.status.errors;
	    	self.update();
	    }
    }
	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'changePasswords-143523'});
  	};
</script>
</change-password>