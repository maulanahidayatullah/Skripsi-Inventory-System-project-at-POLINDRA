<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LogMobilitas extends Model
{
    protected $table = 'log_mobilitas';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];
}
