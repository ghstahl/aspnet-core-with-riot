import DeepFreeze from '../p7-host-core/utils/deep-freeze.js';

class Constants {}
Constants.NAME = 'account-store';
Constants.NAMESPACE = Constants.NAME + ':';
Constants.WELLKNOWN_EVENTS = {
  in: {
    redirect: Constants.NAMESPACE + 'redirect',
    login: Constants.NAMESPACE + 'login',
    loginResult: Constants.NAMESPACE + 'login-result',
    forgot: Constants.NAMESPACE + 'forgot',
    forgotResult: Constants.NAMESPACE + 'forgot-result',
    reset: Constants.NAMESPACE + 'reset',
    resetResult: Constants.NAMESPACE + 'reset-result',
    register: Constants.NAMESPACE + 'register',
    registerResult: Constants.NAMESPACE + 'register-result',
    sendVerificationCode: Constants.NAMESPACE + 'send-verification-code',
    sendVerificationCodeResult: Constants.NAMESPACE + 'send-verification-code-result',
    verifyCode: Constants.NAMESPACE + 'verifyCode',
    verifyCodeResult: Constants.NAMESPACE + 'verifyCode-result'
  },
  out: {
    loginComplete: Constants.NAMESPACE + 'login-complete',
    forgotComplete: Constants.NAMESPACE + 'forgot-complete',
    resetComplete: Constants.NAMESPACE + 'reset-complete',
    registerComplete: Constants.NAMESPACE + 'register-complete',
    sendVerificationCodeComplete: Constants.NAMESPACE + 'send-verification-code-complete',
    verifyCodeComplete: Constants.NAMESPACE + 'verify-code-complete'
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
      this.on(Constants.WELLKNOWN_EVENTS.in.redirect, this._onRedirect);
      this.on(Constants.WELLKNOWN_EVENTS.in.login, this._onLogin);
      this.on(Constants.WELLKNOWN_EVENTS.in.loginResult, this._onLoginResult);
      this.on(Constants.WELLKNOWN_EVENTS.in.forgot, this._onForgot);
      this.on(Constants.WELLKNOWN_EVENTS.in.forgotResult, this._onForgotResult);
      this.on(Constants.WELLKNOWN_EVENTS.in.register, this._onRegister);
      this.on(Constants.WELLKNOWN_EVENTS.in.registerResult, this._onRegisterResult);
      this.on(Constants.WELLKNOWN_EVENTS.in.reset, this._onReset);
      this.on(Constants.WELLKNOWN_EVENTS.in.resetResult, this._onResetResult);
      this.on(Constants.WELLKNOWN_EVENTS.in.sendVerificationCode, this._onSendVerificationCode);
      this.on(Constants.WELLKNOWN_EVENTS.in.sendVerificationCodeResult, this._onSendVerificationCodeResult);
      this.on(Constants.WELLKNOWN_EVENTS.in.verifyCode, this._onVerifyCode);
      this.on(Constants.WELLKNOWN_EVENTS.in.verifyCodeResult, this._onVerifyCodeResult);
      this._bound = !this._bound;
    }
  }
  unbindEvents() {
    if (this._bound === true) {
      this.off(Constants.WELLKNOWN_EVENTS.in.redirect, this._onRedirect);
      this.off(Constants.WELLKNOWN_EVENTS.in.login, this._onLogin);
      this.off(Constants.WELLKNOWN_EVENTS.in.loginResult, this._onLoginResult);
      this.off(Constants.WELLKNOWN_EVENTS.in.forgot, this._onForgot);
      this.off(Constants.WELLKNOWN_EVENTS.in.forgotResult, this._onForgotResult);
      this.off(Constants.WELLKNOWN_EVENTS.in.register, this._onRegister);
      this.off(Constants.WELLKNOWN_EVENTS.in.registerResult, this._onRegisterResult);
      this.off(Constants.WELLKNOWN_EVENTS.in.reset, this._onReset);
      this.off(Constants.WELLKNOWN_EVENTS.in.resetResult, this._onResetResult);
      this.off(Constants.WELLKNOWN_EVENTS.in.sendVerificationCode, this._onSendVerificationCode);
      this.off(Constants.WELLKNOWN_EVENTS.in.sendVerificationCodeResult, this._onSendVerificationCodeResult);
      this.off(Constants.WELLKNOWN_EVENTS.in.verifyCode, this._onVerifyCode);
      this.off(Constants.WELLKNOWN_EVENTS.in.verifyCodeResult, this._onVerifyCodeResult);
      this._bound = !this._bound;
    }
  }

  _onRedirect(url) {
    window.$(location).attr('href', url);
  }

  _redirect() {
    let returnUrl = '/';

    if (riot.state.account.returnUrl) {
      returnUrl = riot.state.account.returnUrl;
    }
    riot.state.account.returnUrl = undefined;
    this._onRedirect(returnUrl);
  }

  _onLogin(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.login, body);

    let url = '/Account/LoginJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.loginResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onLoginResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.loginResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'login1234'});
    } else {
      riot.state.login.status = result.json.status;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.loginComplete);
    }
  }

  _onForgot(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.login, body);

    let url = '/Account/ForgotPasswordJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.forgotResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onForgotResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.forgotResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'forgot1234'});
    } else {
      riot.state.forgot.status = result.json.status;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.forgotComplete);
    }
  }

  _onRegister(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.register, body);

    riot.state.register = {status: {}};
    let url = '/Account/RegisterJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.registerResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onRegisterResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.registerResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'register1234'});
    } else {
      if (result.json.status.ok) {
        riot.state.register = {};
        this._redirect();
      } else {
        riot.state.register.status = result.json.status;
        this.trigger(Constants.WELLKNOWN_EVENTS.out.registerComplete);
      }
    }
  }

  _onReset(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.reset, body);

    let url = '/Account/ResetPasswordJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.resetResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onResetResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.resetResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'register1234'});
    } else {
      if (result.json.status.ok) {
        riot.state.resetPassword = {};
        this._redirect();
      } else {
        riot.state.resetPassword.status = result.json.status;
        this.trigger(Constants.WELLKNOWN_EVENTS.out.resetComplete);
      }
    }
  }

  _onSendVerificationCode(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.sendVerificationCode, body);

    riot.state.verificationCode = {};
    let url = '/Account/SendCodeJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.sendVerificationCodeResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onSendVerificationCodeResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.sendVerificationCodeResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'sendVerificationCode1234'});
    } else {
      riot.state.verificationCode.status = result.json.status;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.sendVerificationCodeComplete);
    }
  }
  _onVerifyCode(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.verifyCode, body);

    riot.state.verifyCode = {};
    let url = '/Account/VerifyCodeJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.verifyCodeResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onVerifyCodeResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.verifyCodeResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'verifyCode-1234'});
    } else {
      riot.state.verifyCode.status = result.json.status;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.verifyCodeComplete);
    }
  }
}
