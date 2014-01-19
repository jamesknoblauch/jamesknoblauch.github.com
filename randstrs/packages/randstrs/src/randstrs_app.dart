library randstrs_app;

import 'dart:html';
import 'dart:math';

import 'package:randstrs/src/password.dart';
import 'package:randstrs/src/random.dart';
import 'package:randstrs/src/pool.dart';
import 'package:randstrs/src/option_panel.dart';
import 'package:randstrs/src/output_panel.dart';


class RandstrsApp {
    RandomOptionPanel option_panel;
    OutputPanel output_panel;
    
    RandstrsApp() {
        random_password_page();
    }
    
    void random_password_page() {
        output_panel = new OutputPanel();
        option_panel = new RandomOptionPanel();
        option_panel.gen_button.onClick.listen(submit_handler);
        option_panel.clear_button.onClick.listen(clear_handler);
    }
    
    void submit_handler(MouseEvent e) {
        if (option_panel.use_pattern) {
            for (int i=0; i<=option_panel.repeat; i++)
                output_panel.add_item(new PatternPassword(option_panel.pattern));
        } else {
            Random r = new ClientSecureRandom();
            CharPool cp = new CharPool(r);
            
            if (option_panel.use_all)
                cp.add_ascii_all();
            else {
                if (option_panel.use_upper)
                    cp.add_ascii_upper();
                if (option_panel.use_lower)
                    cp.add_ascii_lower();
                if (option_panel.use_digits)
                    cp.add_ascii_digits();
                if (option_panel.use_special)
                    cp.add_ascii_special();
                if (option_panel.use_custom)
                    cp.addAll(option_panel.custom_chars);
            }
            
            for (int i=0; i<=option_panel.repeat; i++)
                output_panel.add_item(new RandomPassword(cp, option_panel.length));
        }
    }
    
    void clear_handler(MouseEvent e) {
        option_panel.reset();
        output_panel.reset();
    }
}