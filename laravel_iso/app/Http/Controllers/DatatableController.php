<?php

namespace App\Http\Controllers;

use App\Models\Inventori;
use App\Models\LogMobilitas;
use App\Models\Mobilitas;
use Illuminate\Http\Request;
use Redirect, Response, DB, Config;
use Datatables;
use Auth;
use Yajra\DataTables\Facades\DataTables as FacadesDataTables;

class DatatableController extends Controller
{
    public function barang_json(Request $request)
    {
        if (request()->ajax()) {
            if (!empty($request->search_kode)) {
                $data = Inventori::where('kode_barang', 'like', '%' . $request->search_kode . "%")->get();
            } elseif (!empty($request->search_nup)) {
                $data = Inventori::where('nup', 'like', '%' . $request->search_nup . "%")->get();
            } else {
                $data = Inventori::get();
            }
        }


        return FacadesDataTables::of($data)
            ->addColumn('action', function ($value) {
                return '<a href="/barang/edit/' . $value->id . '" class="btn btn-primary btn-sm ml-1"">Edit </a>
                <div class="btn btn-warning btn-sm m-1 " onClick="pelabelan(' . $value->id . ')" > + Pelabelan </div>
            ';
            })
            ->addColumn('gedung', function ($value) {
                return $value->Gedung->gedung;
            })
            ->addColumn('ruangan', function ($value) {
                return $value->Ruangan->ruangan;
            })
            ->addIndexColumn()
            ->make(true);
    }

    public function lap_barang_json(Request $request)
    {

        if (request()->ajax()) {
            if ($request->filter === "gedung_ruangan") {
                if (!empty($request->value_2)) {
                    $data = DB::table('inventori as inv')
                        ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                        ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                        ->where('ruangan.id_ruangan', $request->value_2)
                        ->get();
                } elseif (!empty($request->value_1)) {
                    $data = DB::table('inventori as inv')
                        ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                        ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                        ->where('gedung.id_gedung', $request->value_1)
                        ->get();
                }
            } elseif ($request->filter === "tahun") {
                $data = DB::table('inventori as inv')
                    ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                    ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                    ->whereBetween('inv.tahun_perolehan', [$request->value_1, $request->value_2])
                    ->get();
            } else {
                $data = DB::table('inventori as inv')
                    ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                    ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                    ->get();
            }
        }


        return FacadesDataTables::of($data)
            ->addIndexColumn()
            ->make(true);
    }

