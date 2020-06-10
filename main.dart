import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_generator/bloc/bloc/generator_bloc_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider<GeneratorBlocBloc>(
          create: (context) => GeneratorBlocBloc(),
          child: MyHomePage(
            title: "Number Generator",
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String lowerLimit;
  String upperLimit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
              child: BlocBuilder(
            bloc: BlocProvider.of<GeneratorBlocBloc>(context),
            builder: (BuildContext context, GeneratorBlocState state) {
              if (state is GeneratorBlocInitial) {
                return buildInitial();
              } else if (state is GeneratorNumberLoading) {
                return buildLoading();
              } else if (state is GeneratorNumbersLoaded) {
                return buildLoaded(state.genNumer);
              }
              return buildInitial();
            }),
      ),
    );
  }

  Padding buildBody(Text data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            onSubmitted: (text) {
              lowerLimit = text;
            },
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "Lower Limit",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: Icon(Icons.arrow_downward),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            onSubmitted: (text) {
              upperLimit = text;
            },
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "Upper Limit",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: Icon(Icons.arrow_upward),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            onPressed: submitData,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(50),
              ),
              height: 70,
              width: 150,
              alignment: Alignment.center,
              child: Text(
                "Generate",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          data,
        ],
      ),
    );
  }

  Widget buildInitial() {
    return buildBody(Text(
      "",
    ));
  }

  Widget buildLoading() {
    return Center(
      heightFactor: 20,
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoaded(String number) {
    return buildBody(Text(
      number,
      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
    ));
  }

  void submitData() {
    BlocProvider.of<GeneratorBlocBloc>(context)
        .add(GetNumbers(lowerLimit, upperLimit));
  }
}
