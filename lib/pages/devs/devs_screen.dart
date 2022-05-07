import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylife/blocs/dev/dev_bloc.dart';
import 'package:mylife/models/dev.dart';
import 'package:mylife/pages/components/custom_app_bar.dart';
import 'package:mylife/pages/components/custom_scaffold_messenger.dart';
import 'package:mylife/pages/components/custom_tooltip.dart';

class DevScreen extends StatefulWidget {
  final Widget loading;
  const DevScreen({Key? key, required this.loading}) : super(key: key);

  @override
  State<DevScreen> createState() => _DevScreenState();
}

class _DevScreenState extends State<DevScreen> {
  late DevBloc _devsBloc;

  List<Map<String, dynamic>> _roles = [];

  @override
  void initState() {
    _devsBloc = DevBloc();
    _devsBloc.add(GetDevList());
    _roles = [
      {
        "id": 0,
        "img": "assets/icons/backend.jpg",
        "title": "Dev Back-End",
        "techs": [
          "assets/icons/laravel.png",
          "assets/icons/flutter.webp",
          "assets/icons/database.png"
        ]
      },
      {
        "id": 1,
        "img": "assets/icons/frontend.jpg",
        "title": "Dev Front-End",
        "techs": [
          "assets/icons/vue.webp",
          "assets/icons/figma.png",
          "assets/icons/bootstrap.png"
        ]
      }
    ];

    super.initState();
  }

  @override
  void dispose() {
    _devsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Devs'),
      body: Center(
        child: BlocProvider(
          create: (_) => _devsBloc,
          child: BlocListener<DevBloc, DevState>(
            listener: (context, state) {
              if (state is DevError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    ErrorScaffoldMessenger.showErrorSnackBar(state.message!));
              }
            },
            child: BlocBuilder<DevBloc, DevState>(
              builder: (context, state) {
                if (state is DevInitial) {
                  return widget.loading;
                } else if (state is DevLoading) {
                  return widget.loading;
                } else if (state is DevLoaded) {
                  return _buildListDev(context, state.devModel, _roles);
                } else if (state is DevError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildListDev(BuildContext context, List<DevModel> model,
    List<Map<String, dynamic>> roles) {
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Desenvolvedores:',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            height: 150.0,
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) {
                return CustomTooltip(
                  message: roles[index]['title'],
                  child: Card(
                    elevation: 2,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CircleAvatar(
                            child: Image.asset(
                              roles[index]['img'],
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                            radius: 30,
                          ),
                          Text(
                            "${model[index].name}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 26),
                          ),
                          Row(
                            children: roles[index]['techs']
                                .map<Widget>((tech) =>
                                    Image.asset(tech, height: 40, width: 40))
                                .toList(),
                          )
                          // Row(
                          //     children: roles[index]['techs']
                          //         .map((String tech, index) => Text(tech))
                          //         .toList()),

                          // roles[index]['techs']
                          //     .map((tech) => Text(tech))
                          //     .toList()
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
          onPressed: () => print('Tela de cadastro :)'),
          child: const Icon(Icons.add),
          style: ButtonStyle(
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