    public function mobilitas_json(Request $request)
    {
        if (request()->ajax()) {
            if (!empty($request->search_kode)) {
                $log_mobilitas = DB::table('log_mobilitas as log')
                    ->join('mobilitas as mobilitas_sebelum', 'log.mobilitas_id_sebelum', '=', 'mobilitas_sebelum.id')
                    ->join('gedung as gedung_sebelum', 'mobilitas_sebelum.gedung_id', '=', 'gedung_sebelum.id_gedung')
                    ->join('ruangan as ruangan_sebelum', 'mobilitas_sebelum.ruangan_id', '=', 'ruangan_sebelum.id_ruangan')

                    ->join('mobilitas as mobilitas_sesudah', 'log.mobilitas_id_sesudah', '=', 'mobilitas_sesudah.id')
                    ->join('gedung as gedung_sesudah', 'mobilitas_sesudah.gedung_id', '=', 'gedung_sesudah.id_gedung')
                    ->join('ruangan as ruangan_sesudah', 'mobilitas_sesudah.ruangan_id', '=', 'ruangan_sesudah.id_ruangan')

                    ->join('users as user', 'mobilitas_sesudah.user_id', '=', 'user.id')
                    ->join('inventori as inventori', 'mobilitas_sesudah.inventori_id', '=', 'inventori.id')
                    ->where('inventori.kode_barang', 'like', '%' . $request->search_kode . "%")

                    ->select('log.id as id', 'log.created_at as tanggal', 'user.name as user', 'inventori.nama_barang as nama_barang', 'inventori.kode_barang as kode_barang', 'inventori.nup as nup', 'gedung_sebelum.gedung as gedung_sebelum', 'ruangan_sebelum.ruangan as ruangan_sebelum', 'gedung_sesudah.gedung as gedung_sesudah', 'ruangan_sesudah.ruangan as ruangan_sesudah',)
                    ->get();
            } elseif (!empty($request->search_nup)) {
                $log_mobilitas = DB::table('log_mobilitas as log')
                    ->join('mobilitas as mobilitas_sebelum', 'log.mobilitas_id_sebelum', '=', 'mobilitas_sebelum.id')
                    ->join('gedung as gedung_sebelum', 'mobilitas_sebelum.gedung_id', '=', 'gedung_sebelum.id_gedung')
                    ->join('ruangan as ruangan_sebelum', 'mobilitas_sebelum.ruangan_id', '=', 'ruangan_sebelum.id_ruangan')

                    ->join('mobilitas as mobilitas_sesudah', 'log.mobilitas_id_sesudah', '=', 'mobilitas_sesudah.id')
                    ->join('gedung as gedung_sesudah', 'mobilitas_sesudah.gedung_id', '=', 'gedung_sesudah.id_gedung')
                    ->join('ruangan as ruangan_sesudah', 'mobilitas_sesudah.ruangan_id', '=', 'ruangan_sesudah.id_ruangan')

                    ->join('users as user', 'mobilitas_sesudah.user_id', '=', 'user.id')
                    ->join('inventori as inventori', 'mobilitas_sesudah.inventori_id', '=', 'inventori.id')
                    ->where('inventori.nup', 'like', '%' . $request->search_nup . "%")

                    ->select('log.id as id', 'log.created_at as tanggal', 'user.name as user', 'inventori.nama_barang as nama_barang', 'inventori.kode_barang as kode_barang', 'inventori.nup as nup', 'gedung_sebelum.gedung as gedung_sebelum', 'ruangan_sebelum.ruangan as ruangan_sebelum', 'gedung_sesudah.gedung as gedung_sesudah', 'ruangan_sesudah.ruangan as ruangan_sesudah',)
                    ->get();
            } else {
                $log_mobilitas = DB::table('log_mobilitas as log')
                    ->join('mobilitas as mobilitas_sebelum', 'log.mobilitas_id_sebelum', '=', 'mobilitas_sebelum.id')
                    ->join('gedung as gedung_sebelum', 'mobilitas_sebelum.gedung_id', '=', 'gedung_sebelum.id_gedung')
                    ->join('ruangan as ruangan_sebelum', 'mobilitas_sebelum.ruangan_id', '=', 'ruangan_sebelum.id_ruangan')

                    ->join('mobilitas as mobilitas_sesudah', 'log.mobilitas_id_sesudah', '=', 'mobilitas_sesudah.id')
                    ->join('gedung as gedung_sesudah', 'mobilitas_sesudah.gedung_id', '=', 'gedung_sesudah.id_gedung')
                    ->join('ruangan as ruangan_sesudah', 'mobilitas_sesudah.ruangan_id', '=', 'ruangan_sesudah.id_ruangan')

                    ->join('users as user', 'mobilitas_sesudah.user_id', '=', 'user.id')
                    ->join('inventori as inventori', 'mobilitas_sesudah.inventori_id', '=', 'inventori.id')

                    ->select('log.id as id', 'log.created_at as tanggal', 'user.name as user', 'inventori.nama_barang as nama_barang', 'inventori.kode_barang as kode_barang', 'inventori.nup as nup', 'gedung_sebelum.gedung as gedung_sebelum', 'ruangan_sebelum.ruangan as ruangan_sebelum', 'gedung_sesudah.gedung as gedung_sesudah', 'ruangan_sesudah.ruangan as ruangan_sesudah',)
                    ->get();
            }
        }

        return FacadesDataTables::of($log_mobilitas)
            ->addColumn('tanggal', function ($value) {
                return date($value->tanggal);
            })
            ->addColumn('sebelum', function ($value) {
                return $value->gedung_sebelum . ' - ' . $value->ruangan_sebelum;
            })
            ->addColumn('sesudah', function ($value) {
                return $value->gedung_sesudah . ' - ' . $value->ruangan_sesudah;
            })
            ->addIndexColumn()
            ->make(true);
    }

