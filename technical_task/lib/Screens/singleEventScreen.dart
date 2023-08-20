import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:technical_task/bloc_file/bloc/bloc_singleEvent.dart';
import 'package:technical_task/bloc_file/event/bloc_singleEvent.dart';
import 'package:technical_task/modals/singleEvent.dart';

import '../bloc_file/state/bloc_singleState.dart';
import '../utils/utility.dart';

class SingleEventScreen extends StatefulWidget {
  final int? id;
  SingleEventScreen({required this.id,super.key});

  @override
  State<SingleEventScreen> createState() => _SingleEventScreenState();
}

class _SingleEventScreenState extends State<SingleEventScreen> {

  bool flag=true;

  late final SingleEventBloc _eventBloc = SingleEventBloc(widget.id);

  @override
  void initState() {
    // TODO: implement initState
    _eventBloc.add(GetSingleEventList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _buildListEvent(),
    );
  }

   Widget _buildListEvent() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _eventBloc,
        child: BlocListener<SingleEventBloc, SingleState>(
          listener: (context, state) {
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<SingleEventBloc, SingleState>(
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

  Widget _buildCard(BuildContext context, SingleEventModal model) {
    String firstHalf;
    String secondHalf;
    if (model.content.data.description.length > 80) {
      firstHalf = model.content.data.description.substring(0, 80);
      secondHalf = model.content.data.description.substring(80, model.content.data.description.length);
    } else {
      firstHalf = model.content.data.description;
      secondHalf = "";
    }
    return SingleChildScrollView(
      child: Column(
            children:[
              Stack(
                children:[ 
                
                  Container(
                    width: 500,
                    child: CachedNetworkImage(
                         
                          width: double.maxFinite,
                          height: UTILITY.height(context)/3.5,
                           fit: BoxFit.cover,
                        imageUrl:model.content!.data!.bannerImage.toString(),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                     ),
                  ),
                   Padding(
                     padding: EdgeInsets.only(top:UTILITY.height(context)/30),
                     child: Row(
      
                       children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:0),
                          child: IconButton(onPressed: (){
                                         Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back),iconSize: 30,color: Colors.white,),
                        ),
                       // SizedBox(width: UTILITY.height(context)/30,),
                         Text('Event Details',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.white),),
                         SizedBox(width: UTILITY.height(context)/7,),
                         Padding(
                           padding: const EdgeInsets.only(right:38.0),
                           child: IconButton(
                            color: Colors.white,
                            onPressed: (){
                              
                                               }, icon: Image.asset('assets/Favicon.png')),
                         ),
                       ],
                     ),
                   ),
                ],
      
                
              ),
              Stack(
                children:[
                  Column(children: [
                  SizedBox(height: UTILITY.height(context)/27,),
                  Padding(
                    padding: EdgeInsets.only(right:UTILITY.height(context)/27),
                    child: Text( '${model.content.data.title}',style: TextStyle(fontSize: 30),),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(top:UTILITY.height(context)/40,left: UTILITY.height(context)/18),
                    child: Row(children: 
                    
                    [
                      CachedNetworkImage(
                           
                            width: UTILITY.width(context)/10,
                            height: UTILITY.height(context)/10,
                             fit: BoxFit.cover,
                          imageUrl:model.content!.data!.organiserIcon.toString(),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                       ),
                       SizedBox(width: UTILITY.height(context)/25,),
                       Column(
                        children: [
                          FittedBox(child: Padding(
                            padding: EdgeInsets.only(right:UTILITY.width(context)/3.5),
                            child: Text('${model.content.data.organiserName}',style: TextStyle(fontSize: 15),softWrap: true,),
                          )),
                          Padding(
                            padding: EdgeInsets.only(right: UTILITY.width(context)/3,),
                            child: Text('Organizer',style: TextStyle(color: Colors.grey[500],fontSize: 12),),
                          )
                        ],
                       )
                    ],),
                  ),
                    SizedBox(height: UTILITY.height(context)/100,),
                  Padding(
                    padding: EdgeInsets.only(top:UTILITY.height(context)/60,left: UTILITY.height(context)/30),
                    child: Row(children: 
                    
                    [
                      IconButton(onPressed: (){
                  
                      }, icon: Image.asset('assets/Date.png')),
                       SizedBox(width: UTILITY.height(context)/49,),
                       Column(
                        children: [
                          Text('${model.content.data.dateTime}',style: TextStyle(fontSize: 15),),
                          Padding(
                            padding: EdgeInsets.only(right: UTILITY.width(context)/7.5,top: UTILITY.width(context)/55.5),
                            child: Text('Friday, 04:00pm - 09:00pm',style: TextStyle(color: Colors.grey[500],fontSize: 12),),
                          )
                        ],
                       )
                    ],),
                  ),
                    // SizedBox(height: UTILITY.height(context)/100,),
                  
                  Padding(
                    padding: EdgeInsets.only(top:UTILITY.height(context)/85,left: UTILITY.height(context)/30),
                    child: Row(children: 
                    
                    [
                      IconButton(onPressed: (){
                  
                      }, icon: Image.asset('assets/location.png')),
                       SizedBox(width: UTILITY.height(context)/53,),
                       Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right:UTILITY.width(context)/16.5),
                            child: FittedBox(child: Text('${model.content.data.venueName}',style: TextStyle(fontSize: 15),softWrap: true,)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: UTILITY.width(context)/50.5,top: UTILITY.width(context)/55.5),
                            child: Text('${model.content.data.venueCity},${model.content.data.venueCountry}',style: TextStyle(color: Colors.grey[500],fontSize: 12),),
                          )
                        ],
                       )
                    ],),
                  ),
                       SizedBox(height: UTILITY.height(context)/53,),
                  Padding(
                    padding:EdgeInsets.only(right:UTILITY.height(context)/3.5),
                    child: Text("About Event",style: TextStyle(fontSize: 20,),),
                  ),
                            
                  Container(
                    padding: new EdgeInsets.symmetric(horizontal: UTILITY.height(context)/35, vertical: UTILITY.height(context)/53),
                    child: secondHalf.isEmpty
                        ? Text(firstHalf)
                        : Column(
                              children: <Widget>[
                  Text(flag ? (firstHalf + "..."): (firstHalf + secondHalf)),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          flag ? "read more" : "read less",
                          style: new TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                              ],
                          ),
                  ),
                            
                            
                  
                  
                  
                  
                              ],),
                Padding(
                         padding: EdgeInsets.only(top:UTILITY.height(context)/1.6,right: UTILITY.height(context)/20.6,left:UTILITY.height(context)/17.6 ),
                         child: Container(
                           width: UTILITY.width(context),
                           height: UTILITY.height(context)/12, // Expand to full width of the card
                           decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3,3),
                              blurRadius: 4,
                              spreadRadius: 4,
                              color: Color.fromARGB(255, 238, 234, 234),
                            )
                          ],
                             borderRadius: BorderRadius.circular(10),
                             color: Color.fromARGB(255, 96, 98, 233),
                           ),
                           child: Padding(
                             padding: EdgeInsets.only(left:UTILITY.height(context)/9),
                             child: Row(
                               children: [
                                 TextButton(
                                   onPressed: () {
                                    
                                                            Fluttertoast.showToast(
                                     msg: "Succesfully booked an event",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     textColor: Colors.white,
                                     fontSize: 16.0
                                 );
                                   },
                                   child: Text(
                                     'Book Now',
                                     style: TextStyle(color: Colors.white,fontSize: 18),
                                   ),
                                 ),
                                 SizedBox(width: UTILITY.height(context)/29,),
                                 IconButton(onPressed: (){}, icon:Image.asset('assets/Group.png'),color:Color.fromARGB(255, 96, 98, 233) ,)
                               ],
                             ),
                           ),
                         ),
                       ),
                ],
              )
            ]),
    );
      

  }

    Widget _buildLoading() => Center(child: CircularProgressIndicator());
}