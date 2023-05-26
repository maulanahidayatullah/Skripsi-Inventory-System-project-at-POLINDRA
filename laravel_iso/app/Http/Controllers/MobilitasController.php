<?php

namespace App\Http\Controllers;

use App\Models\LogMobilitas;
use App\Models\Mobilitas;
use Illuminate\Http\Request;

class MobilitasController extends Controller
{
    public function index()
    {
        $logMobilitas = LogMobilitas::where('selesai', 'true')->get();
        // return $logMobilitas;
        return view('mobilitas.view', compact('logMobilitas'));
    }
}
