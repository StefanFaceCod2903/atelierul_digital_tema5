import 'package:atelierul_digital_tema5/actions/index.dart';
import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final double offset = _scrollController.position.pixels;
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    if (offset > maxScrollExtent - MediaQuery.of(context).size.height) {
      store.dispatch(const GetMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Infinite Movies!')),
          body: RefreshIndicator(
            onRefresh: () async {
              store
                ..dispatch(const SetCurrentPage(1))
                ..dispatch(const GetMovies());

              await store.onChange
                  .where((AppState state) => !state.isLoading)
                  .first;
            },
            child: !store.state.isLoading
                ? CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: store.state.movies.length,
                            (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              store.dispatch(
                                SetSelectedMovie(store.state.movies[index]),
                              );
                              Navigator.pushNamed(
                                context,
                                'movieDetails',
                                arguments: store.state.selectedMovie,
                              );
                            },
                            child: Image.network(
                              store.state.movies[index].image,
                            ),
                          );
                        }),
                      ),
                      SliverToBoxAdapter(
                        child: Builder(
                          builder: (BuildContext context) {
                            return LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 50,
                            );
                          },
                        ),
                      )
                    ],
                  )
                : LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue,
                    size: 50,
                  ),
          ),
        );
      },
    );
  }
}
