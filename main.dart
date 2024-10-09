import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme:const AppBarTheme(
          backgroundColor: Colors.blue,
      ),
      ),
      home: TablePage(),
    );
  }
}

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  // List to represent the table
  List<List<dynamic>> table = [];

  // Controllers for input fields
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final ageController = TextEditingController();

  // Function to add a row to the table
  void addRow(String name, String dept, int age) {
    setState(() {
      table.add([name, dept, age]);
    });
  }

  // Function to build the table
  Widget buildTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Department')),
        DataColumn(label: Text('Age')),
      ],
      rows: table
          .map((row) => DataRow(cells: [
                DataCell(Text(row[0])),
                DataCell(Text(row[1])),
                DataCell(Text(row[2].toString())),
              ]))
          .toList(),
    );
  }

  // Function to handle adding a new row
  void handleAddRow() {
    String name = nameController.text;
    String dept = deptController.text;
    int? age = int.tryParse(ageController.text);

    if (name.isNotEmpty && dept.isNotEmpty && age != null) {
      addRow(name, dept, age);

      // Clear text fields after adding
      nameController.clear();
      deptController.clear();
      ageController.clear();
    } else {
      // Show error if input is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Rows to Table'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
             
            ),
            TextField(
              controller: deptController,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: handleAddRow,
              child: Text('Add Data'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: buildTable(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
