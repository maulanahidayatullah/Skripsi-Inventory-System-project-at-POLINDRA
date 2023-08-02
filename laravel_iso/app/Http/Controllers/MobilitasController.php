<?php

namespace App\Http\Controllers;

use App\Models\LogMobilitas;
use App\Models\Mobilitas;
use App\Models\User;
use Illuminate\Http\Request;

class MobilitasController extends Controller
{
    public function index()
    {
        $log_mobilitas = count(LogMobilitas::get());
        return view('mobilitas.view', compact('log_mobilitas'));
    }

    public function mobilitas_user()
    {
        // $log_mobilitas = count(LogMobilitas::get());
        $user = User::get();
        return view('mobilitas.mobilitas_user', compact('user'));
    }
}
