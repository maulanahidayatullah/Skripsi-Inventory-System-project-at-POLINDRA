<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mobilitas extends Model
{
    protected $table = 'mobilitas';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];


    public function Gedung()
    {
        return $this->hasOne(Gedung::class, 'id_gedung', 'gedung_id');
    }

    public function User()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function Inventori()
    {
        return $this->hasOne(Inventori::class, 'id', 'inventori_id');
    }

    public function Ruangan()
    {
        return $this->hasOne(Ruangan::class, 'id_ruangan', 'ruangan_id');
    }
}
