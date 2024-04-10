// 搜索状态类 (表示搜索相关的不同状态)
import 'package:get/get.dart';

import '../../core.dart';

class SearchState{
  // 构造函数
  const SearchState();
}

// 搜索初始状态
class SearchInitial extends SearchState {}

// 搜索加载中状态
class SearchLoading extends SearchState {}

// 搜索错误状态
class SearchError extends SearchState {
  // 错误信息
  final String message;

  const SearchError(this.message);
}

// 搜索成功状态
class SearchLoaded extends SearchState {
  // 搜索到的笔记列表
  final List<Note> note;

  const SearchLoaded(this.note);
}

// 搜索为空状态
class EmptySearch extends SearchState {
  // 提示信息
  final String message;

  const EmptySearch(this.message);
}
class NoteSearchController extends GetxController {
   // 获取所有笔记的用例
  final GetNotesUsecase getNotes;
  // 搜索状态
   var searchState = Rx<SearchState>(SearchInitial());

  NoteSearchController({
    required this.getNotes,
  });

  // 搜索笔记
  void searchFetch(String query) async {
    // 发射搜索加载中状态
    searchState.value = SearchLoading();

    // 获取所有笔记
    final failureOrLoaded = await getNotes();

    // 处理结果
    failureOrLoaded.fold(
      (failure) => searchState.value = SearchError(_mapFailureMsg(failure)), // 发生错误则发射错误状态
      (listOfNotes) {
        // 过滤笔记
        final filteredList = listOfNotes.where((note) {
          // 忽略垃圾桶中的笔记
          final bool isInTrash = note.stateNote == StatusNote.trash;
          // 检查标题或内容是否包含搜索词 (不区分大小写)
          final bool containsQuery =
                  note.content.toString().toLowerCase().contains(query.toString().toLowerCase());

          return !isInTrash && containsQuery; // 排除垃圾桶中的笔记，并检查是否包含搜索词
        }).toList();

        // 检查过滤后笔记是否为空
        final bool isEmptylistOfNotes = filteredList.isEmpty;

        // 发射对应的状态：空搜索、搜索成功
        searchState.value = isEmptylistOfNotes
            ? const EmptySearch('No matching notes')
            : SearchLoaded(filteredList);
      },
    );
    update();
  }

  // 映射错误信息 (用于根据不同错误类型返回对应的错误消息)
  String _mapFailureMsg(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure _:
        return DATABASE_FAILURE_MSG;
      case NoDataFailure _:
        return NO_DATA_FAILURE_MSG;
      default:
        return 'Unexpected Error , Please try again later . ';
    }
  }
}