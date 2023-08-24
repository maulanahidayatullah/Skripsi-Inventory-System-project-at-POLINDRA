<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Pegawai;
use App\Models\User;
use Illuminate\Http\Request;

class ProfilController extends Controller
{
    public function index(Request $request)
    {
        $profil = User::where('id', $request->user_id)->first();

        if (!empty($profil)) {
            if ($profil->level == 'user_1') {
                $profil['jabatan'] = "Admin 1";
            } elseif ($profil->level == 'user_2') {
                $profil['jabatan'] = "Admin 2";
            } elseif ($profil->level == 'user_3') {
                $profil['jabatan'] = "Pegawai / Mahasiswa";
            } elseif ($profil->level == 'user_4') {
                $profil['jabatan'] = "Pembimbing Organisasi / Penanggung Jawab Instansi";
            } else {
                $profil['jabatan'] = "Wakil Direktur 2";
            }

            $profil['instansi'] = $profil->Instansi->nama;
            return response()->json([
                'success' => true,
                'data' => $profil
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                // 'data' => $inventori
            ], 400);
        }
    }
}
