
/*:
 # Assignment 1
 
 The intent of this homework set is to:
 
 1. make sure that you can correctly use important concepts from Swift
 1. have a base set of code from which we can build our Conway's Game
 of Life app.
 
 This code will be incorporated into your final project, so it is very
 important that we get it right.  To the extent possible, I have given you
 a template for all the neccesary code here and have
 only asked you to fill in the details. You are being asked to
 demonstrate that you understand the meaning of those details
 
 To complete this assignment, you need to have a basic understanding
 of the following Swift concepts:
 * Type Aliases
 * Base operations, in particular the modulo and ternary operators
 * Base data types, in particular Int and Tuple
 * Arrays and Arrays of Arrays
 * Basic control flow including: guard and switch
 * Why and when we avoid the use of "for" as a control flow mechanism
 and use functional constructs instead
 * The Swift types: enum, struct and class and their syntax, differences and similarities
 * Properties of enums, structs and classes
 * Subscripts on structs and classes
 * Functions and in particular higher order functions which take closures as arguments
 * Closures and in particular the trailing closure syntax
 * How to read the signature and therefore the type of a func (or closure)
 * Parameterized types (aka Generics) and their uses
 * Optional types and why they are genericized enums
 * The if-let and guard-let constructs
 
 It sounds like a lot I know, but these are parts of the language that you will use
 every day if programming professionally.  There's just no getting around them.
 
 Before attempting this homework, you should first read:
 * the Swift Tour section of the Apple Swift book
 * all of the learn-swift examples on the topics above, cross-referencing back to the book as you go
 * [the wikipedia page on Conway's Game of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life)
 
 You should also keep these readily at hand while doing this assignment.
 
 **ALL** answers are to be given in line.  _Please do not erase the formatted
 comments as we will
 be grading by reading through this playground._  i.e. go to Editor->Show Rendered Markup
 in Xcode and leave rendering on while doing the homework.  This will prevent you
 from inadvertantly changing things you should not change.
 
 You should make changes to this file **ONLY**
 in the places specified by the marked comments.  Put your code and or comments ONLY in
 those places!  Where the instructions specify a limit on the length of your answers, please
 be aware that we are serious about this.  Swift is built to facilitate concise coding style.
 This homework set has been created in part to teach you this style.
 
 You are **strongly** advised to work the problems in order.  As you progress you must make sure that
 the playground stays in a state where it compiles and runs.  Trust me, not doing this may be the biggest
 mistake you can make.  If you get stuck, you should seek assistance via the discussion forums rather
 than trying to go on.
 
 An excellent practice to get into
 is to do frequent git commits of your work so that you don't lose it and can roll back to previous
 versions if you make a mistake.  Xcode will help you with this.  There is no cost to doing this
 as we will only grade your last check-in prior to the due date.  Commit and push are your friends
 here.
 
 ## Overall requirements:
 1. Your submitted playground must have zero errors and zero warnings
 1. It must successfully run to completion, generating the words The End at the end
 1. It must produce reasonable numbers for Conway's Game of Life, i.e. after a couple of
 iterations, the game should have about 33 living cells.  It should NOT have zero or 100.
 1. The test code at the end should display a regular pattern.
 1. You MUST do the work yourself, do not talk together on this one, any questions should be
 addressed to the discussion boards so that everyone may see them and the instructors may
 determine if they are appropriate.
 
 **DO NOT ANSWER QUESTIONS ON THIS HOMEWORK FOR OTHERS IN THE FORUMS**
 
 You may say something like: "this was discussed in class 4 at 45:16" or "this is in learn-swift 12",
 but no more than that.  Violation of this rule will be treated as an honor violation.  You
 don't want to be that person.
 
 The Honor Code is not the only reason for this requirement.
 An even bigger reason is that if you do not understand how to use Swift at this level you will not
 be able to do the other assignments.  It is VITAL that we get everyone the help they need if they are
 having difficulties.  Some real effort is required to learn any language
 especially Swift and I expect that it will be difficult for everyone.  The difficulty is a feature, not a bug.

 


 ## Problem 1:
 **Problem 1 has already been worked for you as an example**.   Everyone gets 5 free points!
 
 Create a typealias named Position for a tuple which has
 two integer variables: `row` and `col` in that order
*/
// ** Your Problem 1 code goes here! replace the following line **
typealias Position = (row: Int, col: Int)
/*:
 ## Problem 2:
 Using the enum `CellState` defined below:
 1. create the following 4 possible values: `alive`, `empty`, `born` and `died`.
 1. equip `CellState` with a computed variable `isAlive` of type `Bool` which
 is true if the CellState is alive or born, false otherwise.
 1. `isAlive` MUST use **ONLY** a switch statement on self
 1. `isAlive` can be no more than 8 readable lines long, including curly-braces.
 
 Failure to follow all rules will result in zero credit.
 */
