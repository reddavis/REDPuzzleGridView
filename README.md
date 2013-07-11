REDPuzzleGridView
=================

A word puzzle control, similar to Ruzzle's letter board

[Video](http://taylorswift.ly/QBtz)


Screen Shot
===========

![screenshot](http://f.cl.ly/items/0Y0O291T1z2I2T2F2V2n/Image%202013.07.11%2012%3A09%3A35.png)


Adding to Your Project
======================

Just copy all the files from  "REDPuzzleGridView / Word Puzzle Grid / REDPuzzleGridView" into your project.

Implementation
==============

Just implement the following REDPuzzleGridViewDataSource methods:

```objective-c
- (NSInteger)numberOfRowsInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView;
- (NSInteger)numberOfColumnsInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView;
- (REDPuzzleGridTile *)puzzleGridView:(REDPuzzleGridView *)puzzleGridView tileForIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeOfTileInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView;
```

and the following REDPuzzleGridViewDelegate method:

```objective-c
- (void)puzzleGridView:(REDPuzzleGridView *)puzzleGridView didSelectTiles:(NSArray *)selectedCells;
```


REDPuzzleGridTile
=================

REDPuzzleGridView works similar to how you supply UITableView with a cell. To create a custom tile, just create 
a subclass of REDPuzzleGridTile. To change a tile's selected state, just overide

```objective-c
- (void)setSelected:(BOOL)selected
```

## License

Copyright (c) Forever and ever Red Davis

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
