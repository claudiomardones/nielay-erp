<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('role', 50)->default('tenant_user')->after('password');
            $table->bigInteger('tenant_id')->default(0)->after('role');
            $table->bigInteger('current_tenant_id')->nullable()->after('tenant_id');
            
            $table->index('role');
            $table->index('tenant_id');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['role', 'tenant_id', 'current_tenant_id']);
        });
    }
};
