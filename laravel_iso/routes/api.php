<?php

use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\DashboardController;
use App\Http\Controllers\API\InventoriController;
use App\Http\Controllers\API\MobilitasController;
use App\Http\Controllers\API\PeminjamanController;
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

Route::post('dashboard', [DashboardController::class, 'index']);
Route::post('cek_inventori', [InventoriController::class, 'cek_inventori']);
Route::post('profil', [ProfilController::class, 'index']);

Route::post('tambah_mobilitas', [MobilitasController::class, 'tambah_mobilitas']);
Route::post('cek_mobilitas', [MobilitasController::class, 'cek_mobilitas']);
Route::post('get_mobilitas', [MobilitasController::class, 'get_mobilitas']);
Route::post('selesai_mobilitas', [MobilitasController::class, 'selesai_mobilitas']);
Route::post('hapus_mobilitas', [MobilitasController::class, 'hapus_mobilitas']);
Route::post('log_mobilitas', [MobilitasController::class, 'log_mobilitas']);

Route::post('get_gedung_ruangan', [MobilitasController::class, 'get_gedung_ruuangan']);

Route::post('tambah_keranjang_peminjaman', [PeminjamanController::class, 'tambah_keranjang_peminjaman']);
Route::post('cek_keranjang_peminjaman', [PeminjamanController::class, 'cek_peminjaman']);
Route::post('get_keranjang_peminjaman', [PeminjamanController::class, 'get_keranjang_peminjaman']);
Route::post('tambah_peminjaman', [PeminjamanController::class, 'tambah_peminjaman']);

Route::post('detail_peminjaman', [PeminjamanController::class, 'detail_peminjaman']);

Route::post('persetujuan_data', [PeminjamanController::class, 'persetujuan_data']);
Route::post('persetujuan_wadir', [PeminjamanController::class, 'persetujuan_wadir']);
Route::post('persetujuan_pembimbing', [PeminjamanController::class, 'persetujuan_pembimbing']);
// Route::post('hapus_mobilitas', [PeminjamanController::class, 'hapus_mobilitas']);
// Route::post('log_mobilitas', [PeminjamanController::class, 'log_mobilitas']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
