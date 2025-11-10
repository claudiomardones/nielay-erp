<?php

namespace App\Filament\Resources\Tenants;

use App\Filament\Resources\Tenants\TenantResource\Pages;
use App\Models\Tenant;
use Filament\Resources\Resource;
use Filament\Schemas\Components\TextInput;
use Filament\Schemas\Schema;
use Filament\Tables;
use Filament\Tables\Table;

class TenantResource extends Resource
{
    protected static ?string $model = Tenant::class;

    public static function canViewAny(): bool
    {
        return true;
    }

    public static function schema(Schema $schema): Schema
    {
        return $schema->schema([
            TextInput::make('name')->required()->label('Nombre'),
            TextInput::make('code')->disabled()->label('Código'),
            TextInput::make('status')->default('active')->label('Estado'),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')->label('Nombre'),
                Tables\Columns\TextColumn::make('code')->label('Código'),
                Tables\Columns\TextColumn::make('status')->label('Estado'),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ManageTenants::route('/'),
        ];
    }
}