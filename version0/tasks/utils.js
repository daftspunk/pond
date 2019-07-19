'use strict';

var Q = require('q');
var argv = require('yargs').argv;
var os = require('os');
var path = require('path');
const {exec} = require('child_process');

function compileCode(srcLocation, destLocaiton) {
    var nwjcPath = require.resolve('nw'),
        deferred = Q.defer();

    nwjcPath = path.dirname(nwjcPath) + '/nwjs/nwjc';

    exec(nwjcPath + ' "' + srcLocation + '"" "' + destLocaiton + '"', (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            deferred.reject();
            return;
        }

        deferred.resolve();
    });

    return deferred.promise;
}

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

module.exports.copyBuiltApp = function (finalAppDir, projectDir) {
    // TODO: some of this code is OSX specific

    var result = projectDir.copyAsync('app/dist', finalAppDir.path('Contents/Resources/app.nw/dist'), { overwrite: true })
        .then(function() {
            return projectDir.copyAsync('app/package.json', finalAppDir.path('Contents/Resources/app.nw/package.json'), { overwrite: true });
        });

    var indexPath = 'app/src/index-production.html';

    if (process.env.POND_DEV_RELEASE != 'true') {
        // For production we replace main.js with main.bin and use another index.html

        result.then(function() {
            return compileCode(finalAppDir.path('Contents/Resources/app.nw/dist/main.js'), finalAppDir.path('Contents/Resources/app.nw/dist/main.bin'));
        });
    }
    else {
        indexPath = 'app/index.html';
    }

    result.then(function() {
        return projectDir.copyAsync(indexPath, finalAppDir.path('Contents/Resources/app.nw/index.html'), { overwrite: true });
    });

    return result;
}
