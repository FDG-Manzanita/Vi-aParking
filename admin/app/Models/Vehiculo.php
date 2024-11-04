<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vehiculo extends Model
{
    use HasFactory;

    protected $table = 'vehiculos';
    protected $primaryKey = 'idVehiculo';

    protected $fillable = [
        'patente',
        'Usuario_idUsuario',
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'Usuario_idUsuario');
    }
}
