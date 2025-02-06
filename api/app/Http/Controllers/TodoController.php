<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use Illuminate\Http\Request;

class TodoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Todo::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request -> validate([
            'title'=>'required|string|max:255',
            'image'=>'image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('todo_images', 'public');
        }

        return Todo::create([
            'title'=>$request->title,
            'image'=>$imagePath
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Todo $todo)
    {
        return $todo;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Todo $todo)
    {
        $request -> validate([
            'title'=>'required|string|max:255',
            'image'=>'image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('todo_images', 'public');
        }

        $todo->update([
            'title'=>$request->title,
            'image'=>$imagePath
        ]);
        return $todo;
    }

    public function tick(Todo $todo)
    {
        $todo->update([
            'completed'=>true,
        ]);
        $todo->save();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Todo $todo)
    {
        $todo->delete();
        return response()->noContent();
    }
}
