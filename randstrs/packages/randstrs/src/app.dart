library app;

import 'dart:html';
import 'dart:collection';

import 'package:randstrs/random_sequence.dart';


abstract class App {
    void submit_handler(MouseEvent e);
    void clear_handler(MouseEvent e);
}


class NavBar {
    String page_name;
    List<Element> nav_list = new List<Element>();
    UListElement nav_list_left = querySelector('#nav_list_left');
    UListElement nav_list_right= querySelector('#nav_list_right');
    
    NavBar([this.page_name='random']) {
        nav_list.addAll(nav_list_left.children);
        nav_list.addAll(nav_list_right.children);
        
        set_active(page_name);
      
        for (LIElement li in nav_list) {
            AnchorElement a = li.querySelector('a');
            a.onClick.listen(handle_nav_click);
        }
    }
    
    void set_active(String page_name) {
        AnchorElement a;
        
        for (LIElement li in nav_list) {
            a = li.querySelector('a');
            if (a.text == page_name)
                li.classes.add('active');
            else
                li.classes.remove('active');
        }
    }
    
    void handle_nav_click(MouseEvent e) {
        set_active((e.currentTarget as AnchorElement).text);
    }
}


class OutputPanel {
    TableElement table;
    TableSectionElement body;
    
    OutputPanel() {
        table = querySelector('#output_table');
        body = table.createTBody();
    }
    
    void add_item(RandomSequence item) {
        HashMap<String, bool> char_types;
        List<String> types_used = [];
        TableRowElement row = body.insertRow(0);
        
        PreElement pre = new PreElement();
        pre..text = item.toString()
                ..onClick.listen(handle_pre_click)
                    ..classes.add('min-width-pre');
        
        row..addCell().append(pre)
            ..addCell().text = item.blind_entropy.toStringAsFixed(2)
            ..addCell().text = item.pool_entropy.toStringAsFixed(2);
        
        char_types = item.char_types();
        for (String key in char_types.keys) {
            if (char_types[key])
                types_used.add(key);
        }
        row..addCell().text = types_used.join(',')
                ..addCell().text = '${item.unique().length} / ${item.length}';
                
                if (item.score() < 80)
                    row.classes.add('danger');
                else if (item.score() < 110)
                    row.classes.add('warning');
                else
                    row.classes.add('success');
    }
    
    void reset() {
        //body.nodes.clear();
        while (body.nodes.length > 0)
            body.nodes.removeLast();
    }
    
    void handle_pre_click(MouseEvent e) {
        Range range = document.createRange();
        range.selectNodeContents((e.currentTarget as PreElement));
        Selection select = window.getSelection();
        select.addRange(range);
    }
}