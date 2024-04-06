import 'package:dartz/dartz.dart';

import '../../../core/core.dart'; // 导入通用类型、常量等
// import '../note_model.dart'; // 导入笔记实体类
// import '../repositories/repositories.dart'; // 导入笔记仓库接口

// 获取笔记详情用例类
class GetNoteByIdUsecase {

  // 笔记仓库
  final NoteRepositories noteRepositories;

  // 构造方法，注入笔记仓库
  GetNoteByIdUsecase({
    required this.noteRepositories,
  });

  // 执行用例 (获取笔记详情)
  Future<Either<Failure, Note>> call(String noteId) async {
    // 调用笔记仓库的 getNoteById 方法，获取指定 ID 的笔记
    return await noteRepositories.getNoteById(noteId);
  }
}
