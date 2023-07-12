import 'package:flutter/material.dart';
import 'movie.dart';
import 'package:omdbapp/movie_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchEntryProvider = StateProvider<String>((ref) => '');

final apiProvider = Provider<ApiService>((ref) => ApiService());

final movieProvider = FutureProvider<List<Movie>>((ref) {
  return ref.read(apiProvider).getMovie(ref.watch(searchEntryProvider));
});

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final movieList = ref.watch(movieProvider);
    return Scaffold(
      
        appBar: AppBar(
          title: const Text('Sample Code'),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    ref
                        .read(searchEntryProvider.notifier)
                        .update((state) => value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: movieList.when(
                      data: (data) {
                        return GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            children: List.generate(data.length, (index) {
                              return Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SecondRoute(
                                              movie: data[index])),
                                    );
                                  },
                                  
                                    child: Column(
                                      children: <Widget>[
                                        
                                    Container(
                                      
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(10.0),
                                      height: 130,

                                      child: 
                                      Image.network(data[index].poster, width: double.infinity, fit: BoxFit.fitWidth,)
                                      
                                    ),
                                    Text(data[index].title)
                                    
                                  ],)
                                  

                                  
                                )
                              );
                            }));
                        // return ListView.builder(
                        //   itemCount: data.length,
                        //   itemBuilder: (context, index) {
                        //     return ListTile(
                        //       onTap: () {
                        //                 Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) => SecondRoute(
                        //                           movie: data[index])),
                        //                 );
                        //               },
                        //       title: Column(
                        //         children: <Widget>[
                        //           Image.network(data[index].poster),
                        //           Text(data[index].title)
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                      error: ((error, stackTrace) => Text(error.toString())),
                      loading: (() {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })))
            ]));
  }
}
