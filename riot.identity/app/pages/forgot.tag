import '../components/validation-summary.tag'
<forgot>

 
<h2>Forgot your password?</h2>

<form id="myForm" data-toggle="validator" role="form">
    <h4>Enter your email.</h4>
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
      <button id="submitButton" type="submit" class="btn btn-primary">Submit</button>
    </div>

</form>
 
<script>
	var self = this;
    self.mixin("forms-mixin");
	self.name = 'forgot';
 
    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.forgot,data);

        }else{
            console.log('invalid');
        }
    }

    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };

	self.on('mount', function() {
		riot.state.forgot = {};
   		riot.control.on(riot.EVT.accountStore.out.forgotComplete,
      		self._onForgotComplete );

        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
    })

	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.forgotComplete,
      		self._onForgotComplete);
    })

    self._onForgotComplete = () =>{
    	riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/forgot-confirmation');
    }

</script>
</forgot>