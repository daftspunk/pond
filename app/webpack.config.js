var path = require('path')
var webpack = require('webpack')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var HtmlWebpackPlugin = require('html-webpack-plugin')
// var CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = {
    entry: [
        './src/js/main.js',
        './src/stylesheets/main.less'
    ],
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'main.js'
        // publicPath: '/dist'
    },
    module: {
        rules: [
            {
                test: /\.(png|jpe?g|gif|svg|woff|woff2|ttf|eot|ico)$/,
                loader: 'file-loader?name=assets/[name].[ext]'
            },
            {
                test: /\.less$/,
                exclude: /node_modules/,
                loader: ['style-loader', 'css-loader', 'less-loader']
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: [
                    {
                        loader: 'babel-loader',
                        options: {
                            presets: ['es2015']
                        }
                    }
                ]
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                use: ['html-loader']
            },
            {
                test: /\.node$/,
                loader: 'node-loader'
            },
            {
                test: /\.vue$/,
                exclude: /node_modules/,
                use: {
                    loader: 'vue-loader',
                    options: {
                        extractCSS: true,
                        less: ExtractTextPlugin.extract({
                            use: 'css-loader!less-loader',
                            fallback: 'vue-style-loader' // <- this is a dep of vue-loader, so no need to explicitly install if using npm3
                        })
                    }
                }
            },
        ]
    },
    plugins: [
        new webpack.ExternalsPlugin('commonjs', [
            'child_process',
            'electron',
            'process',
            'request',
            'https',
            'https',
            'http',
            'ssh2',
            'os',
            'fs'
        ]),
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery'
        }),
        new HtmlWebpackPlugin({
            template: 'src/index.html'
        })
        // ,
        // new CleanWebpackPlugin(['dist'])
    ]
};
