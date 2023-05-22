<?php

namespace App\Http\Controllers;

use DB;
use auth;
use Alert;
use App\Models\Gedung;
use Illuminate\Http\Request;

class GedungController extends Controller
{

    public function index()
    {
        $gedung = Gedung::get();
        return view('gedung.view', compact('gedung'));
    }

    public function store(Request $request)
    {
        // insert data ke table jenis
        DB::table('gedung')->insert([
            'gedung' => $request->gedung,
        ]);
        // alihkan halaman ke halaman jenis
        Alert::success('Success', 'Data Telah Terinput');
        return redirect('/gedung');
    }

    public function edit($id)
    {

        // $pembimbing = DB::table('users')->where('level', 'rayon')->get();
        // $pj = DB::table('users')->where('level', 'pj')->get();

        // $users = DB::table('users')->get();
        $gedung = DB::table('gedung')->where('id_gedung', $id)->first();

        return view('gedung.edit', compact('gedung'));
    }

    public function update(Request $request)
    {
        // update data jenis
        DB::table('gedung')->where('id_gedung', $request->id_gedung)->update([
            'gedung' => $request->gedung,
        ]);
        // alihkan halaman ke halaman jenis
        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/gedung');
    }

    public function hapus($id)
    {
        // menghapus data jenis berdasarkan id yang dipilih
        DB::table('gedung')->where('id_gedung', $id)->delete();

        // alihkan halaman ke halaman gedung
        Alert::success('Success', 'Data Telah Terhapus');
        return redirect('/gedung');
    }
}
