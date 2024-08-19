
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/core/utils/keys.dart';

class StorageServices extends GetxService {
  late GetStorage _box;

  Future<StorageServices> init() async {
    _box = GetStorage();
    await GetStorage.init();
    // await _box.write(taskKey, []);
    await _box.writeIfNull(taskKey, []);
    return this;
  }
  T read<T>(String key){
    return _box.read(key);
  }
  void write (String key , dynamic value) async{
    await _box.write(key, value);
    
  }
  

// Add any additional methods you might need for reading and writing data
}
