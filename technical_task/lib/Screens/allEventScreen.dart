import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_task/Screens/searchEventScreen.dart';
import 'package:technical_task/Screens/singleEventScreen.dart';
import 'package:technical_task/bloc_file/event/bloc_event.dart';
import 'package:technical_task/utils/utility.dart';


import '../bloc_file/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc_file/state/bloc_state.dart';
import '../modals/allEvents.dart';

class allEvent extends StatefulWidget {
  const allEvent({super.key});

  @override
  State<allEvent> createState() => _allEventState();
}

class _allEventState extends State<allEvent> {

  final Bloc1 _eventBloc = Bloc1();



  @override
  void initState() {
    // TODO: implement initState
  _eventBloc.add(GetEventList());
  //fetchEventList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: CupertinoColors.white,
        elevation: 0,
        backgroundColor: CupertinoColors.white,
        actions: [
           IconButton(icon:Image.asset('assets/search.png'), onPressed: () { 

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchEventScreen()));
         },),
           IconButton(icon:Icon(Icons.more_vert), onPressed: () { 

         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchEventScreen()));
         },),
        ],
        title: Text('Events',style: TextStyle(fontSize: 25),)

        
       
        
        ),
      body: _buildListEvent(),
    );
  }

  Widget _buildListEvent() {
    return Container(
      color: Colors.white30,
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _eventBloc,
        child: BlocListener<Bloc1, State1>(
          listener: (context, state) {
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<Bloc1, State1>(
            builder: (context, state) {
              if (state is Initial) {
                return _buildLoading();
              } else if (state is Loading) {
                return _buildLoading();
              } else if (state is Loaded) {
                return _buildCard(context, state.eventModel);
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
        color: Color.fromARGB(255, 227, 230, 232),
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