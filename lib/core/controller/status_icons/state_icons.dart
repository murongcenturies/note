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
final class StatusIconsInitial extends StatusIconsState {}

// 切换图标状态 (表示笔记状态和归档状态发生变化)
final class ToggleIconsStatusState extends StatusIconsState {
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
final class ReadOnlyState extends StatusIconsState {
  // 当前笔记对象
  final Note currentNote;
  // 构造函数
  const ReadOnlyState(this.currentNote);
}

class StatusIconsController extends GetxController {
  // // 当前笔记对象
  // final _currentNote = Note.empty().obs;
  // // 当前笔记状态
  // final _currentNoteStatus = StatusNote.undefined.obs;
  // // 当前归档状态
  // final _currentArchiveStatus = ArchiveStatus.unarchive.obs;
  // // 代表删除状态的常量
  // final StatusNote _isTrashInNote = StatusNote.trash;
  // 当前笔记对象
  Note _currentNote = Note.empty();
  // 当前笔记状态
  StatusNote _currentNoteStatus = StatusNote.undefined;
  // 当前归档状态
  ArchiveStatus _currentArchiveStatus = ArchiveStatus.unarchive;
  // 代表删除状态的常量
  final StatusNote _isTrashInNote = StatusNote.trash;

  // 切换图标状态 (根据笔记状态更新图标)
  toggleIconsStatus(Note currentNote) {
    _currentNote = currentNote;
    _currentNoteStatus = currentNote.stateNote;
    _currentArchiveStatus = currentNote.stateNote == StatusNote.archived
        ? ArchiveStatus.archive
        : ArchiveStatus.unarchive;

    // 如果笔记状态是删除，只读状态
    if (_isTrashInNote == _currentNoteStatus) {
      return (ReadOnlyState(_currentNote));
    } else {
      // 否则，发射状态图标已切换状态
      return (ToggleIconsStatusState(
        currentNote: _currentNote,
        currentArchiveStatus: _currentArchiveStatus,
        currentNoteStatus: _currentNoteStatus,
      ));
    }
  }

  // 切换图标置顶状态
  void toggleIconPinnedStatus(StatusNote currentStatus) {
    // 在已置顶和未置顶之间切换
    _currentNoteStatus = currentStatus == StatusNote.pinned
        ? StatusNote.undefined
        : StatusNote.pinned;
    // 在这里处理状态图标已切换状态
    ToggleIconsStatusState(
      currentNote: _currentNote,
      currentNoteStatus: _currentNoteStatus,
      currentArchiveStatus: _currentArchiveStatus,
    );
  }
}
