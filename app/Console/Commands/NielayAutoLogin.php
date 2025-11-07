<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\URL;

class NielayAutoLogin extends Command
{
    protected $signature = 'nielay:login-link {email} {--minutes=15} {--ip=}';
    protected $description = 'Genera un link firmado y temporal para auto-login a /admin';

    public function handle(): int
    {
        $email   = $this->argument('email');
        $minutes = (int)$this->option('minutes');
        $params  = ['email' => $email];

        if ($ip = $this->option('ip')) {
            $params['ip'] = $ip;
        }

        $url = URL::temporarySignedRoute(
            'nielay.auto',
            now()->addMinutes($minutes),
            $params
        );

        $this->line($url);
        return self::SUCCESS;
    }
}
