<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LogMobilitas extends Model
{
    protected $table = 'log_mobilitas';
    protected $primaryKey = 'id';

    protected $guarded = ['id'];

    public function User()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function MobilitasSebelum()
    {
        return $this->hasOne(Mobilitas::class, 'id', 'mobilitas_id_sebelum');
    }

    public function MobilitasSesudah()
    {
        return $this->hasOne(Mobilitas::class, 'id', 'mobilitas_id_sesudah');
    }
}
