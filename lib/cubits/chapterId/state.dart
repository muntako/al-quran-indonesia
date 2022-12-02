part of 'cubit.dart';

@immutable
class ChapterIdState extends Equatable {
  final List<ChapterId?>? data;
  final String? message;

  const ChapterIdState({
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
class ChapterIdDefault extends ChapterIdState {}

@immutable
class ChapterIdFetchLoading extends ChapterIdState {
  const ChapterIdFetchLoading() : super();
}

@immutable
class ChapterIdFetchSuccess extends ChapterIdState {
  const ChapterIdFetchSuccess({List<ChapterId?>? data}) : super(data: data);
}

@immutable
class ChapterIdFetchFailed extends ChapterIdState {
  const ChapterIdFetchFailed({String? message}) : super(message: message);
}
