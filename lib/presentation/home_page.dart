import 'package:atelierul_digital_tema5/actions/index.dart';
import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Infinite Movies!')),
          body: !store.state.isLoading
              ? CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(childCount: store.state.movies.length,
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
                          if (store.state.isLoading) {
                            return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blue,
                                size: 50,
                              ),
                            );
                          } else {
                            return TextButton(
                              child: const Text('Load More'),
                              onPressed: () {
                                store.dispatch(const GetMovie());
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                )
              : Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue,
                    size: 50,
                  ),
                ),
        );
      },
    );
  }
}
