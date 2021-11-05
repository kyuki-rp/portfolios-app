import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { SampleComponent } from './sample-component';

class App extends React.Component {
  render() {
    return (
      <ViewOne />
      <ViewAll />
    );
  }
}

ReactDOM.render(<App/>, document.querySelector('#app'));