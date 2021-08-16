class ChattingModel{
  ChattingModel(this.pk, this.name, this.message, this.uploadTime);
  final String pk;
  final String name;
  final String message;
  final int uploadTime;

  factory ChattingModel.fromJson(Map<String, dynamic> json){
    return ChattingModel(json['pk'], json['name'], json['message'], json['uploadTime']);
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'pk':pk,
      'name':name,
      'message':message,
      'uploadTime':uploadTime,
    };
  }
}