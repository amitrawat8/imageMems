import 'package:imageflip/bloc/offline/offine_state.dart';
import 'package:imageflip/bloc/offline/offline_bloc.dart';
import 'package:imageflip/bloc/offline/offline_event.dart';
import 'package:imageflip/utility/ImageShow.dart';
import 'package:imageflip/utility/LoadingIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/mems_dto.dart';
import '../offline/SQLiteDbProvider.dart';
import '../utility/Error_txt.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

class OfflinePage extends StatefulWidget {
  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  final OfflineBloc _newsBloc = OfflineBloc();
  bool isInternet = false;

  @override
  void initState() {
    _newsBloc.add(GetOfflineMemesList());

    super.initState();
  }

  Internet(bool value) {
    setState(() {
      isInternet = value;
    });
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
        child: BlocListener<OfflineBloc, OfflineState>(
          listener: (context, state) {
            /* if (state is MemeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }*/
          },
          child: BlocBuilder<OfflineBloc, OfflineState>(
            builder: (context, state) {
              if (state is OfflineInitial) {
                return LoadingIndicator();
              } else if (state is OfflineLoading) {
                return LoadingIndicator();
              } else if (state is OfflineLoaded) {
                if (state.memesDto != null && state.memesDto!.isNotEmpty) {
                  return _buildCard(context, state.memesDto!);
                }
                return ErrorText(
                  text: "No Offline Data Found",
                );
              } else if (state is OfflineError) {
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

  Widget _buildCard(BuildContext context, List<Memes> model) {
    print(model.length);
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            child: showImage(model[index], index),
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
  }
}
