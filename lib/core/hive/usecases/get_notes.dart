import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart'; // 导入包含常用工具
import '../note_model.dart'; // 导入笔记实体类
import '../repositories/repositories.dart'; // 导入笔记仓库接口

// 获取所有笔记用例类
class GetNotesUsecase {

  // 笔记仓库
  final NoteRepositories noteRepositories;

  // 构造方法，注入笔记仓库
  GetNotesUsecase({
    required this.noteRepositories,
  });

  // 执行用例 (获取所有笔记)
  Future<Either<Failure, List<Note>>> call() async {
    // // 注释掉的部分模拟延迟加载效果 (可选)
    await Future.delayed(const Duration(seconds: 2));

    // 调用笔记仓库的 getAllNotes 方法，获取所有笔记
    return await noteRepositories.getAllNotes();
  }
}
