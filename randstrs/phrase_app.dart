import 'dart:html';

import 'package:randstrs/src/app.dart';


main() {
    App app = new PhraseApp();
}


class PhraseApp implements App {
    PhraseOptionPanel options= new PhraseOptionPanel();
    OutputPanel output = new OutputPanel();
    
    PhraseApp() {
        output = new OutputPanel();
        options = new PhraseOptionPanel();
        options.gen_button.onClick.listen(submit_handler);
        options.clear_button.onClick.listen(clear_handler);
        throw new UnimplementedError('nyi');
    }
    
    void submit_handler(MouseEvent e) {}
    
    void clear_handler(MouseEvent e) {
        options.reset();
        output.reset();
    }
}


class PhraseOptionPanel {
    int default_length, default_repeat;
    
    TextInputElement length_input = querySelector('#length_input');
    TextInputElement repeat_input = querySelector('#repeat_input');
    
    TextInputElement wordlist_input = querySelector('#wordlist_input');
    
    ButtonElement gen_button = querySelector('#gen_button');
    ButtonElement clear_button = querySelector('#clear_button');
    
    
    PhraseOptionPanel() {
        default_length = length;
        default_repeat = repeat;
        throw new UnimplementedError('nyi');
    }
    
    int get length => int.parse(length_input.value);
    
    int get repeat => int.parse(repeat_input.value);
    
    void reset() {
        length_input.value = default_length.toString();
        repeat_input.value = default_repeat.toString();
    }
}