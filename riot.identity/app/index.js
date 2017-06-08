

import './css/index.css';
import './components/my-next-startup.tag';
import './app.tag';
import 'bootstrap-validator';
import P7HostCore from 'p7-riotjs-host/lib/P7HostCore.js';


let p7HostCore = new P7HostCore(riot);

p7HostCore.Initialize();
riot.state.route.defaultRoute = '/main/home';
riot.state.sidebar = {
  touch: 0,
  items: [
      { title: 'Home', route: '/main/home'},
      { title: 'Projects', route: '/main/projects'}
  ]
};

// Add the mixings
// //////////////////////////////////////////////////////
import OptsMixin from './mixins/opts-mixin.js';
riot.mixin('opts-mixin', OptsMixin);

// Add the stores
// //////////////////////////////////////////////////////

import NextConfigStore from './stores/next-config-store.js';
riot.EVT.nextConfigStore = NextConfigStore.constants.WELLKNOWN_EVENTS;
let nextConfigStore = new NextConfigStore();

import AccountStore from './stores/account-store.js';
riot.EVT.accountStore = AccountStore.constants.WELLKNOWN_EVENTS;
let accountStore = new AccountStore();

import SidebarStore         from './stores/sidebar-store.js';
let sidebarStore = new SidebarStore();

riot.control.addStore(nextConfigStore);
riot.control.addStore(sidebarStore);
riot.control.addStore(accountStore);

riot.mount('startup');