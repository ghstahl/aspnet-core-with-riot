import										'riot';
import './css/index.css';
import TypicodeUserStore 			from 	'./stores/typicode-user-store.js';
import RouteContributer 		from 	'./route-contributer.js';

let rcs = new RouteContributer();
let registerRecord = {
  name: 'typicode-component',
  stores: [
		{store: new TypicodeUserStore()}
  ],
  registrants: {
    routeContributer: rcs
  },
  postLoadEvents: [
		{event: 'typicode-init', data: {}}
  ]
};

riot.control.trigger('plugin-registration', registerRecord);

