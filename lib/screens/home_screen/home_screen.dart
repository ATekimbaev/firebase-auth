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
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Candidates> candidates = [];
  int newVoice = 0;
  TextEditingController controllerName = TextEditingController();

  String _selectedCandidate = '';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetCandidatesDataBloc>(context).add(GetDataEvent());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: TextField(
                controller: controllerName,
                decoration: const InputDecoration(
                  hintText: 'Введите имя',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    candidates.add(
                      Candidates(voice: 0, name: controllerName.text),
                    );
                    BlocProvider.of<GetCandidatesDataBloc>(context).add(
                      SendDataEvent(
                        data: ListCandidates(candidates: candidates),
                      ),
                    );
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('Добавить'),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('голосовать'),
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
                            selectedIndex = index;
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
                  print(candidates.map((e) => e.voice));
                  candidates[selectedIndex].voice =
                      candidates[selectedIndex].voice + 1;
                  BlocProvider.of<GetCandidatesDataBloc>(context).add(
                    SendDataEvent(
                      data: ListCandidates(
                        candidates: candidates,
                      ),
                    ),
                  );
                  Navigator.pushReplacement(
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
