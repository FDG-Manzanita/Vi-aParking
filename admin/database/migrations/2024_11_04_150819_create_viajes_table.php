<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateViajesTable extends Migration
{
    public function up()
    {
        Schema::create('viajes', function (Blueprint $table) {
            $table->increments('idViajes');
            $table->string('Destino')->nullable();
            $table->string('Fecha')->nullable();
            $table->tinyInteger('estado')->nullable();
            $table->unsignedInteger('Usuario_idUsuario');
            $table->unsignedInteger('pagos_idpagos');
            $table->foreign('Usuario_idUsuario')->references('idUsuario')->on('usuarios');
            $table->foreign('pagos_idpagos')->references('idpagos')->on('pagos');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('viajes');
    }
}
