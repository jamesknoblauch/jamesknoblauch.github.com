library list;

import 'dart:collection';


class WordList extends ListMixin<String> {
    List<String> items;
    
    WordList([int size]) {
        if (size != null)
            items = new List<String>(size);
        else
            items = new List<String>();
    }
    
    WordList.from(Iterable<String> words) {
        items = new List<String>();
        addAll(words);
    }
    
    WordList.from_text(String text) {
        items = new List<String>();
        add_from_text(text);
    }
    
    void trim() {
        for (int i=0; i<length; i++)
            items[i] = items[i].trim();
    }
    
    void concat(String s, String to_position) {
        if (to_position == 'start') {
            for (int i=0; i<length; i++)
                items[i] = s + items[i];
        } else if (to_position == 'end') {
            for (int i=0; i<length; i++)
                items[i] = items[i] + s;
        } else
            throw new ArgumentError(to_position);
    }
    
    void cull(int min, int max) {
        int l;
        
        for (int i=0; i<length; i++) {
            l = items[i].length;
            if (l < min || l > max)
                removeAt(i);
        }
    }
    
    void upper() {
        for (int i=0; i<length; i++)
            items[i] = items[i].toUpperCase();
    }
    
    void lower() {
        for (int i=0; i<length; i++)
            items[i] = items[i].toLowerCase();
    }
    
    void unique() {
        Set<String> unique = new HashSet<String>.from(this);
        clear();
        addAll(unique);
    }
    
    void union(Iterable<String> other) {
        Set<String> unique = new HashSet<String>.from(this);
        clear();
        unique.addAll(other);
        addAll(unique);
    }
    
    bool add_from_text(String text) {
        Pattern split_pattern = r'[\W_]{2,}|[\s+]|[^\w-]+';
        RegExp re = new RegExp(split_pattern);
        
        for (String word in text.split(re))
            add(word);
        return true;
    }
    
    int get length => items.length;
        set length(int l) => items.length = l;
    
    String operator [] (int i) => items[i];
           operator []= (int i, String word) => items[i] = word;
    
    void add(String word) => items.add(word);
    
    bool add_unique(String word) {
        if (!contains(word)) {
            add(word);
            return true;
        } else
            return false;
    }
    
    void addAll(Iterable<String> words) => items.addAll(words);
}