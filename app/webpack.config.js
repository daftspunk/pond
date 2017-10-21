var path = require('path');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
    entry: './src/js/main.js',
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'main.js',
        // publicPath: '/dist'
    },
    module: {
        rules: [
            // {
            //     test: /\.js$/,
            //     exclude: /node_modules/,
            //     use: [
            //         {
            //             loader: 'babel-loader',
            //             options: {
            //                 presets: ['es2015']
            //             }
            //         }
            //     ]
            // },
            {
              test: /\.vue$/,
              loader: 'vue-loader',
              options: {
                loaders: {
                  less: ExtractTextPlugin.extract({
                    use: 'css-loader!less-loader',
                    fallback: 'vue-style-loader' // <- this is a dep of vue-loader, so no need to explicitly install if using npm3
                  })
                },
                extractCSS: true
              }
            },
            // {
            //   test: /\.less$/,
            //   loader: 'style-loader!css-loader!less-loader'
            // }
            /*
            ,
            {
                test: /\.html$/,
                use: ['html-loader']
            }*/
        ]
    },
    node: {
      child_process: 'empty',
     'fs': 'empty',
     'net': 'empty',
     'tls': 'empty',
     'dns': 'empty'
    },
    plugins: [
        new ExtractTextPlugin("main.css")
    ]
};