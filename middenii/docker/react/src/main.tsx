import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { SampleComponent } from './sample-component';

class App extends React.Component {
  render() {
    return (
      <div>
        <h1>React Example</h1>
        <SampleComponent name="Counter"/>
        <button type="button" className="btn btn-primary">Primary</button>
      </div>
    );
  }
}

ReactDOM.render(<App/>, document.querySelector('#app'));