<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Models\User;
use Filament\Resources\Resource;
use Filament\Schemas\Components\Select;
use Filament\Schemas\Components\TextInput;
use Filament\Schemas\Components\Toggle;
use Filament\Schemas\Schema;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserResource extends Resource
{
    protected static ?string $model = User::class;

    public static function schema(Schema $schema): Schema
    {
        return $schema->schema([
            Select::make('tenant_id')->label('Empresa')
                ->options(fn() => DB::table('newenia_global_core.tenants')->pluck('name', 'id'))
                ->required()->searchable(),
            TextInput::make('name')->label('Nombre Completo')->required()->maxLength(255),
            TextInput::make('email')->label('Email')->email()->required()->unique(ignoreRecord: true)->maxLength(255),
            Select::make('role')->label('Rol')
                ->options(['superadmin' => 'Super Admin', 'admin' => 'Admin Empresa', 'user' => 'Usuario'])
                ->required()->default('user'),
            TextInput::make('password')->label('Contraseña')->password()
                ->dehydrateStateUsing(fn ($state) => $state ? Hash::make($state) : null)
                ->dehydrated(fn ($state) => filled($state))
                ->required(fn (string $context): bool => $context === 'create')->maxLength(255),
            Toggle::make('is_active')->label('Activo')->default(true),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table->columns([
            Tables\Columns\TextColumn::make('id')->label('ID')->sortable(),
            Tables\Columns\TextColumn::make('tenant_id')->label('Empresa')
                ->formatStateUsing(fn ($state) => DB::table('newenia_global_core.tenants')->where('id', $state)->value('name') ?? 'N/A'),
            Tables\Columns\TextColumn::make('name')->label('Nombre')->searchable()->sortable(),
            Tables\Columns\TextColumn::make('email')->label('Email')->searchable()->sortable(),
            Tables\Columns\BadgeColumn::make('role')->label('Rol')
                ->colors(['danger' => 'superadmin', 'warning' => 'admin', 'success' => 'user']),
            Tables\Columns\IconColumn::make('is_active')->label('Activo')->boolean(),
        ]);
    }

    public static function getPages(): array
    {
        return ['index' => Pages\ListUsers::route('/'), 'create' => Pages\CreateUser::route('/create'), 'edit' => Pages\EditUser::route('/{record}/edit')];
    }
}