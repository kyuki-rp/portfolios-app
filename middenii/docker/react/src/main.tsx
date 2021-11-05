import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { SampleComponent } from './sample-component';
import Button from 'react-bootstrap/Button';

class App extends React.Component {
  render() {
    return (
      <div>
        <h1>React Example</h1>
        <SampleComponent name="Counter"/>
        <div className="card">
          <div className="card-body">
            <Button variant="outline-primary">プライマリーボタン</Button>
          </div>
        </div>
      </div>
    );
  }
}

ReactDOM.render(<App/>, document.querySelector('#app'));