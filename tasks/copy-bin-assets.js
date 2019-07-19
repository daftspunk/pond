'use strict';

var gulp = require('gulp');
var os = require('os');
var jetpack = require('fs-jetpack');
var projectDir = jetpack;

var copyPlatformBinAssets = function() {
    var finalDir = projectDir.path('app/dist/assets-bin-php/');

    // The assets-bin-php can only contain directories
    // specific to the current platform, so we empty
    // it completely before copying the new contents.

    projectDir.dir(finalDir, { empty: true });
    finalDir += '/' + os.platform();
    projectDir.dir(finalDir);

    return projectDir.copyAsync('app/src/assets-bin-php/'+os.platform(), finalDir, { overwrite: true });
}

gulp.task('copy-bin-assets', function () {
    return copyPlatformBinAssets();
});
