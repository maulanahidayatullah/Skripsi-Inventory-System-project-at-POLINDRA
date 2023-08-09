<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pelabelan extends Model
{
    protected $table = 'pelabelan';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];

    public function Inventori()
    {
        return $this->belongsTo(Inventori::class, 'inventori_id', 'id');
    }

    public function User()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
