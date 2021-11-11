const path = require("path");

module.exports = {
  mode: "development",
  entry: "./src/index.tsx",
  output: {
    filename: "index.js",
    path: path.resolve("dist"),
    publicPath: "/"
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader"
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"]
      }
    ]
  },
  resolve: {
    extensions: [".ts", ".tsx", ".js", ".json"]
  },
	devServer: {
    static: {
      directory: path.join(__dirname, "dist"),
    },
    historyApiFallback: true,
    allowedHosts: 'all',
    port: 3000,      
    proxy: {
      '/frontend': {
        target: 'http://frontend:3000',
        pathRewrite: {'^/frontend' : ''}
      },
      '/backend': {
        target: 'http://backend:8000',
        pathRewrite: {'^/backend' : ''}
      }
    }
	}
};