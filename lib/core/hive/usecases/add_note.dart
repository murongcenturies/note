import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../note_model.dart';
import '../repositories/repositories.dart';

// 添加笔记用例类
class AddNoteUsecase {

  // 笔记仓库
  final NoteRepositories noteRepositories;

  // 构造方法，注入笔记仓库
  AddNoteUsecase({
    required this.noteRepositories,
  });

  // 执行用例 (添加笔记)
  Future<Either<Failure, Unit>> call(Note note) async {
    // 调用笔记仓库的 addNote 方法，添加笔记
    return await noteRepositories.addNote(note);
  }
}