enum CellState {
    // ** Problem 2.1: Replace the line below with your answer **
    case alive
    case empty
    case born
    case died
    
    var isAlive: Bool {
        // ** Problems 2.2 - 2.4: Replace the line below with your answer **
        switch self {
        case .alive:
            return true
        case .born:
            return true
        default:
            return false
        }
    }
}
/*:
 ## Problem 3:
 I am defining a top-level function, `norm`, immediately below.
 Answer the following questions on this function in the places shown.
 (Your answers may consist of **ONE** valid swift type or expression,
 I do NOT want sentences):
*/
func norm(_ val: Int, to size: Int) -> Int { ((val % size) + size) % size }
/*:
 1. what is the return type of `norm`
 */
/*
 // ** Your Problem 3.1 answer goes here **
Int
 */
/*:
 2. In terms of `size`, what is the maximum value that `norm` will return?
 */
/*
 // ** Your Problem 3.2 answer goes here **
 The maximum value norm will return is size - 1
 */
/*:
 ## Problem 4:
 I am defining a top level function, `positions`, immediately below.
 Answer the following questions on this function in the places shown.
 Your answers may consist of **ONLY** one **STRING OF CHARACTERS**
 which is a valid swift type. (i.e. you need to understand what constitutes
 a valid Swift type).
 */
func positions(rows: Int, cols: Int) -> [Position] {
    (0 ..< rows).flatMap {
        zip( [Int](repeating: $0, count: cols) , 0 ..< cols )
    }
}

/*:
 1. what is the return type of the call to `zip`
 */

/*
 // ** Your Problem 4.1 answer goes here **
[(Int, Int)]
 */
/*:
 2. what is the type of `0 ..< rows`?
 */
/*
 // ** Your Problem 4.2 answer goes here **
 Range<Int>
 
 */

/*:
 3. what is the return type of the call to `flatMap`?
 */
/*
 // ** Your Problem 4.3 answer goes here **
[Int]
 */
/*:
 The following 4 problems apply to the struct Grid shown below.
 
 ## Problem 5:
 In a comment here, explain what the contents
 of the variable named `offsets` in the struct `Grid` below represent.
 
 **Hint:** they are relative to the missing entry in the center and
 have to do with the rules to Conway's Game of Life.
 
 **Your answer may be no more than one sentence.**
 */
/*
 // ** Your Problem 5 comment goes here! **
The variable offsets is the set of all positions of the cells neighbor to the missing entry in the center.
 */
/*:
 ## Problem 6:
 The struct `Grid` has been provided with variables `rows`, `cols`:
 1. **On the initializer of grid**, set `rows` to be 10 by default
 1. **On the initializer of grid**, set `cols` to be 10 by default
 
 ## Problem 7:
 In the location shown below, equip Grid's initializer with code which
 initializes the `rows` and `cols` properties from the arguments
 
 ## Problem 8:
 Write precisely one line of code in the location shown below to set the state of each cell specified
 in `cellStates` to the value specificied by `cellInitializer`.
 */
struct Grid {
    static let offsets: [Position] = [
        (row: -1, col: -1), (row: -1, col: 0), (row: -1, col: 1),
        (row:  0, col: -1),                    (row:  0, col: 1),
        (row:  1, col: -1), (row:  1, col: 0), (row:  1, col: 1)
    ]
    
    let rows, cols: Int
    let cellStates: [[CellState]]
    
    // ** Your Problem 6 code goes on the next line! **
    init(
        _ rows: Int = 10,
        _ cols: Int = 10,
        _ cellInitializer: (Int, Int) -> CellState = { _,_ in .empty }
    ) {
        // ** Your Problem 7 code replaces the next 2 lines!  **
        self.rows = rows
        self.cols = cols
        cellStates = (0 ..< rows).map { row in
            (0 ..< cols).map { col in
                // ** Your Problem 8 code goes on the next line!  **
                cellInitializer(row, col)
            }
        }
    }
}

/*:
 The next two problems apply to the extension to `Grid` immediately below.

 ## Problem 9:
  In the extension to Grid below, examine the `neighbors` call.
  1. Explain in one sentence when you would use the word `of` in relation to this function
  */
 /*
  // ** your problem 9.1 answer goes here.
  
The word of is the external parameter name, which must be used when calling the function.

  2. Explain in one sentence when you would use the word `position` in relation to this function
 // ** your problem 9.2 answer goes here.
The word position is the internal parameter name, which you use inside the function body.

 */
