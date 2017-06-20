import '../components/validation-summary.tag'
<manage-external-logins>
<h2>Manage your external logins.</h2>


<div if={logins.manageLoginsViewModel}>
    <validation-summary status={ status }></validation-summary>
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
              
              <td>
                <button  class="btn btn-default" 
                                onclick="{parent.onLinkLogin}"
                                title="Log in using your {login.authenticationScheme} account">{login.displayName}</button>
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
 
  self.json = {};
  self.status = {};
  self.logins = {};

  
  self.on('mount', function() {

    let q = riot.route.query();
    let errors = q.errors;
    
    if (errors) {
      self.status.errors = window.$.parseJSON(errors);
    }

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
  self.onLinkLogin = (evt) =>{
        let item = evt.item;
        let antiForgeryToken = riot.Cookies.get('XSRF-TOKEN');
        let body = {
          __RequestVerificationToken:antiForgeryToken,
          provider:item.login.authenticationScheme
        };
        riot.control.trigger(riot.EVT.accountStore.in.postForm,'/Manage/RiotLinkLogin',body);
    }
 
</script>
</manage-external-logins>