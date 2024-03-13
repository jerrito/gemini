import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

abstract class SearchLocalDatasource {
  Future<List<Uint8List>> images();
}

class SearchLocalDatasourceImpl implements SearchLocalDatasource {
  @override
  Future<List<Uint8List>> images() async {
    final response = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true, withData: true);

    List<Uint8List> file = [];
    if (response!.files.isNotEmpty) {
      file.addAll(response.files.map((e) => e.bytes!));
    }
    //print(file);
    return file;
  }
}
