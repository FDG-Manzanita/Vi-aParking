<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePagosTable extends Migration
{
    public function up()
    {
        Schema::create('pagos', function (Blueprint $table) {
            $table->increments('idpagos');
            $table->integer('Tiempo_total')->nullable();
            $table->integer('Tiempo_inicio')->nullable();
            $table->unsignedInteger('Detalle_pago_idDetalle_pago');
            $table->integer('tarifa')->nullable();
            $table->foreign('Detalle_pago_idDetalle_pago')->references('idDetalle_pago')->on('detalle_pago');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('pagos');
    }
}
