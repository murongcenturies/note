// 定义一个密封类，用于封装所有笔记状态
import '../../core.dart';

// sealed class NoteState  {
class NoteState {
  // 构造函数
  NoteState();
}

// 加载中状态 (表示正在加载笔记数据)
class LoadingState extends NoteState {
  // 正在加载的笔记类型
  final DrawerSectionView drawerSectionView;

  LoadingState(this.drawerSectionView);
}

// 笔记视图状态 (表示笔记列表已经加载完成)
class NotesViewState extends NoteState {
  // 非置顶笔记列表
  final List<Note> otherNotes;
  // 置顶笔记列表
  final List<Note> pinnedNotes;

  NotesViewState(this.otherNotes, this.pinnedNotes);
}

// 获取单个笔记状态 (表示成功获取指定 ID 的笔记)
class GetNoteByIdState extends NoteState {
  // 获取到的笔记对象
  final Note note;

  GetNoteByIdState(this.note);
}

// 消息状态 (表示与用户交互相关的提示信息)
class MessageState extends NoteState {
  // 消息内容
  final String message;

  MessageState(this.message);
}

// 错误状态 (表示操作失败并提示错误信息)
class ErrorState extends MessageState {
  // 发生错误的抽屉视图类型
  final DrawerSectionView drawerSectionView;

  ErrorState(
    super.message,
    this.drawerSectionView,
  );
}

// 成功状态 (表示操作成功并提示成功信息)
class SuccessState extends MessageState {
  // 成功信息
  SuccessState(super.message);
}

// 切换成功状态 (表示切换操作 (如归档、取消归档) 成功并提示信息)
class ToggleSuccessState extends MessageState {
  // 成功信息
  ToggleSuccessState(super.message);
}

// 空输入状态 (表示用户没有输入任何内容)
class EmptyInputsState extends MessageState {
  // 提示信息
  EmptyInputsState(super.message);
}

//**其他状态**

// // 返回上层状态 (表示需要关闭笔记详情页面)
class GoPopNoteState extends NoteState {}

// 空笔记状态 (表示当前列表中没有笔记)
class EmptyNoteState extends NoteState {
  // 所属的抽屉视图类型
  final DrawerSectionView drawerSectionView;

  EmptyNoteState(this.drawerSectionView);
}

// 可用笔记状态 (表示获取到可编辑的笔记)
class AvailableNoteState extends NoteState {
  // 可编辑的笔记对象
  final Note note;

  AvailableNoteState(this.note);
}

// 只读笔记状态 (表示笔记只能查看，不可编辑)
class ReadOnlyNoteState extends NoteState {
  // 是否为只读状态
  final bool readOnly;

  ReadOnlyNoteState(this.readOnly);
}
