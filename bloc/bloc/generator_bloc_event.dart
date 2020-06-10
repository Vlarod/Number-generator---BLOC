part of 'generator_bloc_bloc.dart';

@immutable
abstract class GeneratorBlocEvent {}

class GetNumbers extends GeneratorBlocEvent {
  final String lowerLimit;
  final String upperLimit;

  GetNumbers(this.lowerLimit, this.upperLimit);
}
