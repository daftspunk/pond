'use strict';

var nw = require('nw');
var childProcess = require('child_process');

var runApp = function () {
    console.log(nw.findpath())

    var app = childProcess.spawn(nw.findpath(), ['./app'], {
        stdio: 'inherit'
    });
};

runApp();