    public function mobilitas_user_json(Request $request)
    {
        if (request()->ajax()) {
            if (!empty($request->user_id)) {
                if (!empty($request->search_kode)) {
                    $log_mobilitas_user = DB::table('log_mobilitas as log')
                        ->join('mobilitas as mobilitas_sebelum', 'log.mobilitas_id_sebelum', '=', 'mobilitas_sebelum.id')
                        ->join('gedung as gedung_sebelum', 'mobilitas_sebelum.gedung_id', '=', 'gedung_sebelum.id_gedung')
                        ->join('ruangan as ruangan_sebelum', 'mobilitas_sebelum.ruangan_id', '=', 'ruangan_sebelum.id_ruangan')

                        ->join('mobilitas as mobilitas_sesudah', 'log.mobilitas_id_sesudah', '=', 'mobilitas_sesudah.id')
                        ->join('gedung as gedung_sesudah', 'mobilitas_sesudah.gedung_id', '=', 'gedung_sesudah.id_gedung')
                        ->join('ruangan as ruangan_sesudah', 'mobilitas_sesudah.ruangan_id', '=', 'ruangan_sesudah.id_ruangan')

                        ->join('users as user', 'mobilitas_sesudah.user_id', '=', 'user.id')
                        ->join('pengguna as pengguna', 'user.id', '=', 'pengguna.user_id')
                        ->join('inventori as inventori', 'mobilitas_sesudah.inventori_id', '=', 'inventori.id')
                        ->where('inventori.kode_barang', 'like', '%' . $request->search_kode . "%")
                        ->where('user.id', 2)

                        ->select('log.id as id', 'log.created_at as tanggal', 'pengguna.nama as user', 'inventori.nama_barang as nama_barang', 'inventori.kode_barang as kode_barang', 'inventori.nup as nup', 'gedung_sebelum.gedung as gedung_sebelum', 'ruangan_sebelum.ruangan as ruangan_sebelum', 'gedung_sesudah.gedung as gedung_sesudah', 'ruangan_sesudah.ruangan as ruangan_sesudah',)
                        ->get();
                } elseif (!empty($request->search_nup)) {
                    $log_mobilitas_user = DB::table('log_mobilitas as log')
                        ->join('mobilitas as mobilitas_sebelum', 'log.mobilitas_id_sebelum', '=', 'mobilitas_sebelum.id')
                        ->join('gedung as gedung_sebelum', 'mobilitas_sebelum.gedung_id', '=', 'gedung_sebelum.id_gedung')
                        ->join('ruangan as ruangan_sebelum', 'mobilitas_sebelum.ruangan_id', '=', 'ruangan_sebelum.id_ruangan')

                        ->join('mobilitas as mobilitas_sesudah', 'log.mobilitas_id_sesudah', '=', 'mobilitas_sesudah.id')
                        ->join('gedung as gedung_sesudah', 'mobilitas_sesudah.gedung_id', '=', 'gedung_sesudah.id_gedung')
                        ->join('ruangan as ruangan_sesudah', 'mobilitas_sesudah.ruangan_id', '=', 'ruangan_sesudah.id_ruangan')

                        ->join('users as user', 'mobilitas_sesudah.user_id', '=', 'user.id')
                        ->join('pengguna as pengguna', 'user.id', '=', 'pengguna.user_id')
                        ->join('inventori as inventori', 'mobilitas_sesudah.inventori_id', '=', 'inventori.id')
                        ->where('inventori.nup', 'like', '%' . $request->search_nup . "%")
                        ->where('user.id', 2)

                        ->select('log.id as id', 'log.created_at as tanggal', 'pengguna.nama as user', 'inventori.nama_barang as nama_barang', 'inventori.kode_barang as kode_barang', 'inventori.nup as nup', 'gedung_sebelum.gedung as gedung_sebelum', 'ruangan_sebelum.ruangan as ruangan_sebelum', 'gedung_sesudah.gedung as gedung_sesudah', 'ruangan_sesudah.ruangan as ruangan_sesudah',)
                        ->get();
                } else {
                    $log_mobilitas_user = DB::table('log_mobilitas as log')
                        ->join('mobilitas as mobilitas_sebelum', 'log.mobilitas_id_sebelum', '=', 'mobilitas_sebelum.id')
                        ->join('gedung as gedung_sebelum', 'mobilitas_sebelum.gedung_id', '=', 'gedung_sebelum.id_gedung')
                        ->join('ruangan as ruangan_sebelum', 'mobilitas_sebelum.ruangan_id', '=', 'ruangan_sebelum.id_ruangan')

                        ->join('mobilitas as mobilitas_sesudah', 'log.mobilitas_id_sesudah', '=', 'mobilitas_sesudah.id')
                        ->join('gedung as gedung_sesudah', 'mobilitas_sesudah.gedung_id', '=', 'gedung_sesudah.id_gedung')
                        ->join('ruangan as ruangan_sesudah', 'mobilitas_sesudah.ruangan_id', '=', 'ruangan_sesudah.id_ruangan')

                        ->join('users as user', 'mobilitas_sesudah.user_id', '=', 'user.id')
                        ->join('pengguna as pengguna', 'user.id', '=', 'pengguna.user_id')
                        ->join('inventori as inventori', 'mobilitas_sesudah.inventori_id', '=', 'inventori.id')

                        ->where('user.id', $request->user_id)

                        ->select('log.id as id', 'user.id as user_id', 'log.created_at as tanggal', 'pengguna.nama as user', 'inventori.nama_barang as nama_barang', 'inventori.kode_barang as kode_barang', 'inventori.nup as nup', 'gedung_sebelum.gedung as gedung_sebelum', 'ruangan_sebelum.ruangan as ruangan_sebelum', 'gedung_sesudah.gedung as gedung_sesudah', 'ruangan_sesudah.ruangan as ruangan_sesudah',)
                        ->get();
                }
            }
        }

        return FacadesDataTables::of($log_mobilitas_user)
            ->addColumn('tanggal', function ($value) {
                return date($value->tanggal);
            })
            ->addColumn('sebelum', function ($value) {
                return $value->gedung_sebelum . ' - ' . $value->ruangan_sebelum;
            })
            ->addColumn('sesudah', function ($value) {
                return $value->gedung_sesudah . ' - ' . $value->ruangan_sesudah;
            })
            ->addIndexColumn()
            ->make(true);
    }

