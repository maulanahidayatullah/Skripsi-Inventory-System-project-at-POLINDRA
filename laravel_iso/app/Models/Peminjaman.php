<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Peminjaman extends Model
{
    protected $table = 'peminjaman';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];

    public function User()
    {
        return $this->hasOne(User::class, 'id', 'user_id')->withDefault();
    }

    public function Inventori()
    {
        return $this->hasOne(Inventori::class, 'id', 'inventori_id');
    }
}
