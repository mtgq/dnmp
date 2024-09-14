<?php

namespace app\controller;

use app\BaseController;

class Index extends BaseController
{
    public function index()
    {
        return view('index');
    }

    public function help()
    {
        return view('help');
    }
}
