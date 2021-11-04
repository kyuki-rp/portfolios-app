import React from 'react';
import ViewAll from "./view_all";  // 追加することで<Sample />が利用できる
import ViewOne from "./view_one";  // 追加することで<Sample />が利用できる

function App() {
  return (
    <>
      <h1>今日の星座占い</h1>
      <ViewOne />
      <ViewAll />
    </>
  );
}

export default App;
