// 引入核心类库
import '../../core.dart';

// 抽屉选择类
class DrawerSelect {
  /// 默认抽屉视图（初始值为 DrawerViews.home）
  static const DrawerViews defaultDrawerView = DrawerViews.home;

  /// 默认抽屉部分（初始值为 DrawerSectionView.home）
  static const DrawerSectionView defaultDrawerSection =
      DrawerSectionView.home;

  /// 当前选中的抽屉视图（私有静态变量）
  static DrawerViews _drawerViews = defaultDrawerView;

  /// 获取当前选中的抽屉视图
  static DrawerViews get drawerViews => _drawerViews;

  /// 设置当前选中的抽屉视图
  static set selectedDrawerView(DrawerViews newDrawerViews) =>
      _drawerViews = newDrawerViews;

  /// 当前选中的抽屉部分（私有静态变量）
  static DrawerSectionView _drawerSection = defaultDrawerSection;

  /// 获取当前选中的抽屉部分
  static DrawerSectionView get drawerSection => _drawerSection;

  /// 设置当前选中的抽屉部分
  static set selectedDrawerSection(DrawerSectionView newDrawerSectionView) =>
      _drawerSection = newDrawerSectionView;
}
