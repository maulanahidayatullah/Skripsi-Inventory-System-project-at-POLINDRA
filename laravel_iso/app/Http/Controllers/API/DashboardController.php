<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\LogMobilitas;
use App\Models\LogPeminjaman;
use App\Models\Mobilitas;
use App\Models\Pegawai;
use App\Models\Peminjaman;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $nama = Pegawai::where('user_id', $request->user_id)->first()->nama;

        if (!empty($nama)) {

            $log_mobilitas = LogMobilitas::where('user_id', $request->user_id)->get()->count();
            $data['log_mobilitas'] = $log_mobilitas;

            if (!empty($log_mobilitas)) {

                $peminjaman = Peminjaman::where('user_id', $request->user_id)->get()->count();


                if (!empty($log_mobilitas)) {
                    $data['log_peminjaman'] = $peminjaman;
                } else {
                    $data['log_peminjaman'] = 0;
                }
            } else {
                $data['log_mobilitas'] = 0;
            }

            $data['nama'] = $nama;


            return response()->json([
                'success' => true,
                'data' => $data
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                // 'data' => $nama
            ], 400);
        }
    }
}
