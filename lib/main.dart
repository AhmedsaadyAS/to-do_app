import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'To-Do List',
        theme: ThemeData(
          primaryColor: Colors.blue,
          hintColor: Colors.black,
          scaffoldBackgroundColor: Color.fromARGB(255, 50, 10, 143),
        ),
        home: TodoScreen(),
      ),
    );
  }
}

class TodoList extends ChangeNotifier {
  List<String> _todos = [];

  List<String> get todos => _todos;

  void add(String todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.playlist_add_check_circle),
              onPressed: () {},
            ),
            Text('To-Do List'),
          ],
        ),
      ),
      body: Consumer<TodoList>(
        builder: (context, todoList, child) {
          return Container(
            margin: EdgeInsets.all(20),
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:  const Color.fromARGB(255, 30, 30, 30),
            ),
            child: ListView.builder(
              itemCount: todoList.todos.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    
                    color: Colors.white,
                    shadowColor: Colors.black12,
                    
                    
                    
                    child: ListTile(
                      
                    
                    
                      title: Text(todoList.todos[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          todoList.remove(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodoScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              
              controller: _controller,
              decoration: InputDecoration(labelText: 'Todo'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<TodoList>(context, listen: false)
                    .add(_controller.text);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}