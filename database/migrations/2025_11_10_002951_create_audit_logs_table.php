<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('audit_logs', function (Blueprint $table) {
            $table->id();
            
            // Usuario que ejecuta la acción
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('user_email')->nullable(); // Por si el user se borra
            
            // Acción ejecutada
            $table->string('action', 50); // created, updated, deleted, login, logout, etc
            
            // Modelo afectado
            $table->string('auditable_type')->nullable(); // App\Models\Tenant
            $table->unsignedBigInteger('auditable_id')->nullable(); // ID del modelo
            
            // Valores antes/después (solo para updates)
            $table->json('old_values')->nullable();
            $table->json('new_values')->nullable();
            
            // Contexto adicional
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->json('metadata')->nullable(); // Datos extra relevantes
            
            // Multi-tenancy
            $table->unsignedBigInteger('tenant_id')->default(0);
            
            // Timestamps
            $table->timestamp('created_at')->useCurrent();
            
            // Índices para búsqueda rápida
            $table->index('user_id');
            $table->index('action');
            $table->index('auditable_type');
            $table->index('auditable_id');
            $table->index('tenant_id');
            $table->index('created_at');
            
            // Índice compuesto para queries comunes
            $table->index(['auditable_type', 'auditable_id']);
            $table->index(['tenant_id', 'created_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('audit_logs');
    }
};