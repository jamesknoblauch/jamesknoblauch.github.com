library output_panel;

import 'dart:html';
import 'dart:collection';

import 'package:randstrs/src/random_sequence.dart';


class OutputPanel {
  TableElement table;
  TableSectionElement body;
  
  OutputPanel() {
      table = querySelector('#output_table');
      //body = table.nodes[2] as TableSectionElement;
      body = table.createTBody();
  }
  
  void add_item(RandomSequence item) {
      TableCellElement cell;
      TableRowElement row = new TableRowElement();
      HashMap<String, bool> char_types;
      List<String> types_used = [];
      
      PreElement pre = new PreElement();
      pre.text = item.toString();
      pre.onClick.listen(handle_pre_click);
      pre.classes.add('min-width-pre');
      
      cell = new TableCellElement();
      cell.children.add(pre);
      row.append(cell);
      
      cell = new TableCellElement();
      cell.text = item.blind_entropy.toStringAsFixed(2);
      row.append(cell);
      
      cell = new TableCellElement();
      cell.text = item.pool_entropy.toStringAsFixed(2);
      row.append(cell);
      
      char_types = item.char_types();
      cell = new TableCellElement();
      for (String key in char_types.keys) {
          if (char_types[key])
              types_used.add(key);
      }
      cell.text = types_used.join(',');
      row.append(cell);
      
      cell = new TableCellElement();
      cell.text = '${item.unique().length} / ${item.length}';
      row.append(cell);
      
      if (item.score() < 80)
          row.classes.add('danger');
      else if (item.score() < 110)
          row.classes.add('warning');
      else
          row.classes.add('success');
      
      body.nodes.insert(0, row);
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