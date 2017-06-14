
<manage-add-phone>
<h2>Add Phone Number.</h2>
<form id="myForm" data-toggle="validator" role="form">
    <h4>Add a phone number.</h4>
    <hr />
 
    <div class="form-group">
    	<validation-summary status={ status }></validation-summary>
        <label for="PhoneNumber" class="control-label">PhoneNumber</label>
        <input 	class="form-control" 
        		name="PhoneNumber" 
        		type="tel"
        		id="PhoneNumber" 	
        		data-error="The Phone number field is required." 
        		required>
        <div class="help-block with-errors"></div>
    </div>
   
    <div class="form-group">
      <button id="submitButton" type="submit" class="btn btn-primary">Send verification code</button>
    </div>

</form>

<script>
	var self = this;
    self.mixin("forms-mixin");
	self.name = 'manage-add-phone';
	self.status = {};
    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.manageAddPhone,data);

        }else{
            console.log('invalid');
        }
    }
    
	self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.manageAddPhoneComplete,
      		self._onManageAddPhoneComplete);

        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
        
    })
	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.manageAddPhoneComplete,
      		self._onManageAddPhoneComplete);
    })
    self._onManageAddPhoneComplete = () =>{
	    self.status = riot.state.manageAddPhone.json.status;
	    if(!self.status.ok){
	    	self.update(); 
	    }else{
	    	riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,'/account/verify-phone-number');
	    }

    }
	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>
</manage-add-phone>