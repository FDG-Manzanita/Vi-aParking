<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsuariosTable extends Migration
{
    public function up()
    {
        Schema::create('usuarios', function (Blueprint $table) {
            $table->id('idUsuario');
            $table->string('Nombre');
            $table->string('Apellido');
            $table->integer('telefono')->nullable();
            $table->string('contraseña');
            $table->string('tipo', 5);
            $table->string('Direccion')->nullable();
            $table->string('Email')->unique();
            $table->timestamps();
        });
    }



    public function down()
    {
        Schema::dropIfExists('usuarios');
    }
}
