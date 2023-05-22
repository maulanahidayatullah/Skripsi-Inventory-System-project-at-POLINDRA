<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inventori extends Model
{
    protected $table = 'inventori';
    protected $primaryKey = 'id';

    public function Gedung()
    {
        return $this->hasOne(Gedung::class, 'id_gedung', 'gedung_id');
    }

    public function Ruangan()
    {
        return $this->hasOne(Ruangan::class, 'id_ruangan', 'ruangan_id');
    }
}
