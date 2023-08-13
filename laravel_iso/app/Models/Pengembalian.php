<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pengembalian extends Model
{
    protected $table = 'pengembalian';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];

    public function User()
    {
        return $this->hasOne(User::class, 'id', 'user_id')->withDefault();
    }

    public function Peminjaman()
    {
        return $this->hasOne(Peminjaman::class, 'id', 'peminjaman_id');
    }
}
