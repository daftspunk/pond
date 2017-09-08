<?php namespace Tests\Functional;

use PhpDeployer\Archiver\ProjectArchiver;
use ZipArchive;

class ArchiverTest extends BaseCase
{
    public function testAllNoIgnore()
    {
        $archiver = new ProjectArchiver(__DIR__.'/../fixtures/partial-test-project', []);

        $zipPath = $archiver->make([
            'core'=>true, 
            'media'=>true,
            'uploads'=>true,
            'plugins'=>true,
            'themes'=>true,
            'config'=>true
        ]);

        $this->assertFileExists($zipPath);

        $zip = new ZipArchive();
        $this->assertTrue($zip->open($zipPath));

        $this->assertInternalType('array', $zip->statName('index.php'));

        // Test random sample of expected files
    }

    // Test default ignore files 
    // Test forced ignore files  (do we need this feature at all?)
    // Test individual components
    // Test individual plugins
    // Test individual themes
}