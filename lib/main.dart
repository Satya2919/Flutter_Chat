import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlychatApp());
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
const String _name = "Satyam";

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
      home:  ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {                     //modified
  @override                                                        //new
  State createState() => new ChatScreenState();                    //new
} 

// Add the ChatScreenState class definition in main.dart.

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {   
  final TextEditingController _textController = new TextEditingController();     
  final List<ChatMessage> _messages = <ChatMessage>[];   


  @override                                                        
  Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(title: new Text("Friendlychat")),
    body: new Column(                                        //modified
      children: <Widget>[                                         
        new Flexible(                                            
          child: new ListView.builder(                             
            padding: new EdgeInsets.all(8.0),                    
            reverse: true,                                       
            itemBuilder: (_, int index) => _messages[index],      
            itemCount: _messages.length,                       
          ),                                                      //new
        ),                                                        //new
        new Divider(height: 1.0),                                 
        new Container(                                            
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor),                  //new
          child: _buildTextComposer(),                       //modified
        ),                                                        //new
      ],                                                          //new
    ),                                                            
  );
}


Widget _buildTextComposer() {
  return new IconTheme(                                            //new
    data: new IconThemeData(color: Theme.of(context).accentColor), //new
    child: new Container(                                     //modified
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: new InputDecoration.collapsed(
                hintText: "Send a message"),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text)),
          ),
        ],
      ),
    ),                                                             
  );
}


void _handleSubmitted(String text) {
  _textController.clear();
    ChatMessage message = new ChatMessage(                        
      text: text,   
      animationController: new AnimationController(                  
      duration: new Duration(milliseconds: 700),                  
      vsync: this,                                                 
    ),                                                                                                            //new
    );                                                             
    setState(() {                                                  
      _messages.insert(0,message);                                
    });   
    message.animationController.forward();                                                            
 }

 @override
void dispose() {                                                   //new
  for (ChatMessage message in _messages)                           //new
    message.animationController.dispose();                         
  super.dispose();                                                 
}  
}


class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(                                    
    sizeFactor: new CurvedAnimation(                             
        parent: animationController, curve: Curves.easeOut),      //new
    axisAlignment: 0.0,                                          
    child: new Container(                                    
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_name, style: Theme.of(context).textTheme.subhead),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                ),
              ],
            ),
          ],
        ),
      )                                                          
    );
  }
}