
import * as React from "react";
import axios from "axios";


interface Props {}
interface State {
  status: string,
  your_zodiac_sign: string,
  description: string,
  star: string
}

class ViewOne extends React.Component<Props, State> {
  constructor(props) {
    super(props);
    this.state = {status:'yet', your_zodiac_sign:'', description:'', star:''};
  };

  handleChange = event => {
    this.setState({your_zodiac_sign: event.target.value});
  }

  handleSubmit = event => {
    event.preventDefault();

    axios
     .post("https://works.middenii.com/zodiac-api/view_one", {"your_zodiac_sign": this.state.your_zodiac_sign})
      .then(res => {
          this.setState({status:res.data.status, description:res.data.description, star:res.data.star});
        })
      .catch(err =>{
        console.log(err);
      });
  };

  render() {
    return (

        <body> 
          {this.state.status == "yet" ?
            <form onSubmit={this.handleSubmit} className="d-flex align-items-center justify-content-center">
              <div className="justify-content-center">
              {/* <input type="text" name="your_zodiac_sign" onChange={this.handleChange}/> */}
              <select className="selectpicker mx-1" onChange={this.handleChange}>
                <option value="">選択してください</option>
                <option value="おひつじ座">おひつじ座</option>
                <option value="おうし座">おうし座</option>
                <option value="ふたご座">ふたご座</option>
                <option value="かに座">かに座</option>
                <option value="しし座">しし座</option>
                <option value="おとめ座">おとめ座</option>
                <option value="てんびん座">てんびん座</option>
                <option value="さそり座">さそり座</option>
                <option value="いて座">いて座</option>
                <option value="やぎ座">やぎ座</option>
                <option value="みずがめ座">みずがめ座</option>
                <option value="うお座">うお座</option>
              </select>
              <button type="submit" className="btn btn-outline-secondary btn-sm mx-1">POST</button>
              </div>

            </form>
            
          :
            <>
            <p className="text-center text-primary display-2">{this.state.description}</p>
            <p className="text-center text-primary display-2">{this.state.star}</p>
            </>
          }
        </body>
     
    );
  }
}

export default ViewOne;
