import 'package:dartz/dartz.dart';
import 'package:note/core/util/errors/failure.dart';

import '../note_model.dart';

// 定义笔记仓库接口
abstract class NoteRepositories {

  // 获取所有笔记
  Future<Either<Failure, List<Note>>> getAllNotes();

  // 根据 ID 获取笔记
  Future<Either<Failure, Note>> getNoteById(String noteId);

  // 添加笔记
  Future<Either<Failure, Unit>> addNote(Note note);

  // 更新笔记
  Future<Either<Failure, Unit>> updateNote(Note note);

  // 删除笔记
  Future<Either<Failure, Unit>> deleteNote(String noteId);
}
