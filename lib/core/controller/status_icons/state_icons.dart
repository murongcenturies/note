import 'package:get/get.dart';
import '../../../../core/core.dart';

// 枚举类型定义笔记的归档状态(归档，未归档)
enum ArchiveStatus { archive, unarchive }

// 状态图标状态类 (表示笔记状态图标的各种状态)
class StatusIconsState {
  // 构造函数
  const StatusIconsState();
}

// 状态图标初始状态
class StatusIconsInitial extends StatusIconsState {}

// 切换图标状态 (表示笔记状态和归档状态发生变化)
class ToggleIconsStatusState extends StatusIconsState {
  // 当前笔记对象
  final Note currentNote;
  // 当前笔记状态
  final StatusNote currentNoteStatus;
  // 当前归档状态
  final ArchiveStatus currentArchiveStatus;

  // 构造函数
  const ToggleIconsStatusState({
    required this.currentNote,
    required this.currentNoteStatus,
    required this.currentArchiveStatus,
  });
}

// 只读状态 (表示笔记处于只读状态，无法修改)
class ReadOnlyState extends StatusIconsState {
  // 当前笔记对象
  final Note currentNote;
  // 构造函数
  const ReadOnlyState(this.currentNote);
}

class StatusIconsController extends GetxController {
  // 当前笔记对象
  final _currentNote = Note.empty().obs;
  // 当前笔记状态
  final _currentNoteStatus = StatusNote.undefined.obs;
  // 当前归档状态
  final _currentArchiveStatus = ArchiveStatus.unarchive.obs;
  // 代表删除状态的常量
  final StatusNote _isTrashInNote = StatusNote.trash;

  // 当前图标状态
  final Rx<StatusIconsState> _currentIconStatus =
      Rx<StatusIconsState>(StatusIconsInitial());
  //获取当前图标状态
  get currentIconStatus => _currentIconStatus;
  get currentNote => _currentNote;
  get currentNoteStatus => _currentNoteStatus;
  get currentArchiveStatus => _currentArchiveStatus;

  // 切换图标状态 (根据笔记状态更新图标)
  void toggleIconsStatus(Note currentNote) {
    _currentNote.value = currentNote;
    _currentNoteStatus.value = currentNote.stateNote;
    _currentArchiveStatus.value = currentNote.stateNote == StatusNote.archived
        ? ArchiveStatus.archive
        : ArchiveStatus.unarchive;

    // 如果笔记状态是删除，则更新为只读状态
    if (_isTrashInNote == _currentNoteStatus.value) {
      _currentIconStatus.value = ReadOnlyState(_currentNote.value);
    } else {
      // 否则，状态图标已切换状态
      _currentIconStatus.value = ToggleIconsStatusState(
        currentNote: _currentNote.value,
        currentArchiveStatus: _currentArchiveStatus.value,
        currentNoteStatus: _currentNoteStatus.value,
      );
    }
    update();
  }

  // 切换图标置顶状态
  void toggleIconPinnedStatus(StatusNote currentStatus) {
    // 在已置顶和未置顶之间切换
    _currentNoteStatus.value = currentStatus == StatusNote.pinned
        ? StatusNote.undefined
        : StatusNote.pinned;
    _currentIconStatus.value = ToggleIconsStatusState(
      currentNote: _currentNote.value,
      currentArchiveStatus: _currentArchiveStatus.value,
      currentNoteStatus: _currentNoteStatus.value,
    );
    update();
  }
}
