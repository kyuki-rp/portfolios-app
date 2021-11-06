import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { SampleComponent } from './sample-component';
import ViewAll from "./view_all";  // 追加することで<Sample />が利用できる
import ViewOne from "./view_one";  // 追加することで<Sample />が利用できる

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