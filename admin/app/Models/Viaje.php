<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Viaje extends Model
{
    use HasFactory;

    protected $table = 'viajes';
    protected $primaryKey = 'idViajes';

    protected $fillable = [
        'Destino',
        'Fecha',
        'estado',
        'Usuario_idUsuario',
        'pagos_idpagos',
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'Usuario_idUsuario');
    }

    public function pago()
    {
        return $this->belongsTo(Pago::class, 'pagos_idpagos');
    }

    public function sector()
    {
        return $this->belongsTo(Sector::class, 'Sector_id_sector');
    }
}
