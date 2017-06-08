import DeepFreeze from '../p7-host-core/utils/deep-freeze.js';

class Constants {}
Constants.NAME = 'account-store';
Constants.NAMESPACE = Constants.NAME + ':';
Constants.WELLKNOWN_EVENTS = {
  in: {
    login: Constants.NAMESPACE + 'login',
    loginResult: Constants.NAMESPACE + 'login-result'
  },
  out: {
    loginComplete: Constants.NAMESPACE + 'login-complete'
  }
};
DeepFreeze.freeze(Constants);

export default class AccountStore {
  static get constants() {
    return Constants;
  }
  constructor() {
	var self = this;
	riot.observable(this);
	self._bound = false;
	self.bindEvents();
  }

	bindEvents() {
		if (this._bound === false) {
		  this.on(Constants.WELLKNOWN_EVENTS.in.login, this._onLogin);
		  this.on(Constants.WELLKNOWN_EVENTS.in.loginResult, this._onLoginResult);
		  this._bound = !this._bound;
		}
	}
	unbindEvents() {
		if (this._bound === true) {
		  this.off(Constants.WELLKNOWN_EVENTS.in.login, this._onLogin);
		  this.off(Constants.WELLKNOWN_EVENTS.in.loginResult, this._onLoginResult);
		  this._bound = !this._bound;
		}
	}

  _onLogin(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.login, body);
   
    let url = '/Account/LoginJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.loginResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method:'POST',body:body}, myAck);
  }
  _onLoginResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.loginResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'login1234'});
    } else {
      this.trigger(Constants.WELLKNOWN_EVENTS.out.loginComplete);
    }
  }
}

