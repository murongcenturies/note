import 'dart:ui';
// import 'dart:convert' show jsonEncode;

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart'
    // ignore: unused_shown_name
    show
        FlutterQuillEmbeds,
        QuillSharedExtensionsConfigurations;
import 'package:share_plus/share_plus.dart' show Share;
import 'package:quill_html_converter/quill_html_converter.dart';
import 'package:quill_pdf_converter/quill_pdf_converter.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:note/view/views.dart';
import '../emotion/emotion_select_view.dart';
import './widgets/widgets.dart';
import 'package:note/core/core.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.note, // 要展示的笔记信息
    required this.noteController, // 笔记控制器
  });

  final NoteController noteController; //笔记控制器
  final Note note; // 笔记数据
  @override
  State<NotePage> createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  late QuillController _controller;
  late FocusNode _focusNode;
  late NoteController noteController;
  final StatusIconsController noteStatusBloc =
      Get.find<StatusIconsController>();
  //是否已读
  RxBool isRead = false.obs;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    _focusNode = FocusNode();
    _loadNoteFields();
    Map<String, dynamic> args = Get.arguments;
    noteController = args['noteController'];
    // print(noteController.selectedNavItem);
  }

  // 获取原始笔记数据（未修改的）
  Note get originNote {
    return Note(
      id: widget.note.id,
      content: widget.note.content,
      modifiedTime: widget.note.modifiedTime,
      stateNote: widget.note.stateNote,
      emotion: widget.note.emotion,
    );
  }

// 获取当前笔记数据
  Note get currentNote {
    bool isToggleIconsStatusState =
        noteStatusBloc.currentIconStatus.value is ToggleIconsStatusState;
    final StatusNote currentStatusNote;
    if (isToggleIconsStatusState) {
      currentStatusNote =
          (noteStatusBloc.currentIconStatus.value as ToggleIconsStatusState)
              .currentNoteStatus;
    } else {
      currentStatusNote = StatusNote.trash;
    }

    final EmotionController emotionController = Get.find<EmotionController>();
    final Emotion currentEmotion = (emotionController
            .currentEmotionIconStatus.value as ToggleEmotionIconsState)
        .currentEmotionStatus;

    // 构建当前笔记对象，包含id、内容，状态等信息
    return Note(
      id: widget.note.id,
      content: _controller.document.toDelta(),
      modifiedTime: widget.note.modifiedTime,
      stateNote: currentStatusNote, // 使用获取到的笔记状态
      emotion: currentEmotion,
    );
  }

