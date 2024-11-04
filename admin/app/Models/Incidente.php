<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Incidente extends Model
{
    use HasFactory;

    protected $table = 'Incidente';
    protected $primaryKey = 'idIncidente';

    protected $fillable = [
        'descripcion',
        'estado',
    ];
}
