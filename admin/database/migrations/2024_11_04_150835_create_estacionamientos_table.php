<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEstacionamientosTable extends Migration
{
    public function up()
    {
        Schema::create('estacionamientos', function (Blueprint $table) {
            $table->increments('Id_Estacionamiento');
            $table->string('Nombre')->nullable();
            $table->string('Ubicación')->nullable();
            $table->integer('Cupostotales')->nullable();
            $table->integer('Cuposdisponibles')->nullable();
            $table->string('estado')->nullable();
            $table->unsignedInteger('Sector_id_sector');
            $table->foreign('Sector_id_sector')->references('id_sector')->on('sector');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('estacionamientos');
    }
}
