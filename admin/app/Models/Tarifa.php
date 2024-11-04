<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tarifa extends Model
{
    use HasFactory;

    protected $table = 'tarifas';
    protected $primaryKey = 'idTarifas';

    protected $fillable = [
        'Precio',
        'tiempo',
        'tipo',
        'Estacionamientos_Id_Estacionamiento',
        'Estacionamientos_Sector_id_sector',
        'pagos_idpagos',
    ];

    public function estacionamiento()
    {
        return $this->belongsTo(Estacionamiento::class, ['Estacionamientos_Id_Estacionamiento', 'Estacionamientos_Sector_id_sector']);
    }

    public function pago()
    {
        return $this->belongsTo(Pago::class, 'pagos_idpagos');
    }
}
