<?php

namespace App\Http\Controllers;

use App\Barang;
use auth;
use DB;
use Response;
use Alert;
use App\Imports\InventoriImport;
use App\Models\Gedung;
use App\Models\Inventori;
use App\Models\Ruangan;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class BarangController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth', 'Admin']);
    }


    public function index()
    {
        $barang = count(Inventori::get());
        $lastNup = Inventori::orderBy('nup', 'DESC')->first();
        $gedung = Gedung::get();

        return view('barang.view', compact('barang', 'lastNup', 'gedung'));
    }

    public function store(Request $request)
    {
        DB::table('inventori')->insert([
            'uraian_akun' => $request->uraian_akun,
            'kode_barang' => $request->kode_barang,
            'nama_barang' => $request->nama_barang,
            'tahun_perolehan' => $request->tahun_perolehan,
            'nup' => $request->nup,
            'merk_type' => $request->merk_type,
            'kuantitas' => $request->kuantitas,
            'nilai_bmn' => $request->nilai_bmn,
            'pengguna' => $request->pengguna,
            'kondisi_barang' => $request->kondisi_barang,
            'keberadaan_barang' => $request->keberadaan_barang,
            'pelabelan_kodefikasi' => $request->pelabelan_kodefikasi,
            'gedung_id' => $request->gedung_id,
            'ruangan_id' => $request->ruangan_id,
            'status_psp' => $request->status_psp,
            'nama_sub_satker' => $request->nama_sub_satker,
            'keterangan' => $request->keterangan,
        ]);

        Alert::success('Success', "Data Telah Terinput");
        return redirect()->back();
    }


    public function edit($id)
    {
        $inventori = Inventori::find($id);
        $gedung = Gedung::get();
        $ruangan = Ruangan::get();

        return view('barang.edit', compact('inventori', 'gedung', 'ruangan'));
    }


    public function qrcode($id)
    {

        $qrcode = DB::table('inventori')->where('id', $id)->first();

        return view('barang.qrcode', compact('qrcode'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Barang  $barang
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        DB::table('inventori')->where('id', $request->id_inventori)->update([
            'uraian_akun' => $request->uraian_akun,
            'kode_barang' => $request->kode_barang,
            'nama_barang' => $request->nama_barang,
            'tahun_perolehan' => $request->tahun_perolehan,
            'nup' => $request->nup,
            'merk_type' => $request->merk_type,
            'kuantitas' => $request->kuantitas,
            'nilai_bmn' => $request->nilai_bmn,
            'kondisi_barang' => $request->kondisi_barang,
            'keberadaan_barang' => $request->keberadaan_barang,
            'pelabelan_kodefikasi' => $request->pelabelan_kodefikasi,
            'gedung_id' => $request->gedung_id,
            'status_psp' => $request->status_psp,
            'keterangan' => $request->keterangan,
        ]);
        // alihkan halaman ke halaman pegawai
        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/barang');
    }

    public function contohFile()
    {
        return response()->download(public_path('assets/file/contoh_file.xlsx'));
    }

    public function import(Request $request)
    {
        // return $request;
        $data = $request->file('file');

        $namaFile = $data->getClientOriginalName();

        $request->file->move(public_path('assets/file/'), $namaFile);

        Excel::import(new InventoriImport, \public_path('assets/file/' . $namaFile));
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Barang  $barang
     * @return \Illuminate\Http\Response
     */
    public function delete($id)
    {
        DB::table('barangs')->where('id_barang', $id)->delete();
        Alert::success('Success', 'Data Telah Terhapus');
        return redirect()->route('barang.index');
    }

    public function ruangan(Request $request)
    {
        $ruangan = Ruangan::where('id_gedung', $request->id)->get();

        return response()->json($ruangan);
        // return view('barang.card.ruangan_id', compact('ruangan'));
    }
}
