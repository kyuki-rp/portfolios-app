
import React from "react";
import axios from "axios";

// const res = axios.get('http://localhost:8000/')

class ViewAll extends React.Component {
  constructor(props) {
    super(props);
    this.state = {status:'yet', res :[]};
  };

  handleClick = () => {
    axios
     .get("http://localhost:8000/view_all")
      .then(res => {
          this.setState({status:res.data.status, res:res.data.main});
        })
      .catch(err =>{
        console.log(err);
      });
  };

  render() {
    return (
        <body className="mx-auto">
          {this.state.status == "yet" ?
            <div className="d-flex align-items-center justify-content-center">
            <button type="button" className="btn btn-secondary mt-5" onClick={this.handleClick}>結果一覧を表示</button>
            </div>
          :
            <table className="table table-striped caption-top">
                <caption class="h2">結果一覧</caption>
                <thead>
                <tr>
                    <th scope="col">順位</th>
                    <th scope="col">星座</th>
                    <th scope="col">スコア</th>
                    <th scope="col">評価</th>
                </tr>
                </thead>
                <tbody>
                    {
                    this.state.res.map(item => (
                        <tr>
                        <th scope="row">{item.rank}</th>
                        <td>{item.zodiac_sign}</td>
                        <td>{item.score}</td>
                        <td>{item.star}</td>
                        </tr>
                    ))
                    }
                </tbody>
            </table>
          }
        </body>
     
    );
  }
}

export default ViewAll;
