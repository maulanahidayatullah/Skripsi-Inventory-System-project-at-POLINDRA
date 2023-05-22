<?php

use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\InventoriController;
use App\Http\Controllers\API\MobilitasController;
use App\Http\Controllers\API\ProfilController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

// Route::post('cek_inventori', [InventoriController::class, 'cek_inventori']);
// Route::post('profil', [ProfilController::class, 'index']);

// Route::post('tambah_mobilitas', [MobilitasController::class, 'tambah_mobilitas']);

// Route::post('cek_mobilitas', [MobilitasController::class, 'cek_mobilitas']);
// Route::post('selesai_mobilitas', [MobilitasController::class, 'selesai_mobilitas']);
// Route::post('log_mobilitas', [MobilitasController::class, 'log_mobilitas']);


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
