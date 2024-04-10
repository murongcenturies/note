import 'package:dartz/dartz.dart';

import '../../../../core/util/util.dart';
import 'repositories.dart';
import '../note_local/note_local_data_source.dart';
import '../note_model.dart';

// 实现 NoteRepositories 接口
class NoteRepositoriesImpl implements NoteRepositories {
  // 本地笔记数据源
  final NoteLocalDataSourse noteLocalDataSourse;

  // 构造方法，注入本地数据源
  NoteRepositoriesImpl({
    required this.noteLocalDataSourse,
  });

  // 获取所有笔记
  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      // 从本地数据源获取所有笔记
      final response = await noteLocalDataSourse.getAllNote();
      // 返回成功结果
      return Right(response);
    } on NoDataException {
      // 如果没有数据，抛出无数据异常
      return Left(NoDataFailure());
    }
  }

  // 根据 ID 获取笔记
  @override
  Future<Either<Failure, Note>> getNoteById(String noteId) async {
    try {
      // 从本地数据源根据 ID 获取笔记
      final response = await noteLocalDataSourse.getNoteById(noteId);
      // 返回成功结果
      return Right(response);
    } on NoDataException {
      // 如果没有数据，抛出无数据异常
      return Left(NoDataFailure());
    }
  }

  // 添加笔记
  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    try {
      // 检查内容是否为空
      if (note.content.isEmpty) {
        // 抛出空输入异常
        return Left(EmptyInputFailure());
      } else {
        // 将 Note 对象转换为 NoteModel 对象
        final NoteModel convertToNoteModel = NoteModel(
          id: note.id,
          content: note.content,
          modifiedTime: note.modifiedTime,
          stateNote: note.stateNote,
          emotion: note.emotion,
        );
        // 使用本地数据源添加笔记
        await noteLocalDataSourse.addNote(convertToNoteModel);
        // 返回成功结果 (unit 表示没有返回值)
        return const Right(unit);
      }
    } on NoDataException {
      // 如果没有数据，抛出无数据异常
      return Left(NoDataFailure());
    }
  }

  // 更新笔记
  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    try {
      // 将 Note 对象转换为 NoteModel 对象
      final NoteModel convertToNoteModel = NoteModel(
        id: note.id,
        content: note.content,
        modifiedTime: note.modifiedTime,
        stateNote: note.stateNote,
        emotion: note.emotion,
      );
      // 使用本地数据源更新笔记
      await noteLocalDataSourse.updateNote(convertToNoteModel);
      // 返回成功结果 (unit 表示没有返回值)
      return const Right(unit);
    } on NoDataException {
      // 如果没有数据，抛出无数据异常
      return Left(NoDataFailure());
    }
  }

  // 删除笔记
  @override
  Future<Either<Failure, Unit>> deleteNote(String noteId) async {
    try {
      // 使用本地数据源删除笔记
      await noteLocalDataSourse.deleteNote(noteId);
      // 返回成功结果 (unit 表示没有返回值)
      return const Right(unit);
    } on NoDataException {
      // 如果没有数据，抛出无数据异常
      return Left(NoDataFailure());
    }
  }
}
