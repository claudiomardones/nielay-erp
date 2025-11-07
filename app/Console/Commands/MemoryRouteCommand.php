<?php
namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\MemoryRouterService;

class MemoryRouteCommand extends Command
{
    protected $signature = 'memory:route {query*} {--limit=3}';
    protected $description = 'Consulta el Memory Router contra /var/www/nielay-system/docs';

    public function handle(MemoryRouterService $svc): int
    {
        $q = implode(' ', $this->argument('query'));
        $limit = (int)$this->option('limit');
        $res = $svc->search($q, $limit);

        if (empty($res)) {
            $this->warn('Sin resultados.');
            return self::SUCCESS;
        }

        foreach ($res as $i => $r) {
            $this->line(sprintf(
                "%d) [%d] %s\n    %s\n",
                $i+1,
                $r["score"],
                $r["file"],
                preg_replace("/\s+/", " ", $r["snippet"])
            ));
        }
        return self::SUCCESS;
    }
}
