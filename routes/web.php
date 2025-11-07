<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Homepage
|--------------------------------------------------------------------------
| Redirige la raíz al panel de Filament.
*/
Route::get('/', function () {
    return redirect('/admin');
});





Route::middleware('web')->group(function () {

    Route::get('/login-direct', function () {
        $user = \App\Models\User::where('email', 'claudiomardoneso@gmail.com')->first();
        
        if (!$user) {
            return 'Usuario no encontrado';
        }
        
        \Filament\Facades\Filament::auth()->login($user, true);
        
        return redirect('/admin');
    });

    Route::get('/diagnostic-full', function () {
        $user = \App\Models\User::find(2);
        
        Auth::login($user, true);
        \Filament\Facades\Filament::auth()->login($user, true);
        
        $panel = \Filament\Facades\Filament::getDefaultPanel();
        
        return response()->json([
            'user_implements_filament' => $user instanceof \Filament\Models\Contracts\FilamentUser,
            'can_access_panel' => $user->canAccessPanel($panel),
            'laravel_auth_check' => Auth::check(),
            'filament_auth_check' => \Filament\Facades\Filament::auth()->check(),
            'session_id' => session()->getId(),
        ]);
    });

});

Route::post('/simple-login', function () {
    $credentials = [
        'email' => request('email'),
        'password' => request('password'),
    ];
    
    if (Auth::attempt($credentials, true)) {
        request()->session()->regenerate();
        return redirect('/admin');
    }
    
    return back()->withErrors(['email' => 'Credenciales incorrectas']);
});

Route::get('/simple-login-form', function () {
    return '
    <!DOCTYPE html>
    <html>
    <head><title>Simple Login</title></head>
    <body>
    <h1>Simple Login</h1>
    <form method="POST" action="/simple-login">
        '.csrf_field().'
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <button type="submit">Login</button>
    </form>
    </body>
    </html>';
});



/*
|--------------------------------------------------------------------------
| Memory Router API (simple)
|--------------------------------------------------------------------------
*/
use Illuminate\Http\Request;
use App\Services\MemoryRouterService;

Route::get('/memory/route', function (Request $request, MemoryRouterService $svc) {
    $q = (string) $request->query('q', '');
    if (trim($q) === '') {
        return response()->json(['ok'=>false,'msg'=>'Parámetro q requerido'], 400);
    }
    $limit = (int) $request->query('limit', 3);
    return response()->json(['ok'=>true,'query'=>$q,'results'=>$svc->search($q, $limit)]);
});

require __DIR__.'/memory.php';
