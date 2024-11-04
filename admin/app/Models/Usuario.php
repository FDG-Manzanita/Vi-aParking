<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Auth\Authenticatable;

class Usuario extends Model implements AuthenticatableContract
{
    use HasFactory, Authenticatable;

    protected $table = 'usuarios'; // Nombre de la tabla
    protected $primaryKey = 'idUsuario'; // Clave primaria
    public $timestamps = false; // Desactivar timestamps

    protected $fillable = [
        'Nombre', 'Apellido', 'telefono', 'contraseña', 'tipo', 'Direccion', 'Email'
    ];

    // Oculta la contraseña al serializar el modelo
    protected $hidden = [
        'contraseña',
    ];
}
