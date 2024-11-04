<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Estacionamiento extends Model
{
    use HasFactory;

    protected $table = 'estacionamientos';
    protected $primaryKey = 'Id_Estacionamiento';

    protected $fillable = [
        'Nombre',
        'Ubicación',
        'Cupostotales',
        'Cuposdisponibles',
        'estado',
        'Sector_id_sector',
    ];

    public function sector()
    {
        return $this->belongsTo(Sector::class, 'Sector_id_sector');
    }

    public function tarifas()
    {
        return $this->hasMany(Tarifa::class, ['Estacionamientos_Id_Estacionamiento', 'Estacionamientos_Sector_id_sector']);
    }
}
