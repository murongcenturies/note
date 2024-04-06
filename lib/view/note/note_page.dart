// import 'dart:io';
import 'dart:ui';
import 'dart:convert' show jsonEncode;

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
import './widgets/widgets.dart';
import 'package:note/core/core.dart';

class NotePage extends StatefulWidget {

  const NotePage({
    super.key,
    required this.note, // 要展示的笔记信息
  });

    
  final Note note; // 笔记数据
  @override
  State<NotePage> createState() => NotePageState();
}


class NotePageState extends State<NotePage> {

  late QuillController _controller;
  late FocusNode _focusNode;
  final NoteController noteController = Get.find<NoteController>(tag: 'home');


  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    _focusNode = FocusNode();
  }

  // 获取原始笔记数据（未修改的）
Note get originNote {
  return Note(
    id: widget.note.id,
    content: widget.note.content,
    modifiedTime: widget.note.modifiedTime,
    stateNote: widget.note.stateNote,
  );
}

// 获取当前笔记数据（可能被修改过的）
Note get currentNote {

  final StatusIconsController noteStatusBloc = Get.find<StatusIconsController>();

  // 获取当前笔记状态（来自图标状态管理器）
  final StatusNote currentStatusNote =
      noteStatusBloc is ToggleIconsStatusState
          ? (noteStatusBloc as ToggleIconsStatusState).currentNoteStatus
          : StatusNote.undefined; // 默认状态为“垃圾箱”

  // 构建当前笔记对象，包含标题、内容、颜色、状态等信息
  return Note(
    id: widget.note.id,
    content: jsonEncode(_controller.document.toDelta().toJson()),
    modifiedTime: widget.note.modifiedTime,
    // 使用bloc中的最新颜色
    stateNote: currentStatusNote, // 使用获取到的笔记状态
  );
}
// // 加载笔记内容到输入框
//   void _loadNoteFields() {
//     _controller.document= widget.note.content;
//   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'sparkler'),
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
          Column(children: <Widget>[
            AppBar(
              // title: Text('Title'),
              //特殊设置，颜色没有被全局主题色覆盖，，使用主动获取的方式
              iconTheme:
                  IconThemeData(color: Theme.of(context).iconTheme.color),
              leading: IconButton.outlined(
                
                icon: AppIcons.home, // 使用home图标
                onPressed: () async {
                  // await saveDocumentToJson();
                  noteController.popNoteAction(currentNote, originNote);
                  print(currentNote);
                  // 返回主页
                  if (Get.currentRoute == AppRouterName.home.path) {
                    Get.back();
                  } else {
                    Get.offNamedUntil(
                        AppRouterName.home.path, (route) => false);
                  }
                },
              ),
              actions: [
                MenuAnchor(
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
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        final html = _controller.document.toDelta().toHtml();
                        _controller.document = Document.fromHtml(html);
                      },
                      child: const Text('Load with HTML'),
                    ),
                    MenuItemButton(
                      onPressed: () async {
                        final pdfDocument = pw.Document();
                        final pdfWidgets =
                            await _controller.document.toDelta().toPdf();
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
                      child: const Text('Print as PDF'),
                    ),
                  ],
                ),
                IconButton(
                  tooltip: 'Share',
                  onPressed: () {
                    final plainText = _controller.document.toPlainText(
                      FlutterQuillEmbeds.defaultEditorBuilders(),
                    );
                    if (plainText.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showText(
                        "We can't share empty document, please enter some text first",
                      );
                      return;
                    }
                    Share.share(plainText);
                  },
                  icon: AppIcons.share,
                  color: Theme.of(context).iconTheme.color,
                ),
                IconButton(
                  tooltip: 'Print to log',
                  onPressed: () {
                    print(
                      jsonEncode(_controller.document.toDelta().toJson()),
                    );
                    ScaffoldMessenger.of(context).showText(
                      'The quill delta json has been printed to the log.',
                    );
                  },
                  icon: AppIcons.print,
                  color: Theme.of(context).iconTheme.color,
                ),
                // const HomeScreenButton(),
              ],
            ),
            MyQuillToolbar(
              controller: _controller,
              focusNode: _focusNode,
            ),
            Expanded(
              child: MyQuillEditor(
                configurations: QuillEditorConfigurations(
                  controller: _controller,
                  readOnly: false,
                  autoFocus: true,
                  expands: false,
                  padding: EdgeInsets.zero,
                  enableInteractiveSelection: true,
                  textCapitalization: TextCapitalization.none,
                  keyboardAppearance: Brightness.light,
                  scrollPhysics: ClampingScrollPhysics(),
                  // keyboardEnabled: true,
                ),
                scrollController: ScrollController(),
                focusNode: _focusNode,
              ),
            ),
          ])
        ],
      ),
    );
  }

  // Future<void> saveDocumentToJson() async {
  //   final json = jsonEncode(_controller.document.toDelta().toJson());
  //   // print(json);
  //   // 获取应用程序的文档目录
  //   final directory = await getApplicationDocumentsDirectory();
  //   // 创建一个新的文件路径
  //   final filePath = '${directory.path}/note.json';
  //   // 创建一个文件对象
  //   final file = File(filePath);
  //   // 将 JSON 字符串写入文件
  //   await file.writeAsString(json);
  // }

  // @override
  // void dispose() {
  //   // final content = _controller.document.toDelta().toJson();
  //   // _saveNoteAsJson(content);
  //   saveDocumentToJson();
  //   super.dispose();
  // }
}
