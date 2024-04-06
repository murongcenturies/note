/// 表示应用路由及其路径的枚举。
enum AppRouterName {
  // 路由视图
  login(name: 'login', path: '/login'),
  // 首页
  home(name: 'home', path: '/home'),
  // 笔记视图
  note(name: 'note', path: '/note'),

  // 存档区
  archive(name: 'Archive', path: '/Archive'),
  // 回收站
  trash(name: 'Trash', path: '/Trash'),
  // 设置页
  setting(name: 'Setting', path: '/Setting'),

  emotion(name: 'Emotion', path: '/Emotion');

  const AppRouterName({required this.name, required this.path});

  final String name; // 路由名称
  final String path;  // 路由路径
}