part of 'cubit.dart';

@immutable
class JuzIdState extends Equatable {
  final JuzId? data;
  final String? message;

  const JuzIdState({
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
class JuzIdDefault extends JuzIdState {}

@immutable
class JuzIdFetchLoading extends JuzIdState {
  const JuzIdFetchLoading() : super();
}

@immutable
class JuzIdFetchSuccess extends JuzIdState {
  const JuzIdFetchSuccess({JuzId? data}) : super(data: data);
}

@immutable
class JuzIdFetchFailed extends JuzIdState {
  const JuzIdFetchFailed({String? message}) : super(message: message);
}
