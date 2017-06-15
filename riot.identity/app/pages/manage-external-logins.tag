import '../components/validation-summary.tag'
<manage-external-logins>
<h2>Manage your external logins.</h2>

<div if={logins.manageLoginsViewModel}>
    <h4>Registered Logins</h4>
     <table class="table">
        <tbody>
                <tr each={login in logins.manageLoginsViewModel.currentLogins}>
                    <td>{login.loginProvider}</td>
                    <td>
                    	<div>
                    		<a onclick={onRemoveLoginProvider} 
                    			class="btn btn-default"
                    			title="Remove this {login.loginProvider} login from your account">Remove</a>
                          
                        </div>
                    </td>
                </tr>
        </tbody>
    </table>
</div>

<script>
  var self = this;
  self.mixin("forms-mixin");
  self.name = 'manage';

  self.json = {};
  self.status = {};
  self.logins = {};

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
		riot.control.on(riot.EVT.accountStore.out.externalLoginsComplete,
			self._onExternalLoginsComplete);

		riot.control.trigger(riot.EVT.accountStore.in.externalLogins);
    })

	self.on('unmount', function() {
		riot.control.off(riot.EVT.accountStore.out.externalLoginsComplete,
			self._onExternalLoginsComplete);
    })

	
  	self.onToggleTwoFactor = (evt) =>{
		riot.control.trigger(riot.EVT.accountStore.in.enableTwoFactor,{enable:!self.json.indexViewModel.twoFactor});
    }

  	self.onRemovePhoneNumber = (evt) =>{
    	riot.control.trigger(riot.EVT.accountStore.in.removePhoneNumber);
    }

  	self._onFetchNewInfo = () =>{
    	riot.control.trigger(riot.EVT.accountStore.in.userManageInfo);
  	}

  	self._onExternalLoginsComplete = () =>{
		self.json = riot.state.manageLogins.json;
      	let status = self.json.status;
      	self.logins.manageLoginsViewModel = self.json.manageLoginsViewModel;
    	self.update();
    }

	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>
</manage-external-logins>