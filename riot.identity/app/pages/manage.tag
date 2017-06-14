 
import '../components/validation-summary.tag'
<manage>
<h2>Manage your account.</h2>

<h4>Change your account settings</h4>
<hr />




<script>
	var self = this;
    self.mixin("forms-mixin");
	self.name = 'manage';
	self.status = {};
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
    

	self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.userManageInfoComplete,
      		self._onUserManageInfoComplete);
		riot.control.trigger(riot.EVT.accountStore.in.userManageInfo);
    })
	self.on('unmount', function() {
   		riot.control.off(riot.EVT.accountStore.out.userManageInfoComplete,
      		self._onUserManageInfoComplete);
    })
    self._onUserManageInfoComplete = () =>{
	    self.status.errors = riot.state.register.status.errors;
    	self.update();
    }
	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>
</manage>