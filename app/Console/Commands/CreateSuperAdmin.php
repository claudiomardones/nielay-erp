<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;

class CreateSuperAdmin extends Command
{
    protected $signature = 'user:create-admin';
    protected $description = 'Create super admin user';

    public function handle()
    {
        $user = User::where('email', 'claudiomardoneso@gmail.com')->first();
        
        if ($user) {
            $this->info('✅ Usuario ya existe');
            return;
        }

        User::create([
            'name' => 'Claudio Mardoneso',
            'email' => 'claudiomardoneso@gmail.com',
            'password' => bcrypt('Newenia.123'),
            'role' => 'super_admin',
            'tenant_id' => 0,
        ]);

        $this->info('✅ Usuario creado exitosamente');
    }
}
