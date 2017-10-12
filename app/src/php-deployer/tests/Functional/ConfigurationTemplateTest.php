<?php namespace Tests\Functional;

use PhpDeployer\ConfigurationTemplate\View as ConfigurationTemplateView;
use Exception;

class ConfigurationTemplateTest extends BaseCase
{
    public function testRenderNoErrors()
    {
        $view = new ConfigurationTemplateView();
        $this->assertEquals('1 2', $view->render('app', '{{t1}} {{t2}}', [
            (object)['name'=>'t1', 'value'=>1],
            (object)['name'=>'t2', 'value'=>2]
        ]));
        $this->assertEquals('3', $view->render('app', '{{t3}}', [
            (object)['name'=>'t3', 'value'=>3]]
        ));

        $this->assertEquals('no', $view->render('app', '{{config.app.debug}}', [
            (object)['name'=>'config', 'value'=>['app'=>['debug'=>'no']]]
        ]));
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage Unexpected character "@"
     */
    public function testRenderSyntaxError()
    {
        $view = new ConfigurationTemplateView();
        $this->assertEquals('1 2', $view->render('app', '{%@%}'));
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage Variable "t1" does not exist
     */
    public function testRenderNoVarError()
    {
        $view = new ConfigurationTemplateView();
        $view->render('app', '{{t1}}');
    }
}