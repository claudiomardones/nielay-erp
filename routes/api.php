use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Services\MemoryRouterService;

Route::middleware(['memkey'])->get('/memory/route', function (Request $request, MemoryRouterService $svc) {
    $q = (string) $request->query('q', '');
    if (trim($q) === '') {
        return response()->json(['ok'=>false,'msg'=>'Parámetro q requerido'], 400);
    }
    $limit = (int) $request->query('limit', 5);
    try {
        return response()->json([
            'ok' => true,
            'query' => $q,
            'results' => $svc->search($q, $limit),
        ], 200);
    } catch (\Throwable $e) {
        return response()->json(['ok'=>false,'msg'=>$e->getMessage()], 500);
    }
});
