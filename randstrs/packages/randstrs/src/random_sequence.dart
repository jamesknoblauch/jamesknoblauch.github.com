library random_sequence;

import 'dart:math';
import 'dart:collection';

import 'package:randstrs/src/pool.dart';


class RandomSequence<T> {
    List<T> items;
    Pool<T> pool;
    int length;
    
    RandomSequence([this.pool, this.length=0]) {
        items = new List<T>();
        generate();
    }
    
    void generate() {
        for (int i=0; i<length; i++)
            items.add(pool.get());
    }
    
    double get blind_entropy => length * (log(94) / log(2));
    
    double get pool_entropy => length * (log(pool.length) / log(2));
    
    HashSet<T> unique() {
        return new HashSet<T>.from(items);
    }
    
    double frequency(Comparable<T> element, bool relative) {
        int freq = 0;
        for (Comparable<T> e in items) {
            if (e.compareTo(element) == 0)
                freq++;
        }
        if (relative)
            return freq / length.toDouble();
        else
            return freq.toDouble();
    }
    
    HashMap<String, bool> char_types() {
        HashMap<String, bool> types_used = {
            'U': false,
            'L': false,
            'D':false,
            'S': false,
            'W': false
        };
        
        for (String i in items) {
            types_used['U'] = CharPool.ASCII_UPPER.contains(i) || types_used['U'];
            types_used['L'] = CharPool.ASCII_LOWER.contains(i) || types_used['L'];
            types_used['D'] = CharPool.ASCII_DIGITS.contains(i) || types_used['D'];
            types_used['S'] = CharPool.ASCII_SPECIAL.contains(i) || types_used['S'];
            types_used['W'] = CharPool.ASCII_WHITESPACE.contains(i) || types_used['W'];
        }
        
        return types_used;
    }
    
    double score() {
        double score = 0.0;
        for (bool v in char_types().values) {
            if (v)
                score += 2;
        }
        return score + (blind_entropy + pool_entropy) / 2;
    }
}