/*:
 ## Problem 10:
 In the extension to `Grid` below, provide a return
 value of type `Position` for the function `neighbors`
 such that `neighbors` returns the coordinates of all neighbor cells of `self`.
 Where by neighbor we mean one of the 8 cells in a grid which touches the current
 cell.
 
 Your answer MUST:
 1. implement the "wrap-around" rules of Conway's Game of Life by making use of the `norm` function provided above
 1. make use of `offset` as passed into map
 1. be no longer than 3 readable lines long
 
 Failure to follow all rules will result in zero credit.
 
 **HINT** Note that the code you are being asked to write is inside of a map
 function operating over the `offsets` array and that it returns a position
 which represents a neighbor of the given cell which has its own position.
 */
extension Grid {
    func neighbors(of position: Position) -> [Position] {
        Grid.offsets.map { offset in
            // ** Your Problem 10 Code goes here! replace the following line **
            let row = norm(position.row, to: self.rows)
            let col = norm(position.col, to: self.cols)
            return Position(row: row, col: col)
        }
    }
}
/*:
 The next two problems apply to the extension to `Grid` immediately below.

 ## Problem 11:
 *In ONE sentence* explain why this subscript does not and should not have a set
 */
 /*
  // ** Your Problem 11 answer goes here **
This subscript should not have a set because that would allow the user to set the cellstate of a cell at the given position, and that is done elsewhere in the mechanics of the game of life.

  */
/*:
 ## Problem 12:
 In the extension to `Grid` below, equip `Grid` with a subscript which allows you to
 get the values of a cell of type `CellState` in the following manner:
 ```
 let someCellState = aGrid[4,7]
 ```
 Your solution MUST:
 1. implement only the `get`
 1. make use of the norm function defined above
 1. be no more than 3 lines long
 1. use a guard statement to ensure that row and col are **between -1 and rows+1 or cols+1 respectively** and return .none if they are not.
 
 Failure to follow all rules will result in zero credit.
 
 Before you ask, yes, I know that this does not have to return a CellState?, but could return just a CellState.
 One of the points of this question is for you to learn to handle optionals.
*/
extension Grid {
    subscript (row: Int, col: Int) -> CellState? {
        get {
            // *** Your Problem 12 code goes here ***
            guard row > -1 && row < self.rows + 1 && col > -1 && col < self.cols + 1 else { return .none }
            return self.cellStates[norm(row, to: self.rows)][norm(col, to: self.cols)]
        }
    }
}
/*:
 The next three problems apply to the extension to `Grid` immediately below.

 ## Problem 13:
 In the computed var `numLiving` below,

 1. What is the type of `positions(rows: rows, cols: cols)`?
 */
/*
 // ** Your Problem 13.1 answer goes here **
 Array<(row: Int, col: Int)>
 */
/*:
 2. What is the type of the _second_ argument to reduce?
 */
/*
 // ** Your Problem 13.2 answer goes here **
 Bool
 */
/*:
 ## Problem 14:
 In a comment, explain what the reduce function
 in the following extension returns, in the context of Conway's Game of Life.
 
 Your answer may consist of **AT MOST** 2 sentences
 */

/*
 // ** Your Problem 14 answer goes here **
 The reduce function maps over the cells of the grid and counts each living one, and returns the total number of living cells.
 */

/*:
 ## Problem 15:
 1. In a comment, explain what `$1` in: `self[$1.row, $1.col]!` does. Your answer may consist of **AT MOST** one sentence.
 */
/*
  // ** Your Problem 15.1 answer goes here **
$1 is the position of the cell that the function is currently looking at, to determine if it is living or non-living.
 */
/*:
  2. In a comment, explain what `!` in: `self[$1.row, $1.col]!` does and why we want to avoid it. Your answer may consist of **AT MOST** two sentences.
 */
/*
   // ** Your Problem 15.2 answer goes here **
 The ! is the force unwrap operator, which will cause the program to abort if the value is nil.
*/
extension Grid {
    var numLiving: Int {
        positions(rows: rows, cols: cols).reduce(0) {
            self[$1.row, $1.col]!.isAlive ? $0 + 1 : $0
        }
    }

}


