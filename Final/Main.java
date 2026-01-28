import java.awt.Button;
import java.awt.Color;
import java.awt.Dialog;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridLayout;
import java.awt.Label;
import java.awt.Panel;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;


public class Main extends Frame implements WindowListener, ColorTileGUI {
    private ColorTile ct;
    private Button[][] tileTable;
    private static final Font f = new Font("serif", Font.BOLD,16);
    private final ResultDialog resultDialog = new ResultDialog(this, "Result");
    private static final Color[] COLORS = {Color.RED, Color.BLUE, Color.GREEN, Color.YELLOW};
    private static final Color EMPTY = Color.LIGHT_GRAY;

    public Main() {
        super("ColorTile");
        ct = new ColorTile(10, 10, 30, COLORS.length); // size 10 x 10 Empty 30
        init();
        ct.initTable(this);
    }

    public static void main(String[] args) {
        new Main();
    }

    private void init() {
        this.tileTable = new Button[ct.getHeight()][ct.getWidth()];
        this.addWindowListener(this);
        this.setLayout(new GridLayout(ct.getHeight(), ct.getWidth()));
        for (int y = 0; y < ct.getHeight(); y++) {
            for (int x = 0; x < ct.getWidth(); x++) {
                Button tile = new Button();
                tile.setBackground(EMPTY);
                tile.setFont(f);
                tile.addMouseListener(new MouseEventHandler(ct, this, x, y));
                tileTable[y][x] = tile;
                this.add(tile);
            }
        }
        this.setSize(50 * ct.getWidth(), 50 * ct.getHeight());
        this.setVisible(true);
    }

    @Override
    public void windowOpened(WindowEvent e) {
    
    }

    @Override
    public void windowClosing(WindowEvent e) {
        System.exit(0);
    }

    @Override
    public void windowClosed(WindowEvent e) {

    }

    @Override
    public void windowIconified(WindowEvent e) {

    }

    @Override
    public void windowDeiconified(WindowEvent e) {

    }

    @Override
    public void windowActivated(WindowEvent e) {

    }

    @Override
    public void windowDeactivated(WindowEvent e) {

    }

    @Override
    public void setTileColor(int x, int y, int tileColor){
        this.tileTable[y][x].setBackground(COLORS[tileColor]);
    }

    @Override
    public void setEmptyTile(int x, int y){
        this.tileTable[y][x].setBackground(EMPTY);
    }

    @Override
    public void win() {
        resultDialog.showDialog("Win !!!");
    }

    @Override
    public void lose() {
        resultDialog.showDialog("Lose ...");
    }
}




class MouseEventHandler implements MouseListener {

    ColorTile ct;
    ColorTileGUI ctgui;
    int x, y;

    MouseEventHandler(ColorTile ct, ColorTileGUI ctgui, int x, int y) {
        this.ct = ct;
        this.ctgui = ctgui;
        this.x = x;
        this.y = y;
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        switch (e.getButton()) {
            case MouseEvent.BUTTON1: {
                // Left click
                ct.openTile(x, y, ctgui);
            } break;
            case MouseEvent.BUTTON2: {
                // Wheel click
            } break;
            case MouseEvent.BUTTON3: {
                // Right click
                ct.reset(ctgui);
            } break;
        }
    }

    @Override
    public void mousePressed(MouseEvent e) {

    }

    @Override
    public void mouseReleased(MouseEvent e) {

    }

    @Override
    public void mouseEntered(MouseEvent e) {

    }

    @Override
    public void mouseExited(MouseEvent e) {

    }

}


class ResultDialog extends Dialog {

    Label label;
    Button btn;

    public ResultDialog(Frame owner, String title) {
        super(owner, title);
        setLayout(new GridLayout(2, 1));
        Panel p1 = new Panel();
        label = new Label();
        p1.add(label);
        this.add(p1);
        this.setSize(200, 100);
        btn = new Button();
        btn.setLabel("exit");
        btn.addMouseListener(new MouseListener(){
            @Override
            public void mouseClicked(MouseEvent e) {
                System.exit(0);
            }
            @Override
            public void mousePressed(MouseEvent e) {

            }
            @Override
            public void mouseReleased(MouseEvent e) {

            }
            @Override
            public void mouseEntered(MouseEvent e) {

            }
            @Override
            public void mouseExited(MouseEvent e) {

            }
        });
        Panel p2 = new Panel();
        p2.add(btn);
        this.add(p2);
    }

    public void showDialog(String message) {
        Panel p1 = new Panel();
        this.label.setText(message);
        this.setVisible(true);
    }
}
