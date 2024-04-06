import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/repositories.dart';

// 删除笔记用例类
class DeleteNoteUsecase {

  // 笔记仓库
  final NoteRepositories noteRepositories;

  // 构造方法，注入笔记仓库
  DeleteNoteUsecase({
    required this.noteRepositories,
  });

  // 执行用例 (删除笔记)
  Future<Either<Failure, Unit>> call(String noteId) async {
    // 调用笔记仓库的 deleteNote 方法，删除笔记
    return await noteRepositories.deleteNote(noteId);
  }
}
