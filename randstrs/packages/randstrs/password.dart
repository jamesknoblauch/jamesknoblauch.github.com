library password;

import 'dart:math';

import 'pool.dart';
import 'random_sequence.dart';
import 'random.dart';


abstract class Password {
    void generate();
    double get blind_entropy;
    double get pool_entropy;
    int get length;
}


class RandomPassword extends RandomSequence<String> implements Password {

    RandomPassword(CharPool pool, int length) : super(pool, length);
  
    String toString() =>  items.join();
}


class PatternPassword extends RandomSequence<String> implements Password {
    String pattern;
    List<CharPool> char_pools = new List<CharPool>();
    List<int> char_count = new List<int>();
    
    PatternPassword(this.pattern) {
        _parse_pattern();
        generate();
    }
    
    void _parse_pattern() {
        RegExp re = new RegExp(r'\d+[auldsw]{1}');
        CharPool cp;
        String char_set_code;
        int end;
        int count;
      
        for (String segment in pattern.split(':')) {
            segment = segment.toLowerCase();
            if (re.hasMatch(segment)) {
                cp = new CharPool(new ClientSecureRandom());
                end = segment.length - 1;
          
                count = int.parse(segment.substring(0, end));
                char_count.add(count);
                length += count;
          
                char_set_code = segment.substring(end);
                if (char_set_code == 'a')
                    cp.add_ascii_all();
                else if (char_set_code == 'u')
                    cp.add_ascii_upper();
                else if (char_set_code == 'l')
                    cp.add_ascii_lower();
                else if (char_set_code == 'd')
                    cp.add_ascii_digits();
                else if (char_set_code == 's')
                    cp.add_ascii_special();
                else if (char_set_code == 'w')
                    cp.add_ascii_whitespace();
                char_pools.add(cp);
            } else
                throw new ArgumentError(pattern);
        }
    }
    
    void generate() {
        for (int i=0; i<char_count.length; i++) {
            for (int j=0; j<char_count[i]; j++)
                items.add(char_pools[i].get());
        }
    }
    
    double get pool_entropy {
        double entropy = 0.0;
        for (int i=0; i<char_count.length; i++)
            entropy += char_count[i] * (log(char_pools[i].length) / log(2));
        return entropy;
    }
    
    String toString() =>  items.join();
}


class PassPhrase extends RandomSequence<String> implements Password {
  
    PassPhrase(WordPool pool, int length) : super(pool, length);

    int get char_length {
        int l = 0;
        for (String s in items)
            l += s.length;
        return l;
    }
    
    double get blind_entropy => char_length * (log(94) / log(2));
    
    String toString() => items.join();
}