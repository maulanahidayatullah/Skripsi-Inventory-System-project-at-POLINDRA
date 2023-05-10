<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Inventori;
use Illuminate\Http\Request;

class InventoriController extends Controller
{
    public function cek_inventori(Request $request)
    {
        $inventori = Inventori::where('kode_barang', $request->kode_barang)->first();
        if (!empty($inventori)) {
            return response()->json([
                'success' => true,
                'data' => $inventori
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                // 'data' => $inventori
            ], 400);
        }
    }
}
