import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';

// 笔记控制器
class NoteController extends GetxController {
  final DrawerSectionView selectedNavItem;
  // 定义状态变量
  // final _noteState = Rx<NoteState>(LoadingState(DrawerSectionView.home));
  // Rx<NoteState> get noteState => _noteState;
  late final Rx<NoteState> _noteState;
  Rx<NoteState> get noteState => _noteState;

  NoteController(this.selectedNavItem) {
    // Initialize _drawerController
    _noteState = Rx<NoteState>(LoadingState(selectedNavItem));
  }

  @override
  void onInit() {
    super.onInit();
    // 加载笔记数据
    loadNotes();
  }

  // 可选的旧的笔记对象
  Note? oldNote;

  // 是否为新建笔记的标志
  bool _isNewNote = false;

  Future<void> loadNotes() async {
    final GetNotesUsecase getNotes = Get.find();
    // 获取所有笔记结果
    final failureOrLoaded = await getNotes();
    // await Future.delayed(const Duration(seconds: 2));
    // 映射返回: 置顶笔记 || 非置顶笔记 (其他笔记) || 空笔记
    _noteState.value = _mapLoadNotesState(failureOrLoaded, selectedNavItem);
    update();
    // print('it is here');
    print(_noteState.value);
    // _noteState.value = EmptyNoteState(DrawerSectionView.home);
  }

  Future<void> refreshNotes() async {
    final GetNotesUsecase getNotes = Get.find();
    // 获取所有笔记结果
    final failureOrLoaded = await getNotes();
    // await Future.delayed(const Duration(seconds: 2));
    // 映射返回: 置顶笔记 || 非置顶笔记 (其他笔记) || 空笔记
    _noteState.value = _mapLoadNotesState(failureOrLoaded, selectedNavItem);
    update();
    // print(_noteState.value);
  }

  // 添加笔记的方法
  void addNote(Note note) async {
    final AddNoteUsecase addNote = Get.find();
    // 调用用例类添加笔记，并获取结果
    final Either<Failure, Unit> failureOrSuccess = await addNote(note);

    // 根据结果更新状态
    noteState.value = failureOrSuccess.fold(
      (failure) => ErrorState(
        // 转换错误信息
        _mapFailureMsg(failure),
        DrawerSelect.drawerSection,
      ),
      (_) => SuccessState(ADD_SUCCESS_MSG),
    );
  }

  // 处理空输入事件的方法
  void handleEmptyInputs() {
    // 更新状态为EmptyInputsState，并提供提示信息
    noteState.value = EmptyInputsState(EMPTY_TEXT_MSG);
  }

  // 处理获取笔记详情事件的方法
  void getById(String noteId) async {
    final GetNoteByIdUsecase getNoteByIdUseCase = Get.find();
    // 调用用例类获取笔记详情，并获取结果
    final failureOrSuccess = await getNoteByIdUseCase(noteId);
    print(noteId);
    // 根据结果更新状态
    noteState.value = failureOrSuccess.fold(
      (_) {
        // 设置为新建笔记
        _isNewNote = true;
        // 返回空笔记状态
        return GetNoteByIdState(Note.empty());
      },
      (note) {
        // 设置非新建笔记
        _isNewNote = false;
        // 返回获取到的笔记详情状态
        return GetNoteByIdState(note);
      },
    );
  }

  // 处理更新笔记事件的方法
  updateNote(Note note) async {
    final UpdateNoteUsecase updateNote = Get.find();
    // 调用用例类更新笔记，并获取结果
    final Either<Failure, Unit> failureOrSuccess = await updateNote(note);

    // 根据结果更新状态
    noteState.value = failureOrSuccess.fold(
      (failure) => ErrorState(
        // 转换错误信息
        _mapFailureMsg(failure),
        DrawerSelect.drawerSection,
      ),
      (_) => SuccessState(UPDATE_SUCCESS_MSG),
    );
    print(noteState.value);
  }

