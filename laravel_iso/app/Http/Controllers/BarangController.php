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
use App\Models\Pelabelan;
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
        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/barang');
    }

    public function contohFile()
    {
        return response()->download(public_path('assets/file/_Contoh File.xlsx'));
    }

    public function import(Request $request)
    {
        $data = $request->file('file');

        $namaFile = $data->getClientOriginalName();

        $request->file->move(public_path('assets/file/'), $namaFile);

        Excel::import(new InventoriImport, public_path('assets/file/' . $namaFile));

        Alert::success('Success', 'Data Berhasil Di Import');
        return redirect()->back();
    }

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
    }

    public function tambah_keranjang(Request $request)
    {
        $keranjang = Pelabelan::where('inventori_id', $request->inventori_id)->where('status', 'false')->first();

        if (empty($keranjang)) {
            DB::table('pelabelan')->insert([
                'user_id'      => Auth::user()->id,
                'inventori_id' => $request->inventori_id,
                'status'       => 'false',
            ]);
            return 1;
        } else {
            return 0;
        }
    }

    public function pelabelan_barang()
    {
        $pelabelan = Pelabelan::get();
        return view('pelabelan.view', compact('pelabelan'));
    }

    public function hapus_pelabelan(Request $request)
    {
        return DB::table('pelabelan')->where('id', $request->pelabelan_id)->delete();
    }

    public function print_qr()
    {
        $user_id = Auth::user()->id;
        $pelabelan = Pelabelan::where('user_id', $user_id)->where('status', 'false')->get();

        foreach ($pelabelan as $key => $value) {
            Inventori::where('id', $value->inventori_id)->update([
                'pelabelan_kodefikasi' => 'sudah'
            ]);
        }

        return $pelabelan;
    }
}
