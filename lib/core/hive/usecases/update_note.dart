import 'package:dartz/dartz.dart';
// import 'package:sparklers/core/util/errors/failure.dart';

import '../../../core/util/util.dart';
import '../note_model.dart';
import '../repositories/repositories.dart';

// 更新笔记用例类
class UpdateNoteUsecase {

  // 笔记仓库
  final NoteRepositories noteRepositories;

  // 构造方法，注入笔记仓库
  UpdateNoteUsecase({
    required this.noteRepositories,
  });

  // 执行用例 (更新笔记)
  Future<Either<Failure, Unit>> call(Note note) async {
    // 调用笔记仓库的 updateNote 方法，更新笔记
    return await noteRepositories.updateNote(note);
  }
}
