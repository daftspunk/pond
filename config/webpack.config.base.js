/**
 * Base webpack config used across other specific configs
 */

import fs from 'fs';
import path from 'path';
import webpack from 'webpack';
import { dependencies as externals } from '../package.json';

// Find all the dependencies without a `main` property and add them as webpack externals
function filterDepWithoutEntryPoints(dep) {
    // Return true if we want to add a dependency to externals
    try {
        // If the root of the dependency has an index.js, return true
        if (fs.existsSync(path.join(__dirname, `../node_modules/${dep}/index.js`))) {
            return false;
        }
        const pgkString = fs
            .readFileSync(path.join(__dirname, `../node_modules/${dep}/package.json`))
            .toString();
        const pkg = JSON.parse(pgkString);
        const fields = ['main', 'module', 'jsnext:main', 'browser'];
        return !fields.some(field => field in pkg);
    } catch (e) {
        console.log(e);
        return true;
    }
}

function resolve(dir) {
    return path.join(__dirname, '..', dir);
}

export default {
    externals: [
        ...Object.keys(externals || {}).filter(filterDepWithoutEntryPoints)
    ],

    module: {
        rules: [
            {
                test: /\.jsx?$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        cacheDirectory: true
                    }
                }
            }
        ]
    },

    output: {
        path: path.join(__dirname, '../src', 'app'),
        // https://github.com/webpack/webpack/issues/1114
        libraryTarget: 'commonjs2'
    },

    /**
     * Determine the array of extensions that should be used to resolve modules.
     */
    resolve: {
        extensions: ['.js', '.jsx', '.json'],
        alias: {
            '@': resolve('src'),
            '@app': resolve('src/app'),
            '@modules': resolve('src/modules'),
            '@components': resolve('src/components'),
            '@constants': resolve('src/modules/system/constants'),
            '@packages': resolve('src/packages')
        }
    },

    plugins: [
        new webpack.EnvironmentPlugin({
            NODE_ENV: 'production'
        }),

        new webpack.NamedModulesPlugin()
    ]
};
