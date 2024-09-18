import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PowerPointList extends StatefulWidget {
  const PowerPointList({super.key});

  @override
  _PowerPointListState createState() => _PowerPointListState();
}

class _PowerPointListState extends State<PowerPointList> {
  List<String> pptList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPowerPoints();
  }

  Future<void> fetchPowerPoints() async {
    final storage = FirebaseStorage.instance;
    final listResult = await storage.ref('presentation').listAll();

    setState(() {
      pptList = listResult.items.map((item) => item.name).toList();
      isLoading = false;
    });
  }

  Future<void> downloadPowerPoint(String fileName) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref('presentation/$fileName');

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      await ref.writeToFile(file);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded $fileName successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download $fileName: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PowerPoint Presentations'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pptList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pptList[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => downloadPowerPoint(pptList[index]),
                  ),
                );
              },
            ),
    );
  }
}
