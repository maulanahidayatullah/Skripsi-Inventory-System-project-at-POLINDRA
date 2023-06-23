<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Gedung;
use App\Models\Inventori;
use App\Models\LogMobilitas;
use App\Models\Mobilitas;
use App\Models\Ruangan;
use Illuminate\Support\Facades\Validator;

use Illuminate\Http\Request;

use function PHPUnit\Framework\isTrue;

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

    public function get_mobilitas(Request $request)
    {
        $mobilitas = Mobilitas::where('user_id', $request->user_id)
            ->where('selesai', 'false')
            ->get();

        if (count($mobilitas) !== 0) {
            foreach ($mobilitas as $key => $value) {
                $mobilitas->success = 'success';
                $mobilitas->user = $value->User->Pegawai;
                $mobilitas->inventori = $value->Inventori;
                $mobilitas->gedung = $value->Gedung;
                $mobilitas->ruangan = $value->Ruangan;
            }
            return response()->json([
                'success' => true,
                'data' => $mobilitas
            ], 200);
        } else {
            $mobilitas->success = 'success';
            return response()->json([
                'success' => false,
                'data' => $mobilitas
            ], 400);
        }
    }


    public function tambah_mobilitas(Request $request)
    {
        $inventori = Inventori::where('nup', $request->nup)->first();

        if (!empty($inventori)) {

            $mobilitas = Mobilitas::where('inventori_id', $inventori->id)
                ->where('selesai', 'false')->first();

            if (empty($mobilitas)) {

                $data                       = new Mobilitas();
                $data->user_id              = $request->user_id;
                $data->inventori_id         = $inventori->id;
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
                        'success' => true,
                        'note' => 'Barang berhasil ditambahkan'
                    ], 200);
                }
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Barang sudah pernah ditambahkan'
                ], 400);
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
            $inventori->gedung_id        = $request->gedung_id;
            $inventori->ruangan_id       = $request->ruangan_id;
            $inventori->save();
            if ($inventori->save()) {
                $data = new Mobilitas();
                $data->user_id          = $request->user_id;
                $data->inventori_id     = $mobilitas->inventori_id;
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

    public function hapus_mobilitas(Request $request)
    {

        $mobilitas = Mobilitas::where('id', $request->mobilitas_id)->where('user_id', $request->user_id)->where('selesai', 'false')->first();
        $mobilitas->delete();

        $log = LogMobilitas::where('mobilitas_id_sebelum', $request->mobilitas_id)->where('user_id', $request->user_id)->where('selesai', 'false')->first();
        $log->delete();

        return response()->json([
            'success' => true,
            'note' => 'Mobilitas berhasil di Hapus'
        ], 200);
    }

    public function log_mobilitas(Request $request)
    {
        $log = LogMobilitas::where('user_id', $request->user_id)
            ->where('selesai', 'true')
            ->orderBy("id", "desc")
            ->get();

        if (count($log) !== 0) {
            foreach ($log as $key => $value) {
                $log->inventori = $value->MobilitasSebelum->Inventori;
                $log->gedungSebelum = $value->MobilitasSebelum->Gedung;
                $log->ruanganSebelum = $value->MobilitasSebelum->Ruangan;
                $log->gedungSesudah = $value->MobilitasSesudah->Gedung;
                $log->ruanganSesudah = $value->MobilitasSesudah->Ruangan;
                $log[$key]->date = date($value->created_at);
            }
            // $log[0]->created_at = "aasd"
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

    public function get_gedung_ruuangan()
    {
        $gedung = Gedung::get();
        // return $gedung[2]->Ruangan;

        if (count($gedung) !== 0) {
            foreach ($gedung as $key => $value) {
                $gedung->Ruangan = $value->Ruangan;
            }
            return response()->json([
                'success' => true,
                'data' => $gedung
            ], 200);
        } else {
            return response()->json([
                'success' => false,
            ], 400);
        }
    }

    public function get_ruangan(Request $request)
    {
        $ruangan = Ruangan::where('id_gedung', $request->gedung_id)->get();
        if (count($ruangan) !== 0) {
            return response()->json([
                'success' => true,
                'data' => $ruangan
            ], 200);
        } else {
            return response()->json([
                'success' => false,
            ], 400);
        }
    }
}
