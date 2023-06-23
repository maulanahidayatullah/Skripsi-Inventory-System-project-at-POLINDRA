<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LogPeminjaman extends Model
{
    protected $table = 'log_peminjaman';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];
}
