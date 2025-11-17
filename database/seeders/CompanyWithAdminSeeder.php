<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
class CompanyWithAdminSeeder extends Seeder
{
    public function run(): void
    {
        $companies = [
            ['tenant' => ['code' => 'DEMO-COBRANZA', 'name' => 'Empresa Demo Cobranzas', 'status' => 'active'], 'admin' => ['name' => 'Admin Demo', 'email' => 'admin@democobranza.cl', 'password' => 'demo2025', 'role' => 'admin']],
            ['tenant' => ['code' => 'ACME-CORP', 'name' => 'ACME Corporation', 'status' => 'active'], 'admin' => ['name' => 'Juan Pérez', 'email' => 'jperez@acme.cl', 'password' => 'acme2025', 'role' => 'admin']],
        ];
        foreach ($companies as $company) { $this->createCompanyWithAdmin($company); }
        $this->command->info('✅ Empresas creadas'); $this->command->table(['Empresa', 'Email', 'Password'], array_map(function ($c) { return [$c['tenant']['name'], $c['admin']['email'], $c['admin']['password']]; }, $companies));
    }
    private function createCompanyWithAdmin(array $data): void
    {
        $existingTenant = DB::table('newenia_global_core.tenants')->where('code', $data['tenant']['code'])->first();
        if ($existingTenant) { $tenantId = $existingTenant->id; } else { $tenantId = DB::table('newenia_global_core.tenants')->insertGetId(['code' => $data['tenant']['code'], 'name' => $data['tenant']['name'], 'status' => $data['tenant']['status'], 'created_at' => now(), 'updated_at' => now()]); }
        $existingUser = DB::table('newenia_global_core.users')->where('email', $data['admin']['email'])->first();
        if ($existingUser) return;
        DB::table('newenia_global_core.users')->insert(['tenant_id' => $tenantId, 'email' => $data['admin']['email'], 'name' => $data['admin']['name'], 'password' => Hash::make($data['admin']['password']), 'role' => $data['admin']['role'], 'is_active' => true, 'created_at' => now(), 'updated_at' => now()]);
    }
}