require('webpack');

const path = require('path');
const SOURCE_DIR = path.resolve(__dirname, 'src/');

module.exports = {
    target: 'web',
    cache: true,
    context: SOURCE_DIR,
    entry: {
        'app': [
            SOURCE_DIR + '/Entry.tsx'
        ]
    },
    output: {
        path: path.resolve(__dirname, 'build/'),
        filename: '[name].js'
    },
    resolve: {
        extensions: ['.ts', '.tsx', '.js'],
        modules: ['node_modules']
    },
    module: {
        rules: [
            {
                test: /\.(ts|tsx)?$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        babelrc: false,
                        presets: [
                            '@babel/preset-env',
                            '@babel/preset-typescript',
                            '@babel/preset-react'
                        ],
                        plugins: [
                            ['@babel/plugin-transform-runtime', {'regenerator': true}],
                            ['@babel/plugin-proposal-decorators', {'legacy': true}],
                            '@babel/plugin-proposal-class-properties',
                            '@babel/plugin-proposal-object-rest-spread'
                        ]
                    }
                }
            }
        ]
    }
};
