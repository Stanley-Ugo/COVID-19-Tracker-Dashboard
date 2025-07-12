part of 'covid_data_bloc.dart';

sealed class CovidDataEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  const CovidDataEvent();
}

class FetchCovidDataEvent extends CovidDataEvent {
  const FetchCovidDataEvent({required this.noOfDays});
  final int noOfDays;
}
