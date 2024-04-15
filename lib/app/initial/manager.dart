import 'package:get/get.dart';
import 'package:note/core/core.dart';

class DependencyManager extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => DrawerNavigationController());
    Get.lazyPut(() => SettingsController());
    Get.put(TranSlationController());


    // => 仓库注册 (使用延迟加载单例) //
    Get.lazyPut<NoteRepositories>(
      () => NoteRepositoriesImpl(noteLocalDataSourse: Get.find()),
    );

    // => 数据源注册 (使用延迟加载单例) //
    Get.lazyPut<NoteLocalDataSourse>(() => NoteLocalDataSourceWithHiveImpl());
    // 初始化数据库
    Get.put<NoteLocalDataSourse>(NoteLocalDataSourceWithHiveImpl()..initDb());
    // 初始化数据库
    // Get.putAsync<NoteLocalDataSourse>(() async {
    //   final noteLocalDataSource = NoteLocalDataSourceWithHiveImpl();
    //   await noteLocalDataSource.initDb();
    //   return noteLocalDataSource;
    // });

    // => 获取所有笔记的用例注册 //
    Get.put(GetNotesUsecase(noteRepositories: Get.find<NoteRepositories>()));
    // => 根据ID获取笔记的用例注册 //
    Get.put(GetNoteByIdUsecase(noteRepositories: Get.find<NoteRepositories>()));
    // => 添加笔记的用例注册 //
    Get.put(AddNoteUsecase(noteRepositories: Get.find<NoteRepositories>()));
    // => 更新笔记的用例注册 //
    Get.put(UpdateNoteUsecase(noteRepositories: Get.find<NoteRepositories>()));
    // => 删除笔记的用例注册  //
    Get.put(DeleteNoteUsecase(noteRepositories: Get.find<NoteRepositories>()));
  }
}
