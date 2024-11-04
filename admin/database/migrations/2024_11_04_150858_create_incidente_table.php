<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateIncidenteTable extends Migration
{
    public function up()
    {
        Schema::create('Incidente', function (Blueprint $table) {
            $table->increments('idIncidente');
            $table->string('descripcion')->nullable();
            $table->string('estado')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('Incidente');
    }
}
