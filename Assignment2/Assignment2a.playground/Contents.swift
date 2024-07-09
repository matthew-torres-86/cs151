/*:
 # Assignment 2
 
 The intent of this homework set is to make sure that you:
 
 1. have a firm grasp of the use functional composition in Swift and
 1. can correctly use important concepts from Apple's Combine library
 
 There are two playgrounds in this Assignment Assignment2a and Assignment2b.

 Once again, to the extent possible, I have given you
 a template for all the neccesary code here and have
 only asked you to fill in the details.
 
 To complete this assignment, you need to have a basic understanding
 of the following Swift concepts:
 
 * Functions lifted to nominal types and the use of the `callAsFunction` function on structs, classes or enums
 * Generics in Swift
 * Functional composition using generics
 * Map/FlatMap/Reduce as general operations on generic types
 * Recursive functional composition using generics
 * Principles of Functional Reactive Programming
 * Basic operations of Combine Publishers and Subscribers
 * Basic use of Combine as a tool for asynchronous programming, in
   particular with timers and network calls.
 
 Before attempting this homework, you should first read the Learn-swift playgrounds: 1-12, 26-31, and 33-35
 
 You should also keep these readily at hand while doing this assignment.
 
 Once again, **ALL** answers are to be given in line.
 Please do not erase the formatted
 comments, i.e. go to Editor->Show Rendered Markup
 in Xcode and leave rendering on while doing the homework.
 This will prevent you from inadvertantly changing things you should not change.
 
 You should make changes to this file **ONLY**
 in the places specified by the marked comments.
 Put your code and or comments ONLY in
 those places!
 As before, where the instructions specify a limit on the length of your
 answers, limit your answers to that length.
  
 ## Overall requirements:
 1. You must work all problems in both playgrounds: Assignment2a and Assignment2b.
 1. Your submitted playgrounds must have zero errors and zero warnings.  **Turning
 in a playground which does not successfully compile will result in zero points for
 all questions in that playground.**
 1. You MUST do the work yourself, do not talk together on this one,
 any questions should be addressed to the discussion boards so that
 everyone may see them and the instructors may determine if they are appropriate
 
 All the previous honor code rules from before still apply.  To wit:
 
 **DO NOT ANSWER QUESTIONS ON THIS HOMEWORK FOR OTHERS IN THE FORUMS**
 
 You may say something like: "this was discussed in class 4 at 45:16" or
 "this is in learn-swift 12", but no more than that.
 
 Violation of this rule will be treated as an honor violation.
 
 There are 20 problems, each problem counts 5 points.

 ## General Instruction

In many of the problems which follow, you will be provided with
an example implementation of a function, followed by a commented
skeleton of a slightly differing function.

**DO NOT CHANGE THE FUNCTION DECLARATION
OF THE COMMENTED FUNCTION.**

Your job in these problems is
to look at the signature of the function as provided and implement
it using the principles embedded in the example function.  If you
change the provided function declaration, you are not working the
problem. NB, the compiler will guide you to the answer in this case.
 Essentially, if you do not change the signature, the code will not
 compile until you very likely have the correct answer.  The compiler
 is your friend.  It has your best interests at heart.  No matter how
 right you think you are, you should listen to it.

### Problem 1
 
 In one word, explain which generic parameter of a Combine Publisher
 type you would expect to make use of the following type.
 */
enum Assignment2Error: Error {
    case myError
}
// ** Your Problem 1 answer goes here **
/*
Errors 
*/
/*:
 ### Problem 2

 Here is the curry function we wrote in class.
 */
public func curry<A, B, C>(
    _ function: @escaping (A, B) -> C
) -> (A) -> (B) -> C {
    { (a: A) -> (B) -> C in
        { (b: B) -> C in
            function(a, b)
        }
    }
}
/*:
 It takes a function of two arguments and returns an
 equivalent function-returning-function. In this case
 the returned functions are expressed as closures.

 Uncomment
 the function immediately below and extend
 the two argument curry above with an implementation
 which does the same thing for a function of three arguments.
 *HINT:* Remember the rule about how to write functions
 which return closures.
 */
// ** Your Problem 2 answer goes here **

 public func curry<A, B, C, D>(
     _ function: @escaping (A, B, C) -> D
 ) -> (A) -> (B) -> (C) -> D {
     { (a: A) -> (B) -> (C) -> D in
         { (b: B) -> (C) -> D in
             { (c: C) -> D in
                 function(a, b, c)
             }
         }
     }
 }

/*:
 ### Problem 3

 Here is the multiargument form of the flip function we wrote in class.
 */
func flip<A, B, C>(
    _ f: @escaping (A, B) -> C
) -> (B, A) -> C {
    { b, a in
        f(a, b)
    }
}
/*:
 It takes a function of two arguments and returns an
 equivalent function where the order of the two
 arguments is flipped. In this case
 the returned functions are expressed as closures.

 Uncomment
 the function immediately below and extend
 the two argument flip above with an implementation
 which does the same thing for a function of three arguments.
 *HINT:* Use the same hint as above. :)
 */
// ** Your Problem 3 answer goes here **

 func flip<A, B, C, D>(
    _ f: @escaping (A, B, C) -> D
 ) -> (B, A, C) -> D {
     { b, a, c in
         f(a, b, c)
     }
 }

/*:
 ### Problem 4

 Here is the function-returning-function form of the flip function we wrote in class.
*/
func flip<A, B, C>(
    _ f: @escaping (A) -> (B) -> C
) -> (B) -> (A) -> C {
    { b in
        { a in
            f(a)(b)
        }
    }
}
/*:
 As in Problem 3, uncomment
 the function immediately below and extend
 the two argument flip immediately above with an implementation
 which does the same thing for a function of three arguments.
 *HINT:* All the hints are pretty much the same. :)
 */
