<?php

namespace App\Http\Controllers;

use App\Models\Estacionamiento;
use App\Models\Sector;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        // Obtener la cantidad de estacionamientos por sector
        $estacionamientosPorSector = Estacionamiento::select('Sector_id_sector', \DB::raw('count(*) as total'))
            ->groupBy('Sector_id_sector')
            ->get();

        // Preparar los datos para la vista
        $sectores = [];
        $totales = [];

        foreach ($estacionamientosPorSector as $estacionamiento) {
            // Obtener el nombre del sector si es necesario
            $sector = Sector::find($estacionamiento->Sector_id_sector);
            $sectores[] = $sector ? $sector->direccion : 'Desconocido'; // Asumiendo que 'direccion' es el nombre del sector
            $totales[] = $estacionamiento->total;
        }

        return view('dashboard', compact('sectores', 'totales'));
    }
}
