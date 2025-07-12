part of 'covid_data_bloc.dart';

sealed class CovidDataState extends Equatable {
  const CovidDataState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class FetchCovidDataInitial extends CovidDataState {
  @override
  List<Object> get props => [];
}

class FetchingCovidDataState extends CovidDataState {}

class FetchedCovidDataState extends CovidDataState {
  FetchedCovidDataState({required this.covidDataModel});
  CovidDataModel covidDataModel;
}

class FetchCovidDataFailedState extends CovidDataState {
  const FetchCovidDataFailedState({required this.errorMessage});
  final String errorMessage;
}
