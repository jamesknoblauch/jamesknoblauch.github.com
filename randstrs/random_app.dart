
import 'dart:math';
import 'dart:html';

import 'package:randstrs/password.dart';
import 'package:randstrs/random.dart';
import 'package:randstrs/pool.dart';
import 'package:randstrs/src/app.dart';


main() {
    App app = new RandomApp();
}


class RandomApp implements App {
    RandomOptionPanel options = new RandomOptionPanel();
    OutputPanel output = new OutputPanel();
    
    RandomApp() {
        options.gen_button.onClick.listen(submit_handler);
        options.clear_button.onClick.listen(clear_handler);
    }
    
    void submit_handler(MouseEvent e) {
        Random r;
        CharPool cp;
        
        if (options.use_pattern) {
            for (int i=0; i<=options.repeat; i++)
                output.add_item(new PatternPassword(options.pattern));
        } else {
            r = new ClientSecureRandom();
            cp = new CharPool(r);
            
            if (options.use_all)
                cp.add_ascii_all();
            else {
                if (options.use_upper)
                    cp.add_ascii_upper();
                if (options.use_lower)
                    cp.add_ascii_lower();
                if (options.use_digits)
                    cp.add_ascii_digits();
                if (options.use_special)
                    cp.add_ascii_special();
                if (options.use_custom)
                    cp.addAll(options.custom_chars);
            }
            
            for (int i=0; i<=options.repeat; i++)
                output.add_item(new RandomPassword(cp, options.length));
        }
    }
    
    void clear_handler(MouseEvent e) {
        options.reset();
        output.reset();
    }
}


class RandomOptionPanel {
    int default_length, default_repeat;
    
    TextInputElement length_input = querySelector('#length_input');
    TextInputElement repeat_input = querySelector('#repeat_input');
    
    CheckboxInputElement upper_checkbox = querySelector('#upper_chars');
    CheckboxInputElement lower_checkbox = querySelector('#lower_chars');
    CheckboxInputElement digits_checkbox = querySelector('#digit_chars');
    CheckboxInputElement special_checkbox = querySelector('#special_chars');
    CheckboxInputElement all_chars_checkbox = querySelector('#all_chars');
    
    CheckboxInputElement custom_checkbox = querySelector('#custom_checkbox');
    TextInputElement custom_input = querySelector('#custom_input');
    
    CheckboxInputElement pattern_checkbox = querySelector('#pattern_checkbox');
    TextInputElement pattern_input = querySelector('#pattern_input');
    
    ButtonElement gen_button = querySelector('#gen_button');
    ButtonElement clear_button = querySelector('#clear_button');
    
    
    RandomOptionPanel() {
        default_length = length;
        default_repeat = repeat;
        
        custom_checkbox.onChange.listen(custom_change_handler);
        all_chars_checkbox.onChange.listen(all_chars_change_handler);
        pattern_checkbox.onChange.listen(pattern_change_handler);
    }
    
    int get length => int.parse(length_input.value);
    
    int get repeat => int.parse(repeat_input.value);
    
    bool get use_upper => upper_checkbox.checked;
    
    bool get use_lower => lower_checkbox.checked;
    
    bool get use_digits => digits_checkbox.checked;
    
    bool get use_special => special_checkbox.checked;
    
    bool get use_all => all_chars_checkbox.checked;
    
    bool get use_custom => custom_checkbox.checked;
    
    bool get use_pattern => pattern_checkbox.checked;
    
    String get custom_chars => custom_input.value;
    
    String get pattern => pattern_input.value;
    
    void reset() {
        length_input.disabled = false;
        length_input.value = default_length.toString();
        
        repeat_input.value = default_repeat.toString();
        
        custom_checkbox.checked = false;
        custom_checkbox.disabled = false;
        custom_input.value = '';
        custom_input.disabled = true;
        
        pattern_checkbox.checked = false;
        pattern_input.value = '';
        pattern_input.disabled = true;
        
        all_chars_checkbox.checked = true;
        all_chars_checkbox.disabled = false;
        set_all_chars(true);
    }
    
    void set_all_chars(bool t) {
        upper_checkbox.disabled = t;
        upper_checkbox.checked = t;
        
        lower_checkbox.disabled = t;
        lower_checkbox.checked = t;
        
        digits_checkbox.disabled = t;
        digits_checkbox.checked = t;
        
        special_checkbox.disabled = t;
        special_checkbox.checked = t;
    }
    
    void all_chars_change_handler(Event e) {
        set_all_chars(all_chars_checkbox.checked);
    }
    
    void custom_change_handler(Event e) {
        custom_input.disabled = !custom_checkbox.checked;
    }
    
    void pattern_change_handler(Event e) {
        bool use_pattern = pattern_checkbox.checked;
        
        pattern_input.disabled = !use_pattern;
        pattern_input.value = '';
        
        length_input.disabled = use_pattern;
        length_input.value = default_length.toString();
        
        set_all_chars(!use_pattern);
        
        all_chars_checkbox.disabled = use_pattern;
        all_chars_checkbox.checked = !use_pattern;
        
        upper_checkbox.disabled = true;
        lower_checkbox.disabled = true;
        digits_checkbox.disabled = true;
        special_checkbox.disabled = true;
        
        custom_checkbox.disabled = use_pattern;
        custom_checkbox.checked = false;
        
        custom_input.disabled = true;
        custom_input.value = '';
    }
}