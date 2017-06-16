<?php

function getPlatformIssues(&$errors, &$warnings)
{
    $errors = array();
    $warnings = array();

    if ($iniPath = php_ini_loaded_file()) {
        $iniMessage = PHP_EOL.'The php.ini used by your command-line PHP is: ' . $iniPath;
    } else {
        $iniMessage = PHP_EOL.'A php.ini file does not exist. You will have to create one.';
    }

    if (ini_get('detect_unicode')) {
        $errors['unicode'] = array(
            'The detect_unicode setting must be disabled.',
            'Add the following to the end of your `php.ini`:',
            '    detect_unicode = Off',
            $iniMessage
        );
    }

    if (!function_exists('json_decode')) {
        $errors['json'] = array(
            'The json extension is missing.',
            'Install it or recompile php without --disable-json'
        );
    }

    if (!class_exists('ZipArchive')) {
        $errors['zip'] = array(
            'The ZipArchive extension is missing.',
            'Install it to continue'
        );
    }

    if (!extension_loaded('filter')) {
        $errors['filter'] = array(
            'The filter extension is missing.',
            'Install it or recompile php without --disable-filter'
        );
    }

    if (!extension_loaded('hash')) {
        $errors['hash'] = array(
            'The hash extension is missing.',
            'Install it or recompile php without --disable-hash'
        );
    }

    if (!extension_loaded('iconv') && !extension_loaded('mbstring')) {
        $errors['iconv_mbstring'] = array(
            'The iconv OR mbstring extension is required and both are missing.',
            'Install either of them or recompile php without --disable-iconv'
        );
    }

    if (!ini_get('allow_url_fopen')) {
        $errors['allow_url_fopen'] = array(
            'The allow_url_fopen setting is incorrect.',
            'Add the following to the end of your `php.ini`:',
            '    allow_url_fopen = On',
            $iniMessage
        );
    }

    if (extension_loaded('ionCube Loader') && ioncube_loader_iversion() < 40009) {
        $ioncube = ioncube_loader_version();
        $errors['ioncube'] = array(
            'Your ionCube Loader extension ('.$ioncube.') is incompatible with Phar files.',
            'Upgrade to ionCube 4.0.9 or higher or remove this line (path may be different) from your `php.ini` to disable it:',
            '    zend_extension = /usr/lib/php5/20090626+lfs/ioncube_loader_lin_5.3.so',
            $iniMessage
        );
    }

    if (version_compare(PHP_VERSION, '5.5.0', '<')) {
        $errors['php'] = array(
            'Your PHP ('.PHP_VERSION.') is too old, you must upgrade to PHP 5.5.0 or higher.'
        );
    }

    if (!extension_loaded('openssl')) {
        $warnings['openssl'] = array(
            'The openssl extension is missing, which means that secure HTTPS transfers are impossible.',
            'If possible you should enable it or recompile php with --with-openssl'
        );
    }

    if (extension_loaded('openssl') && OPENSSL_VERSION_NUMBER < 0x1000100f) {
        // Attempt to parse version number out, fallback to whole string value.
        $opensslVersion = trim(strstr(OPENSSL_VERSION_TEXT, ' '));
        $opensslVersion = substr($opensslVersion, 0, strpos($opensslVersion, ' '));
        $opensslVersion = $opensslVersion ? $opensslVersion : OPENSSL_VERSION_TEXT;

        $warnings['openssl_version'] = array(
            'The OpenSSL library ('.$opensslVersion.') used by PHP does not support TLSv1.2 or TLSv1.1.',
            'If possible you should upgrade OpenSSL to version 1.0.1 or above.'
        );
    }

    if (!defined('HHVM_VERSION') && !extension_loaded('apcu') && ini_get('apc.enable_cli')) {
        $warnings['apc_cli'] = array(
            'The apc.enable_cli setting is incorrect.',
            'Add the following to the end of your `php.ini`:',
            '    apc.enable_cli = Off',
            $iniMessage
        );
    }

    foreach ($errors as $key => $value) {
        $errors[$key] = PHP_EOL.implode(PHP_EOL, $value);
    }

    foreach ($warnings as $key => $value) {
        $warnings[$key] = PHP_EOL.implode(PHP_EOL, $value);
    }

    return !empty($errors);
}

function respond($content, $statusCode = 200, $statusMessage = 'OK')
{
    header('HTTP/1.0 '.$statusCode.' '.$statusMessage, true, $statusCode);
    echo $content;
}

function installOctober()
{
    $zip = new ZipArchive();
    $file = __DIR__.DIRECTORY_SEPARATOR.'installer.pak';

    if ($zip->open($file) !== true) {
        return false;
    }
        
    $zip->extractTo(__DIR__);
    $zip->close();
    return true;
}

$errors = array();
$warnings = array();

if (getPlatformIssues($errors, $warnings)) {
    $content = json_encode(array(
        'errors'=>$errors,
        'warnings'=>$warnings)
    );

    return respond($content, 500, 'Internal Server Error');
}

if (installOctober()) {
    return respond('DONE');
}

return respond('Unable to extract the archive.', 500, 'Internal Server Error');
?>