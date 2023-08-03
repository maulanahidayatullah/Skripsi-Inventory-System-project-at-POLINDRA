<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inventori extends Model
{
    protected $table = 'inventori';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];

    public function Gedung()
    {
        return $this->hasOne(Gedung::class, 'id_gedung', 'gedung_id')->withDefault();
    }

    public function Ruangan()
    {
        return $this->hasOne(Ruangan::class, 'id_ruangan', 'ruangan_id')->withDefault();
    }

    public function Pegawai()
    {
        return $this->hasOne(Pegawai::class, 'id', 'pegawai_id')->withDefault();
    }
}
