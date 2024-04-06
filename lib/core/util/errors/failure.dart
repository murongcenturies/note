// 抽象基类，用于表示应用程序中的错误
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // 获取错误的属性列表 (用于比较)
  @override
  List<Object> get props => [];
}

// 没有数据错误
class NoDataFailure extends Failure {}

// 空输入错误
class EmptyInputFailure extends Failure {}

// 数据库操作错误
class DatabaseFailure extends Failure {}

// 获取数据错误
class RetrieveFailure extends Failure {}
