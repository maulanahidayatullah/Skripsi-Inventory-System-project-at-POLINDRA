<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Mobilitas;

use Illuminate\Http\Request;

class MobilitasController extends Controller
{
    public function cek_mobilitas(Request $request)
    {
        $mobilitas =
            Mobilitas::where('user_id', $request->user_id)
            ->where('selesai', 'false')
            ->get();

        if (count($mobilitas) !== 0) {
            return response()->json([
                'success' => true,
                'data' => $mobilitas
            ], 200);
        } else {
            return response()->json([
                'success' => false,
            ], 400);
        }
    }

    public function tambah_mobilitas(Request $request)
    {
        $mobilitas =
            Mobilitas::where('user_id', $request->user_id)
            ->where('selesai', 'false')
            ->get();

        if (count($mobilitas) !== 0) {
            return response()->json([
                'success' => true,
                'data' => $mobilitas
            ], 200);
        } else {
            return response()->json([
                'success' => false,
            ], 400);
        }
    }
}