    public function pelabelan_json()
    {
        $data = DB::table('pelabelan as label')
            ->join('users as user', 'label.user_id', '=', 'user.id')
            ->join('inventori as inv', 'label.inventori_id', '=', 'inv.id')
            ->where('status', 'false')

            ->select('label.id as id', 'inv.nama_barang as nama_barang', 'inv.kode_barang as kode_barang', 'inv.nup as nup', 'inv.tahun_perolehan as tahun',)
            ->get();

        return FacadesDataTables::of($data)
            ->addColumn('action', function ($value) {
                return '<div class="btn btn-danger btn-sm m-1 " onClick="hapus(' . $value->id . ')" > Hapus </div>';
            })
            ->addIndexColumn()
            ->make(true);
    }

    public function input_ruangan_json()
    {
        $inputruangan = DB::table("input_ruangan")
            ->join('barangs', function ($join) {
                $join->on('input_ruangan.id_barang', '=', 'barangs.id_barang');
            })
            ->join('ruangan', function ($join) {
                $join->on('input_ruangan.id_ruangan_barang', '=', 'ruangan.id_ruangan');
            })
            ->get();


        return datatables()->of($inputruangan)
            ->addColumn('action', function ($u) {
                return '<a href="/input_ruangan/edit/' . $u->id_input_ruangan . '" class="btn btn-primary btn-sm ml-2"">Edit </a>
            ';
            })
            ->addColumn('total', function ($u) {
                return $u->jumlah_masuk + $u->jumlah_rusak_ruangan;
            })
            ->make(true);

        return datatables()->of($inputruangan)->make(true);
    }
    public function keluar_json()
    {
        $keluar = DB::table("keluar")
            ->join('barangs', function ($join) {
                $join->on('keluar.id_barang', '=', 'barangs.id_barang');
            })->get();

        return datatables()->of($keluar)
            ->addColumn('action', function ($u) {
                return '<a href="/keluar/edit/' . $u->id_keluar . '" class="btn btn-primary btn-sm ml-2"">Edit </a>
            ';
            })
            ->make(true);

        return datatables()->of($keluar)->make(true);
    }
    public function masuk_json()
    {
        $masuk = DB::table("masuk")
            ->join('barangs', function ($join) {
                $join->on('masuk.id_barang', '=', 'barangs.id_barang');
            })->get();

        return datatables()->of($masuk)
            ->addColumn('action', function ($u) {
                return '<a href="/masuk/edit/' . $u->id_masuk . '" class="btn btn-primary btn-sm ml-2"">Edit </a>
            <a href="/masuk/detail/' . $u->id_masuk . '" class="btn btn-warning btn-sm ml-2"">Detail </a>
            
            ';
            })
            ->make(true);

        return datatables()->of($masuk)->make(true);
    }


