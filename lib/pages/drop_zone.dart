import 'dart:html' as html;
import 'package:flutter/material.dart';

class DropZone extends StatelessWidget {
  DropZone({super.key});

  void _pickFiles() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final List<html.File> files = uploadInput.files!;
      for (var file in files) {
        acceptFile(file);
      }
    });
  }

  Future<void> acceptFile(html.File file) async {
    final name = file.name;
    print('Name: $name');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1)),
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 40, color: Colors.black),
                  Text(
                    'Drop Files here',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _pickFiles,
                    icon: Icon(Icons.search, color: Colors.black),
                    label: Text(
                      'Choose Files',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
