<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetallePago extends Model
{
    use HasFactory;

    protected $table = 'detalle_pago'; // Nombre de la tabla
    protected $primaryKey = 'idDetalle_pago'; // Clave primaria

    protected $fillable = [
        'Total',
        'descuento',
        'fecha',
    ];

    public function pagos()
    {
        return $this->hasMany(Pago::class, 'Detalle_pago_idDetalle_pago');
    }
}
