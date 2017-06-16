
import './pages/login.tag';
import './pages/register.tag';
import './pages/riotjs.tag';
import './pages/error.tag';
import './pages/forgot.tag';
import './pages/forgot-confirmation.tag';
import './pages/reset-password.tag';
import './pages/send-verification-code.tag';
import './pages/verify-code.tag';
import './pages/manage.tag';
import './pages/manage-change-phone.tag';
import './pages/manage-add-phone.tag';
import './pages/verify-phone-number.tag';
import './pages/change-password.tag';
import './pages/manage-external-logins.tag';

export default class RouteContributer {
  constructor() {
    riot.observable(this);
    this.name = 'RouteContributer';
    this._initializeViewSet();
  }

  _initializeViewSet() {
    this.defaultRoute = '/account/login?returnurl=%2F';
    this._viewsSet = new Set();

    let s = this._viewsSet;

    s.add('login');
    s.add('register');
    s.add('forgot');
    s.add('forgot-confirmation');
    s.add('reset-password');
    s.add('send-verification-code');
    s.add('verify-code');
    s.add('manage');
    s.add('manage-change-phone');
    s.add('manage-add-phone');
    s.add('verify-phone-number');
    s.add('change-password');
    s.add('manage-external-logins');
    s.add('riotjs');

    this.views = Array.from(s);

  }

  contributeRoutes(r) {
    var self = this;

    console.log(self.name, riot.EVT.router.out.contributeRoutes, r);

    // http://localhost:41749/riotaccount/login#account/login?returnurl=%2Fabout
    r('/account/login?returnurl=*', function (returnUrl) {
      console.log('/account/login?returnurl=*: ' + returnUrl);
      let view = 'login';

      riot.state.account.returnUrl = decodeURIComponent(returnUrl);

      riot.control.trigger(riot.EVT.routeStore.in.riotRouteLoadView, view);
    });
    // http://localhost:41749/riotaccount/register#account/register?returnurl=%2Fabout
    r('/account/register?returnurl=*', function (returnUrl) {
      console.log('/account/register?returnurl=*: ' + returnUrl);
      let view = 'register';

      riot.state.account.returnUrl = decodeURIComponent(returnUrl);
      riot.control.trigger(riot.EVT.routeStore.in.riotRouteLoadView, view);
    });

    // http://localhost:41749/riotaccount#account/reset-password?userid={id}&code={code}&
    r('/account/reset-password..', function () {
      let q = riot.route.query();
      let userid = q.userid;
      let code = q.code;
      let view = 'reset-password';

      console.log('/account/reset-password..:', userid, code);

      riot.state.resetPassword.userid = userid;
      riot.state.resetPassword.code = code;
      riot.control.trigger(riot.EVT.routeStore.in.riotRouteLoadView, view);
    });

    r('/account/*', (name)=>{
      console.log('route handler of /account/' + name);
      let view = name;

      if (self.views.indexOf(view) === -1) {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch, self.defaultRoute);
      } else {
        riot.control.trigger(riot.EVT.routeStore.in.riotRouteLoadView, view);
      }
    });

    r('/account..', ()=>{
      console.log('route handler of /account');
      riot.control.trigger(riot.EVT.routeStore.in.routeDispatch, self.defaultRoute);
    });

    r('/error..', ()=>{
      console.log('route handler of /error..');
      riot.control.trigger(riot.EVT.routeStore.in.riotRouteLoadView, 'error');
    });
  }
}
