import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mobile_dev_lab1/bloc/loading_bloc.dart';
import 'package:mobile_dev_lab1/data/Phrase.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<LoadingBloc>().add(LoadScreenEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: const Text('La frase diaria'),
        actions: const [
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          )
        ],
      ),
      frontLayer: BlocBuilder<LoadingBloc, LoadingState>(
        builder: (context, state) {
          if (state is LoadingInitial) {
            return const Center(
              child: SpinKitRing(color: Colors.purple),
            );
          }
          if (state is LoadingSuccess) {
            return FrontLayer(
              phrase: state.phrase,
              datetime: state.datetime,
              country: state.country,
              background: state.background,
            );
          }
          if (state is LoadingError) {
            return Text(state.errorMsg);
          } else {
            return Container();
          }
        },
      ),
      backLayer: BlocBuilder<LoadingBloc, LoadingState>(
        builder: (context, state) {
          if (state is LoadingSuccess) {
            List<Widget> list = [];
            List<String> countries = [];
            state.countries.forEach((key, value) {
              list.add(ListTile(
                title: Text(key),
                leading: Image(image: NetworkImage(value)),
              ));
              countries.add(key);
            });
            return BackdropNavigationBackLayer(
              items: list,
              onTap: (int position) => {
                context
                    .read<LoadingBloc>()
                    .add(ChangeCountryEvent(country: countries[position]))
              },
            );
          } else {
            return Container();
          }
        },
      ),
      backLayerBackgroundColor: Colors.purple,
    );
  }
}

class FrontLayer extends StatelessWidget {
  final Phrase phrase;
  final DateTime datetime;
  final String country;
  final String background;
  const FrontLayer({
    Key? key,
    required this.phrase,
    required this.datetime,
    required this.country,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(background),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.darken)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  country,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                Text(
                  DateFormat.Hms().format(datetime),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  phrase.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Text(
                  "-${phrase.author}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
