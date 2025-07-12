import 'dart:async';
import 'dart:io';

String handleException(dynamic error) {
  if (error is SocketException) {
    return "It seems you are not connected to the internet. Please check your internet connection and try again";
  } else if (error is TimeoutException) {
    return "The request timed out. Kindly check your internet connection";
  } else {
    return "This was not supposed to happen! Please try again later.";
  }
}
