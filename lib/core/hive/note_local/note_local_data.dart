import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note/core/core.dart';
import 'package:path_provider/path_provider.dart';

// 引入相关模型和适配器
import '../emotion_note_hive.dart';
import '../hive.dart';
// import 'note_local_data_source.dart';
// import 'note_model.dart';
import '../state_note_hive.dart';
import '../delta.dart';

// 实现笔记本地数据源接口，使用 Hive 作为存储
class NoteLocalDataSourceWithHiveImpl implements NoteLocalDataSourse {
  // 定义 Hive 盒子名称
  final String _boxNote = 'note_box';

  // 初始化 Hive 数据库
  @override
  Future<bool> initDb() async {
    try {
      // 获取应用文档目录
      final appDocumentDir = await getApplicationDocumentsDirectory();

      // 初始化 Hive
      Hive.init(appDocumentDir.path);

      // 注册 Hive 适配器
      Hive.registerAdapter(NoteHiveAdapter());
      Hive.registerAdapter(StateNoteHiveAdapter());
      Hive.registerAdapter(DeltaAdapter());
      Hive.registerAdapter(EmotionAdapter());

      // 打开指定名称的 Hive 盒子
      await Hive.openBox<NoteHive>(_boxNote);
// print('12');
      // 初始化成功
      return true;

      // 捕获异常并抛出连接失败异常
    } catch (_) {
      throw ConnectionException();
    }
  }

  // 获取所有笔记
  @override
  Future<List<NoteModel>> getAllNote() async {
    try {
      // 获取 Hive 盒子
      final noteBox = Hive.box<NoteHive>(_boxNote);

      // 将 Hive 存储对象转换为 NoteModel 列表
      final List<NoteModel> resultNotes = noteBox.values
          .map((note) => NoteModel(
        id: note.id,
        content: note.content,
        modifiedTime: note.modifiedTime,
        stateNote: note.stateNoteHive.stateNote,
        emotion: note.emotionHive.emotion,
      ))
          .toList();

      // 返回 NoteModel 列表
      return resultNotes;

      // 捕获异常并抛出无数据异常
    } catch (_) {
      throw NoDataException();
    }
  }

  // 根据 ID 获取笔记
  @override
  Future<NoteModel> getNoteById(String noteModelById) async {
    try {
      // 获取 Hive 盒子
      final noteBox = Hive.box<NoteHive>(_boxNote);

      // 查找指定 ID 的 NoteHive 对象
      final NoteHive resultNote = noteBox.values.firstWhere(
            (element) => element.id == noteModelById,
      );

      // 将 NoteHive 对象转换为 NoteModel 并返回
      return NoteModel(
        id: resultNote.id,
        content: resultNote.content,
        modifiedTime: resultNote.modifiedTime,
        stateNote: resultNote.stateNoteHive.stateNote,
         emotion: resultNote.emotionHive.emotion,
      );

      // 捕获异常并抛出无数据异常
    } catch (_) {
      throw NoDataException();
    }
  }
  // 添加笔记
  @override
  Future<Unit> addNote(NoteModel noteModel) async {
    try {
      // 获取 Hive 盒子
      final noteBox = Hive.box<NoteHive>(_boxNote);

      // 使用 noteModel 的 id 作为 Hive 盒子的键
      final noteKey = noteModel.id;

      // 将 NoteModel 对象转换为 NoteHive 对象
      final NoteHive noteHive = NoteHive(
        id: noteModel.id,
        content: noteModel.content,
        modifiedTime: noteModel.modifiedTime,
        stateNoteHive: noteModel.stateNote.stateNoteHive,
        emotionHive: noteModel.emotion.emotionHive,
      );
      // 将 NoteHive 对象存入 Hive 盒子中，使用 put 方法 (类似于插入)
      await noteBox.put(noteKey, noteHive);

      // 成功添加后返回 unit (表示没有返回值)
      return unit;
    } catch (_) {
      // 捕获异常并抛出无数据异常
      throw NoDataException();
    }
  }

  // 更新笔记
  @override
  Future<Unit> updateNote(NoteModel noteModel) async {
    try {
      // 获取 Hive 盒子
      final noteBox = Hive.box<NoteHive>(_boxNote);

      // 使用 noteModel 的 id 作为 Hive 盒子的键
      final indexNoteId = noteModel.id;

      // 将 NoteModel 对象转换为 NoteHive 对象
      final NoteHive noteHive = NoteHive(
        id: noteModel.id,
        content: noteModel.content,
        modifiedTime: noteModel.modifiedTime,
        stateNoteHive: noteModel.stateNote.stateNoteHive,
        emotionHive: noteModel.emotion.emotionHive,
      );

      // 将更新后的 NoteHive 对象存入 Hive 盒子中，使用 put 方法 (会覆盖原有数据)
      await noteBox.put(indexNoteId, noteHive);

      // 成功更新后返回 unit (表示没有返回值)
      return unit;
    } catch (_) {
      // 捕获异常并抛出无数据异常
      throw NoDataException();
    }
  }

  // 删除笔记
  @override
  Future<Unit> deleteNote(String noteModelId) async {
    try {
      // 获取 Hive 盒子
      final noteBox = Hive.box<NoteHive>(_boxNote);

      // 使用 noteModelId 作为键，从 Hive 盒子中删除对应的 NoteHive 对象
      await noteBox.delete(noteModelId);

      // 成功删除后返回 unit (表示没有返回值)
      return unit;
    } catch (_) {
      // 捕获异常并抛出无数据异常
      throw NoDataException();
    }
  }
}
