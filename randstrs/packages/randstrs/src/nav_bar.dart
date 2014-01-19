import 'dart:html';


class NavBar {
    String page_name;
    UListElement nav_list_left = querySelector('#nav_list_left');
    UListElement nav_list_right = querySelector('#nav_list_right');
    List<Element> nav_list = new List<Element>();
    
    NavBar(this.page_name) {
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