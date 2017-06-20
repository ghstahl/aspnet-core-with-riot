import {DeepFreeze, StoreBase} from 'p7-riotjs-host/lib/P7HostCore.js';

class Constants {}
Constants.NAME = 'account-store';
Constants.NAMESPACE = Constants.NAME + ':';
Constants.WELLKNOWN_EVENTS = {
  in: {
    removeExternalLogin: Constants.NAMESPACE + 'remove-external-login',
    removeExternalLoginResult: Constants.NAMESPACE + 'remove-external-login-result',
    externalLogins: Constants.NAMESPACE + 'external-logins',
    externalLoginsResult: Constants.NAMESPACE + 'external-logins-result',
    changePassword: Constants.NAMESPACE + 'change-password',
    changePasswordResult: Constants.NAMESPACE + 'change-password-result',
    enableTwoFactor: Constants.NAMESPACE + 'enable-two-factor',
    enableTwoFactorResult: Constants.NAMESPACE + 'enable-two-factor-result',
    removePhoneNumber: Constants.NAMESPACE + 'remove-phone-number',
    removePhoneNumberResult: Constants.NAMESPACE + 'remove-phone-number-result',
    verifyPhoneNumber: Constants.NAMESPACE + 'verify-phone-number',
    verifyPhoneNumberResult: Constants.NAMESPACE + 'verify-phone-number-result',
    manageAddPhone: Constants.NAMESPACE + 'manage-add-phone',
    manageAddPhoneResult: Constants.NAMESPACE + 'manage-add-phone-result',
    userManageInfo: Constants.NAMESPACE + 'user-manage-info',
    userManageInfoResult: Constants.NAMESPACE + 'user-manage-info-result',
    postForm: Constants.NAMESPACE + 'post-form',
    redirect: Constants.NAMESPACE + 'redirect',
    loginInfo: Constants.NAMESPACE + 'login-info',
    loginInfoResult: Constants.NAMESPACE + 'login-info-result',
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
    removeExternalLoginComplete: Constants.NAMESPACE + 'remove-external-login-complete',
    externalLoginsComplete: Constants.NAMESPACE + 'external-logins-complete',
    changePasswordComplete: Constants.NAMESPACE + 'change-password-complete',
    enableTwoFactorComplete: Constants.NAMESPACE + 'enable-two-factor-complete',
    removePhoneNumberComplete: Constants.NAMESPACE + 'remove-phone-number-complete',
    verifyPhoneNumberComplete: Constants.NAMESPACE + 'verify-phone-number-complete',
    userManageInfoComplete: Constants.NAMESPACE + 'user-manage-info-complete',
    loginInfoComplete: Constants.NAMESPACE + 'login-info-complete',
    loginComplete: Constants.NAMESPACE + 'login-complete',
    forgotComplete: Constants.NAMESPACE + 'forgot-complete',
    resetComplete: Constants.NAMESPACE + 'reset-complete',
    registerComplete: Constants.NAMESPACE + 'register-complete',
    sendVerificationCodeComplete: Constants.NAMESPACE + 'send-verification-code-complete',
    verifyCodeComplete: Constants.NAMESPACE + 'verify-code-complete',
    manageAddPhoneComplete: Constants.NAMESPACE + 'manage-add-phone-complete'
  }
};
DeepFreeze.freeze(Constants);

