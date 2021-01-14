import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quran_listienning/bloc/chooseSura/choose_sura_bloc.dart';
import 'package:quran_listienning/bloc/search_in_chosse/search_in_choose_bloc.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/screens/listenScreen.dart';
import 'package:quran_listienning/widgets/listTileOfSura.dart';

class ChooseSura extends StatefulWidget {
  final int id;

  const ChooseSura({this.id});

  @override
  _ChooseSuraState createState() => _ChooseSuraState();
}

class _ChooseSuraState extends State<ChooseSura> {
  TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  navigateToListen(Quran quran, int index, BuildContext context) async {
    focusNode.unfocus(); //so you can hide keyboard before navigate

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Listen(quran.data, widget.id, index);
        },
      ),
    );
  }

  Widget _searchAddList(Quran quran, List<Data> _searchListItems) {
    return ListView.builder(
        itemCount: _searchListItems.length,
        itemBuilder: (BuildContext context, int index) {
          int i = int.parse(_searchListItems[index].soraNumber) - 1;
          return ListTileOfSura(
            onTap: () {
              navigateToListen(quran, i, context);
            },
            index: i,
            quran: quran,
          );
        });
  }

  allData(Quran quran) {
    return AnimationLimiter(
      child: ListView.builder(
          itemCount: quran.data.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: ScaleAnimation(
                    child: ListTileOfSura(
                      onTap: () {
                        navigateToListen(quran, index, context);
                      },
                      index: index,
                      quran: quran,
                    ),
                  ),
                ),
              )),
    );
  }

  Widget buildListOfQuran(Quran quran, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: IconButton(
                onPressed: () async {
                  focusNode.unfocus();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * .7,
              child: TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'ادخل اسم سوره',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.right,
                controller: _controller,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: Colors.white),
              child: BlocBuilder<SearchInChooseBloc, SearchInChooseState>(
                builder: (context, state) {
                  if (state is SearchInChooseInitial) {
                    BlocProvider.of<SearchInChooseBloc>(context)
                        .add(StartSearching(_controller, quran));
                    return allData(quran);
                  } else if (state is Searching) {
                    return _searchAddList(quran, state.newValue);
                  } else if (state is NoSearch) {
                    return allData(quran);
                  } else {
                    return Container();
                  }
                },
              )),
        ),
      ],
    );
  }

  onIniti(BuildContext context, int id) {
    context.read<ChooseSuraBloc>().add(GetAllQuranEvent(readerId: id));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => onIniti(context, widget.id));

    super.initState();
  }

  @override
  void dispose() {
    _controller.clear(); //reset state so you can search again

    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFF2F2),
        body: SafeArea(
          child: RefreshIndicator(onRefresh: () {
            onIniti(context, widget.id);
            return Future.delayed(Duration.zero);
          }, child: BlocBuilder<ChooseSuraBloc, ChooseSuraState>(
            builder: (context, state) {
              if (state is ChooseSuraInitial) {
                return CircularProgressIndicator();
              } else if (state is ChooseSuraLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ChooseSuraLoaded) {
                return buildListOfQuran(state.quran, context);
              } else if (state is ChooseSuraError) {
                return Center(
                  child: Text('error in connecting please retry again'),
                );
              } else {
                return Container();
              }
            },
          )),
        ));
  }
}
