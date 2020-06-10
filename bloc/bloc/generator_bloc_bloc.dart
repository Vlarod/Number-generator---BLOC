import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'generator_bloc_event.dart';
part 'generator_bloc_state.dart';

class GeneratorBlocBloc extends Bloc<GeneratorBlocEvent, GeneratorBlocState> {
  @override
  GeneratorBlocState get initialState => GeneratorBlocInitial();

  @override
  Stream<GeneratorBlocState> mapEventToState(
    GeneratorBlocEvent event,
  ) async* {
    if(event is GetNumbers) {
      yield GeneratorNumberLoading();
      final genNumber = await _calculateNumber(event.lowerLimit, event.upperLimit);
      yield GeneratorNumbersLoaded(genNumber);
    }
  }

  Future<String> _calculateNumber(String lowerLimit, String upperLimit) {
    int lowerLimitI = int.parse(lowerLimit);
    int upperLimitI = int.parse(upperLimit);
    return Future.delayed(Duration(seconds: 1), () {
      return (Random().nextInt(upperLimitI) % (upperLimitI - lowerLimitI + 1) + lowerLimitI).toString();
    });
  }
}