export default class AccountStore extends StoreBase {
  static get constants() {
    return Constants;
  }
  constructor() {
    super();
    riot.observable(this);
    this._bound = false;
    this.riotHandlers = [
      {event: Constants.WELLKNOWN_EVENTS.in.removeExternalLogin, handler: this._onRemoveExternalLogin},
      {event: Constants.WELLKNOWN_EVENTS.in.removeExternalLoginResult, handler: this._onRemoveExternalLoginResult},
      {event: Constants.WELLKNOWN_EVENTS.in.externalLogins, handler: this._onExternalLogins},
      {event: Constants.WELLKNOWN_EVENTS.in.externalLoginsResult, handler: this._onExternalLoginsResult},
      {event: Constants.WELLKNOWN_EVENTS.in.changePassword, handler: this._onChangePassword},
      {event: Constants.WELLKNOWN_EVENTS.in.changePasswordResult, handler: this._onChangePasswordResult},
      {event: Constants.WELLKNOWN_EVENTS.in.enableTwoFactor, handler: this._onEnableTwoFactor},
      {event: Constants.WELLKNOWN_EVENTS.in.enableTwoFactorResult, handler: this._onEnableTwoFactorResult},
      {event: Constants.WELLKNOWN_EVENTS.in.removePhoneNumber, handler: this._onRemovePhoneNumber},
      {event: Constants.WELLKNOWN_EVENTS.in.removePhoneNumberResult, handler: this._onRemovePhoneNumberResult},
      {event: Constants.WELLKNOWN_EVENTS.in.verifyPhoneNumber, handler: this._onVerifyPhoneNumber},
      {event: Constants.WELLKNOWN_EVENTS.in.verifyPhoneNumberResult, handler: this._onVerifyPhoneNumberResult},
      {event: Constants.WELLKNOWN_EVENTS.in.manageAddPhone, handler: this._onManageAddPhone},
      {event: Constants.WELLKNOWN_EVENTS.in.manageAddPhoneResult, handler: this._onManageAddPhoneResult},
      {event: Constants.WELLKNOWN_EVENTS.in.userManageInfo, handler: this._onUserManageInfo},
      {event: Constants.WELLKNOWN_EVENTS.in.userManageInfoResult, handler: this._onUserManageInfoResult},
      {event: Constants.WELLKNOWN_EVENTS.in.postForm, handler: this._onPostForm},
      {event: Constants.WELLKNOWN_EVENTS.in.redirect, handler: this._onRedirect},
      {event: Constants.WELLKNOWN_EVENTS.in.loginInfo, handler: this._onLoginInfo},
      {event: Constants.WELLKNOWN_EVENTS.in.loginInfoResult, handler: this._onLoginInfoResult},
      {event: Constants.WELLKNOWN_EVENTS.in.login, handler: this._onLogin},
      {event: Constants.WELLKNOWN_EVENTS.in.loginResult, handler: this._onLoginResult},
      {event: Constants.WELLKNOWN_EVENTS.in.forgot, handler: this._onForgot},
      {event: Constants.WELLKNOWN_EVENTS.in.forgotResult, handler: this._onForgotResult},
      {event: Constants.WELLKNOWN_EVENTS.in.register, handler: this._onRegister},
      {event: Constants.WELLKNOWN_EVENTS.in.registerResult, handler: this._onRegisterResult},
      {event: Constants.WELLKNOWN_EVENTS.in.reset, handler: this._onReset},
      {event: Constants.WELLKNOWN_EVENTS.in.resetResult, handler: this._onResetResult},
      {event: Constants.WELLKNOWN_EVENTS.in.sendVerificationCode, handler: this._onSendVerificationCode},
      {event: Constants.WELLKNOWN_EVENTS.in.sendVerificationCodeResult, handler: this._onSendVerificationCodeResult},
      {event: Constants.WELLKNOWN_EVENTS.in.verifyCode, handler: this._onVerifyCode},
      {event: Constants.WELLKNOWN_EVENTS.in.verifyCodeResult, handler: this._onVerifyCodeResult}
    ];
    this.bindEvents();
  }