/*:
 ## Problem 16:
 Let's test your work so far.
 
 1. Uncomment the lines of working code marked immediately below.
 
 2. Replace the cellInitializer with a closure which causes each cell to be `.alive` with probability 1/3 and `.empty` otherwise
 
 3. Use the following expression to determine if the `state` should be .alive or .empty:
 
 `     (0 ... 2).randomElement() == 2`
 
 4. Assign the state using the ternary conditional operators `?:`
 
 5. If your code above compiles and runs the value returned from grid.numLiving
 should be approximately 33. If it is not around 33, then debug your code above.
 Explain why it should be approximately but not necessarily exactly 33 in a **one sentence** comment in the location shown below.
 
 **Hint:** This example passes the initializer in trailing closure syntax.
 You will want to set the state of
 a cell using code similar to what you've already done
 
 Failure to follow all rules will result in zero credit.
 */
var grid = Grid(10, 10) { _, _ in
    // ** Your Problem 16 code replaces the following line! **
    (0...2).randomElement() == 2 ? .alive : .empty

}
grid.numLiving
/*
 // ** Your Problem 16.5 answer goes here **
 It should be approximately 33 because the result (0...2).randomElement() == 2 should cause 1/3 of the 100 cels in the grid to be initialized as alive.
 */
/*:
 ## Problem 17:
 In the extension to Grid below, write precisely one line of code which:
 1. uses the ternary conditional operators `?` and `:`
 1. returns `count + 1` if the state of the referenced cell is `alive`, otherwise return `count`
 
 **HINT** you are returning a running count of living cells
 
 Failure to follow all rules will result in zero credit.
 */
extension Grid {
    func livingNeighbors(of position: Position) -> Int {
        neighbors(of: position).reduce(0) { (count, position) in
            // ** Replace the following line with your Problem 17 code
            self[position.row, position.col]!.isAlive ? count + 1 : count
        }
    }
}
/*:
 ## Problem 18:
 In the extension to `Grid` shown below, implement a function nextState which:
 1. returns a properly initialized CellState
 1. implements the rules of Conway's Game of Life
 
 Your answer MUST:
 * be no more than 8 lines long
 * use a `switch` statement on `livingNeighbors(of:)` from above to determine
 the value to return
 * consist of a single case and a default statement in the `switch` expression
 * return a value from each case of the `switch` using a ternary expression
 * use the `isAlive` property of `CellState` from above in a where clause attached to the case as part of the determination of state
 * return `alive` if the cell was alive at the previous iteration and had either 2 or 3 living neighbors
 * return `born` if the cell was not alive at the previous iteration and had precisely three living neighbors
 * return `died` if the cell was alive in the previous iteration and does not meet the preceding conditions
 * return `empty` otherwise
 
 Failure to follow all rules will result in zero credit.
 */
extension Grid {
    func nextState(of position: Position) -> CellState {
        // ** Replace the following line with your Problem 18 code
        switch livingNeighbors(of: position){
        case 2, 3:
            return self[position.row, position.col]!.isAlive ? .alive : .born
        default:
            return self[position.row, position.col]!.isAlive ? .died : .empty
        }
    }
}
/*:
 ## Problem 19:
 In the extension to `Grid` shown below, implement a function next which:
 1. takes no parameters
 1. returns a properly initialized Grid object which
 1. represents the next state of the current grid using the rules of Conway's Game of Life
 
 Your answer MUST:
 * be no more than 3 lines long
 * consist only of returning the results of a Grid initializer
 * make use of the rows and cols variables of the current grid
 * make use of the nextState method from problem 14
 
 Failure to follow all rules will result in zero credit.
 */
extension Grid {
    func next() -> Grid {
        // ** Replace the following line for Problem 19 **
        let grid = Grid(rows, cols) { row, col in
            nextState(of: (row, col))}
        return grid
    }
}
/*:
 ## Problem 20:
 In the location shown below implement an initializer which:
 1. uses a switch statement on a Position object formed from the row and col arguments
 2. returns .alive if the position is any of (0,1), (1,2), (2,0), (2,1), (2,2) and .empty otherwise
 3. consists of no more than 4 lines of code
 */
func testInitializer(row: Int, col: Int) -> CellState {
    
    switch (row, col){
    case (0, 1), (1, 2), (2, 0), (2, 1), (2, 2): return .alive
    default: return .empty
    }
}
/*:
 ## Problem 21 (Bonus):
 In **one word** describe what pattern is produced by the following code
 */
/*
 // ** Your Problem 21 answer goes here **

 */
grid = Grid(10, 10, testInitializer)
grid.numLiving
grid = grid.next()
grid.numLiving
grid = grid.next()
grid.numLiving
grid = grid.next()
grid.numLiving
grid = grid.next()
grid.numLiving
grid = grid.next()
grid.numLiving

let theEnd = "The End"
