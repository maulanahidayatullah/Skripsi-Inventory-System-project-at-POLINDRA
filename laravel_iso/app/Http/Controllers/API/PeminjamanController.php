<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Inventori;
use App\Models\Peminjaman;
use App\Models\User;
use Illuminate\Http\Request;

class PeminjamanController extends Controller
{
    public function cek_peminjaman(Request $request)
    {
        $peminjaman = Peminjaman::where('user_id', $request->user_id)
            ->where('keranjang', 'true')
            ->get();

        if (count($peminjaman) !== 0) {
            return response()->json([
                'success' => true,
                'data' => $peminjaman
            ], 200);
        } else {
            return response()->json([
                'success' => false,
            ], 400);
        }
    }

    public function get_keranjang_peminjaman(Request $request)
    {
        $peminjaman = Peminjaman::where('user_id', $request->user_id)
            ->where('keranjang', 'true')
            ->get();

        // return $peminjaman[0]->User->Pegawai;
        if (count($peminjaman) !== 0) {
            foreach ($peminjaman as $key => $value) {
                $peminjaman->success = 'success';
                $peminjaman->inventori = $value->Inventori;
            }
            return response()->json([
                'success' => true,
                'data' => $peminjaman
            ], 200);
        } else {
            $peminjaman->success = 'success';
            return response()->json([
                'success' => false,
                'data' => $peminjaman
            ], 400);
        }
    }

    public function tambah_keranjang_peminjaman(Request $request)
    {
        $inventori = Inventori::where('nup', $request->nup)->first();

        if (!empty($inventori)) {

            $peminjaman = Peminjaman::where('inventori_id', $inventori->id)
                ->where('keranjang', 'true')->first();

            if (empty($peminjaman)) {

                $data                       = new Peminjaman();
                $data->user_id              = $request->user_id;
                $data->inventori_id         = $inventori->id;
                $data->kondisi_barang       = $inventori->kondisi_barang;
                $data->keranjang            = 'true';
                $data->save();

                if ($data->save()) {
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

    public function tambah_peminjaman(Request $request)
    {
        $peminjaman = Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'true')->get();

        if (count($peminjaman) !== 0) {

            $instansi_id = User::where('id', $request->user_id)->first()->instansi_id;
            $barang_kembali = $request->tgl_kembali . ' ' . $request->jam_kembali;

            // return $peminjaman;
            foreach ($peminjaman as $key => $value) {
                $value->kode_peminjaman        = $this->generate_code_pemnjaman($request->user_id);
                $value->instansi_id            = $instansi_id;
                $value->unit_kerja             = $request->unit_kerja;
                $value->nama_kegiatan          = $request->nama_kegiatan;
                $value->jumlah                 = $request->jumlah;
                $value->satuan                 = $request->satuan;
                $value->keterangan             = $request->keterangan;
                $value->tgl_pinjam             = date('y-m-d h:i');
                $value->tgl_kembali            = $barang_kembali;
                $value->persetujuan_wadir      = 'belum';
                $value->persetujuan_pembimbing = 'belum';
                $value->status_persetujuan     = 'belum';
                $value->keranjang              = 'false';
                $value->save();
            }
            return response()->json([
                'success' => true,
                'note' => 'Peminjaman Ditambahkan, Sliahkan menunggu Persetujuan '
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Belum ada Keranjang peminjaman'
            ], 400);
        }
    }

    public function detail_peminjaman(Request $request)
    {
        $detail = Peminjaman::where('kode_peminjaman', $request->kode_peminjaman)->get();

        if (!empty($detail)) {
            return response()->json([
                'success' => true,
                'data' => $detail
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Peminjaman Gagal'
            ], 400);
        }
    }

    public function status_peminjaman(Request $request)
    {
        $peminjaman = Peminjaman::where('inventori_id', $request->inventori_id)
            ->where('user_id', $request->user_id)->where('keranjang', 'false')->get();

        return $peminjaman;
    }

    public function persetujuan_data(Request $request)
    {
        $user = User::where('id', $request->user_id)->first();

        if ($user->level == 'mbl_1') {
            $persetujuan = Peminjaman::where('keranjang', 'false')->where('status_persetujuan', 'belum')->groupBy('kode_peminjaman')->get();

            if (!empty($persetujuan)) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Peminjaman Gagal'
                ], 400);
            }
        } elseif ($user->level == 'mbl_2') {
            $persetujuan = Peminjaman::where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'belum')->groupBy('kode_peminjaman')->get();

            if (!empty($persetujuan)) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Peminjaman Gagal'
                ], 400);
            }
        } else {
            $persetujuan = Peminjaman::where('user_id', $request->user_id)->where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'belum')->groupBy('kode_peminjaman')->get();

            if (!empty($persetujuan)) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Peminjaman Gagal'
                ], 400);
            }
        }
    }

    public function persetujuan_wadir(Request $request)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $request->kode_peminjaman)->get();

        foreach ($peminjaman as $key => $value) {
            $value->update(['persetujuan_wadir' => 'setuju']);
        }

        return 'success';
    }

    public function persetujuan_pembimbing(Request $request)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $request->kode_peminjaman)->get();

        if (!empty($peminjaman)) {
            return response()->json([
                'success' => true,
                'data' => $peminjaman
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Peminjaman Gagal'
            ], 400);
        }
    }

    public function generate_code_pemnjaman($user_id)
    {
        $code = "Pol-" . "P-" . $user_id . '-' . date('ymd');
        return $code;
    }
}
