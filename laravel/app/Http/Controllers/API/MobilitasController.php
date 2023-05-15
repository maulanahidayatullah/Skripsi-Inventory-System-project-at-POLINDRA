<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Inventori;
use App\Models\LogMobilitas;
use App\Models\Mobilitas;
use Illuminate\Support\Facades\Validator;

use Illuminate\Http\Request;

class MobilitasController extends Controller
{
    public function cek_mobilitas(Request $request)
    {
        $mobilitas = Mobilitas::where('user_id', $request->user_id)
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
        $inventori = Inventori::where('kode_barang', $request->kode_barang)->first();

        if (!empty($inventori)) {

            $mobilitas = Mobilitas::where('inventori_id', $inventori->id)->first();

            if (empty($mobilitas)) {

                $data                       = new Mobilitas();
                $data->user_id              = $request->user_id;
                $data->inventori_id         = $inventori->id;
                $data->jurusan_id           = $inventori->jurusan_id;
                $data->gedung_id            = $inventori->gedung_id;
                $data->ruangan_id           = $inventori->ruangan_id;
                $data->selesai              = 'false';
                $data->save();

                if ($data->save()) {
                    $log                        = new LogMobilitas();
                    $log->user_id               = $request->user_id;
                    $log->mobilitas_id_sebelum  = $data->id;
                    $log->selesai              = 'false';
                    $log->save();

                    return response()->json([
                        'success' => false,
                        'note' => 'Barang berhasil ditambahkan'
                    ], 200);
                }
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Barang sudah pernah ditambahkan'
                ], 200);
            }
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Barang tidak ditemukan'
            ], 400);
        }
    }

    public function selesai_mobilitas(Request $request)
    {
        $mobilitas            = Mobilitas::where('id', $request->mobilitas_id)->where('selesai', 'false')->first();
        $mobilitas->selesai   = 'true';

        $mobilitas->save();

        if ($mobilitas->save()) {

            $inventori  = Inventori::where('id', $mobilitas->inventori_id)->first();
            $inventori->jurusan_id       = $request->jurusan_id;
            $inventori->gedung_id        = $request->gedung_id;
            $inventori->ruangan_id       = $request->ruangan_id;

            $inventori->save();

            if ($inventori->save()) {

                $data = new Mobilitas();
                $data->user_id          = $request->user_id;
                $data->inventori_id     = $mobilitas->inventori_id;
                $data->jurusan_id       = $inventori->jurusan_id;
                $data->gedung_id        = $inventori->gedung_id;
                $data->ruangan_id       = $inventori->ruangan_id;
                $data->selesai          = 'true';

                $data->save();

                if ($data->save()) {
                    $log                        = LogMobilitas::where('mobilitas_id_sebelum', $mobilitas->id)->first();
                    $log->user_id               = $request->user_id;
                    $log->mobilitas_id_sesudah  = $data->id;
                    $log->selesai              = 'true';
                    $log->save();

                    return response()->json([
                        'success' => false,
                        'note' => 'Mobilitas barang berhasil'
                    ], 200);
                } else {
                    return response()->json([
                        'success' => false,
                        'note' => 'Mobilitas barang Gagal'
                    ], 400);
                }
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Mobilitas barang Gagal'
                ], 400);
            }
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Mobilitas barang Gagal'
            ], 400);
        }
    }

    public function log_mobilitas(Request $request)
    {
        $log = LogMobilitas::where('user_id', $request->user_id)
            ->where('selesai', 'true')
            ->get();

        if (count($log) !== 0) {
            return response()->json([
                'success' => true,
                'data' => $log
            ], 200);
        } else {
            return response()->json([
                'success' => false,
            ], 400);
        }
    }
}
