library random;

import 'dart:math';
import 'dart:html';
import 'dart:typed_data';

//TODO: implement Random
class ClientSecureRandom implements Random {
    static const int MAX_INT = 4294967295;
  
    int int_from_range(min, max) {
        int range, remainder, div, result;
        Uint32List buffer = new Uint32List(1);
        
        window.crypto.getRandomValues(buffer);
        if (buffer[0] == MAX_INT)
            return int_from_range(min, max);
        
        range = max - min;
        remainder = MAX_INT % range;
        div = MAX_INT ~/ range;
        
        if (buffer[0] < MAX_INT - remainder)
            result = min + buffer[0] ~/ div;
        else
            result = int_from_range(min, max);
        return result;
    }
    
    int nextInt([max=MAX_INT]) => int_from_range(0, max);
    
    //NYI
    double nextDouble() {
        throw new UnimplementedError('nextDouble not yet implemented.');
    }
    
    //NYI
    bool nextBool() {
        throw new UnimplementedError('nextBool not yet implemented.');
    }
}