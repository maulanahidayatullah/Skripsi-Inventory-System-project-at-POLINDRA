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

            $cek_peminjaman = Peminjaman::where('status_persetujuan', '!=', null)->where('selesai', '!=', null)->where('inventori_id', $inventori->id)->first();

            if (empty($cek_peminjaman)) {
                $peminjaman = Peminjaman::where('inventori_id', $inventori->id)->where('user_id', $request->user_id)
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
                    'note' => 'Barang sedang dalam peminjaman'
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
        // return $this->generate_code_pemnjaman($request->user_id);
        $peminjaman = Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'true')->get();

        if (count($peminjaman) !== 0) {

            $instansi_id = User::where('id', $request->user_id)->first()->instansi_id;
            $barang_kembali = $request->tgl_kembali . ' ' . $request->jam_kembali;

            $lvl_user = User::where('id', $request->user_id)->first()->level;

            // return $lvl_user;
            if ($lvl_user === 'user_3') {
                Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'true')->update([
                    'kode_peminjaman'        => $this->generate_code_pemnjaman($request->user_id),
                    'instansi_id'            => $instansi_id,
                    'unit_kerja'             => $request->unit_kerja,
                    'nama_kegiatan'          => $request->nama_kegiatan,
                    'jumlah'                 => $request->jumlah,
                    'satuan'                 => $request->satuan,
                    'keterangan'             => $request->keterangan,
                    'tgl_pinjam'             => date('y-m-d h:i'),
                    'tgl_kembali'            => $barang_kembali,
                    'persetujuan_wadir'      => 'belum',
                    'persetujuan_pembimbing' => 'belum',
                    'status_persetujuan'     => 'belum',
                    'selesai'                => 'false',
                    'keranjang'              => 'false',
                ]);

                Peminjaman::where('user_id', '!=', $request->user_id)->where('keranjang', 'true')->delete();


                return response()->json([
                    'success' => true,
                    'note' => 'Peminjaman Ditambahkan, Sliahkan menunggu Persetujuan '
                ], 200);
            } elseif ($lvl_user === 'user_4') {
                Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'true')->update([
                    'kode_peminjaman'        => $this->generate_code_pemnjaman($request->user_id),
                    'instansi_id'            => $instansi_id,
                    'unit_kerja'             => $request->unit_kerja,
                    'nama_kegiatan'          => $request->nama_kegiatan,
                    'jumlah'                 => $request->jumlah,
                    'satuan'                 => $request->satuan,
                    'keterangan'             => $request->keterangan,
                    'tgl_pinjam'             => date('y-m-d h:i'),
                    'tgl_kembali'            => $barang_kembali,
                    'persetujuan_wadir'      => 'belum',
                    'persetujuan_pembimbing' => 'setuju',
                    'status_persetujuan'     => 'belum',
                    'selesai'                => 'false',
                    'keranjang'              => 'false',
                ]);

                Peminjaman::where('user_id', '!=', $request->user_id)->where('keranjang', 'true')->delete();


                return response()->json([
                    'success' => true,
                    'note' => 'Peminjaman Ditambahkan, Sliahkan menunggu Persetujuan '
                ], 200);
            } elseif ($lvl_user === 'user_5') {
                Peminjaman::where('user_id', $request->user_id)->where('keranjang', 'true')->update([
                    'kode_peminjaman'        => $this->generate_code_pemnjaman($request->user_id),
                    'instansi_id'            => $instansi_id,
                    'unit_kerja'             => $request->unit_kerja,
                    'nama_kegiatan'          => $request->nama_kegiatan,
                    'jumlah'                 => $request->jumlah,
                    'satuan'                 => $request->satuan,
                    'keterangan'             => $request->keterangan,
                    'tgl_pinjam'             => date('y-m-d h:i'),
                    'tgl_kembali'            => $barang_kembali,
                    'persetujuan_wadir'      => 'setuju',
                    'persetujuan_pembimbing' => 'setuju',
                    'status_persetujuan'     => 'setuju',
                    'selesai'                => 'false',
                    'keranjang'              => 'false',
                ]);

                Peminjaman::where('user_id', '!=', $request->user_id)->where('keranjang', 'true')->delete();


                return response()->json([
                    'success' => true,
                    'note' => 'Peminjaman Ditambahkan'
                ], 200);
            }
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

        if (count($detail) !== 0) {
            foreach ($detail as $key => $value) {
                $detail->success = 'success';
                $detail->inventori = $value->Inventori;
                $detail->user = $value->User;
            }
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

        if ($user->level == 'user_3') {
            $persetujuan = Peminjaman::where('keranjang', 'false')->where('status_persetujuan', 'belum')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        } elseif ($user->level == 'user_4') {
            $persetujuan = Peminjaman::where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'belum')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' =>
                    'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        } else {
            $persetujuan = Peminjaman::where('user_id', $request->user_id)->where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'belum')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        }
    }

    public function persetujuan_wadir(Request $request)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $request->kode_peminjaman)->get();

        if (count($peminjaman) !== 0) {
            foreach ($peminjaman as $key => $value) {
                if ($value->persetujuan_pembimbing === 'setuju') {
                    $value->update([
                        'status_persetujuan' => 'setuju',
                        'persetujuan_wadir' => 'setuju',
                        'selesai' => 'false'
                    ]);
                } else {
                    $value->update([
                        'persetujuan_wadir' => 'setuju'
                    ]);
                }
            }

            return response()->json([
                'success' => true,
                'note' => 'Berhasil Di setujui'
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Persetujuan Gagal'
            ], 400);
        }
    }

    public function persetujuan_pembimbing(Request $request)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $request->kode_peminjaman)->get();

        if (count($peminjaman) !== 0) {
            foreach ($peminjaman as $key => $value) {
                if ($value->persetujuan_wadir === 'setuju') {
                    $value->update([
                        'status_persetujuan' => 'setuju',
                        'persetujuan_pembimbing' => 'setuju',
                        'selesai' => 'false'
                    ]);
                } else {
                    $value->update([
                        'persetujuan_pembimbing' => 'setuju'
                    ]);
                }
            }

            return response()->json([
                'success' => true,
                'note' => 'Berhasil Di setujui'
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'note' => 'Persetujuan Gagal'
            ], 400);
        }
    }

    public function proses_peminjaman(Request $request)
    {
        $user = User::where('id', $request->user_id)->first();

        if ($user->level == 'user_3') {
            $persetujuan = Peminjaman::where('keranjang', 'false')->where('status_persetujuan', 'setuju')->where('selesai', 'false')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Peminjaman Gagal',
                    'data' => $persetujuan
                ], 400);
            }
        } elseif ($user->level == 'user_4') {
            $persetujuan = Peminjaman::where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'setuju')->where('selesai', 'false')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        } else {
            $persetujuan = Peminjaman::where('user_id', $request->user_id)->where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'setuju')->where('selesai', 'false')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        }
    }

    public function riwayat_peminjaman(Request $request)
    {
        $user = User::where('id', $request->user_id)->first();

        if ($user->level == 'user_3') {
            $persetujuan = Peminjaman::where('keranjang', 'false')->where('status_persetujuan', 'setuju')->where('selesai', 'true')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        } elseif ($user->level == 'user_4') {
            $persetujuan = Peminjaman::where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'setuju')->where('selesai', 'true')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' => 'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        } else {
            $persetujuan = Peminjaman::where('user_id', $request->user_id)->where('instansi_id', $user->instansi_id)->where('keranjang', 'false')->where('status_persetujuan', 'setuju')->where('selesai', 'true')->groupBy('kode_peminjaman')->get();

            if (count($persetujuan) !== 0) {
                return response()->json([
                    'success' => true,
                    'data' => $persetujuan
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'note' =>
                    'Tidak ada data',
                    'data' => $persetujuan
                ], 400);
            }
        }
    }

    public function generate_code_pemnjaman($user_id)
    {
        $code = "PJM-" . $user_id . date('ymd');
        return $code;
    }
}
