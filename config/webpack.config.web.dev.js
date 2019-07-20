/* eslint global-require: 0, import/no-dynamic-require: 0 */

/**
 * Build config for web development that uses
 * Hot-Module-Replacement
 */

import path from 'path';
import webpack from 'webpack';
import merge from 'webpack-merge';
import htmlLoader from 'html-loader';
import HtmlWebpackPlugin from 'html-webpack-plugin';
import baseConfig from './webpack.config.base';
import CheckNodeEnv from '../src/release/internals/scripts/CheckNodeEnv';

CheckNodeEnv('development');

const port = process.env.PORT || 1111;
const publicPath = `http://localhost:${port}/`;

export default merge.smart(baseConfig, {
    devtool: 'inline-source-map',

    mode: 'development',

    target: 'web',

    entry: [
        'react-hot-loader/patch',
        `webpack-dev-server/client?${publicPath}`,
        'webpack/hot/only-dev-server',
        path.join(__dirname, '../src/app/index.js')
    ],

    output: {
        path: path.join(__dirname, '..', 'dist'),
        publicPath,
        filename: 'web.dev.js',
        libraryTarget: 'umd'
    },

    module: {
        rules: [
            // Babel loader
            {
                test: /\.jsx?$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        cacheDirectory: true,
                        plugins: [
                            // Here, we include babel plugins that are only required for the
                            // renderer process. The 'transform-*' plugins must be included
                            // before react-hot-loader/babel
                            'transform-class-properties',
                            'transform-es2015-classes',
                            'react-hot-loader/babel',
                        ]
                    }
                }
            },
            // html-loader
            {
                test: /\.(html)$/,
                use: {
                    loader: 'html-loader'
                }
            },
            // css-loader (global)
            {
                test: /\.global\.css$/,
                use: [
                    {
                        loader: 'style-loader'
                    },
                    {
                        loader: 'css-loader',
                        options: {
                            sourceMap: true
                        }
                    }
                ]
            },
            // css-loader (others)
            {
                test: /^((?!\.global).)*\.css$/,
                use: [
                    {
                        loader: 'style-loader'
                    },
                    {
                        loader: 'css-loader',
                        options: {
                            modules: true,
                            sourceMap: true,
                            importLoaders: 1,
                            localIdentName: '[name]__[local]__[hash:base64:5]'
                        }
                    }
                ]
            },
            // SASS support - compile all .global.scss files and pipe it to style.css
            {
                test: /\.global\.(scss|sass)$/,
                use: [
                    {
                        loader: 'style-loader'
                    },
                    {
                        loader: 'css-loader',
                        options: {
                            sourceMap: true
                        }
                    },
                    {
                        loader: 'sass-loader'
                    }
                ]
            },
            // SASS support - compile all other .scss files and pipe it to style.css
            {
                test: /^((?!\.global).)*\.(scss|sass)$/,
                use: [
                    {
                        loader: 'style-loader'
                    },
                    {
                        loader: 'css-loader',
                        options: {
                            modules: true,
                            sourceMap: true,
                            importLoaders: 1,
                            localIdentName: '[name]__[local]__[hash:base64:5]'
                        }
                    },
                    {
                        loader: 'sass-loader'
                    }
                ]
            },
            // WOFF Font
            {
                test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,
                use: {
                    loader: 'url-loader',
                    options: {
                        limit: 10000,
                        mimetype: 'application/font-woff'
                    }
                }
            },
            // WOFF2 Font
            {
                test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/,
                use: {
                    loader: 'url-loader',
                    options: {
                        limit: 10000,
                        mimetype: 'application/font-woff'
                    }
                }
            },
            // TTF Font
            {
                test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
                use: {
                    loader: 'url-loader',
                    options: {
                        limit: 10000,
                        mimetype: 'application/octet-stream'
                    }
                }
            },
            // EOT Font
            {
                test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
                use: 'file-loader'
            },
            // SVG Font
            {
                test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
                use: {
                    loader: 'url-loader',
                    options: {
                        limit: 10000,
                        mimetype: 'image/svg+xml'
                    }
                }
            },
            // Common Image Formats
            {
                test: /\.(?:ico|gif|png|jpg|jpeg|webp)$/,
                use: 'url-loader'
            }
        ]
    },

    plugins: [

        new webpack.HotModuleReplacementPlugin({
            // bug :(
            // du coup il faut relaoder http://localhost:1111/dist#/ manuellement...
            // cf : https://github.com/webpack/webpack/issues/6693
            // multiStep: true
        }),

        new webpack.NoEmitOnErrorsPlugin(),

        /**
         * Create global constants which can be configured at compile time.
         *
         * Useful for allowing different behaviour between development builds and
         * release builds
         *
         * NODE_ENV should be production so that modules do not perform certain
         * development checks
         *
         * By default, use 'development' as NODE_ENV. This can be overriden with
         * 'staging', for example, by changing the ENV variables in the npm scripts
         */
        new webpack.EnvironmentPlugin({
            NODE_ENV: 'development'
        }),

        new webpack.LoaderOptionsPlugin({
            debug: true
        }),

        new HtmlWebpackPlugin({
            hash: true,
            title: 'October Pond',
            myPageHeader: 'Pond',
            template: './src/app/app.web.html',
            filename: 'index.html' // relative to root of the application
        })
    ],

    node: {
        __dirname: false,
        __filename: false
    },

    devServer: {
        open: false,
        openPage: '/dist',
        port,
        publicPath,
        compress: true,
        noInfo: false,
        stats: 'errors-only',
        inline: true,
        lazy: false,
        hot: true,
        headers: { 'Access-Control-Allow-Origin': '*' },
        contentBase: path.join(__dirname, '..', 'dist'),
        watchOptions: {
            aggregateTimeout: 300,
            ignored: /node_modules/,
            poll: 100
        },
        historyApiFallback: {
            verbose: true,
            disableDotRule: false
        },
        before() {
            if (process.env.START_HOT) {
                console.log('Starting Web Process...');
            }
        }
    }
});
