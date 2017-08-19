'use strict';

var gulp = require('gulp');
var jetpack = require('fs-jetpack');
var projectDir = jetpack;

var copyAssets = function() {
    var finalDir = projectDir.path('app/dist/assets');
    projectDir.dir(finalDir, { empty: true });
    return projectDir.copyAsync('app/src/assets', finalDir, { overwrite: true });
}

gulp.task('copy-assets', ['copy-php-deployer'], function () {
    return copyAssets();
});