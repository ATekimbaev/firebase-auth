import 'package:firebase_app/models/kandidates_model.dart';
import 'package:firebase_app/screens/home_screen/bloc/get_candidates_data_bloc.dart';
import 'package:firebase_app/screens/home_screen/resulst_screen.dart';
import 'package:firebase_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.email});

  final String email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Candidates> candidates = [];

  String _selectedCandidate = '';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetCandidatesDataBloc>(context).add(GetDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Кандидаты'),
            const SizedBox(height: 25),
            BlocConsumer<GetCandidatesDataBloc, GetCandidatesDataState>(
              listener: (context, state) {
                if (state is GetCandidatesDataSuccess) {
                  candidates = state.data.candidates;
                }
              },
              builder: (context, state) {
                if (state is GetCandidatesDataSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.candidates.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.data.candidates[index].name),
                        Radio(
                          value: state.data.candidates[index].name,
                          groupValue: _selectedCandidate,
                          onChanged: (val) {
                            _selectedCandidate =
                                state.data.candidates[index].name;
                            print(_selectedCandidate);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GetCandidatesDataBloc>(context).add(
                    SendDataEvent(
                      data: ListCandidates(candidates: candidates),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(model: candidates),
                    ),
                  );
                },
                child: Text('Голосовать'))
          ],
        ),
      ),
    );
  }
}
