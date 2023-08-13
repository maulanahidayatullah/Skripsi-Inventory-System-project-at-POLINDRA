<?php

namespace App\Http\Controllers;

use App\Models\User;
use DB;
use DataTables;
use Alert;
use App\Models\Instansi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{


    public function AuthRouteAPI(Request $request)
    {
        return $request->user();
    }

    public function index2()
    {
        return view('auth.login');
    }

    public function index()
    {
        $instansi = Instansi::get();
        $user = DB::table("users")->get();
        return view('user.view', compact('user', 'instansi'));
    }

    public function pj()
    {
        $user = DB::table("users")->where('level', 'pj')->get();
        $ruangan = DB::table('ruangan')->get();
        return view('pj.view', compact('user', 'ruangan'));
    }

    public function rayon()
    {

        $user = DB::table("users")->where('level', 'rayon')->get();

        $ruangan = DB::table('ruangan')->get();

        return view('rayon.view', compact('user', 'ruangan'));
    }

    public function bukan_pj()
    {

        $user = DB::table("users")->where('level', 'bukan_pj')->get();

        return view('bukan_pj.view', compact('user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        // return $request;

        $request->validate([
            'email' => 'required|unique:users',
            'username' => 'required|unique:users',
        ]);

        $password = Hash::make($request->password);
        // $data = array_replace($request->all(), ['password' => $password]);

        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'username' => $request->username,
            'password' => $password,
            'level' => $request->level,
            'no_hp' => $request->no_hp,
            'alamat' => $request->alamat,
            'instansi_id' => $request->instansi_id,
        ]);

        // User::create($data);
        Alert::success('Success', 'Data Telah Terinput');
        return redirect()->back();
    }

    public function show(User $user)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = DB::table('users')->where('id', $id)->first();
        // $user = DB::table('users')->get();
        $instansi = Instansi::get();


        return view('user.edit', compact('user', 'instansi'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        // return $request;
        if (!empty($request->new_password)) {
            $new_password = Hash::make($request->new_password);
            DB::table('users')->where('id', $request->id)->update([
                'name' => $request->name,
                'email' => $request->email,
                'username' => $request->username,
                'password' => $new_password,
                'level' => $request->level,
                'no_hp' => $request->no_hp,
                'alamat' => $request->alamat,
                'instansi_id' => $request->instansi_id,
            ]);
        } else {
            DB::table('users')->where('id', $request->id)->update([
                'name' => $request->name,
                'email' => $request->email,
                'username' => $request->username,
                'level' => $request->level,
                'no_hp' => $request->no_hp,
                'alamat' => $request->alamat,
                'instansi_id' => $request->instansi_id,
            ]);
        }


        Alert::success('Success', 'Data Telah Terupdate');
        return redirect()->route('user.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user)
    {
        $user->delete();
        Alert::success('Success', 'Data Telah Terhapus');
        return redirect()->back();
    }

    // instansi

    public function instansi()
    {
        $instansi = Instansi::get();
        return view('instansi.view', compact('instansi'));
    }

    public function instansi_store(Request $request)
    {
        DB::table('instansi')->insert([
            'nama' => $request->instansi,

        ]);
        // alihkan halaman ke halaman jenis
        Alert::success('Success', 'Data Telah Terinput');
        return redirect('/instansi');
    }

    public function instansi_edit($id)
    {

        $instansi = DB::table('instansi')->where('id', $id)->first();

        return view('instansi.edit', compact('instansi'));
    }

    public function instansi_update(Request $request)
    {
        DB::table('instansi')->where('id', $request->id_instansi)->update([
            'nama' => $request->instansi,
        ]);

        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/instansi');
    }

    public function instansi_delete($id)
    {
        // menghapus data jenis berdasarkan id yang dipilih
        DB::table('instansi')->where('id', $id)->delete();

        // alihkan halaman ke halaman ruangan
        Alert::success('Success', 'Data Telah Terhapus');
        return redirect('/instansi');
    }

    //pj

    public function store_pj(Request $request)
    {

        $request->validate([
            'email' => 'required|unique:users',
            'username' => 'required|unique:users',
        ]);

        $password = Hash::make($request->password);
        $data = array_replace($request->all(), ['password' => $password]);

        User::create($data);
        Alert::success('Success', 'Data Telah Terinput');
        return redirect()->back();
    }

    public function edit_pj($id)
    {
        $user2 = DB::table('users')->where('id', $id)->first();


        $ruangan = DB::table('ruangan')->get();

        return view('pj.edit', compact('ruangan', 'user2'));
    }

    public function update_pj(Request $request)
    {

        DB::table('users')->where('id', $request->id)->update([
            'name' => $request->name,
            'email' => $request->email,
            'username' => $request->username,

        ]);

        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/pj');
    }

    //rayon

    public function store_rayon(Request $request)
    {

        $request->validate([
            'email' => 'required|unique:users',
            'username' => 'required|unique:users',
        ]);

        $password = Hash::make($request->password);
        $data = array_replace($request->all(), ['password' => $password]);

        User::create($data);
        Alert::success('Success', 'Data Telah Terinput');
        return redirect()->back();
    }

    public function edit_rayon($id)
    {
        $user2 = DB::table('users')->where('id', $id)->first();


        $ruangan = DB::table('ruangan')->get();

        return view('rayon.edit', compact('ruangan', 'user2'));
    }

    public function update_rayon(Request $request)
    {

        DB::table('users')->where('id', $request->id)->update([
            'name' => $request->name,
            'email' => $request->email,
            'username' => $request->username,

        ]);

        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/rayon');
    }

    //bukan pj

    public function store_bukan_pj(Request $request)
    {

        $request->validate([
            'email' => 'required|unique:users',
            'username' => 'required|unique:users',
        ]);

        $password = Hash::make($request->password);
        $data = array_replace($request->all(), ['password' => $password]);

        User::create($data);
        Alert::success('Success', 'Data Telah Terinput');
        return redirect()->back();
    }

    public function edit_bukan_pj($id)
    {
        $user2 = DB::table('users')->where('id', $id)->first();


        $ruangan = DB::table('ruangan')->get();

        return view('bukan_pj.edit', compact('ruangan', 'user2'));
    }

    public function update_bukan_pj(Request $request)
    {

        DB::table('users')->where('id', $request->id)->update([
            'name' => $request->name,
            'email' => $request->email,
            'username' => $request->username,

        ]);

        Alert::success('Success', 'Data Telah Terupdate');
        return redirect('/bukan_pj');
    }
}
