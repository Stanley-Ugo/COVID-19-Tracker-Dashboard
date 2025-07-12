import 'package:bloc/bloc.dart';
import 'package:covid_19_tracker_dashboard/features/dashboard/data/repository/covid_data_repository.dart';
import 'package:covid_19_tracker_dashboard/helper/exception_handler.dart';
import 'package:covid_19_tracker_dashboard/networking/api_exception.dart';
import 'package:equatable/equatable.dart';

import '../data/models/models.dart';

part 'covid_data_event.dart';
part 'covid_data_state.dart';

class CovidDataBloc extends Bloc<CovidDataEvent, CovidDataState> {
  final CovidRepository covidRepository;
  CovidDataBloc({required this.covidRepository})
    : super(FetchCovidDataInitial()) {
    on<FetchCovidDataEvent>((event, emit) async {
      try {
        emit(FetchingCovidDataState());
        final data = await covidRepository.fetchHistoricalData(noOfDays: event.noOfDays);
        emit(FetchedCovidDataState(covidDataModel: data));
      } catch (e) {
        if (e is ApiException) {
          emit(FetchCovidDataFailedState(errorMessage: e.message));
        } else {
          final errorMessage = handleException(e);
          emit(FetchCovidDataFailedState(errorMessage: errorMessage));
        }
      }
    });
  }
}
