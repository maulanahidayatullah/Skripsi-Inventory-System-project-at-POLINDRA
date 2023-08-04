<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pelabelan extends Model
{
    protected $table = 'pelabelan';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];
}
