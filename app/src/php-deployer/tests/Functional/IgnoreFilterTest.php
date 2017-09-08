<?php namespace Tests\Functional;

use PhpDeployer\Archiver\IgnoreFilter;

class IgnoreFilterTest extends BaseCase
{
    public function testIgnorePaths()
    {
        $filter = new IgnoreFilter([
            '/starts-with',
            '/dir/',
            'occurs',
            '.git',
            '.gitignore',
            '/deep/path/to/file.txt'
        ]);

        $this->assertFalse($filter->shouldIgnore('file.txt'));

        $this->assertFalse($filter->shouldIgnore('/something/starts-with'));
        $this->assertTrue($filter->shouldIgnore('/starts-with/file.txt'));
        $this->assertTrue($filter->shouldIgnore('starts-with/file.txt'));

        $this->assertTrue($filter->shouldIgnore('/dir/something'));
        $this->assertFalse($filter->shouldIgnore('/dir'));

        $this->assertTrue($filter->shouldIgnore('/dir/some/occurs/thing'));
        $this->assertTrue($filter->shouldIgnore('occurs/in/some/thing'));

        $this->assertTrue($filter->shouldIgnore('occurs/in/some/.git'));
        $this->assertTrue($filter->shouldIgnore('/.git'));

        $this->assertTrue($filter->shouldIgnore('/some/.gitignore'));
        $this->assertTrue($filter->shouldIgnore('/.gitignore'));

        $this->assertFalse($filter->shouldIgnore('/path/file.txt'));
        $this->assertTrue($filter->shouldIgnore('/deep/path/to/file.txt'));
        $this->assertTrue($filter->shouldIgnore('deep/path/to/file.txt'));
    }
}