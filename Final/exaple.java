import java.util.Random;

interface ColorTileGUI {
    public void setTileColor(int x, int y, int tileColor);

    public void setEmptyTile(int x, int y);

    public void win();

    public void lose();
}

public class ColorTile {

    private final int height;
    private final int width;
    private final int[][] table;
    private final int defaultEmptyCount;
    private final int totalColors;
    private int score;


    public ColorTile(int height, int width, int defaultEmptyCount, int totalColors) {
        this.height = height;
        this.width = width;
        this.table = new int[height][width];
        this.defaultEmptyCount = defaultEmptyCount;
        this.totalColors = totalColors;
        this.score = 0;
    }

    public int getHeight() {
        return height;
    }

    public int getWidth() {
        return width;
    }

    void initTable(ColorTileGUI gui) {
        /* ----- add here ----- */
        Random rand = new Random();
        // 場面に色をセット
        for (int y = 0; y < this.height; y++) {
            for (int x = 0; x < this.width; x++) {
                this.table[y][x] = rand.nextInt(this.totalColors); // 赤青緑黄の中からランダムに配置
            }
        }
        setEmpties(); // 盤面に空白をセット
        // GUIに反映する
        for (int y = 0; y < this.height; y++) {
            for (int x = 0; x < this.width; x++) {
                if (this.table[y][x] == -1) {
                    gui.setEmptyTile(x, y);
                    continue;
                }
                gui.setTileColor(x, y, this.table[y][x]);
            }
        }
    }

    void setEmpties(){
        /* ----- add here ----- */
        Random rand = new Random();
        for (int i = 0; i < this.defaultEmptyCount; i++) {
            int x = rand.nextInt(this.width);
            int y = rand.nextInt(this.height);
            if (this.table[y][x] == -1) {
                continue;
            }
            this.table[y][x] = -1; // 空白を入れる
        }
    }

    public void openTile(int x, int y, ColorTileGUI gui) {
        /* ----- add here ----- */
        
    }

    private int checkWinCondition(){
        /* ----- add here ----- */
        for (int y = 0; y < this.height; y++) {
            for (int x = 0; x <this.width; x++) {
                if (this.table[y][x] == -1) {
                    int right = 0;
                    int left = 0;
                    int up = 0;
                    int down = 0;
                    //横に同じものがあるか
                    while (this.table[y][x + right] == -1 && x + right < this.width) {
                        right++;
                    }
                    while (this.table[y][x - left] == -1 && x - left > 0) {
                        left++;
                    }
                    //横方向に同じ物がある
                    if (this.table[y][x + right] == this.table[y][x - left] && (this.table[y][x + right] != -1 && this.table[y][x - left] != -1)) {
                        return 1; //未だある
                    }
                    //縦に同じものがあるか
                    while (this.table[y + up][x] == -1 && y + up < this.height) {
                        up++;
                    }
                    while (this.table[y - down][x] == -1 && y - down > 0) {
                        down++;
                    }
                    //縦方向に同じものがある．
                    if (this.table[y + up][x] == this.table[y -down][x] && (this.table[y + up][x] != -1 && this.table[y - down][x] != -1)) {
                        return 1;
                    }
                    //十字の判断
                    //上方向と右方向
                    if (this.table[y + up][x] == this.table[y][x + right] && (this.table[y + up][x] != -1 && this.table[y][x + right] != -1)) {
                        return 1;
                    //上方向と左方向
                    } else if (this.table[y + up][x] == this.table[y][x - left] && (this.table[y + up][x] != -1 && this.table[y][x - left] != -1)) {
                        return 1;
                    //下方向と右方向
                    } else if (this.table[y - down][x] == this.table[y][x + right] && (this.table[y - down][x] != -1 && this.table[y][x - right] != -1)) {
                        return 1;
                    //下方向と左方向
                    } else if (this.table[y - down][x] == this.table[y][x - left] && (this.table[y - down][x] != -1 && this.table[y][x - left] != -1)) {
                        return 1;
                    }
                }
            }
        }
        return 0;
    }

    public void reset(ColorTileGUI gui){
        /* ----- add here ----- */
        this.initTable(gui);
    }

}