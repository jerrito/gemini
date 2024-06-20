import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable{
 final String errorMessage, error;
 final num errorCode;

  const ErrorModel({required this.errorMessage, required this.error, required this.errorCode});
 
  factory ErrorModel.fromJson(Map<String, dynamic> json)=>
  ErrorModel(errorMessage: json["message"],
   error: json["error"], errorCode: json["errorCode"],);

   toMap ()=>
   {
    "message":errorMessage,
    "error":error,
    "errorCode":errorCode
   };
  @override
  List<Object?> get props => [errorMessage, error, errorCode,];
}