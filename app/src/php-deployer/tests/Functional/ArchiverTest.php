<?php namespace Tests\Functional;

use PhpDeployer\Archiver\ProjectArchiver;
use ZipArchive;

class ArchiverTest extends BaseCase
{
    public function testAllNoIgnore()
    {
        $archiver = new ProjectArchiver(__DIR__.'/../fixtures/partial-test-project', true);

        $zipPath = $archiver->make();

        $this->assertFileExists($zipPath);

        $zip = new ZipArchive();
        $this->assertTrue($zip->open($zipPath));

        $this->assertInternalType('array', $zip->statName('index.php'));
        $this->assertInternalType('array', $zip->statName('.pondgitdir/test.txt'));
        $this->assertInternalType('array', $zip->statName('.htaccess'));
        $this->assertInternalType('array', $zip->statName('modules/backend/behaviors/FormController.php'));
        $this->assertInternalType('array', $zip->statName('modules/backend/behaviors/importexportcontroller/assets/css/export.css'));
        $this->assertInternalType('array', $zip->statName('vendor/classpreloader/classpreloader/composer.json'));
        $this->assertInternalType('array', $zip->statName('themes/demo/assets/css/vendor.css'));
        $this->assertInternalType('array', $zip->statName('storage/app/uploads/public/fields.yaml'));
        $this->assertInternalType('array', $zip->statName('plugins/october/demo/Plugin.php'));
        $this->assertInternalType('array', $zip->statName('plugins/october/demo/Plugin.php'));
        $this->assertInternalType('array', $zip->statName('plugins/october/demo/.pondgitdir/test/test.txt'));

        $archivedPaths = $archiver->getArchivedComponentPaths();
        $this->assertContains('index.php', $archivedPaths);
        $this->assertContains('plugins', $archivedPaths);

        $archivedComponents = $archiver->getArchivedComponents();
        $this->assertContains('core', $archivedComponents);
        $this->assertContains('media', $archivedComponents);
        $this->assertContains('uploads', $archivedComponents);
        $this->assertContains('plugins', $archivedComponents);
        $this->assertContains('themes', $archivedComponents);
    }

    public function testDefaultPondIgnore()
    {
        $archiver = new ProjectArchiver(__DIR__.'/../fixtures/partial-test-project');

        $zipPath = $archiver->make();

        $this->assertFileExists($zipPath);

        $zip = new ZipArchive();
        $this->assertTrue($zip->open($zipPath));
        $this->assertInternalType('array', $zip->statName('index.php'));
        $this->assertInternalType('array', $zip->statName('.htaccess'));
        $this->assertInternalType('array', $zip->statName('modules/backend/behaviors/FormController.php'));
        $this->assertFalse($zip->statName('.pondignore'));
        $this->assertFalse($zip->statName('.pondgitdir/test.txt'));
        $this->assertFalse($zip->statName('plugins/october/demo/.pondgitdir/test/test.txt'));
    }

    public function testAllPlugins()
    {
        $archiver = new ProjectArchiver(__DIR__.'/../fixtures/partial-test-project');

        $zipPath = $archiver->make([
            'plugins'=>true
        ]);

        $this->assertFileExists($zipPath);

        $zip = new ZipArchive();
        $this->assertTrue($zip->open($zipPath));
        $this->assertFalse($zip->statName('index.php'));
        $this->assertFalse($zip->statName('.htaccess'));
        $this->assertFalse($zip->statName('modules/backend/behaviors/FormController.php'));
        $this->assertInternalType('array', $zip->statName('plugins/october/demo/Plugin.php'));
        $this->assertInternalType('array', $zip->statName('plugins/october/test/Plugin.php'));

        $archivedPaths = $archiver->getArchivedComponentPaths();
        $this->assertNotContains('index.php', $archivedPaths);
        $this->assertContains('plugins', $archivedPaths);

        $archivedComponents = $archiver->getArchivedComponents();
        $this->assertNotContains('core', $archivedComponents);
        $this->assertNotContains('media', $archivedComponents);
        $this->assertNotContains('uploads', $archivedComponents);
        $this->assertContains('plugins', $archivedComponents);
        $this->assertNotContains('themes', $archivedComponents);
        $this->assertNotContains('config', $archivedComponents);
    }

    public function testOnePlugin()
    {
        $archiver = new ProjectArchiver(__DIR__.'/../fixtures/partial-test-project');

        $zipPath = $archiver->make([
            'plugins'=>['october/demo']
        ]);

        $this->assertFileExists($zipPath);

        $zip = new ZipArchive();
        $this->assertTrue($zip->open($zipPath));
        $this->assertFalse($zip->statName('index.php'));
        $this->assertFalse($zip->statName('.htaccess'));
        $this->assertFalse($zip->statName('modules/backend/behaviors/FormController.php'));
        $this->assertInternalType('array', $zip->statName('plugins/october/demo/Plugin.php'));
        $this->assertFalse($zip->statName('plugins/october/test/Plugin.php'));

        $archivedPaths = $archiver->getArchivedComponentPaths();
        $this->assertNotContains('index.php', $archivedPaths);
        $this->assertContains('plugins/october/demo', $archivedPaths);

        $archivedComponents = $archiver->getArchivedComponents();
        $this->assertNotContains('core', $archivedComponents);
        $this->assertNotContains('media', $archivedComponents);
        $this->assertNotContains('uploads', $archivedComponents);
        $this->assertContains('plugins/october/demo', $archivedComponents);
        $this->assertNotContains('themes', $archivedComponents);
        $this->assertNotContains('config', $archivedComponents);
    }

    public function testOneTheme()
    {
        $archiver = new ProjectArchiver(__DIR__.'/../fixtures/partial-test-project');

        $zipPath = $archiver->make([
            'themes'=>['demo']
        ]);

        $this->assertFileExists($zipPath);

        $zip = new ZipArchive();
        $this->assertTrue($zip->open($zipPath));
        $this->assertFalse($zip->statName('index.php'));
        $this->assertFalse($zip->statName('.htaccess'));
        $this->assertFalse($zip->statName('modules/backend/behaviors/FormController.php'));
        $this->assertFalse($zip->statName('plugins/october/demo/Plugin.php'));
        $this->assertInternalType('array', $zip->statName('themes/demo/assets/css/vendor.css'));

        $archivedComponents = $archiver->getArchivedComponents();
        $this->assertNotContains('core', $archivedComponents);
        $this->assertNotContains('media', $archivedComponents);
        $this->assertNotContains('uploads', $archivedComponents);
        $this->assertNotContains('plugins', $archivedComponents);
        $this->assertContains('themes/demo', $archivedComponents);
        $this->assertNotContains('config', $archivedComponents);
    }
}