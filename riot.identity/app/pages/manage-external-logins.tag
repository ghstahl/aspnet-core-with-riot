import '../components/validation-summary.tag'
<manage-external-logins>
<h2>Manage your external logins.</h2>

<div if={logins.manageLoginsViewModel}>
    <div if={logins.manageLoginsViewModel.currentLogins.length > 0}>
      <h4>Registered Logins</h4>
    
      <table class="table">
        <tbody>
          <tr each={login in logins.manageLoginsViewModel.currentLogins}>
            <td>{login.loginProvider}</td>
            <td>
            	<div>
            		<a onclick={onRemoveExternalLogin} 
            			class="btn btn-default"
            			title="Remove this {login.loginProvider} login from your account">Remove</a>
                </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div if={logins.manageLoginsViewModel.otherLogins.length > 0}>
      <h4>Add another service to log in.</h4>
    
       <table class="table">
          <tbody>
            <tr each={login in logins.manageLoginsViewModel.otherLogins}>
              <td>{login.displayName}</td>
              <td>
                <div>
                  <form method="post" class="form-horizontal" action="/Manage/RiotLinkLogin">
                    <button type="submit" 
                            class="btn btn-default" 
                            name="provider"
                            value="{login.authenticationScheme}"   
                            title="Log in using your {login.authenticationScheme} account">Add</button>
                  
                      <input name="__RequestVerificationToken" type="hidden" value="{parent.antiForgeryToken}" />
                  </form>
                </div>
              </td>
            </tr>
          </tbody>
      </table>
    </div>
</div>

<script>
  var self = this;
  self.mixin("forms-mixin");
  self.name = 'manage';
  self.antiForgeryToken = riot.Cookies.get('XSRF-TOKEN');
  self.json = {};
  self.status = {};
  self.logins = {};

  
  self.on('mount', function() {
		riot.control.on(riot.EVT.accountStore.out.externalLoginsComplete,
			self._onExternalLoginsComplete);
    riot.control.on(riot.EVT.accountStore.out.removeExternalLoginComplete,
      self._onFetchNewInfo);

		self._onFetchNewInfo();
    })

	self.on('unmount', function() {
		riot.control.off(riot.EVT.accountStore.out.externalLoginsComplete,
			self._onExternalLoginsComplete);
    riot.control.off(riot.EVT.accountStore.out.removeExternalLoginComplete,
      self._onFetchNewInfo);
    })

  self.onAddLoginProvider = (evt) =>{
    let url = '/Manage/RiotLinkLogin?provider=' + evt.item.login.authenticationScheme;
    riot.control.trigger(riot.EVT.accountStore.in.redirect,url);
    }

  self.onRemoveExternalLogin = (evt) =>{
    riot.control.trigger(riot.EVT.accountStore.in.removeExternalLogin,evt.item.login);
    }

  self._onFetchNewInfo = () =>{
    riot.control.trigger(riot.EVT.accountStore.in.externalLogins);
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