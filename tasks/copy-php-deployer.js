'use strict';

var gulp = require('gulp');
var jetpack = require('fs-jetpack');
var projectDir = jetpack;

var copyAssets = function() {
    var finalDir = projectDir.path('app/dist/php-deployer');
    projectDir.dir(finalDir, { empty: true });
    return projectDir.copyAsync('app/src/php-deployer', finalDir, { overwrite: true })
        .then(function() {
            return projectDir.dir(finalDir+'/logs', { empty: true })
                .then(function() {
                    return projectDir.dir(finalDir+'/tests', { empty: true })
                })
        })
}

gulp.task('copy-php-deployer', function () {
    return copyAssets();
});