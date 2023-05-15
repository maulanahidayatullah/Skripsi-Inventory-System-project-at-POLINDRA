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
        $profil = Pegawai::where('user_id', $request->user_id)->first();

        if (!empty($profil)) {
            $email = User::where('id', $request->user_id)->first()->email;
            $profil['email'] = $email;

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
