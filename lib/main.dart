import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex_app/pokeInfo.dart';
import 'package:pokedex_app/pokemonfact.dart';

void main()=>runApp(MaterialApp(
      title: "Pokedex",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://github.com/Biuni/PokemonGO-Pokedex/blob/master/pokedex.json";

  PokeCenter pokecenter;


  @override
  void initState() {

    super.initState();

    fetchData();
  }

  fetchData() async {
    var res =  await http.get(url);
    var decodedJson = jsonDecode(res.body);

    pokecenter = PokeCenter.fromJson(decodedJson);
    print(pokecenter.toJson());
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.red,
      ),

      body: pokecenter == null?Center(
          child: CircularProgressIndicator(),
      )
      : GridView.count(crossAxisCount: 2,
      children: pokecenter.pokemon.map((pokemon) => Padding(
        padding: const EdgeInsets.all(2.0),
       child: InkWell(
         onTap: (){

           Navigator.push(context, MaterialPageRoute(builder: (context)=> PokeFact(
             pokemon: pokemon,
           )));
           
         },
         child: Hero(
           tag: pokemon.img,
           child: Card(
             elevation: 3.0,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
               Container(
                  height: 100.0,
                 width: 100.0,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image:NetworkImage(pokemon.img)
                   ),
                 ),
               ),
                 Text(
                   pokemon.name,
                   style: TextStyle(fontSize:  20.0,
                       fontWeight: FontWeight.bold),
                 )
             ],
             ),
           ),
         ),
      ),
      )).toList(),

      ),


      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.red,
          child: Icon(Icons.refresh)),
    );
  }
}
