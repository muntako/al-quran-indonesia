part of 'cubit.dart';

@immutable
class BookmarkState extends Equatable {
  final List<Bookmark?>? data;
  final bool? isLastRead;
  final String? message;

  const BookmarkState({
    this.data,
    this.message,
    this.isLastRead = false,
  });

  @override
  List<Object?> get props => [
        data,
        message,
        isLastRead,
      ];
}

@immutable
class BookmarkDefault extends BookmarkState {}

@immutable
class BookmarkFetchLoading extends BookmarkState {
  const BookmarkFetchLoading() : super();
}

@immutable
class BookmarkFetchSuccess extends BookmarkState {
  const BookmarkFetchSuccess({List<Bookmark?>? data, bool? isLastRead})
      : super(
          data: data,
          isLastRead: isLastRead,
        );
}

@immutable
class BookmarkFetchFailed extends BookmarkState {
  const BookmarkFetchFailed({String? message}) : super(message: message);
}
