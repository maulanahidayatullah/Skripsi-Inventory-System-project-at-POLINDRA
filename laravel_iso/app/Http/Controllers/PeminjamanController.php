<?php

namespace App\Http\Controllers;

use auth;
use DB;
use Alert;
use App\Exports\PeminjamanExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Controllers\Controller;
use App\Models\Peminjaman;
use App\Models\Pengembalian;
use Illuminate\Http\Request;

class PeminjamanController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth', 'Admin']);
    }



    public function index()
    {
        $peminjaman = Peminjaman::groupBy('kode_peminjaman')->get()->count();

        return view('peminjaman.view', compact('peminjaman'));
    }

    public function detail($kode_peminjaman)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $kode_peminjaman)->get();

        return view('peminjaman.detail', compact('peminjaman'));
    }

    public function pengembalian()
    {

        $pengembalian = Pengembalian::groupBy('kode_peminjaman')->get()->count();
        return view('pengembalian.view', compact('pengembalian'));
    }

    public function cek_kode(Request $request)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $request->kode_peminjaman)->where('selesai', 'false')->get();

        if (count($peminjaman) !== 0) {
            Alert::success('Success', 'Kode Peminjaman Ditemukan');
            return redirect("/pengembalian/create/$request->kode_peminjaman");
        } else {
            Alert::error('Gagal', 'Kode Peminjaman Tidak Ditemukan');
            return redirect('/pengembalian');
        }
    }

    public function pengembalian_create($kode_peminjaman)
    {
        $peminjaman = Peminjaman::where('kode_peminjaman', $kode_peminjaman)->get();


        return view('pengembalian.create', compact('peminjaman'));
    }

    public function pengembalian_store(Request $request)
    {
        $banyak_data = count($request->peminjaman_id);
        // return $request;

        for ($i = 0; $i < $banyak_data; $i++) {
            DB::table('pengembalian')->insert([
                'user_id'           => $request->user_id,
                'peminjaman_id'     => $request->peminjaman_id[$i],
                'kondisi_barang'    => $request->kondisi_barang[$i],
                'kode_peminjaman'   => $request->kode_peminjaman,
                'tgl_kembali'       => date('y-m-d h:i'),
            ]);

            DB::table('peminjaman')->where('id', $request->peminjaman_id[$i])->update([
                'selesai' => 'true',
            ]);

            DB::table('inventori')->where('id', $request->inventori_id[$i])->update([
                'kondisi_barang' => $request->kondisi_barang[$i],
            ]);
        }


        Alert::success('Success', 'Pengembalian barang berhasil ditambahkan');
        return redirect('/pengembalian');
        // $peminjaman = Peminjaman::where('kode_peminjaman', $request)->get();

    }

    public function detail_pengembalian($kode_peminjaman)
    {
        $pengembalian = Pengembalian::where('kode_peminjaman', $kode_peminjaman)->get();

        return view('pengembalian.detail', compact('pengembalian'));
    }


    public function export_excel()
    {
        return Excel::download(new PeminjamanExport(), 'peminjaman.xlsx');
    }
}
