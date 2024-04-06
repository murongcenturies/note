// 引入 Dartz 库用于处理结果类型 (Either)
import 'package:dartz/dartz.dart';

// 引入笔记模型类
import '../note_model.dart';

// 抽象类：笔记本地数据源
abstract class NoteLocalDataSourse {
  // 初始化数据库 (异步操作，返回 Future<bool>)
  Future<bool> initDb();

  // 获取所有笔记 (异步操作，返回 Future<List<NoteModel>>)
  Future<List<NoteModel>> getAllNote();

  // 根据 ID 获取笔记 (异步操作，返回 Future<NoteModel>)
  Future<NoteModel> getNoteById(String noteModelById);

  // 添加笔记 (异步操作，返回 Future<Unit> - 表示没有返回值)
  Future<Unit> addNote(NoteModel noteModel);

  // 更新笔记 (异步操作，返回 Future<Unit> - 表示没有返回值)
  Future<Unit> updateNote(NoteModel noteModel);

  // 删除笔记 (异步操作，返回 Future<Unit> - 表示没有返回值)
  Future<Unit> deleteNote(String noteModelId);
}
