<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSectorTable extends Migration
{
    public function up()
    {
        Schema::create('sector', function (Blueprint $table) {
            $table->increments('id_sector');
            $table->string('direccion')->nullable();
            $table->integer('ubicación')->nullable();
            $table->unsignedInteger('Encargados_idEncargado');
            $table->unsignedInteger('Viajes_idViajes');
            $table->foreign('Encargados_idEncargado')->references('idEncargado')->on('encargados');
            $table->foreign('Viajes_idViajes')->references('idViajes')->on('viajes');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('sector');
    }
}
