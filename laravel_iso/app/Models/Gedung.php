<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gedung extends Model
{
    protected $table = 'gedung';
    protected $primaryKey = 'id';

    public function Ruangan()
    {
        return $this->hasMany(Ruangan::class, 'id_gedung', 'id_gedung');
    }
}
