<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetallePagoTable extends Migration
{
    public function up()
    {
        Schema::create('detalle_pago', function (Blueprint $table) {
            $table->increments('idDetalle_pago');
            $table->integer('Total')->nullable();
            $table->tinyInteger('descuento')->nullable();
            $table->date('fecha')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('detalle_pago');
    }
}
