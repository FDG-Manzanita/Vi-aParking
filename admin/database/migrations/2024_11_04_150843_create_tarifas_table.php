<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTarifasTable extends Migration
{
    public function up()
    {
        Schema::create('tarifas', function (Blueprint $table) {
            $table->increments('idTarifas');
            $table->integer('Precio')->nullable();
            $table->integer('tiempo')->nullable();
            $table->string('tipo', 15)->nullable();
            $table->unsignedInteger('Estacionamientos_Id_Estacionamiento');
            $table->unsignedInteger('Estacionamientos_Sector_id_sector');
            $table->unsignedInteger('pagos_idpagos');
            $table->foreign(['Estacionamientos_Id_Estacionamiento', 'Estacionamientos_Sector_id_sector'])->references(['Id_Estacionamiento', 'Sector_id_sector'])->on('estacionamientos');
            $table->foreign('pagos_idpagos')->references('idpagos')->on('pagos');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('tarifas');
    }
}
