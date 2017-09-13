<?php namespace Tests\Functional;

use PhpDeployer\ConfigurationTemplate\View as ConfigurationTemplateView;
use Exception;

class ConfigurationTemplateTest extends BaseCase
{
    public function testRenderNoErrors()
    {
        $view = new ConfigurationTemplateView();
        $this->assertEquals('1 2', $view->render('app', '{{t1}} {{t2}}', ['t1'=>1, 't2'=>2]));
        $this->assertEquals('3', $view->render('app', '{{t3}}', ['t3'=>3]));
        $this->assertEquals('no', $view->render('app', '{{config.app.debug}}', ['config'=>['app'=>['debug'=>'no']]]));
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