// 加载笔记内容到输入框
  void _loadNoteFields() {
    if (widget.note.content.isNotEmpty) {
      try {
        //从widget.note对象中获取content属性，并将其存储在contentDelta变量中
        final contentDelta = widget.note.content;

        //将contentDelta的内容加载到文本编辑器中
        // _controller.compose(contentDelta,
        //     const TextSelection.collapsed(offset: 0), ChangeSource.local);
        _controller.document = Document.fromDelta(contentDelta);
        //获取文本编辑器中的内容长度
        final contentLength = _controller.document.length;

        //更新文本编辑器中的选择内容
        _controller.updateSelection(
            TextSelection.collapsed(offset: contentLength), ChangeSource.local);
      } catch (e) {
        // 处理错误
        // print('加载笔记内容失败: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: I18nContent.title.tr),
      body: Stack(
        children: <Widget>[
          // 添加背景图片
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppIcons.cloud), // 背景图片路径
                  fit: BoxFit.fill, // 适应方式，可以根据需求调整
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.5), // 使用主题背景颜色
                ),
              ),
            ),
          ),
          Column(children: [
            _appBar(context),
            Expanded(
              child: Obx(() {
                return Column(children: [
                  if (!isRead.value)
                    MyQuillToolbar(
                      controller: _controller,
                      focusNode: _focusNode,
                    ),
                  Expanded(
                    child: MyQuillEditor(
                      configurations: QuillEditorConfigurations(
                        sharedConfigurations: _sharedConfigurations,
                        controller: _controller,
                        autoFocus: true,
                        expands: false,
                        readOnly: isRead.value,
                        // readOnly: false,
                      ),
                      scrollController: ScrollController(),
                      focusNode: _focusNode,
                    ),
                  ),
                ]);
              }),
            ),

            // MyQuillToolbar(
            //   controller: _controller,
            //   focusNode: _focusNode,
            // ),
            // Expanded(
            //   child: MyQuillEditor(
            //     configurations: QuillEditorConfigurations(
            //       controller: _controller,
            //       readOnly: false,
            //       autoFocus: true,
            //       expands: false,
            //       padding: EdgeInsets.zero,
            //       enableInteractiveSelection: true,
            //       textCapitalization: TextCapitalization.none,
            //       keyboardAppearance: Brightness.light,
            //       scrollPhysics: const ClampingScrollPhysics(),
            //       // keyboardEnabled: true,
            //     ),
            //     scrollController: ScrollController(),
            //     focusNode: _focusNode,
            //   ),
            // ),
          ])
        ],
      ),
    );
  }

  // ignore: unused_element
  QuillSharedConfigurations get _sharedConfigurations {
    return const QuillSharedConfigurations(
      // locale: Locale('en'),
      extraConfigurations: {
        QuillSharedExtensionsConfigurations.key:
            QuillSharedExtensionsConfigurations(
          assetsPrefix: 'assets', // Defaults to assets
        ),
      },
    );
  }

  Widget _appBar(BuildContext context) {
    return GetBuilder<StatusIconsController>(
      builder: (controller) {
        final currentNoteStatus = controller.currentIconStatus.value; // 当前笔记状态

        final currentStatus = currentNoteStatus is ReadOnlyState; // 当前状态是否是只读状态

        // 导航栏右侧按钮 (根据状态决定是否显示)
        List<Widget> actions;
        if (currentStatus) {
          isRead.value = true;
          // 只读状态下，显示还原或删除按钮
          actions = [
            restoreNoteOrDelete(),
          ];
        } else {
          // 非只读状态下，显示固定的图标按钮
          actions = [
            //设置文档情绪
            EmotionSelector(note: currentNote),
            //固定当前文档
            IconPinnedStatus(),
            //归档当前文档
            const IconArchiveStatus(),
            IconButton(
              tooltip: I18nContent.share.tr,
              onPressed: () {
                final plainText = _controller.document.toPlainText(
                  FlutterQuillEmbeds.defaultEditorBuilders(),
                );
                if (plainText.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showText(
                    I18nContent.showText.tr,
                  );
                  return;
                }
                Share.share(plainText);
              },
              icon: AppIcons.share,
              color: Theme.of(context).iconTheme.color,
            ),
            _menuMore(),
          ];
        }
        return AppBar(
          //特殊设置，颜色没有被全局主题色覆盖，，使用主动获取的方式
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
          leading: IconButton.outlined(
            icon: AppIcons.arrowBack, // 左返回图标
            onPressed: () async {
              noteController.popNoteAction(currentNote, originNote);
              // 返回主页
              navigateToHome();
            },
          ),
          actions: actions,
        );
      },
    );
  }

  Widget restoreNoteOrDelete() {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
              return;
            }
            controller.open();
          },
          icon: AppIcons.more, // 更多图标
          color: Theme.of(context).iconTheme.color,
          tooltip: I18nContent.more.tr,
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            // 还原笔记为未定义
            noteController.moveNote(currentNote, StatusNote.undefined);
            Get.find<NoteController>(tag: 'home').refreshNotes();
          },
          child: Row(
            children: [
              Icon(Icons.restore, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 5),
              Text(I18nContent.recycle.tr),
            ],
          ),
        ),
        MenuItemButton(
          onPressed: () {
            // 点击事件：显示永久删除确认弹窗
            AppAlerts.showAlertDeleteDialog(context, originNote);
          },
          child: Row(
            children: [
              Icon(Icons.delete_forever_outlined,
                  color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 5),
              Text(I18nContent.delete.tr),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuMore() {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
              return;
            }
            controller.open();
          },
          icon: AppIcons.more, // 更多图标
          color: Theme.of(context).iconTheme.color,
          tooltip: I18nContent.more.tr,
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            final html = _controller.document.toDelta().toHtml();
            _controller.document = Document.fromHtml(html);
          },
          child: Row(
            children: [
              Icon(Icons.html_sharp, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 5),
              Text(I18nContent.load.tr),
            ],
          ),
        ),
        MenuItemButton(
          onPressed: () async {
            final pdfDocument = pw.Document();
            final pdfWidgets = await _controller.document.toDelta().toPdf();
            pdfDocument.addPage(
              pw.MultiPage(
                maxPages: 200,
                pageFormat: PdfPageFormat.a4,
                build: (context) {
                  return pdfWidgets;
                },
              ),
            );
            await Printing.layoutPdf(
                onLayout: (format) async => pdfDocument.save());
          },
          child: Row(
            children: [
              Icon(Icons.picture_as_pdf,
                  color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 5),
              Text(I18nContent.pdf.tr),
            ],
          ),
        ),
        MenuItemButton(
          child: Row(
            children: [
              Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 5),
              Text(I18nContent.moreToTrash.tr),
            ],
          ),
          onPressed: () {
            noteController.moveNote(currentNote, StatusNote.trash);
            //  Get.find<NoteController>(tag: 'trash').refreshNotes();
          },
        ),
      ],
    );
  }

  void navigateToHome() {
    if (noteController.noteState.value is GoPopNoteState) {
      // 如果是返回状态，则关闭页面
      // Navigator.pop(context);
      Get.back();
      // print(noteController.noteState.value);
      // print(currentNote);
    }
  }
}
