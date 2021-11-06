import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { SampleComponent } from './sample-component';

class App extends React.Component {
  render() {
    return (
      <>
        <h1>今日の星座占い</h1>
      </>
    );
  }
}

ReactDOM.render(<App/>, document.querySelector('#app'));