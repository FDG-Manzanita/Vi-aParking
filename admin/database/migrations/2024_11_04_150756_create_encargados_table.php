<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEncargadosTable extends Migration
{
    public function up()
    {
        Schema::create('encargados', function (Blueprint $table) {
            $table->increments('idEncargado');
            $table->string('nombre')->nullable();
            $table->string('apellido')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('encargados');
    }
}
