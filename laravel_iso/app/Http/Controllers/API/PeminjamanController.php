<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Inventori;
use App\Models\Peminjaman;
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
        $peminjaman = Peminjaman::where('inventori_id', $request->inventori_id)
            ->where('user_id', $request->user_id)->where('keranjang', 'true')->first();

        if (!empty($peminjaman)) {
            $barang_kembali = $request->tgl_kembali . ' ' . $request->jam_kembali;

            $peminjaman->kode_peminjaman        = $this->generate_code_pemnjaman($request->user_id);
            $peminjaman->unit_kerja             = $request->unit_kerja;
            $peminjaman->nama_kegiatan          = $request->nama_kegiatan;
            $peminjaman->jumlah                 = $request->jumlah;
            $peminjaman->satuan                 = $request->satuan;
            $peminjaman->keterangan             = $request->keterangan;
            $peminjaman->tgl_pinjam             = date('y-m-d h:i');
            $peminjaman->tgl_kembali            = $barang_kembali;
            $peminjaman->persetujuan_wadir      = 'belum';
            $peminjaman->persetujuan_pembimbing = 'belum';
            $peminjaman->status_persetujuan     = 'belum';
            $peminjaman->keranjang              = 'false';

            if ($peminjaman->save()) {
                return response()->json([
                    'success' => true,
                    'note' => 'Peminjaman Ditambahkan, Sliahkan menunggu Persetujuan '
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Peminjaman Gagal'
                ], 400);
            }
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Belum ada Keranjang peminjaman'
            ], 400);
        }
    }

    public function status_peminjaman(Request $request)
    {
        $peminjaman = Peminjaman::where('inventori_id', $request->inventori_id)
            ->where('user_id', $request->user_id)->where('keranjang', 'false')->get();

        return $peminjaman;
    }

    public function data_persetujuan(Request $request)
    {
        $persetujuan = Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'false')->where('status_persetujuan', 'belum')->get();

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

    public function proses_peminjaman(Request $request)
    {
        $persetujuan = Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'false')->where('status_persetujuan', 'belum')->get();

        if (!empty($persetujuan)) {
            return response()->json([
                'success' => true,
                'data' => $persetujuan
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Tidak ada data'
            ], 400);
        }
    }

    public function generate_code_pemnjaman($user_id)
    {
        $code = "Pol-" . "P-" . $user_id . '-' . date('ymd');
        return $code;
    }
}
