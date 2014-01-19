library option_panel;

import 'dart:html';


class RandomOptionPanel {
    TextInputElement length_input, repeat_input;
    int length, repeat;
    int default_length = 12;
    int default_repeat = 0;
    
    CheckboxInputElement all_chars_checkbox, upper_checkbox, lower_checkbox,
                         digits_checkbox, special_checkbox;
    bool use_all, use_upper, use_lower, use_digits, use_special;
    
    CheckboxInputElement custom_checkbox;
    bool use_custom;
    TextInputElement custom_input;
    String custom_chars;
    
    CheckboxInputElement pattern_checkbox;
    bool use_pattern;
    TextInputElement pattern_input;
    String pattern;
    
    ButtonElement gen_button;
    ButtonElement clear_button;
    
    RandomOptionPanel() {
        length_input = querySelector('#length_input');
        length_input.onChange.listen(length_change_handler);
        length_input.value = default_length.toString();
        length = default_length;
        
        repeat_input = querySelector('#repeat_input');
        repeat_input.onChange.listen(repeat_change_handler);
        repeat_input.value = default_repeat.toString();
        repeat = default_repeat;
        
        upper_checkbox = querySelector('#upper_chars');
        upper_checkbox.onChange.listen(upper_change_handler);
        
        lower_checkbox = querySelector('#lower_chars');
        lower_checkbox.onChange.listen(lower_change_handler);
        
        digits_checkbox = querySelector('#digit_chars');
        digits_checkbox.onChange.listen(digits_change_handler);
  
        special_checkbox = querySelector('#special_chars');
        special_checkbox.onChange.listen(special_change_handler);
  
        custom_checkbox = querySelector('#custom_checkbox');
        custom_checkbox.onChange.listen(custom_change_handler);
        use_custom = custom_checkbox.checked;
        
        custom_input = querySelector('#custom_input');
        custom_input.onChange.listen(custom_input_change_handler);
        custom_chars = '';
        custom_input.disabled = !use_custom;
        
        all_chars_checkbox = querySelector('#all_chars');
        all_chars_checkbox.onChange.listen(all_chars_change_handler);
        all_chars_checkbox.checked = true;
        set_all_chars(true);
        
        pattern_checkbox = querySelector('#pattern_checkbox');
        pattern_checkbox.onChange.listen(pattern_change_handler);
        use_pattern = pattern_checkbox.checked;
        
        pattern_input = querySelector('#pattern_input');
        pattern_input.onChange.listen(pattern_input_change_handler);
        pattern = '';
        pattern_input.disabled = !use_pattern;
        
        gen_button = querySelector('#gen_button');
        clear_button = querySelector('#clear_button');
    }
    
    void reset() {
        length_input.disabled = false;
        length_input.value = '12';
        length = 12;
        
        repeat_input.value = '0';
        repeat = 0;
        
        custom_checkbox.checked = false;
        custom_checkbox.disabled = false;
        use_custom = false;
        custom_chars = '';
        custom_input.value = '';
        custom_input.disabled = !use_custom;
        
        pattern_checkbox.checked = false;
        use_pattern = false;
        pattern = '';
        pattern_input.value = '';
        pattern_input.disabled = !use_pattern;
        
        all_chars_checkbox.checked = true;
        all_chars_checkbox.disabled = false;
        set_all_chars(true);
    }
    
    void length_change_handler(Event e) {
        try {
            length = int.parse(length_input.value);
        } catch(FormatException, e) {
            length = default_length;
            length_input.value = default_length.toString();
        }
    }
    
    void repeat_change_handler(Event e) {
        try {
            repeat = int.parse(repeat_input.value);
        } catch(FormatException, e) {
            repeat = default_repeat;
            repeat_input.value = default_repeat.toString();
        }
    }
    
    void set_all_chars(bool t) {
        use_all = t;
        
        upper_checkbox.disabled = t;
        upper_checkbox.checked = t;
        use_upper = t;
        
        lower_checkbox.disabled = t;
        lower_checkbox.checked = t;
        use_lower = t;
        
        digits_checkbox.disabled = t;
        digits_checkbox.checked = t;
        use_digits = t;
        
        special_checkbox.disabled = t;
        special_checkbox.checked = t;
        use_special = t;
    }
    
    void all_chars_change_handler(Event _) {
        set_all_chars(all_chars_checkbox.checked);
    }
    
    void upper_change_handler(Event _) {
        use_upper = upper_checkbox.checked;
    }
    
    void lower_change_handler(Event _) {
        use_lower = lower_checkbox.checked;
    }
    
    void digits_change_handler(Event _) {
        use_digits = digits_checkbox.checked;
    }
    
    void special_change_handler(Event _) {
        use_special = special_checkbox.checked;
    }
    
    void custom_change_handler(Event _) {
        use_custom = custom_checkbox.checked;
        custom_input.disabled = !use_custom;
    }
    
    void custom_input_change_handler(Event _) {
        custom_chars = custom_input.value.toString();
    }
    
    void pattern_change_handler(Event _) {
        use_pattern = pattern_checkbox.checked;
        pattern_input.disabled = !use_pattern;
        pattern_input.value = '';
        pattern = '';
        
        length_input.disabled = use_pattern;
        length_input.value = default_length.toString();
        length = default_length;
        
        set_all_chars(!use_pattern);
        
        all_chars_checkbox.disabled = use_pattern;
        all_chars_checkbox.checked = !use_pattern;
        use_all = !use_pattern;
        
        upper_checkbox.disabled = true;
        lower_checkbox.disabled = true;
        digits_checkbox.disabled = true;
        special_checkbox.disabled = true;
        
        custom_checkbox.disabled = use_pattern;
        custom_checkbox.checked = false;
        use_custom = false;
        
        custom_input.disabled = true;
        custom_input.value = '';
        custom_chars = '';
    }
    
    void pattern_input_change_handler(Event _) {
        pattern = pattern_input.value.toString();
    }
}