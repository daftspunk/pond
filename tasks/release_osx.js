'use strict';

var Q = require('q');
var gulpUtil = require('gulp-util');
var childProcess = require('child_process');
var jetpack = require('fs-jetpack');
var utils = require('./utils');

var projectDir;
var releasesDir;
var tmpDir;
var finalAppName;
var finalAppDir;
var manifest;

var init = function () {
    projectDir = jetpack;
    tmpDir = projectDir.dir('./tmp', { empty: true });
    releasesDir = projectDir.dir('./releases');
    manifest = projectDir.read('app/package.json', 'json');
    finalAppName = manifest.name + '.app',
    finalAppDir = tmpDir.cwd(manifest.productName);

    return Q();
};

var copyRuntime = function () {
    var nodeSrcDir = 'nw-normal/node_modules/nw/nwjs/nwjs.app';

    if (process.env.POND_DEV_RELEASE == 'true') {
        nodeSrcDir = 'node_modules/nw/nwjs/nwjs.app';
        console.log('Building DEV release. Do not use for production.');
    }

    return projectDir.copyAsync(nodeSrcDir, finalAppDir.path());
};

var copyBuiltApp = function () {
    return utils.copyBuiltApp(finalAppDir, projectDir);
};

var prepareOsSpecificThings = function () {
    // Info.plist
    var info = projectDir.read('resources/osx/Info.plist');
    info = utils.replace(info, {
        productName: manifest.productName,
        version: manifest.version,
        bundleName: manifest.name
    });
    finalAppDir.write('Contents/Info.plist', info);

    // Localization strings
    var strings = projectDir.read('resources/osx/InfoPlist.strings');
    strings = utils.replace(strings, {
        version: manifest.version,
        bundleDisplayName: manifest.productName
    });

    var stringsFiles = finalAppDir.find('Contents/Resources', {
        matching: 'InfoPlist.strings'
    });

    stringsFiles.forEach(function(stringsFile) {
        finalAppDir.write(stringsFile, strings);
    });

    // Icon
    projectDir.copy('resources/osx/icon.icns', finalAppDir.path('Contents/Resources/icon.icns'));

    return Q();
};

var packToDmgFile = function () {
    var deferred = Q.defer();

    var appdmg = require('appdmg');
    var dmgName = manifest.name + '_' + manifest.version + '.dmg';

    // Prepare appdmg config
    var dmgManifest = projectDir.read('resources/osx/appdmg.json');
    dmgManifest = utils.replace(dmgManifest, {
        productName: manifest.productName,
        appPath: finalAppDir.path(),
        dmgIcon: projectDir.path("resources/osx/dmg-icon.icns"),
        dmgBackground: projectDir.path("resources/osx/dmg-background.png"),
        appName: finalAppName
    });

    tmpDir.write('appdmg.json', dmgManifest);

    // Delete DMG file with this name if already exists
    releasesDir.remove(dmgName);

    gulpUtil.log('Packaging to DMG file...');

    var readyDmgPath = releasesDir.path(dmgName);
    appdmg({
        source: tmpDir.path('appdmg.json'),
        target: readyDmgPath
    })
    .on('error', function (err) {
        console.error(err);
    })
    .on('finish', function () {
        gulpUtil.log('DMG file ready!', readyDmgPath);
        deferred.resolve();
    });

    return deferred.promise;
};

var cleanClutter = function () {
   return tmpDir.removeAsync('.');
};

module.exports = function () {
    return init()
    .then(copyRuntime)
    .then(copyBuiltApp)
    .then(prepareOsSpecificThings)
    .then(packToDmgFile)
    .then(cleanClutter);
};
