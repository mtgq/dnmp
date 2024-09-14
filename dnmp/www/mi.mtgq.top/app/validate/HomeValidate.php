<?php

namespace app\validate;

use think\Validate;

class HomeValidate extends Validate
{
    protected $rule = [
        'username|用户名' => 'require|check_username_is_email_or_mobile',
        'password|密码' => 'require',
        'step|步数' => 'require|number|between:1,98800',
    ];

    protected $message = [
        'step.between' => '步数只能在1-98800之间',
    ];

    protected function check_username_is_email_or_mobile($value, $rule, $data = [])
    {
        if (Validate::is($value, 'email')) {
            return true;
        } else {
            if (Validate::is($value, 'mobile')) {
                return true;
            } else {
                return '账号输入错误';
            }
        }
    }
}