<?php
namespace App\Services;

use Nielay\Core\MemoryRouter\MemoryRouter;

class MemoryRouterService
{
    private MemoryRouter $router;

    public function __construct()
    {
        $this->router = new MemoryRouter('/var/www/nielay-system/docs');
    }

    public function search(string $q, int $limit = 3): array
    {
        return $this->router->route($q, $limit);
    }
}
