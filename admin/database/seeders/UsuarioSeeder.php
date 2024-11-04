<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Usuario;
use Illuminate\Support\Facades\Hash;

class UsuarioSeeder extends Seeder
{
    public function run()
    {
        Usuario::create([
            'Nombre' => 'Nombre',
            'Apellido' => 'Apellido',
            'telefono' => '123456789',
            'Email' => 'xase@gmail.com',
            'contraseña' => Hash::make('1234'), // Hashea la contraseña
            'tipo' => 'administrador', // Opcional
            'Direccion' => 'Dirección Ejemplo' // Opcional
        ]);
    }
}
