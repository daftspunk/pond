'use strict';

var argv = require('yargs').argv;
var os = require('os');

module.exports.os = function () {
    switch (os.platform()) {
        case 'darwin':
            return 'osx';
        case 'linux':
            return 'linux';
        case 'win32':
            return 'windows';
    }
    return 'unsupported';
};

module.exports.replace = function (str, patterns) {
    Object.keys(patterns).forEach(function (pattern) {
        var matcher = new RegExp('{{' + pattern + '}}', 'g');
        str = str.replace(matcher, patterns[pattern]);
    });
    return str;
};

module.exports.getEnvName = function () {
    return argv.env || 'development';
};

module.exports.copyBuiltApp = function (finalAppDir, projectDir) {
    return projectDir.copyAsync('app/dist', finalAppDir.path('Contents/Resources/app.nw/dist'), { overwrite: true })
    .then(function() {
        return projectDir.copyAsync('app/index.html', finalAppDir.path('Contents/Resources/app.nw/index.html'), { overwrite: true });
    })
    .then(function() {
        return projectDir.copyAsync('app/package.json', finalAppDir.path('Contents/Resources/app.nw/package.json'), { overwrite: true });
    });
}
