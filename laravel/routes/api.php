<?php

use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\InventoriController;
use App\Http\Controllers\MobilitasController;
use App\Http\Controllers\ProfilController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

Route::post('cek_inventori', [InventoriController::class, 'cek_inventori']);
Route::post('profil', [ProfilController::class, 'index']);


Route::post('cek_mobilitas', [MobilitasController::class, 'cek_mobilitas']);


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
