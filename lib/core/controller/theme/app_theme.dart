// 导入 FlexColorScheme 和其他依赖包
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';


// 应用主题类 AppTheme
class AppTheme {

  // 浅色主题
  static  ThemeData light = FlexThemeData.light(

      scheme: FlexScheme.cyanM3,
  subThemesData: const FlexSubThemesData(
    interactionEffects: false,
    tintedDisabledControls: false,
    blendOnColors: false,
    useTextTheme: true,
    filledButtonSchemeColor: SchemeColor.tertiaryContainer,
    elevatedButtonSecondarySchemeColor: SchemeColor.secondaryContainer,
    outlinedButtonSchemeColor: SchemeColor.onBackground,
    outlinedButtonOutlineSchemeColor: SchemeColor.onSurface,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    inputDecoratorUnfocusedBorderIsColored: false,
    fabUseShape: true,
    fabRadius: 24.0,
    fabSchemeColor: SchemeColor.tertiaryContainer,
    alignedDropdown: true,
    tooltipRadius: 4,
    tooltipSchemeColor: SchemeColor.inverseSurface,
    tooltipOpacity: 0.9,
    useInputDecoratorThemeInDialogs: true,
    snackBarElevation: 6,
    snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1.00,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,

    fontFamily: 'Roboto',
    ).copyWith(
  iconTheme:  const IconThemeData(
    color: Color(0xFF003E46),
    // color:  Color.lerp(Colors.blue, Colors.red, 0.5),  // 混合颜色
    ),  // 图标按钮颜色
);

  // 深色主题
  static  ThemeData dark = FlexThemeData.dark(

     scheme: FlexScheme.cyanM3,
  subThemesData: const FlexSubThemesData(
    interactionEffects: false,
    tintedDisabledControls: false,
    useTextTheme: true,
    filledButtonSchemeColor: SchemeColor.tertiaryContainer,
    elevatedButtonSecondarySchemeColor: SchemeColor.secondaryContainer,
    outlinedButtonSchemeColor: SchemeColor.onBackground,
    outlinedButtonOutlineSchemeColor: SchemeColor.onSurface,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    inputDecoratorUnfocusedBorderIsColored: false,
    fabUseShape: true,
    fabRadius: 24.0,
    fabSchemeColor: SchemeColor.tertiaryContainer,
    alignedDropdown: true,
    tooltipRadius: 4,
    tooltipSchemeColor: SchemeColor.inverseSurface,
    tooltipOpacity: 0.9,
    useInputDecoratorThemeInDialogs: true,
    snackBarElevation: 6,
    snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1.00,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,

    fontFamily: 'Roboto',
  ).copyWith(
  iconTheme:  const IconThemeData(
    color: Color(0xFFCDE7ED),
    // color:  Color.lerp(
    //   Color.lerp(Colors.blue, Colors.red, 0.5),  // 原混合颜色
    //   Colors.white,  // 对比色
    //   0.5,  // 插值因子
    // ),
    ),  // 图标按钮颜色
    );

}
