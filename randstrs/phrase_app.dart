import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:randstrs/src/app.dart';
import 'package:randstrs/random.dart';
import 'package:randstrs/list.dart';
import 'package:randstrs/pool.dart';
import 'package:randstrs/password.dart';


main() {
    App app = new PhraseApp();
}


class PhraseApp implements App {
    FileList wordlist_files;
    WordPool word_pool;
    
    PhraseOptionPanel options= new PhraseOptionPanel();
    OutputPanel output = new OutputPanel();
    
    PhraseApp() {
        output = new OutputPanel();
        options = new PhraseOptionPanel();
        options.wordlist_file_input.onChange.listen(wordlist_input_handler);
        options.gen_button.onClick.listen(submit_handler);
        options.clear_button.onClick.listen(clear_handler);
    }
    
    void wordlist_input_handler(Event e) {
        FileReader reader;
        Random r = new ClientSecureRandom();
        word_pool = new WordPool(r);
        wordlist_files = options.wordlist_file_input.files;
        
        for (File f in wordlist_files) {
            options.browse_button.classes.add('active');
            FileReader reader = new FileReader();
            reader.readAsText(f);
            reader.onLoadEnd.listen((Event e) {
                Future fwp = new Future(() {
                    word_pool.add_from_text((e.currentTarget as FileReader).result);
                });
                
                fwp.then((_) {
                    options.browse_button.classes.remove('active');
                    options.wordlist_text_input.value = '${word_pool.length} words';
                });
            });
        }
    }
    
    void submit_handler(MouseEvent e) {
        for (int i=0; i<=options.repeat; i++)
            output.add_item(new PassPhrase(word_pool, options.length));
    }
    
    void clear_handler(MouseEvent e) {
        options.reset();
        output.reset();
    }
}


class PhraseOptionPanel {
    int default_length, default_repeat;
    
    TextInputElement length_input = querySelector('#length_input');
    TextInputElement repeat_input = querySelector('#repeat_input');
    
    SpanElement browse_button = querySelector('#browse_button');
    InputElement wordlist_file_input = querySelector('#wordlist_file_input');
    TextInputElement wordlist_text_input = querySelector('#wordlist_text_input');
    
    AnchorElement gen_button = querySelector('#gen_button');
    AnchorElement clear_button = querySelector('#clear_button');
    
    PhraseOptionPanel() {
        default_length = length;
        default_repeat = repeat;
    }
    
    int get length => int.parse(length_input.value);
    
    int get repeat => int.parse(repeat_input.value);
    
    void reset() {
        length_input.value = default_length.toString();
        repeat_input.value = default_repeat.toString();
        wordlist_text_input.value = '';
    }
}