  _onPostForm(path, params, method) {
    let $ = window.$;

    method = method || 'post'; // Set method to post by default, if not specified.

    let form = $(document.createElement('form'))
                .attr({'method': method, 'action': path});

    $.each(params, function (key, value) {
      $.each(value instanceof Array ? value : [value], function (i, val) {
        $(document.createElement('input'))
          .attr({ 'type': 'hidden', 'name': key, 'value': val })
          .appendTo(form);
      });
    });

    form.appendTo(document.body).submit();

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
      riot.state.verifyCode.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.verifyCodeComplete);
    }
  }
  _onLoginInfo(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.loginInfo, body);

    riot.state.loginInfo = {};
    let url = '/Account/InfoJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.loginInfoResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, null, myAck);
  }

  _onLoginInfoResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.loginInfoResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'loginInfo-1234'});
    } else {
      riot.state.loginInfo.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.loginInfoComplete);
    }
  }

  _onUserManageInfo(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.userManageInfo, body);

    riot.state.manage = {};
    let url = '/Manage/InfoJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.userManageInfoResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, null, myAck);
  }

  _onUserManageInfoResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.userManageInfoResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'userManageInfo-1234'});
    } else {
      riot.state.manage.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.userManageInfoComplete);
    }
  }

  _onManageAddPhone(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.manageAddPhone, body);

    riot.state.manage = {};
    let url = '/Manage/AddPhoneNumberJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.manageAddPhoneResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onManageAddPhoneResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.manageAddPhoneResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'manageAddPhone-1234'});
    } else {
      riot.state.manageAddPhone.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.manageAddPhoneComplete);
    }
  }

  _onVerifyPhoneNumber(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.verifyPhoneNumber, body);

    riot.state.manage = {};
    let url = '/Manage/VerifyPhoneNumberJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.verifyPhoneNumberResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body}, myAck);
  }

  _onVerifyPhoneNumberResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.verifyPhoneNumberResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'verifyPhoneNumber-1234'});
    } else {
      riot.state.verifyPhoneNumber.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.verifyPhoneNumberComplete);
    }
  }

  _onRemovePhoneNumber(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.removePhoneNumber, body);

    let url = '/Manage/RemovePhoneNumberJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.removePhoneNumberResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST' }, myAck);
  }

  _onRemovePhoneNumberResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.removePhoneNumberResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'removePhoneNumber-1234'});
    } else {
      this.trigger(Constants.WELLKNOWN_EVENTS.out.removePhoneNumberComplete);
    }
  }
  _onEnableTwoFactor(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.enableTwoFactor, body);

    let url = '/Manage/EnableTwoFactorAuthenticationJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.enableTwoFactorResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body }, myAck);
  }

  _onEnableTwoFactorResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.enableTwoFactorResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'enableTwoFactor-1234'});
    } else {
      this.trigger(Constants.WELLKNOWN_EVENTS.out.enableTwoFactorComplete);
    }
  }
  _onChangePassword(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.changePassword, body);

    riot.state.changePassword = {};
    let url = '/Manage/ChangePasswordJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.changePasswordResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body }, myAck);
  }

  _onChangePasswordResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.changePasswordResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'changePassword-1234'});
    } else {
      riot.state.changePassword.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.changePasswordComplete);
    }
  }
  _onExternalLogins(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.externalLogins, body);

    riot.state.changePassword = {};
    let url = '/Manage/ManageLoginsJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.externalLoginsResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'GET' }, myAck);
  }

  _onExternalLoginsResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.externalLoginsResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'externalLogins-1234'});
    } else {
      riot.state.manageLogins.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.externalLoginsComplete);
    }
  }
  _onRemoveExternalLogin(body) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.removeExternalLogin, body);

    riot.state.removeExternalLogin = {};
    let url = '/Manage/RemoveLoginJson';
    let myAck = {
      evt: Constants.WELLKNOWN_EVENTS.in.removeExternalLoginResult
    };

    riot.control.trigger(riot.EVT.fetchStore.in.fetch, url, {method: 'POST', body: body }, myAck);
  }

  _onRemoveExternalLoginResult(result, ack) {
    console.log(Constants.NAME, Constants.WELLKNOWN_EVENTS.in.removeExternalLoginResult, result, ack);
    if (result.error || !result.response.ok) {
      riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll, {code: 'removeExternalLogin-1234'});
    } else {
      riot.state.removeExternalLogin.json = result.json;
      this.trigger(Constants.WELLKNOWN_EVENTS.out.removeExternalLoginComplete);
    }
  }

}
