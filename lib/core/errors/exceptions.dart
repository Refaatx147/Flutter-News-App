import 'package:dio/dio.dart';
import 'package:news_appp/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}



  void handleDioExceptions(DioException e) {
    switch(e.type){
      // 7 of them the request does not go to database either bad response 
      case DioExceptionType.connectionTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionError:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.unknown:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badResponse:
        switch(e.response?.statusCode)
          {
           case 400:  // bad request
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    
           case 401:  // unauthorized
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    
           case 403:  // forbidden
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    
           case 404:  // not found
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    
           case 409:  // coefficient
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    
           case 422:  // unprocessable Entity
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    
           case 504:  // Server exception
           throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
          }
    
    }
  }
