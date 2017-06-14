
import './css/index.css';
import './components/my-next-startup.tag';
import './app.tag';
import 'bootstrap-validator';
import P7HostCore from 'p7-riotjs-host/lib/P7HostCore.js';

let p7HostCore = new P7HostCore(riot);

p7HostCore.Initialize();
riot.state.route.defaultRoute = '/account';
riot.state.sidebar = {
  touch: 0,
  items: [
      { title: 'Account', route: '/account'},
      { title: 'Projects', route: '/main/projects'}
  ]
};

riot.state.account = {};
riot.state.login = {};
riot.state.forgot = {};
riot.state.resetPassword = {};
riot.state.register = {};
riot.state.verificationCode = {};
riot.state.verifyCode = {};
riot.state.manage = {};
riot.state.manageAddPhone = {};
riot.state.verifyPhoneNumber = {};

// Add the mixings
// //////////////////////////////////////////////////////
import OptsMixin from './mixins/opts-mixin.js';
riot.mixin('opts-mixin', OptsMixin);
import FormsMixin from './mixins/forms-mixin.js';
riot.mixin('forms-mixin', FormsMixin);

// Add the stores
// //////////////////////////////////////////////////////

import NextConfigStore from './stores/next-config-store.js';
riot.EVT.nextConfigStore = NextConfigStore.constants.WELLKNOWN_EVENTS;
let nextConfigStore = new NextConfigStore();

import AccountStore from './stores/account-store.js';
riot.EVT.accountStore = AccountStore.constants.WELLKNOWN_EVENTS;
let accountStore = new AccountStore();

import SidebarStore from './stores/sidebar-store.js';
let sidebarStore = new SidebarStore();

riot.control.addStore(nextConfigStore);
riot.control.addStore(sidebarStore);
riot.control.addStore(accountStore);

riot.mount('startup');