  // 处理删除笔记事件的方法
  void deleteNoteById(String noteId) async {
    final DeleteNoteUsecase deleteNoteById = Get.find();
    // 调用用例类删除笔记，并获取结果
    final Either<Failure, Unit> failureOrSuccess = await deleteNoteById(noteId);

    // 根据结果更新状态
    noteState.value = failureOrSuccess.fold(
      (failure) => ErrorState(
        // 转换错误信息
        _mapFailureMsg(failure),
        DrawerSelect.drawerSection,
      ),
      (_) => SuccessState(DELETE_SUCCESS_MSG),
    );
  }

  // 处理返回操作事件的方法
  void popNoteAction(Note currentNote, Note originNote) async {
    // 检查笔记是否有修改 (是否需要更新)
    final bool isDirty = currentNote != originNote;

    // 设置修改时间
    final Note updatedNote = currentNote.copyWith(modifiedTime: DateTime.now());

    // 检查笔记是否为空
    final bool isNoteEmpty = currentNote.content.isEmpty;

    if (_isNewNote && isNoteEmpty) {
      // 新建笔记为空，则更新状态为EmptyInputsState，并提供提示信息
      noteState.value = EmptyInputsState(EMPTY_TEXT_MSG);
    } else if (_isNewNote || (!_isNewNote && isDirty)) {
      // 笔记已修改，需要更新
      if (_isNewNote) {
        // 新建笔记，调用添加笔记的方法
        addNote(currentNote);
      } else {
        // 现有笔记，调用更新笔记的方法
        updateNote(updatedNote);
      }
    }
  }

// 处理移动笔记事件的方法
  void moveNote(Note? note, StatusNote newStatus) async {
    // 检查笔记是否存在
    final bool existsNote = note != null;

    if (!existsNote) {
      // 笔记不存在，则更新状态为EmptyInputsState，并提供提示信息
      noteState.value = EmptyInputsState(EMPTY_TEXT_MSG);
      // 通知关闭详情页面
      // noteState.value = GoPopNoteState();
      return;
    }

    // 存储旧的笔记对象
    oldNote = note;

    // 内部方法，用于更新笔记并根据结果更新状态
    Future<NoteState> updateNoteAndEmit({
      required StatusNote statusNote, // 要更新到的笔记状态
      required NoteState successState, // 更新成功后要更新的状态
    }) async {
      // 创建一个更新后的笔记对象，包含新的状态和修改时间
      final updatedNote = note.copyWith(
        statusNote: statusNote,
        modifiedTime: DateTime.now(),
      );

      // 调用用例类更新笔记，并获取结果
      final failureOrSuccess = await updateNote(updatedNote);

      if (failureOrSuccess == null) {
        // Handle the null case
        return ErrorState('Unexpected Error , Please try again later .',
            DrawerSelect.drawerSection);
            // print('333');
      }
      // 根据结果更新并返回要更新的状态
      return failureOrSuccess.fold(
        (failure) => ErrorState(
          // 更新失败，则更新错误状态
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        ),
        (_) => successState, // 更新成功，则返回指定的状态
      );
    }

    Future<NoteState>? newState;

    // 根据新的笔记状态进行不同的处理
    switch (newStatus) {
      case StatusNote.archived: //  archive 状态
        newState = updateNoteAndEmit(
          statusNote: newStatus,
          successState: ToggleSuccessState(
            // 更新切换成功状态
            note.stateNote == StatusNote.pinned // 判断是否取消置顶
                ? NOTE_ARCHIVE_WITH_UNPINNED_MSG // 提示已归档并且取消置顶
                : NOTE_ARCHIVE_MSG, // 提示已归档
          ),
        );
        break;
      case StatusNote.undefined: // 未定义状态
        newState = updateNoteAndEmit(
          statusNote: newStatus,
          successState: ToggleSuccessState(NOTE_UNARCHIVED_MSG), // 更新取消归档成功状态
        );
        break;
      case StatusNote.trash: // 垃圾桶状态
        newState = updateNoteAndEmit(
          statusNote: newStatus,
          successState:
              ToggleSuccessState(MOVE_NOTE_TRASH_MSG), // 更新移动到垃圾桶成功状态
        );
        break;
      case StatusNote.pinned: // 置顶状态
        // 不需要处理
        break;
    }

    noteState.value = await newState!;

    // 通知关闭详情页面
    // noteState.value = GoPopNoteState();
  }

