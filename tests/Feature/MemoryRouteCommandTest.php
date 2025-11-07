<?php

namespace Tests\Feature;

use Tests\TestCase;

class MemoryRouteCommandTest extends TestCase
{
    public function test_memory_route_command_runs(): void
    {
        $this->artisan('memory:route ESTADO PROYECTO --limit=2')
            ->assertSuccessful();
    }
}
