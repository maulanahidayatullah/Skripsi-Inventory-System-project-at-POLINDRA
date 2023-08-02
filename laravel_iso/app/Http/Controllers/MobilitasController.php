<?php

namespace App\Http\Controllers;

use App\Models\LogMobilitas;
use App\Models\Mobilitas;
use Illuminate\Http\Request;

class MobilitasController extends Controller
{
    public function index()
    {
        $log_mobilitas = count(LogMobilitas::get());
        return view('mobilitas.view', compact('log_mobilitas'));
    }
}
