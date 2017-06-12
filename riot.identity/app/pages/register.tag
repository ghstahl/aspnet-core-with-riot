import '../components/validation-summary.tag'
<register>
<h2>Register.</h2>

<form id="myForm" data-toggle="validator" role="form">
    <h4>Create a new account.</h4>
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
      <button id="submitButton" type="submit" class="btn btn-primary">Register</button>
    </div>

</form>


<script>
	var self = this;
	self.name = 'register';
	self.status = {
        };
    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.register,data);

        }else{
            console.log('invalid');
        }
    }
    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };
    self.toJSONString = ( form ) =>{
        var obj = {};
        var elements = form.querySelectorAll( "input, select, textarea" );
        for( var i = 0; i < elements.length; ++i ) {
            var element = elements[i];
            var name = element.name;
            var value = element.value;

            if( name ) {
                obj[ name ] = value;
            }
        }

        return JSON.stringify( obj );
    }

	self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.registerComplete,
      		self._onRegisterComplete);

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
   		riot.control.off(riot.EVT.accountStore.out.registerComplete,
      		self._onRegisterComplete);
    })
    self._onRegisterComplete = () =>{
	    self.status.errors = riot.state.register.status.errors;
    	self.update();
    }
	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>
</register>