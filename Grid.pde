class Grid {
  Cell[] cellArray;
  int[] cellValues;
  int GRID_SIZE;
  int GRID_UNIT_SIZE;
  float CELL_WIDTH;
  String GRID_CODE;
  
  Grid(String grid_code, int grid_size, int grid_unit_size, float cell_width) {
    this.GRID_CODE = grid_code;
    this.GRID_SIZE = grid_size;
    this.GRID_UNIT_SIZE = grid_unit_size;
    this.CELL_WIDTH = cell_width;
    this.cellArray = new Cell[grid_size*grid_size];
    this.cellValues = new int[grid_size*grid_size];
    for (int i=0; i<GRID_CODE.length();i++) {
      cellValues[i] = Integer.parseInt(Character.toString(GRID_CODE.charAt(i)));
      cellArray[i] = new Cell(i, cellValues[i],CELL_WIDTH);
    }
  }
  
  Cell[] getCellArray() {
    return this.cellArray;
  }
  
  int getScore() {
    int score = 0;
    for (Cell cell : cellArray) {
      if (checkCell(cell))
        score++;
    }
    return score;
  }
  
  ArrayList <Cell> getEmptyCells() {
    ArrayList <Cell> empty_cells = new ArrayList<Cell>();
    for(int i=0; i<this.cellArray.length ; i++) {
      if (this.cellArray[i].getNum()==0)
        empty_cells.add(this.cellArray[i]);
    }
    return empty_cells;
  }
  
  int validCellsNum() {
    int valid_cells_num = 0;
    for (Cell c : this.cellArray) {
      if (checkCell(c))
        valid_cells_num++;
    }
    return valid_cells_num;  
  }
  
  boolean colValid(Cell cell) {
    for (int i = cell.getIndex()%9; i<=(cell.getIndex()%9)+72; i=i+GRID_SIZE) {
      if (cell.getIndex()!=cellArray[i].getIndex() && 
          cellArray[i].getNum()!=0 &&
          cell.getNum()==cellArray[i].getNum())
        return false;
    }
    return true;
  }
  
  boolean rowValid(Cell cell) {
    int starting_row_index = (int) Math.floor(cell.getIndex()/9)*9;
    for (int i = starting_row_index; i<=starting_row_index+8; i=i+1) {
      if (cell.getIndex()!=cellArray[i].getIndex() && 
          cellArray[i].getNum()!=0 &&
          cell.getNum()==cellArray[i].getNum())
        return false;
    }
    return true;
  }
  
  boolean unitValid(Cell cell) {
    int cell_index = cell.getIndex();
    int col_index = cell_index - (cell_index%3);
    int starting_unit_index = col_index - 9*(((int) Math.floor(col_index/9))%3);
    for (int i=0; i<3; i++) {
      int start_cell_index = starting_unit_index + (9*i);
      for (int j=0; j<3; j++) {
        if (cell.getIndex()!=cellArray[start_cell_index+j].getIndex() && 
            cellArray[start_cell_index+j].getNum()!=0 &&
            cell.getNum()==cellArray[start_cell_index+j].getNum())
          return false;
      }
    }
    return true;
  }
  
  
  boolean checkCell(Cell cell) {
    if (cell.getNum()==0 || cell.getNum()>9)
      return false;
      
    return colValid(cell) && rowValid(cell) && unitValid(cell);
  }
  
  void switchCells(Cell c1, Cell c2) {
    int c1_num = c1.getNum();
    c1.setNum(c2.getNum());
    c2.setNum(c1_num);
  }
  
  void draw() {
    int index = 0;
    float y_start = 50;
    for(int i=0; i<GRID_SIZE; i++) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j++) {
        strokeWeight(1);
        cellArray[index].setCoordinates(x_start, y_start);
        cellArray[index].draw(x_start, y_start);
        x_start=x_start+CELL_WIDTH;
        index++;
      }
      y_start=y_start+CELL_WIDTH;
    }
  
    y_start = 50;
    for(int i=0; i<GRID_SIZE; i = i+GRID_UNIT_SIZE) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j = j+GRID_UNIT_SIZE) {
        stroke(0,0,0);
        strokeWeight(5);
        noFill();
        rect(x_start, y_start, GRID_UNIT_SIZE*CELL_WIDTH, GRID_UNIT_SIZE*CELL_WIDTH); 
        x_start=x_start+GRID_UNIT_SIZE*CELL_WIDTH;
      }
      y_start=y_start+GRID_UNIT_SIZE*CELL_WIDTH;
    }
  }
  
  void highlightValidity() {
    int index = 0;
    float y_start = 50;
    for(int i=0; i<GRID_SIZE; i++) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j++) {
        strokeWeight(1);
        cellArray[index].setCoordinates(x_start, y_start);
        strokeWeight(3);
        if(this.checkCell(cellArray[index]))
          stroke(0,128,0);
        else
          stroke(255, 0, 0);
        cellArray[index].draw(x_start, y_start);
        x_start=x_start+CELL_WIDTH;
        index++;
      }
      y_start=y_start+CELL_WIDTH;
    }
  
    y_start = 50;
    for(int i=0; i<GRID_SIZE; i = i+GRID_UNIT_SIZE) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j = j+GRID_UNIT_SIZE) {
        stroke(0,0,0);
        strokeWeight(5);
        noFill();
        rect(x_start, y_start, GRID_UNIT_SIZE*CELL_WIDTH, GRID_UNIT_SIZE*CELL_WIDTH); 
        x_start=x_start+GRID_UNIT_SIZE*CELL_WIDTH;
      }
      y_start=y_start+GRID_UNIT_SIZE*CELL_WIDTH;
    }
  }
}