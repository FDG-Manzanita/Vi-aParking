<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function showLoginForm()
    {
        return view('login');
    }

    public function login(Request $request)
    {
        $request->validate([
            'Email' => 'required|email',
            'contraseña' => 'required',
        ]);

        $user = Usuario::where('Email', $request->Email)->first();

        if ($user && $user->tipo === 'admin') {
            // Comparación de la contraseña en texto plano sin encriptación
            if ($user->contraseña === $request->contraseña) {
                // Autenticar al usuario y redirigir
                Auth::login($user);
                return redirect()->route('dashboard');
            }
        }

        return back()->withErrors([
            'email' => 'Las credenciales no coinciden con nuestros registros.',
        ]);
    }

    public function dashboard()
    {
        return view('dashboard');
    }

    public function logout(Request $request)
    {
        Auth::logout();
        return redirect()->route('login');
    }
}
