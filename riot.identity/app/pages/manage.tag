 
import '../components/validation-summary.tag'
<manage>
<h2>Manage your account.</h2>

<div>
    <h4>Change your account settings</h4>
    <hr />
    <dl class="dl-horizontal">
        <dt>Password:</dt>
        <dd>
                <a class="btn-bracketed" href="/Manage/ChangePassword">Change</a>
        </dd>
        <dt>External Logins:</dt>
        <dd>

            0 <a class="btn-bracketed" href="/Manage/ManageLogins">Manage</a>
        </dd>
        <dt>Phone Number:</dt>
        <dd if={json.indexViewModel}>
          
          <div if={json.indexViewModel.phoneNumber}>
            {json.indexViewModel.phoneNumber}
            <a href="#account/manage-change-phone" class="btn-bracketed">Change</a>
            <a onclick={onRemovePhoneNumber} class="btn-bracketed">Remove</a>
          </div>
          <div if={!json.indexViewModel.phoneNumber}> 
            None
            <a href="#account/manage-add-phone" class="btn-bracketed">Add</a>
          </div>
        </dd>

        <dt>Two-Factor Authentication:</dt>
        <dd>
                  
        </dd>
    </dl>
</div>





<script>
	var self = this;
  self.mixin("forms-mixin");
	self.name = 'manage';

  self.json = {};
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
    riot.control.on(riot.EVT.accountStore.out.removePhoneNumberComplete,
          self._onRemovePhoneNumberComplete);
		riot.control.trigger(riot.EVT.accountStore.in.userManageInfo);
    })

	self.on('unmount', function() {
   	riot.control.off(riot.EVT.accountStore.out.userManageInfoComplete,
      		self._onUserManageInfoComplete);
    riot.control.off(riot.EVT.accountStore.out.removePhoneNumberComplete,
          self._onRemovePhoneNumberComplete);
    })

  self.onRemovePhoneNumber = (evt) =>{
    riot.control.trigger(riot.EVT.accountStore.in.removePhoneNumber);
    }

  self._onRemovePhoneNumberComplete = () =>{
    riot.control.trigger(riot.EVT.accountStore.in.userManageInfo);
    }

  self._onUserManageInfoComplete = () =>{
	    self.json = riot.state.manage.json;
      self.status = self.json;
    	self.update();
    }

	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>
</manage>