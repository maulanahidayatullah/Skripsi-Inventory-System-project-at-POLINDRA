<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required',
            'confirm_password' => 'required|same:password'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Silahkan Ulangi',
                'data'    => $validator->errors()
            ]);
        }

        $input = $request->all();
        $input['password'] = bcrypt($request['password']);

        $user = User::create($input);

        $success['token']   = $user->createToken('auth_token')->plainTextToken;
        $success['name']    = $user->name;
        $success['level']   = $user->level;

        return response()->json([
            'success' => true,
            'message' => 'Sukses',
            'data'    => $success
        ], 200);
    }

    public function login(Request $request)
    {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $auth = Auth::user();
            $success['token'] = $auth->createToken('auth_token')->plainTextToken;
            $success['name'] = $auth->name;
            $success['email'] = $auth->email;
            $success['level']   = $auth->level;

            return response()->json([
                'success' => true,
                'message' => 'Login Sukses',
                'data' => $success
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Login Gagal',
                'data' => null
            ], 400);
        }
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Berhail Logout',
            'data' => null
        ], 200);
    }
}