  // 处理撤销移动笔记事件的方法
  void undoMoveNote(Note oldNote) async {
    // 调用用例类更新笔记 (还原旧的笔记)
    await updateNote(oldNote);
    // 更新返回上层状态
    // noteState.value = GoPopNoteState();
  }

//-----------------------------------------------------------------//
//=> // 映射返回: 置顶笔记 || 非置顶笔记 (其他笔记) || 空笔记
  NoteState _mapLoadNotesState(
    Either<Failure, List<Note>> either,
    DrawerSectionView drawerSectionView,
  ) {
    return either.fold(
      (failure) => ErrorState(
        // 失败，则返回错误状态
        _mapFailureMsg(failure),
        DrawerSelect.drawerSection,
      ),
      (notes) {
        // 按修改时间降序排列笔记
        notes.sort((a, b) => b.modifiedTime.compareTo(a.modifiedTime));

        // 根据状态过滤笔记
        List<Note> filterNotesByState(List<Note> notes, StatusNote state) {
          return notes.where((note) => note.stateNote == state).toList();
        }

        final pinnedNotes =
            filterNotesByState(notes, StatusNote.pinned); // 置顶笔记
        final undefinedNotes =
            filterNotesByState(notes, StatusNote.undefined); // 非置顶笔记 (其他笔记)
        final archiveNotes =
            filterNotesByState(notes, StatusNote.archived); // 归档笔记
        final trashNotes = filterNotesByState(notes, StatusNote.trash); // 垃圾桶笔记

        // 检查是否有对应状态的笔记
        bool hasPinnedNotes = pinnedNotes.isNotEmpty;
        bool hasUndefinedNotes = undefinedNotes.isNotEmpty;
        bool hasArchiveNotes = archiveNotes.isNotEmpty;
        bool hasTrashNotes = trashNotes.isNotEmpty;

        // 根据抽屉视图类型，返回不同的状态
        switch (drawerSectionView) {
          case DrawerSectionView.home: // 主页
            if (notes.isEmpty || (!hasUndefinedNotes && !hasPinnedNotes)) {
              // 笔记为空或无非置顶笔记和置顶笔记
              return EmptyNoteState(drawerSectionView); // 返回空笔记状态
            }
            return hasPinnedNotes // 存在置顶笔记
                ? NotesViewState(
                    undefinedNotes, pinnedNotes) // 返回包含非置顶笔记和置顶笔记的状态
                : NotesViewState(undefinedNotes, const []); // 仅返回非置顶笔记的状态

          case DrawerSectionView.archive: // 归档页
            if (notes.isEmpty || (!hasArchiveNotes)) {
              // 笔记为空或无归档笔记
              return EmptyNoteState(drawerSectionView); // 返回空笔记状态
            }
            return NotesViewState(archiveNotes, const []); // 返回包含归档笔记的状态

          case DrawerSectionView.trash: // 垃圾桶页
            if (notes.isEmpty || (!hasTrashNotes)) {
              // 笔记为空或无垃圾桶笔记
              return EmptyNoteState(drawerSectionView); // 返回空笔记状态
            }
            return NotesViewState(trashNotes, const []); // 返回包含垃圾桶笔记的状态
        }
      },
    );
  }

  //=> // 映射返回: 失败消息
  String _mapFailureMsg(Failure failure) {
    // 根据错误类型，返回不同的错误信息
    switch (failure.runtimeType) {
      case const (DatabaseFailure): // 数据库错误
        return DATABASE_FAILURE_MSG; // 数据库错误提示
      case const (NoDataFailure): // 无数据错误
        return NO_DATA_FAILURE_MSG; // 无数据错误提示
      default: // 未知错误
        return 'Unexpected Error , Please try again later .'; // 通用错误提示 未知错误，请稍后再试。
    }
  }
}
