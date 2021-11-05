import * as React from 'react';
import ViewAll from "./view_all";  // 追加することで<Sample />が利用できる
import ViewOne from "./view_one";  // 追加することで<Sample />が利用できる
import Button from 'react-bootstrap/Button';

function App() {
  return (
    <>
      <h1>今日の星座占い</h1>
      <div className="card">
        <div className="card-body">
          <p>bootstrap</p>
          <Button variant="outline-primary">プライマリーボタン</Button>
        </div>
      </div>
    </>
  );
}

export default App;
