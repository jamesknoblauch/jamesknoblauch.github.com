library pool;

import 'dart:math';
import 'package:randstrs/src/list.dart';


abstract class Pool<T> {
    int length;
    T get();
    bool add(T element);
}


class CharPool implements Pool<String> {
    static final String ASCII_UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static final String ASCII_LOWER = "abcdefghijklmnopqrstuvwxyz";
    static final String ASCII_DIGITS = "0123456789";
    static final String ASCII_SPECIAL = "~`!@#\$%^&*()-_=+[]{}\\|;:'\",.<>/?";
    static final String ASCII_WHITESPACE = " \t\r\n";
    List<String> items;
    Random random;
  
    CharPool(this.random, [size]) {
        if (size != null)
            items = new List<String>(size);
        else
            items = new List<String>();
    }
  
    CharPool.from_string(this.random, String chars) {
        items = new List<String>(chars.length);
        addAll(chars);
    }
  
    bool add(String c) {
        if (!items.contains(c)) {
            items.add(c);
            return true;
        } else
            return false;
    }
    
    bool addAll(String s) {
        bool result = false;
        for (String c in s.split(''))
            result = add(c) || result;
        return result;
    }
    
    bool add_ascii_upper() => addAll(ASCII_UPPER);
    
    bool add_ascii_lower() => addAll(ASCII_LOWER);
    
    bool add_ascii_digits() => addAll(ASCII_DIGITS);
    
    bool add_ascii_special() => addAll(ASCII_SPECIAL);
    
    bool add_ascii_whitespace() => addAll(ASCII_WHITESPACE);
    
    bool add_ascii_all() {
        bool u, l, d, s, w;
        u = addAll(ASCII_UPPER);
        l = addAll(ASCII_LOWER);
        d = addAll(ASCII_DIGITS);
        s = addAll(ASCII_SPECIAL);
        return u || l || d || s;
    }
    
    bool removeAll(String chars) {
        bool result = false;
        for (String c in chars.split('')) {
            if (items.contains(c))
                result = items.remove(c) || result;
        }
        return result;
    }
    
    int get length => items.length;
        set length(int l) => items.length = l;
    
    String get() => items[random.nextInt(length)];
    
    String toString() => items.join();
}


class WordPool extends WordList implements Pool<String> {
  Random random;
  
  WordPool(this.random) : super();
  
  WordPool.from(this.random, List<String> words) : super.from(words);
  
  WordPool.from_text(this.random, String text) : super.from_text(text);
    
  String get() => this[random.nextInt(length)];
}