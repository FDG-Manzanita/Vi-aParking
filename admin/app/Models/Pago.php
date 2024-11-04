<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pago extends Model
{
    use HasFactory;

    protected $table = 'pagos';
    protected $primaryKey = 'idpagos';

    protected $fillable = [
        'Tiempo_total',
        'Tiempo_inicio',
        'Detalle_pago_idDetalle_pago',
        'tarifa',
    ];

    public function detallePago()
    {
        return $this->belongsTo(DetallePago::class, 'Detalle_pago_idDetalle_pago');
    }

    public function viajes()
    {
        return $this->hasMany(Viaje::class, 'pagos_idpagos');
    }

    public function tarifas()
    {
        return $this->hasMany(Tarifa::class, 'pagos_idpagos');
    }
}
