import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<File> fileFromImageUrl(String pathImage) async {
  Uri url = Uri.parse('https://drive.google.com/uc?export=view&id=$pathImage');
  final response = await http.get(url);

  final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, '$pathImage.png'));

  file.writeAsBytesSync(response.bodyBytes);
  return file;
}