// ** Your Problem 4 answer goes here **

 func flip<A, B, C, D>(
    _ f: @escaping (A) -> (B) -> (C) -> D
 ) -> (B) -> (A) -> (C) -> D {
     { b in
         { a in
             { c in
                 f(a)(b)(c)
             }
         }
     }
 }

/*:
 ### Problem 5

 Here is the compose function we wrote in class.  Notice
 that it is a two-argument function.  Hence, we can curry
 it.
 */
func compose<A, B, C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> (A) -> C {
    { a in
        g(f(a))
    }
}
/*:
 As in the problems above, uncomment
 the function immediately below and implement
 the curried form of compose.
 */
// ** Your Problem 5 answer goes here **

func curriedCompose<A, B, C>(
    _ f: @escaping (A) -> B
) -> ( @escaping (B) -> C) -> (A) -> C {
    { g in
        {a in
            g(f(a))
        }
    }
}

/*:
 Now let's see what happens when
 we lift function invocation (as opposed to application) up to a struct.
 The next several question will reference the following stuct
*/
struct Func<A, B> {
    let call: (A) -> B
    init(_ call: @escaping (A) -> B) {
        self.call = call
    }
}
/*:
 ### Problem 6

 As in the problems above, uncomment
 the function immediately below.  Provide an implemention
 of the `callAsFunction` function.
 */
extension Func {
    // ** Your Problem 6 answer goes here **

    func callAsFunction(_ a: A) -> B {
        self.call(a)
    }

}
/*:
 ### Problem 7

 Uncomment out the function below and implement the specified
 map function. Remember that `Func` is just giving a
 func from A to B a name in exactly the same way that a struct
 gives a name to a tuple.  This will help you think about using
 Func.
*/
extension Func {
    // ** Your Problem 7 answer goes here **
    
    func map<C>(_ transform: @escaping (B) -> C) -> Func<A, C> {
        return Func<A, C>.init {a in
            let b = call(a)
            return transform(b)
        }
    }
}

/*:
 ### Problem 8

 In one word, state what function given above looks so much like your
 shiny new map function that it is in fact, exactly equivalent.
*/
// ** Your Problem 8 answer goes here **
// Compose!
//
/*:
### Problem 9
 Uncomment out the function below and implement the specified
 flatMap function.  *Hint: you will need to use your `A` value twice.*
*/
extension Func {
    // ** Your Problem 9 answer goes here **

    func flatMap<C>(_ transform: @escaping (B) -> Func<A, C>) -> Func<A, C> {
        return Func<A, C>.init {a in
            transform(call(a)).call(a)
        }
    }
}
/*:
 _Problems 10-13 below reference the following:_
 */
func tripler(_ anInt: Int) -> Double { Double(anInt * 3) }
let f = Func(tripler)
type(of: f)
/*:
### Problem 10

 What is the type of `f`?
 */
// ** Your Problem 10 answer goes here **
//Func<Int, Double>
//
/*:
### Problem 11
 Using the `callAsFunction` notation provide code which uses
 `f` to produce the value: `9`
 */
// ** Your Problem 11 answer goes here **
f.callAsFunction(3)

/*:
 Here is the `Continuation` struct we wrote in class.  The next two questions
 refer to it:
 */
struct Continuation<A, R> {
    let sink: (@escaping (A) -> R) -> R
    init(_ sink: @escaping (@escaping (A) -> R) -> R) {
        self.sink = sink
    }
    init(_ a: A) {
        self = .init { downstream in
            downstream(a)
        }
    }
    func callAsFunction(_ f: @escaping (A) -> R) -> R {
        sink(f)
    }
}

extension Continuation {
    func map<B>(_ f: @escaping (A) -> B) -> Continuation<B, R> {
        .init { downstream in self { a in
            downstream(f(a))
        } }
    }
    func flatMap<B>(_ f: @escaping (A) -> Continuation<B, R>) -> Continuation<B, R> {
        .init { downstream in self { a in
            f(a)(downstream)
        } }
    }
}
/*:
### Problem 12

 Uncomment the implementation of `log` below and use `f` to print a string
 which describes `a` and then continues computation.
*/
extension Continuation {
    func log(_ f: @escaping (A) -> String) -> Continuation<A, R> {
        .init { downstream in self { a in
            // Your Problem 12 Implementation Goes Here!
            print(f(a))
            return downstream(a)
        }
    }
}
}
/*:
  The next question makes use of `tripler` above and the following functions:
 */
func toString(_ aDouble: Double) -> String { aDouble.description }
func encloseInSpaces(_ aString: String) -> String { "  \(aString)  " }
func identity<T>(_ t: T) -> T { t }
/*:
### Problem 13

 Note that toString composes with encloseInSpaces,
 the composition of which composes with tripler.

 Specifically:
 */
let trivialFunc = compose(tripler, compose(toString, encloseInSpaces))
let trivialString = trivialFunc(3)
/*:
 We can use exactly this composability with our Continuation type.
 In the function below, replace the indicated lines with a
 Continuation which starts with 3 and successively maps
 to `tripler`, `toString` and `encloseInSpaces`.  Use your `log` function
 in between each step to show the progress.  Verify that the outcome is "  9.0  "

 Specifically your answer should be 6 lines below, consisting of 3 map's and 3 log's
 */
func createAContinuation() -> Continuation<String, String> {
    Continuation<Int, String>(3)
//         Replace the following line with your Problem 13 answer lines
        .map(tripler)
        .log({val in return "\(val.description)"}) // 3.0
        .map(toString)
        .log({val in return "\(val.description)"})
        .map(encloseInSpaces)
        .log({val in return "\(val.description)"})
}
let theString = createAContinuation().sink(identity)
