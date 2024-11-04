<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Encargado extends Model
{
    use HasFactory;

    protected $table = 'encargados';
    protected $primaryKey = 'idEncargado';

    protected $fillable = [
        'nombre',
        'apellido',
    ];

    public function sectores()
    {
        return $this->hasMany(Sector::class, 'Encargados_idEncargado');
    }
}
