part of 'generator_bloc_bloc.dart';

@immutable
abstract class GeneratorBlocState {}

class GeneratorBlocInitial extends GeneratorBlocState {}

class GeneratorNumberLoading extends GeneratorBlocState {}

class GeneratorNumbersLoaded extends GeneratorBlocState {
  final String genNumer;

  GeneratorNumbersLoaded(this.genNumer);
}
