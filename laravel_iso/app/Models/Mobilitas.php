<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mobilitas extends Model
{
    protected $table = 'mobilitas';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];
}
