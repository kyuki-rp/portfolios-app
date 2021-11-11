import React from 'react';
import ReactDOM from 'react-dom';
// import './index.css';
import App from './main';
import 'bootstrap/dist/css/bootstrap.min.css';
import createBrowserHistory from 'history/createBrowserHistory';
                                                                                const history = createBrowserHistory({ basename: '/frontend' }); // 追加
ReactDOM.render(
  <React.StrictMode>
    <ConnectedRouter history={history}>
      <App />
    </ConnectedRouter>
  </React.StrictMode>,
  document.getElementById('root')
);