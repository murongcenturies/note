import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/core.dart';
import '../home/widgets/grid_view_notes.dart';

class NotesSearching extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search your notes';

  @override
  TextStyle? get searchFieldStyle => const TextStyle().copyWith(fontSize: 18.0);

  @override
  List<Widget>? buildActions(BuildContext context) => query.isNotEmpty
      ? [IconButton(onPressed: () => query = '', icon: const Icon(Icons.close))]
      : [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.navigate_before),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  // 构建搜索结果
  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();
    // 获取GetNotesUsecase实例
    final GetNotesUsecase getNotes = Get.find();
    // 获取NoteSearchController实例
    final controller = Get.put(NoteSearchController(getNotes: getNotes));
    // 调用searchFetch方法进行搜索
    controller.searchFetch(query);

    // 返回搜索结果的Widget
    return Obx(() {
      final state = controller.searchState.value;
      if (state is SearchLoading) {
        return _buildLoadingIndicator();
      } else if (state is SearchLoaded) {
        return _buildSearchLoaded(state.note);
      } else if (state is EmptySearch) {
        return _buildEmptySearch(state.message);
      } else if (state is SearchError) {
        return _buildSearchError(state.message);
      }
      return const SizedBox.shrink();
    });
  }

  // 构建加载中的指示器
  Widget _buildLoadingIndicator() {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  // 构建搜索结果加载完成的Widget
  Widget _buildSearchLoaded(List<Note> notes) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        GridNotes(notes: notes, isShowDismiss: false),
      ],
    );
  }

  // 构建搜索结果为空的Widget
  Widget _buildEmptySearch(String message) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppIcons.emptySearch, Text(message)],
          ),
        ),
      ],
    );
  }

  // 构建搜索错误的Widget
  Widget _buildSearchError(String message) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppIcons.error, Text(message)],
          ),
        ),
      ],
    );
  }
}
