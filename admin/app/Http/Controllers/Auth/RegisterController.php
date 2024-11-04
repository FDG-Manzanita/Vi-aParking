<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Usuario;
use Illuminate\Http\Request;

class RegisterController extends Controller
{
    public function showRegistrationForm()
    {
        return view('auth.register');
    }

    public function register(Request $request)
    {
        // Validar los datos del usuario
        $request->validate([
            'Nombre' => 'required|string|max:255',
            'Apellido' => 'required|string|max:255',
            'telefono' => 'required|string|max:20',
            'contraseña' => 'required|string|min:8|confirmed',
            'tipo' => 'required|string', // Por ejemplo, 'admin' o 'user'
            'Direccion' => 'required|string|max:255',
            'Email' => 'required|email|unique:usuarios,Email',
        ]);

        // Crear el nuevo usuario
        $usuario = new Usuario();
        $usuario->Nombre = $request->Nombre;
        $usuario->Apellido = $request->Apellido;
        $usuario->telefono = $request->telefono;
        $usuario->contraseña = bcrypt($request->contraseña); // Encriptar contraseña antes de guardar
        $usuario->tipo = $request->tipo;
        $usuario->Direccion = $request->Direccion;
        $usuario->Email = $request->Email;

        // Guardar el usuario en la base de datos
        $usuario->save();

        // Redirigir al usuario o mostrar un mensaje de éxito
        return redirect()->route('login')->with('success', 'Registro exitoso. Por favor, inicie sesión.');
    }
}
