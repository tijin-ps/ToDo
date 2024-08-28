import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> _tasks = [];
  List<Map<String, String>> _filteredTasks = [];
  String _priority = 'Medium';
  bool isAddingTask = false;
  bool _isSearching = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _definitionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _drawerNameController = TextEditingController();
  final TextEditingController _drawerEmailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadUserData();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List<dynamic> taskList = json.decode(tasksString);
      setState(() {
        _tasks =
            taskList.map((task) => Map<String, String>.from(task)).toList();
        _filteredTasks = _tasks;
      });
    }
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _drawerNameController.text = prefs.getString('name') ?? 'Your Name';
      _drawerEmailController.text = prefs.getString('email') ?? 'Your Email';
    });
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksString = json.encode(_tasks);
    await prefs.setString('tasks', tasksString);
  }

  void _addOrEditTask({int? index}) async {
    if (index != null) {
      if (index < 0 || index >= _tasks.length || _tasks[index] == null) {
        print("Task at index $index does not exist.");
        return;
      }

      final task = _tasks[index];
      _nameController.text = task['name'] ?? '';
      _definitionController.text = task['definition'] ?? '';
      _priority = task['priority'] ?? 'Medium';
      _dateController.text = task['dueDate'] ?? '';
      _timeController.text = task['dueTime'] ?? '';
    } else {
      _nameController.clear();
      _definitionController.clear();
      _priority = 'Medium';
      _dateController.clear();
      _timeController.clear();
    }

    setState(() {
      isAddingTask = true;
    });

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.yellow.shade700,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.black,
          content: SizedBox(
            width: 400,
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      index == null ? 'Add Task' : 'Edit Task',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: TextStyle(color: Colors.yellow.shade700),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _definitionController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Task Definition',
                      labelStyle: TextStyle(color: Colors.yellow.shade700),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _priority,
                    dropdownColor: Colors.black,
                    items: ['Low', 'Medium', 'High']
                        .map((priority) => DropdownMenuItem(
                              value: priority,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    priority,
                                    style: TextStyle(
                                        color: Colors.yellow.shade700),
                                  ),
                                  if (priority != 'High')
                                    Divider(
                                      color: Colors.yellow.shade700,
                                      thickness: 1.5,
                                      height: 0,
                                    ),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'priority',
                      labelStyle: TextStyle(color: Colors.yellow.shade700),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _dateController,
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Select Date',
                            labelStyle:
                                TextStyle(color: Colors.yellow.shade700),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade700),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade700),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade700),
                            ),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _timeController,
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Select Time',
                            labelStyle:
                                TextStyle(color: Colors.yellow.shade700),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade700),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade700),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade700),
                            ),
                          ),
                          onTap: () => _selectTime(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.clear();
                _definitionController.clear();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                backgroundColor: Colors.yellow.shade700,
              ),
              child: Text(
                'Clear',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isAddingTask = false;
                });
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                backgroundColor: Colors.yellow.shade700,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _definitionController.text.isNotEmpty) {
                  setState(() {
                    if (index != null) {
                      _tasks[index] = {
                        'name': _nameController.text,
                        'definition': _definitionController.text,
                        'priority': _priority,
                        'dueDate': _dateController.text,
                        'dueTime': _timeController.text,
                      };
                    } else {
                      _tasks.add({
                        'name': _nameController.text,
                        'definition': _definitionController.text,
                        'priority': _priority,
                        'dueDate': _dateController.text,
                        'dueTime': _timeController.text,
                      });
                    }
                    _filteredTasks = _tasks;
                    isAddingTask = false;
                  });
                  _saveTasks();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Please enter both task name and definition.'),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                backgroundColor: Colors.yellow.shade700,
              ),
              child: Text(
                index == null ? 'Add Task' : 'Update Task',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (_dateController.text.isNotEmpty) {
      try {
        final dateFormat = DateFormat('dd-MM-yyyy');
        initialDate = dateFormat.parse(_dateController.text);
      } catch (e) {
        print("Error parsing date: $e");
        initialDate = DateTime.now();
      }
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(date);
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (_timeController.text.isNotEmpty) {
      final parsedTime = TimeOfDay(
        hour: int.parse(_timeController.text.split(":")[0]),
        minute: int.parse(_timeController.text.split(":")[1]),
      );
      initialTime = parsedTime;
    }

    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        _timeController.text = _formatTime(picked);
      });
    }
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Delete Task',
              style: TextStyle(color: Colors.yellow.shade700),
            ),
          ),
          content: Text(
            'Are you sure you want to delete this task?',
            style: TextStyle(color: Colors.yellow.shade700),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.yellow.shade700),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                  _filteredTasks = _tasks;
                });
                _saveTasks();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.yellow.shade700),
              ),
            ),
          ],
        );
      },
    );
  }

  void _searchTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTasks = _tasks;
        _isSearching = false;
      } else {
        _filteredTasks = _tasks
            .where((task) =>
                task['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _isSearching = true;
      }
    });
  }

  String _formatTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.yellow;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          "ToDo",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.yellow.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              child: TextField(
                controller: _searchController,
                onChanged: _searchTasks,
                decoration: InputDecoration(
                  hintText: 'Search...',
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(
        nameController: _drawerNameController,
        emailController: _drawerEmailController,
      ),
      body: Container(
        color: Colors.black,
        child: _isSearching && _filteredTasks.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No task found',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio:
                        (MediaQuery.of(context).size.width / 4) / 49,
                  ),
                  itemCount: _filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = _filteredTasks[index];
                    return Stack(
                      children: [
                        GestureDetector(
                          child: SizedBox(
                            child: Card(
                              color: _getPriorityColor(task['priority']!),
                              elevation: 4.0,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: task['isComplete'] == 'true',
                                        onChanged: (value) {
                                          setState(() {
                                            task['isComplete'] =
                                                value.toString();
                                            _filteredTasks[index] = task;
                                            _saveTasks();
                                          });
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(
                                              task['priority']!),
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(8.0)),
                                        ),
                                        child: Text(
                                          task['name']!,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                task['isComplete'] == 'true'
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          task['definition']!,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            decoration:
                                                task['isComplete'] == 'true'
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                          'Date: ${task['dueDate']}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                task['isComplete'] == 'true'
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                          'Time: ${task['dueTime']}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                task['isComplete'] == 'true'
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 2,
                          child: PopupMenuTheme(
                            data: PopupMenuThemeData(
                              color: Colors.yellow.shade700,
                            ),
                            child: PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              onSelected: (value) {
                                if (value == 'delete') {
                                  _deleteTask(index);
                                }

                                if (value == 'edit') {
                                  _addOrEditTask(index: index);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOrEditTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow.shade700,
        shape: CircleBorder(),
        elevation: 6.0,
        highlightElevation: 12.0,
      ),
    );
  }
}
