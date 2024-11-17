class PostDetails{
  final String id;
  String? title;
  String? content;
   String? date;
  PostDetails({required this.id,this.title,this.content,this.date});

  factory PostDetails.fromMap(Map<String,dynamic>map,String id){
    return PostDetails(
        id: id,
      title: map['title'],
      content: map['pDescription']
    );

  }
  Map<String,dynamic> toMap(){
    return {
      'title':'title',
      'content':'pDescription'
    };
  }
}