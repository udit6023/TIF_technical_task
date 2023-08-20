import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_task/Screens/singleEventScreen.dart';
import 'package:technical_task/modals/allEvents.dart';



import '../bloc_file/bloc/bloc_search.dart';

import '../bloc_file/event/bloc_searchEvent.dart';
import '../bloc_file/state/bloc_searchState.dart';
import '../utils/utility.dart';


class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({super.key});

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  TextEditingController _controller=new TextEditingController();

  late final SearchBloc _eventBloc=SearchBloc(_controller.text);


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
          Navigator.pop(context);
        },),
        title: Container(
      //padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search Event Name",
          prefixIcon: IconButton(icon: Image.asset('assets/search1.png'),onPressed: () {
        },),
        ),
        onChanged: (text){
          if(_controller==null){
            _buildLoading();
          }else{
               setState(() {
            _controller.text=text;
            _eventBloc.add(GetSearchEventList());
          });
          
          
          }
         
        },
      ),
    )),
      body: _buildListEvent(),
    );
  }


  Widget _buildListEvent() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _eventBloc,
        child: BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is Initial) {
                return _buildLoading();
              } else if (state is Loading) {
                return _buildLoading();
              } else if (state is Loaded) {
                return _buildCard(context, state.searcheventModel);
              } else if (state is Error) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, allEvents model) {
    return ListView.builder(
      itemCount: model.content!.data!.length,
      itemBuilder: (context, index) {
        
        return Card(
          elevation: 4,
           color: Colors.white,
          child: InkWell(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleEventScreen(id: model.content!.data![index].id,)));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
      BoxShadow(
        offset: Offset(3,3),
        color: Colors.white,
        blurRadius: 1.0,
        spreadRadius: 2 // soften the shadow
        
      )
    ],
              ),
              
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
    width: UTILITY.width(context)/5,
                    height: UTILITY.height(context)/8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      
      image: DecorationImage(
        image: imageProvider, fit: BoxFit.fill),
    ),
  ),
                    width: UTILITY.width(context)/5,
                    height: UTILITY.height(context)/8,
                    fit: BoxFit.fill,
        imageUrl:model.content!.data![index].bannerImage.toString(),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),

     SizedBox(width: UTILITY.height(context)/35,),
                  Padding(
                    padding: EdgeInsets.only(left: UTILITY.height(context)/90),
                    child: Column(
                      children: [
                        
                        Padding(
                          padding: EdgeInsets.only(top:UTILITY.height(context)/400,right: UTILITY.height(context)/40),
                          child: Text('${model.content!.data![index].dateTime}',style: TextStyle(color: const Color.fromARGB(255, 33, 47, 243)),),
                        ),
                       SizedBox(height: UTILITY.height(context)/100,),
                        Padding(
                          padding: EdgeInsets.only(right:UTILITY.height(context)/100),
                          child: Text('${model.content!.data![index].title}',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                  
                        SizedBox(height: UTILITY.height(context)/50,),
                        Padding(
                          padding:EdgeInsets.only(right: UTILITY.height(context)/40),
                          child: Row(
                            children: [
                              Icon(Icons.location_pin,size: 17,color:  Colors.grey[700],),
                              SizedBox(width:UTILITY.height(context)/90,),
                              FittedBox(child: Text('${model.content!.data![index].venueCity},${model.content!.data![index].venueCountry}',style: TextStyle(color: Colors.grey[700]),softWrap: true,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}