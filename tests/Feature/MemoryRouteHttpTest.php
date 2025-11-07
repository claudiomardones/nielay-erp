<?php

namespace Tests\Feature;

use Tests\TestCase;

class MemoryRouteHttpTest extends TestCase
{
    public function test_memory_route_endpoint_ok(): void
    {
        $resp = $this->get('/memory/route?q=ESTADO%20PROYECTO');
        $resp->assertStatus(200)
             ->assertJson(['ok' => true]);
    }
}
