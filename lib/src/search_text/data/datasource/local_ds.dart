import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

abstract class SearchLocalDatasource {
  Future<Map<List<Uint8List>, List<String>>> images();
}

class SearchLocalDatasourceImpl implements SearchLocalDatasource {
  @override
  Future<Map<List<Uint8List>, List<String>>> images() async {
    final response = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true, withData: true);

    List<Uint8List> file = [];
    List<String> ext = [];
    Map<List<Uint8List>, List<String>> all = <List<Uint8List>, List<String>>{};
    if (response!.files.isNotEmpty) {
      file.addAll(response.files.map((e) => e.bytes!));
      ext.addAll(response.files.map((e) => e.extension!));
    }
    
     all.addAll({
      file:ext
     });
    
    //print(file);
    return all;
  }

  
}
