import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quran_listienning/bloc/favourit/fav_bloc.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/widgets/listTileOfSuraFav.dart';

import 'listenScreen.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  FavBloc _favBloc;
  navigateToListen(List<Data> data, int index, BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Listen(data, null, index);
        },
      ),
    );
  }

  allData(List<dynamic> data) {
    return data == null || data.isEmpty
        ? Center(child: Text('no Fav add some'))
        : AnimationLimiter(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: ScaleAnimation(
                          child: ListTileOfSuraFav(
                            onTap: () {
                              navigateToListen(data, index, context, 0);
                            },
                            index: index,
                            data: data,
                          ),
                        ),
                      ),
                    )),
          );
  }

  @override
  void initState() {
    _favBloc = BlocProvider.of<FavBloc>(context);
    _favBloc.add(GetFav());
    super.initState();
  }

  @override
  void dispose() {
    _favBloc.add(Dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'المفضلة',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFF2F2),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFFFF2F2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height -
                  Scaffold.of(context).appBarMaxHeight,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color: Colors.white),
                  child: BlocBuilder<FavBloc, FavState>(
                    builder: (context, state) {
                      if (state is FavInitial) {
                        context.watch<FavBloc>().add(GetFav());
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FavLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FavLoaded) {
                        return allData(state.data);
                      } else
                        return Container();
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
