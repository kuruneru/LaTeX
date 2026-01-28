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
        this.defaultEmptyCount = defaultEmptyCount; // 空白の個数
        this.totalColors = totalColors; // 色の種類（それぞれの番号がそれぞれの色と紐付いている）
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

    void setEmpties() {
        /* ----- add here ----- */
        Random rand = new Random();
        int count = 1;
        while (count <= this.defaultEmptyCount) {
            int x = rand.nextInt(this.width);
            int y = rand.nextInt(this.height);
            if (this.table[y][x] == -1) {
                continue;
            }
            this.table[y][x] = -1; // 空白を入れる
            count++;
        }
    }

    public void openTile(int x, int y, ColorTileGUI gui) {
        /* ----- add here ----- */
        int right = 0;
        int left = 0;
        int up = 0;
        int down = 0;

        //横に同じものがあるか
        while (x + right < this.width - 1 && this.table[y][x + right] == -1) {
            right++;
        }
        while (x - left > 0 && this.table[y][x - left] == -1) {
            left++;
        }
        //縦に同じものがあるか
        while (y + up < this.height - 1 && this.table[y + up][x] == -1) {
            up++;
        }
        while (y - down > 0 && this.table[y - down][x] == -1) {
            down++;
        }
        //System.out.println("上: " + down + " 下: " + up + " 右: " + right + " 左: " + left);
        //十字の判断
        //横方向に同じ物がある
        if (this.table[y][x + right] == this.table[y][x - left] && (this.table[y][x + right] != -1 && this.table[y][x - left] != -1)) {
            //横方向と縦方向に同じものがある
            if (this.table[y - down][x] == this.table[y + up][x] && (this.table[y - down][x] != -1 && this.table[y + up][x] != -1)) {
                this.score += 4;
                table[y - down][x] = -1;
                table[y + up][x] = -1;
                table[y][x + right] = -1;
                table[y][x - left] = -1;
                gui.setEmptyTile(x, y - down);
                gui.setEmptyTile(x, y + up);
                gui.setEmptyTile(x + right, y);
                gui.setEmptyTile(x - left, y);

                if (checkWinCondition() == 1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.win();
                } else if (checkWinCondition() == -1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.lose();
                }

                return;
            //横方向と上方向に同じものがある
            } else if (this.table[y - down][x] == this.table[y][x + right] && (this.table[y - down][x] != -1 && this.table[y][x + right] != -1)) {
                this.score += 3;
                table[y - down][x] = -1;
                table[y][x + right] = -1;
                table[y][x - left] = -1;
                gui.setEmptyTile(x, y - down);
                gui.setEmptyTile(x + right, y);
                gui.setEmptyTile(x - left, y);

                if (checkWinCondition() == 1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.win();
                } else if (checkWinCondition() == -1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.lose();
                }

                return;            
            }
            //横方向と下方向に同じものがある
            if (this.table[y + up][x] == this.table[y][x + right] && (this.table[y + up][x] != -1 && this.table[y][x + right] != -1)) {
                this.score += 3;
                table[y + up][x] = -1;
                table[y][x + right] = -1;
                table[y][x - left] = -1;
                gui.setEmptyTile(x, y + up);
                gui.setEmptyTile(x + right, y);
                gui.setEmptyTile(x - left, y);

                if (checkWinCondition() == 1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.win();
                } else if (checkWinCondition() == -1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.lose();
                }

                return;
            }

            this.score += 2;
            this.table[y][x + right] = -1;
            this.table[y][x - left] = -1;
            gui.setEmptyTile(x + right, y);
            gui.setEmptyTile(x - left, y);

            if (checkWinCondition() == 1) {
                System.out.printf("score = %d\n", this.score);
                gui.win();
            } else if (checkWinCondition() == -1) {
                System.out.printf("score = %d\n", this.score);
                gui.lose();
            }        

            return ;
        }

        //縦方向に同じものがある
        if (this.table[y - down][x] == this.table[y + up][x] && (this.table[y - down][x] != -1 && this.table[y + up][x] != -1)) {
            //縦方向と右方向に同じものがある
            if (this.table[y - down][x] == this.table[y][x + right] && (this.table[y - down][x] != -1 && this.table[y][x + right] != -1)) {
                this.score += 3;
                table[y - down][x] = -1;
                table[y + up][x] = -1;
                table[y][x + right] = -1;
                gui.setEmptyTile(x, y - down);
                gui.setEmptyTile(x, y + up);
                gui.setEmptyTile(x + right, y);

                if (checkWinCondition() == 1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.win();
                } else if (checkWinCondition() == -1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.lose();
                }

                return ;
            }
            
            if (this.table[y - down][x] == this.table[y][x - left] && (this.table[y - down][x] != -1 && this.table[y][x - left] != -1)) {
                this.score += 3;
                table[y - down][x] = -1;
                table[y + up][x] = -1;
                table[y][x - left] = -1;
                gui.setEmptyTile(x, y - down);
                gui.setEmptyTile(x, y + up);
                gui.setEmptyTile(x - left, y);    

                if (checkWinCondition() == 1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.win();
                } else if (checkWinCondition() == -1) {
                    System.out.printf("score = %d\n", this.score);
                    gui.lose();
                }

                return ;
            }
            this.score += 2;
            this.table[y - down][x] = -1;
            this.table[y + up][x] = -1;
            gui.setEmptyTile(x, y - down);
            gui.setEmptyTile(x, y + up);

            if (checkWinCondition() == 1) {
                System.out.printf("score = %d\n", this.score);
                gui.win();
            } else if (checkWinCondition() == -1) {
                System.out.printf("score = %d\n", this.score);
                gui.lose();
            }

            return ;
        }

        //上方向と右方向
        if (this.table[y - down][x] == this.table[y][x + right] && (this.table[y - down][x] != -1 && this.table[y][x + right] != -1)) {
            this.score += 2;
            this.table[y - down][x] = -1;
            this.table[y][x + right] = -1;
            gui.setEmptyTile(x, y - down);
            gui.setEmptyTile(x + right, y);

            if (checkWinCondition() == 1) {
                System.out.printf("score = %d\n", this.score);
                gui.win();
            } else if (checkWinCondition() == -1) {
                System.out.printf("score = %d\n", this.score);
                gui.lose();
            }            

            return ;
        
        }
        
        //上方向と左方向
        if (this.table[y - down][x] == this.table[y][x - left] && (this.table[y - down][x] != -1 && this.table[y][x - left] != -1)) {
            this.score += 2;
            this.table[y - down][x] = -1;
            this.table[y][x - left] = -1;
            gui.setEmptyTile(x, y - down);
            gui.setEmptyTile(x - left, y);

            if (checkWinCondition() == 1) {
                System.out.printf("score = %d\n", this.score);
                gui.win();
            } else if (checkWinCondition() == -1) {
                System.out.printf("score = %d\n", this.score);
                gui.lose();
            }

            return ;
        
        }
        //下方向と右方向
        if (this.table[y + up][x] == this.table[y][x + right] && (this.table[y + up][x] != -1 && this.table[y][x + right] != -1)) {
            this.score += 2;
            this.table[y + up][x] = -1;
            this.table[y][x + right] = -1;
            gui.setEmptyTile(x, y + up);
            gui.setEmptyTile(x + right, y);

            if (checkWinCondition() == 1) {
                System.out.printf("score = %d\n", this.score);
                gui.win();
            } else if (checkWinCondition() == -1) {
                System.out.printf("score = %d\n", this.score);
                gui.lose();
            }

            return ;
        
        }
        //下方向と左方向
        if (this.table[y + up][x] == this.table[y][x - left] && (this.table[y + up][x] != -1 && this.table[y][x - left] != -1)) {
            this.score += 2;
            this.table[y + up][x] = -1;
            this.table[y][x - left] = -1;
            gui.setEmptyTile(x, y + up);
            gui.setEmptyTile(x - left, y);

            if (checkWinCondition() == 1) {
                System.out.printf("score = %d\n", this.score);
                gui.win();
            } else if (checkWinCondition() == -1) {
                System.out.printf("score = %d\n", this.score);
                gui.lose();
            }

            return ;
        }
    }

    private int checkWinCondition() {
        /* ----- add here ----- */
        //空白のカウント
        int count = 0;
        for (int y = 0; y < this.height; y++) {
            for (int x = 0; x <this.width; x++) {
                if (this.table[y][x] == -1) {
                    int right = 0;
                    int left = 0;
                    int up = 0;
                    int down = 0;
                    //横に同じものがあるか
                    while (this.table[y][x + right] == -1 && x + right < this.width - 1) {
                        right++;
                    }
                    while (this.table[y][x - left] == -1 && x - left > 0) {
                        left++;
                    }
                    //横方向に同じ物がある
                    if (this.table[y][x + right] == this.table[y][x - left] && (this.table[y][x + right] != -1 && this.table[y][x - left] != -1)) {
                        return 0; //未だある
                    }
                    //縦に同じものがあるか
                    while (this.table[y + up][x] == -1 && y + up < this.height - 1) {
                        up++;
                    }
                    while (this.table[y - down][x] == -1 && y - down > 0) {
                        down++;
                    }
                    //縦方向に同じものがある．
                    if (this.table[y + up][x] == this.table[y -down][x] && (this.table[y + up][x] != -1 && this.table[y - down][x] != -1)) {
                        return 0;
                    }
                    //十字の判断
                    //上方向と右方向
                    if (this.table[y + up][x] == this.table[y][x + right] && (this.table[y + up][x] != -1 && this.table[y][x + right] != -1)) {
                        return 0;
                    //上方向と左方向
                    } else if (this.table[y + up][x] == this.table[y][x - left] && (this.table[y + up][x] != -1 && this.table[y][x - left] != -1)) {
                        return 0;
                    //下方向と右方向
                    } else if (this.table[y - down][x] == this.table[y][x + right] && (this.table[y - down][x] != -1 && this.table[y][x - right] != -1)) {
                        return 0;
                    //下方向と左方向
                    } else if (this.table[y - down][x] == this.table[y][x - left] && (this.table[y - down][x] != -1 && this.table[y][x - left] != -1)) {
                        return 0;
                    }
                    count++;
                }
            }
        }
        if (count == this.width * this.height) {
            return 1;
        }
        return -1;
    }

    public void reset(ColorTileGUI gui) {
        /* ----- add here ----- */
        this.initTable(gui);
    }

}