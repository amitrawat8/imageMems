import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageflip/utility/Error_txt.dart';
import 'package:imageflip/utility/ImageShow.dart';
import 'package:imageflip/utility/LoadingIndicator.dart';

import '../bloc/memes/memes_bloc.dart';
import '../bloc/memes/memes_event.dart';
import '../bloc/memes/memes_state.dart';
import '../model/mems_dto.dart';
import '../offline/SQLiteDbProvider.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

class MemePage extends StatefulWidget {
  @override
  _MemePageState createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  final MemesBloc _newsBloc = MemesBloc();

  bool loadingBookmarker = true;
  List<Memes> memesList = [];

  @override
  void initState() {
    getAllOfflineData();
    _newsBloc.add(GetMemesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<MemesBloc, MemeState>(
          listener: (context, state) {
            if (state is MemeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MemesBloc, MemeState>(
            builder: (context, state) {
              if (state is MemeInitial) {
                return LoadingIndicator();
              } else if (state is MemeLoading) {
                return LoadingIndicator();
              } else if (state is MemeLoaded) {
                return _buildCard(context, state.memesDto);
              } else if (state is MemeError) {
                return ErrorText(
                  text: state.message!,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, MemesDTO? model) {
    if (loadingBookmarker) {
      for (var ml in memesList) {
        for (var meme in model!.data!.memes!) {
          if (ml.id == meme.id) {
            meme.bookmark = true;
            break;
          }
        }
      }
      loadingBookmarker = false;
    }

    return ListView.builder(
      itemCount: model!.data?.memes!.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            child: showImage(model.data?.memes![index], index),
          ),
        );
      },
    );
  }

  showImage(Memes? memes, int position) {
    if (memes == null) {
      return Container();
    }
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              ImageLoader(memes.url!),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    if (memes.bookmark!) {
                      removedBookmark(memes);
                    } else {
                      addBookMarker(memes);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.topRight,
                    height: 40,
                    width: 80,
                    child: memes.bookmark!
                        ? Icon(
                            Icons.bookmark,
                            size: 35.0,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.bookmark_border,
                            size: 35.0,
                          ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        memes.name!,
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void getAllOfflineData() {
    SQLiteDbProvider.db.getAllMemesData().then((value) => {
          if (mounted)
            {
              setState(() {
                memesList = value;
              }),
            }
        });
  }

  void addBookMarker(Memes model) {
    if (mounted) {
      setState(() {
        model.bookmark = true;
      });
      SQLiteDbProvider.db.insert(model);
    }
  }

  void removedBookmark(Memes model) {
    if (mounted) {
      setState(() {
        model.bookmark = false;
      });
    }

    ifExitCheck(model.id!);
  }

  ifExitCheck(String id) {
    SQLiteDbProvider.db.uidExists(id).then((value) => {
          if (value) {SQLiteDbProvider.db.delete(id)}
        });
  }
}
