import * as React from 'react';
import * as ReactDOM from 'react-dom';
// import { BrowserRouter } from 'react-router-dom';
import { Router } from 'react-router-dom'
// import './index.css';
import App from './main';
import 'bootstrap/dist/css/bootstrap.min.css';

ReactDOM.render(
  <React.StrictMode>
        <App />
  </React.StrictMode>,
  document.querySelector('#app')
);