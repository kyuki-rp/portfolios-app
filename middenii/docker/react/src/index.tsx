import * as React from 'react';
import * as ReactDOM from 'react-dom';
// import './index.css';
import App from './App';
import 'bootstrap/dist/css/bootstrap.min.css';
import Button from 'react-bootstrap/Button';

ReactDOM.render(
  <div className="card">
    <div className="card-body">
      <p>bootstrap</p>
      <Button variant="outline-primary">プライマリーボタン</Button>
    </div>
  </div>,
  document.getElementById('root')
);

