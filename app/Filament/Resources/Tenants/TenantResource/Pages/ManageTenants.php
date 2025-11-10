<?php

namespace App\Filament\Resources\Tenants\TenantResource\Pages;

use App\Filament\Resources\Tenants\TenantResource;
use Filament\Actions;
use Filament\Resources\Pages\ManageRecords;

class ManageTenants extends ManageRecords
{
    protected static string $resource = TenantResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make()
                ->label('Nuevo Cliente'),
        ];
    }
}