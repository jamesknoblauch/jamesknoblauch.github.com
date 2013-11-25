int entity_count = 20;
Entity target;
Entity[] entities;
MaxHeap<Entity> entity_queue;
int x_max = 600;
int y_max = 600;

public class MaxHeap<T extends Comparable<T>> {
    private ArrayList<T> nodes;

    public MaxHeap() {
        nodes = new ArrayList<T>();
    }
    
    public MaxHeap(int initial_capacity) {
        nodes = new ArrayList<T>(initial_capacity);
    }

    public void insert(T node) {
        nodes.add(node);
        heapify_up(nodes.size()-1);
    }

    public T extract_max() {
        T min_node;

        if (is_empty())
            min_node = null;
        else {
            min_node = nodes.get(0);
            delete(0);
            heapify_down(0);
        }
        return min_node;
    }

    public T peek() {
        return nodes.get(0);
    }

    public boolean is_empty() {
        return nodes.isEmpty();
    }

    private void delete(int i) {
        int end;

        end = nodes.size() - 1;
        swap(i, end);
        nodes.remove(end);
        heapify_down(i);
    }

    private void swap(int i, int j) {
        T temp;

        if (i != j) {
            temp = nodes.get(i);
            nodes.set(i, nodes.get(j));
            nodes.set(j, temp);
        }
    }

    private int maximize(int i, int j) {
        int max;
        if (nodes.get(i).compareTo(nodes.get(j)) > 0)
            max = i;
        else if (nodes.get(i).compareTo(nodes.get(j)) < 0)
            max = j;
        else
            max = i;
        return max;
    }

    private void heapify_up(int i) {
        int parent;

        parent = (int) ((i-1) / 2);
        while (i > 0 && nodes.get(i).compareTo(nodes.get(parent)) > 0) {
            swap(i, parent);
            i = parent;
            parent = (int) ((i-1) / 2);
        }
    }

    private void heapify_down(int i) {
        int left_child;
        int end;
        int child_to_swap;

        left_child = 2*i + 1;
        end = nodes.size() - 1;
        while (left_child <= end) {
            if (left_child < end)
                child_to_swap = maximize(left_child, left_child+1);
            else
                child_to_swap = left_child;
            if (nodes.get(child_to_swap).compareTo(nodes.get(i)) > 0) {
                swap(child_to_swap, i);
                i = child_to_swap;
                left_child = 2*i + 1;
            } else
                left_child = end + 1;
        }
    }
}

public class Entity implements Comparable<Entity> {
    private int x, y;
    private float dx, dy;
    private Entity target;

    public Entity(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public void set_target(Entity target) {
        this.target = target;
    }

    public float calc_distance() {
        dx = x - target.x;
        dy = y - target.y;
        if (dx == 0)
            return abs(dy);
        else if (dy == 0)
            return abs(dx);
        else
            return sqrt(pow(dx, 2) + pow(dy, 2));
    }

    public void seek() {
        dx = x - target.x;
        dy = y - target.y;

        if (dx > 0)
            x--;
        else if (dx < 0)
            x++;
        else
            x += 0;
        if (dy > 0)
            y--;
        else if (dy < 0)
            y++;
        else
            y += 0;
    }

    public void flee() {
        dx = x - target.x;
        dy = y - target.y;

        if (random(0, 1) <= 0.05) {
            if (dx < 0)
                x--;
            else
                x++;
            if (dy < 0)
                y--;
            else
                y++;
        } else {
            x += (int) random(-1, 1);
            y += (int) random(-1, 1);
        }
    }

    public void draw() {
        ellipse(x, y, 5, 5);
    }

    public int compareTo(Entity other) {
        if (calc_distance() < other.calc_distance())
            return -1;
        else if (calc_distance() > other.calc_distance())
            return 1;
        else
            return 0;
    }

    public boolean equals(Entity other) {
        return calc_distance() == other.calc_distance();
    }

    public String toString() {
        return x + ", " + y;
    }
}

void gen_entities(int count) {
    target = new Entity((int) random(0, x_max),(int) random(0, y_max));
    entities = new Entity[count];
    entity_queue = new MaxHeap<Entity>();
    for (int i=0; i<entity_count; i++) {
        entities[i] = new Entity((int) random(0, x_max),(int) random(0, y_max));
        entities[i].set_target(target);
        entity_queue.insert(entities[i]);
    }
    
}

void setup() {
    //frameRate(100);
    size(x_max, y_max);
    background(100);
    stroke(0);

    gen_entities(entity_count);

    fill(100, 150, 200);
    target.draw();

    fill(255);
    for (int i=0; i<entity_count; i++)
        entities[i].draw();
}

void draw() {
    if (entity_queue.is_empty()) {
        background(100);
        gen_entities(entity_count);
    } else {
        Entity max = entity_queue.extract_max();
        max.seek();
        if (max.calc_distance() > 0)
            entity_queue.insert(max);
    }
    //background(100);
    fill(100, 150, 200);
    target.draw();
    fill(255);
    for (int i=0; i<entity_count; i++)
        entities[i].draw();
}