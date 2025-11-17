<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        $systemTenant = DB::table('newenia_global_core.tenants')->where('code', 'SYSTEM')->first();
        if (!$systemTenant) {
            $systemTenantId = DB::table('newenia_global_core.tenants')->insertGetId(['code' => 'SYSTEM', 'name' => 'System', 'status' => 'active', 'created_at' => now(), 'updated_at' => now()]);
        } else {
            $systemTenantId = $systemTenant->id;
        }
        $existingUser = DB::table('newenia_global_core.users')->where('email', 'admin@nielay.com')->first();
        if ($existingUser) { $this->command->info('Usuario admin@nielay.com ya existe.'); return; }
        DB::table('newenia_global_core.users')->insert(['tenant_id' => $systemTenantId, 'email' => 'admin@nielay.com', 'name' => 'Admin NIELAY', 'password' => Hash::make('nielay2025'), 'role' => 'admin', 'is_active' => true, 'created_at' => now(), 'updated_at' => now()]);
        $this->command->info('✅ Usuario admin creado'); $this->command->info('📧 Email: admin@nielay.com'); $this->command->info('🔑 Password: nielay2025');
    }
}