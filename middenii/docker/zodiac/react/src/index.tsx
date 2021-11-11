import * as React from 'react';
import * as ReactDOM from 'react-dom';
// import { BrowserRouter } from 'react-router-dom';
import { Router } from 'react-router-dom'
// import './index.css';
import App from './main';
import 'bootstrap/dist/css/bootstrap.min.css';
import createBrowserHistory from 'history/createBrowserHistory';
const history = createBrowserHistory({ basename: '/frontend' }); // 追加

ReactDOM.render(
  <React.StrictMode>
      <Router history={history}>
        <App />
      </Router>
  </React.StrictMode>,
  document.querySelector('#app')
);