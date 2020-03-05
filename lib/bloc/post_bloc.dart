import 'package:bloc/bloc.dart';
import 'package:infinite_list_flutter_app/bloc/bloc.dart';
import 'package:infinite_list_flutter_app/data/_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostClient postClient;

  PostBloc({ @required this.postClient});


  @override
  Stream<PostState> transformEvents(Stream<PostEvent> events,
      Stream<PostState> Function(PostEvent event) next,) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await postClient.fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoaded) {
          final posts = await postClient.fetchPosts(
              currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
            posts: currentState.posts + posts,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
}
