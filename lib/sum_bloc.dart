import 'dart:async';

/**
 * Simple Bloc Pattern For sum two numbers
 */
class SumBloc{

  // create stream to watch 
  StreamController<double> controller = StreamController();

  /**
   * create stream
   */
  Stream<double> getStream(){
    return controller.stream;
  }

  /**
   * add sum function
   * @param {int} number one
   * @param {int} number two
   * add to stream using sink
   */
  doSum(double num1, double num2){
    double sum = num1 + num2;
    controller.sink.add(sum);
  }

  /**
   * close stream
   */
  void dispose(){
    controller.close();
  }
}