    public function peminjaman_json()
    {

        $peminjaman = DB::table("peminjaman")
            ->join('barangs', function ($join) {
                $join->on('peminjaman.id_barang', '=', 'barangs.id_barang');
            })->get();

        return datatables()->of($peminjaman)
            ->addColumn('action', function ($u) {
                if ($u->status == 'Belum Dikembalikan') {
                    return '<a href="/peminjaman/edit/' . $u->id_peminjaman . '" class="btn btn-primary btn-sm ml-2"">Edit </a>
                <a href="/peminjaman/detail/' . $u->id_peminjaman . '" class="btn btn-warning btn-sm ml-2"">Detail </a>
                <a href="/peminjaman/status/' . $u->id_peminjaman . '/' . $u->id_barang . '" class="btn btn-success btn-sm ml-2"  onclick="return confirm("Apakah Anda Yakin ?")">Kembalikan </a>
                
            ';
                } else {
                    return '<a href="/peminjaman/detail/' . $u->id_peminjaman . '" class="btn btn-warning btn-sm ml-2"">Detail </a>
            ';
                }
            })
            ->make(true);

        return datatables()->of($peminjaman)->make(true);
    }



    public function rusak_ruangan_json()
    {

        $rusak_ruangan = DB::table("rusak_ruangan")
            ->join('barangs', function ($join) {
                $join->on('rusak_ruangan.id_barang_rusak', '=', 'barangs.id_barang');
            })->join('ruangan', function ($join) {
                $join->on('rusak_ruangan.id_ruangan_rusak', '=', 'ruangan.id_ruangan');
            })
            ->join('users', function ($join) {
                $join->on('rusak_ruangan.user_id_ruangan', '=', 'users.id');
            })->get();

        return datatables()->of($rusak_ruangan)
            ->addColumn('action', function ($u) {
                if ($u->status == 'rusak') {
                    return '<a href="/rusak_ruangan/edit/' . $u->id_rusak_ruangan . '" class="btn btn-primary btn-sm ml-2"">Edit </a>
                        <a href="/rusak_ruangan/status/' . $u->id_rusak_ruangan . '/' . $u->id_barang_rusak . '" class="btn btn-success btn-sm ml-2"  onclick="return confirm("Apakah Anda Yakin ?")">V </a>

            ';
                } else {
                    return 'Tidak ada opsi';
                }
            })

            ->addColumn('nama', function ($u) {
                return $u->name;
            })

            ->addColumn('status_rusak', function ($u) {
                if ($u->status == 'sudah_diperbaiki') {
                    return 'Sudah Di Perbaiki';
                } else {
                    return 'Rusak';
                }
            })
            ->make(true);
        return datatables()->of($rusak_ruangan)->make(true);
    }

    public function rusak_luar_json()
    {

        $rusak_luar = DB::table("rusak_luar")
            ->join('barangs', function ($join) {
                $join->on('rusak_luar.id_barang_rusak_luar', '=', 'barangs.id_barang');
            })->join('users', function ($join) {
                $join->on('rusak_luar.user_id_luar', '=', 'users.id');
            })->get();

        return datatables()->of($rusak_luar)
            ->addColumn('action', function ($u) {
                if ($u->status == 'rusak') {
                    return '<a href="/rusak_luar/edit/' . $u->id_rusak_luar . '" class="btn btn-primary btn-sm ml-2"">Edit </a>
                        <a href="/rusak_luar/status/' . $u->id_rusak_luar . '/' . $u->id_barang_rusak_luar . '" class="btn btn-success btn-sm ml-2"  onclick="return confirm("Apakah Anda Yakin ?")">V </a>

            ';
                } else {
                    return 'Tidak ada opsi';
                }
            })

            ->addColumn('nama', function ($u) {
                return $u->name;
            })



            ->addColumn('status_rusak', function ($u) {
                if ($u->status == 'sudah_diperbaiki') {
                    return 'Sudah Di Perbaiki';
                } else {
                    return 'Rusak';
                }
            })
            ->make(true);
        return datatables()->of($rusak_luar)->make(true);
    }
}
