part of 'cubit.dart';

@immutable
class SurahState extends Equatable {
  final List<Surah?>? data;
  final String? message;

  const SurahState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

@immutable
class SurahDefault extends SurahState {}

@immutable
class SurahFetchLoading extends SurahState {
  const SurahFetchLoading() : super();
}

@immutable
class SurahFetchSuccess extends SurahState {
  const SurahFetchSuccess({List<Surah?>? data}) : super(data: data);
}

@immutable
class SurahFetchFailed extends SurahState {
  const SurahFetchFailed({String? message}) : super(message: message);
}
