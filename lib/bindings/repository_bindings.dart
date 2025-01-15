import 'package:get/get.dart';

import '../base/repository/data_repository.dart';
import '../base/repository/data_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataRepository>(
          () => DataRepositoryImpl(),
      tag: (DataRepository).toString(),
      fenix: true,
    );
  }
}