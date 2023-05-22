<?php

namespace App\Http\Controllers;

use DB;
use auth;
use Alert;
use App\Models\Gedung;
use App\Models\Ruangan;
use Illuminate\Http\Request;

class RuanganController extends Controller
{
	public function __construct()
	{
		$this->middleware(['auth', 'Admin']);
	}

	public function index()
	{
		// $ruangan = DB::table('users')
		// 		->join('ruangan', function ($join) {
		// 				$join->on('users.id', '=', 'ruangan.id_pembimbing');
		// 		})->get();

		// 		dd($ruangan);

		// $pjtable= DB::table('users')
		// 		->join('ruangan', function ($join) {
		// 				$join->on('users.id', '=', 'ruangan.id_pj');
		// 		})->get();

		// $pembimbing=DB::table('users')->where('level','rayon')->get();
		// $pj=DB::table('users')->where('level','pj')->get();

		// $users = DB::table('users')->get();
		$ruangan = Ruangan::get();
		$gedung = Gedung::get();

		// mengirim data jenis ke view index
		return view('ruangan.view', compact('ruangan', 'gedung'));
	}

	// method untuk insert data ke table jenis
	public function store(Request $request)
	{
		// insert data ke table jenis
		DB::table('ruangan')->insert([
			'ruangan' => $request->ruangan,
			// 'id_pembimbing' => $request->id_pembimbing,
			'id_gedung' => $request->id_gedung

		]);
		// alihkan halaman ke halaman jenis
		Alert::success('Success', 'Data Telah Terinput');
		return redirect('/ruangan');
	}

	// method untuk edit data pegawai
	public function edit($id)
	{

		// $pembimbing = DB::table('users')->where('level', 'rayon')->get();
		// $pj = DB::table('users')->where('level', 'pj')->get();

		// $users = DB::table('users')->get();
		$ruangan = DB::table('ruangan')->where('id_ruangan', $id)->first();
		$gedung = Gedung::get();

		return view('ruangan.edit', compact('ruangan', 'gedung'));
	}

	// update data jenis
	public function update(Request $request)
	{
		// update data jenis
		DB::table('ruangan')->where('id_ruangan', $request->id_ruangan)->update([
			'ruangan' => $request->ruangan,
			// 'id_pembimbing' => $request->id_pembimbing,
			'id_gedung' => $request->id_gedung
		]);
		// alihkan halaman ke halaman jenis
		Alert::success('Success', 'Data Telah Terupdate');
		return redirect('/ruangan');
	}

	public function hapus($id)
	{
		// menghapus data jenis berdasarkan id yang dipilih
		DB::table('ruangan')->where('id_ruangan', $id)->delete();

		// alihkan halaman ke halaman ruangan
		Alert::success('Success', 'Data Telah Terhapus');
		return redirect('/ruangan');
	}
}
