import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylife/blocs/dev/dev_bloc.dart';
import 'package:mylife/components/custom_app_bar.dart';
import 'package:mylife/models/dev.dart';

class DevScreen extends StatefulWidget {
  final Widget loading;
  const DevScreen({Key? key, required this.loading}) : super(key: key);

  @override
  State<DevScreen> createState() => _DevScreenState();
}

class _DevScreenState extends State<DevScreen> {
  late DevBloc _devsBloc;

  @override
  void initState() {
    _devsBloc = DevBloc();
    _devsBloc.add(GetDevList());

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
                  SnackBar(content: Text(state.message!)),
                );
              }
            },
            child: BlocBuilder<DevBloc, DevState>(
              builder: (context, state) {
                if (state is DevInitial) {
                  return widget.loading;
                } else if (state is DevLoading) {
                  return widget.loading;
                } else if (state is DevLoaded) {
                  return _buildListDev(context, state.devModel);
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

Widget _buildListDev(BuildContext context, List<DevModel> model) {
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Desenvolvedores:',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: SizedBox(
          height: 150.0,
          child: ListView.builder(
            itemCount: model.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text("${model[index].id} - ${model[index].name}")
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      ElevatedButton(
          onPressed: () => print('Vou pra tela de cadastro!'),
          child: const Icon(Icons.add),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )))),
    ],
  );
}
