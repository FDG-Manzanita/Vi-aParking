<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sector extends Model
{
    use HasFactory;

    protected $table = 'sector';
    protected $primaryKey = 'id_sector';

    protected $fillable = [
        'direccion',
        'ubicación',
        'Encargados_idEncargado',
        'Viajes_idViajes',
    ];

    public function encargado()
    {
        return $this->belongsTo(Encargado::class, 'Encargados_idEncargado');
    }

    public function estacionamientos()
    {
        return $this->hasMany(Estacionamiento::class, 'Sector_id_sector');
    }
}
