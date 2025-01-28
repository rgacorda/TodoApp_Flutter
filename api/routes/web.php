<?php

use App\Http\Controllers\TodoController;
use Illuminate\Support\Facades\Route;

// Route::get('/', function () {
//     return view('server api working');
// });

Route::apiResource('todos',TodoController::class);
Route::patch('/todos/{todo}/toggle', [TodoController::class, 'tick']);