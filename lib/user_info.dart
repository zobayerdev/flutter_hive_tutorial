// ignore_for_file: unused_label, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hive_tutorial/service/hive_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HiveService _service = HiveService();
  final TextEditingController _controller = TextEditingController();

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter data'),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      await _service.addData(_controller.text);
                      log('Data Insert successfully');
                      _controller.clear();
                      _refresh();
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _service.getAllData().length,
              itemBuilder: (context, index) {
                final data = _service.getAllData()[index];
                return ListTile(
                  title: Text(data),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          _controller.text = data;
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Update'),
                              content: TextField(
                                controller: _controller,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await _service.updateData(
                                      index,
                                      _controller.text,
                                    );
                                    _controller.clear();
                                    _refresh();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Save',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _service.deleteData(index);
                          _refresh();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
