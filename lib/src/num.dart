extension DoubleExt on double{
  double setNumInBounds(){
    if(this<0) return 0;
    if(this>1) return 1;
    return this;
  }
}