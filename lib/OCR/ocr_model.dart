import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? _image;
  String _extractedText = '';
  final textRecognizer = TextRecognizer();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _extractText();
    }
  }

  Future<void> _extractText() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFile(_image!);
    final recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      _extractedText = recognizedText.text;
    });
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(_extractedText),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> _savePdf() async {
    // Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (await Permission.storage.isGranted) {
      final output = await getExternalStorageDirectory();
      final file = File(
          "${output!.path}/extracted_text_${DateTime.now().millisecondsSinceEpoch}.pdf");
      final pdfBytes = await _generatePdf();
      await file.writeAsBytes(pdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR to PDF')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_image != null) Image.file(_image!),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.camera),
                  child: const Text('Camera'),
                ),
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  child: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(_extractedText),
            const SizedBox(height: 20),
            if (_extractedText.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  child: PdfPreview(
                    build: (format) => _generatePdf(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _savePdf,
                child: const Text('Save PDF'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
