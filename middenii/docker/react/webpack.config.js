const path = require("path");

module.exports = {
  mode: "development",
  entry: "./src/main.tsx",
  output: {
    filename: "index.js",
    path: path.resolve("dist"),
    publicPath: "/frontend",
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
    historyApiFallback: {
      index: '/frontend/'
    },
    allowedHosts: 'all',
    port: 3000
	}
};