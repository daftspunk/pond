'use strict';

var nw = require('nw');
var childProcess = require('child_process');

var runApp = function () {
    console.log(nw.findpath())
    var env = Object.create(process.env);
    env.NODE_ENV = 'dev';

    var app = childProcess.spawn(nw.findpath(), ['./app'], {
        stdio: 'inherit',
        env: env
    });
};

runApp();