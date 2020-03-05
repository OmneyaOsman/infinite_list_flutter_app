import 'package:flutter/material.dart';
import 'package:infinite_list_flutter_app/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'widget/bottom_loader_widget.dart';
import 'widget/post_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollingController = ScrollController();

  final _scrollThreshold = 200.0;

  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollingController.addListener(_onScroll);
    _postBloc = context.bloc<PostBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list'),
      ),
      body: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        return _homeWidget(state, _scrollingController);
      }),
    );
  }

  Widget _homeWidget(PostState state, ScrollController scrollController) {
    var widget;
    switch (state.runtimeType) {
      case PostUninitialized:
        widget = Center(
          child: CircularProgressIndicator(),
        );
        break;
      case PostError:
        {
          widget = Center(
            child: Text('failed to fetch posts'),
          );
        }
        break;
      case PostLoaded:
        {
          if (state is PostLoaded) {
            widget = (state.posts.isEmpty)
                ? Center(
                    child: Text('no posts'),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.posts.length
                          ? BottomLoader()
                          : PostWidget(post: state.posts[index]);
                    },
                    itemCount: state.hasReachedMax
                        ? state.posts.length
                        : state.posts.length + 1,
                    controller: scrollController,
                  );
          }
        }
        break;
      default:
        {
          widget = Container();
        }
        break;
    }
    return widget;
  }

  void _onScroll() {
    final maxScrolling = _scrollingController.position.maxScrollExtent;
    final currentScrolling = _scrollingController.position.pixels;
    if (maxScrolling - currentScrolling <= _scrollThreshold)
      _postBloc.add(Fetch());
  }

  @override
  void dispose() {
    _scrollingController.dispose();
    super.dispose();
  }
}
