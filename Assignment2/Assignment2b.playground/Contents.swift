import Combine
import Foundation
//import _Concurrency

/*:
 # Assignment 2B
 
 ### Problem 14
 In the location shown below, publish `[1, 2, 3]` such that
 
 1. type(of: c1) is AnyCancellable
 2. r1 contains ["2", "4", "6"]
 3. you use a single `map` operator
 4. your answer consists of no more than 4 lines of code
 */


var r1: [String] = []
/// *Your Problem 14 code starts on the next line*
let c1 = [1, 2, 3]
    .publisher
    .map{ "\($0 * 2)" }
    .sink { r1.append($0) }
/// *Your Problem 14 stops here*
type(of: c1)
r1 == ["2", "4", "6"]

/*:
### Problem 15
 In the same manner as Problem 14, publish `sub1` in the location shown below such that
 
 1. type(of: c2) is AnyCancellable
 2. r2 == "6" is true
 3. you use a single `reduce` operator which sums values starting at 0
 4. your answer consists of no more than 4 lines of code
 */
var r2 = 0
let sub1 = PassthroughSubject<Int, Never>()
/// *Your Problem 15 code starts on the next line*
let c2 = sub1
    .reduce(0, { accum, next in accum + next })
    .sink { r2 = $0 }
/// *Your Problem 15 stops here*
sub1.send(1)
sub1.send(2)
sub1.send(3)
sub1.send(completion: .finished)

type(of: c2)
r2 == 6

/*:
### Problem 16
 In the location shown below publish `c3` such that
 
 1. type(of: c3) is AnyCancellable
 2. r3 == "140" is true
 3. you use a single flatMap operator which produces a SequencePublisher
 4. the SequencePublisher publishes a sequence all of whose elements are the input value such it repeats the input value, value number of times
 (Hint: use the Array(repeating:, count:) initializer with the input value as both arguments)
 5. you use a single `reduce` operator which sums values starting at zero
 4. your answer consists of no more than 5 lines of code
 */
let arrArr = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
let arr2 = arrArr.flatMap { inner in inner.map {anInt in String(anInt) } }
arr2

var r3 = ""
/// *Your Problem 16 code starts on the next line*
let c3 = [1, 2, 3, 4, 5, 6, 7]
    .flatMap{ anInt in Array(repeating: anInt, count: anInt) }
    .publisher
    .reduce(0, { accum, next in accum + next })
    .sink {r3 = "\($0)"}
/// *Your Problem 16 stops here*
type(of: c3)
r3 == "140"

/*:
 _The following types and value are used in Problem 17:_
 */
enum MyFirstError: Error {
    case first(Double)
}
enum MySecondError: Error {
    case second(Double)
}

var count = 0

/*:
### Problem 17
 Problem 17 comes in several parts.
 
 17.1 - Fill in the following function so that if the value is 0
 it throws MyFirstError.first(Double(count)) otherwise
 it increments count and returns value.  Your answer must
 use a guard-else statement as its first line and should
 consist of no more than 5 lines
 */
func isZero(_ value: Double) throws -> Double {
    /// ** Your problem 17.1 solution goes here **
    guard value != 0 else {
        throw MyFirstError.first(Double(count));
    }
    count = count + 1
    return value
}
/*:
 17.2 - Fill in the following function so that if error
 is .first, it returns .second with the same
 associated value as .first
 */
func changeError(_ error: Error) -> MySecondError {
    switch error as? MyFirstError {
        /// ** Your problem 17.2 solution goes here **
    case .first(let val): return .second(val)
    default: return .second(0.0)
    }
}
/*:
 17.3 - Fill in the following function so that
 it returns `Just(Double(value))` where `value`
 is the associated value of `error`
*/
func toJust(_ error: MySecondError) -> Just<Double> {
    /// ** Your problem 17.3 solution replaces the following line **
    switch error{
    case .second(let val): return Just(val)
    }
}

var r4 = [Double]()
let sub2 = PassthroughSubject<Double, MyFirstError>()

/*:
 17.4 - Apply `tryMap`, `mapError`, and `catch` to `sub2`
 using your functions from above and use a `sink` which
 appends `$0` to the result variable defined above.
*/
/// *Your 17.4 answer starts here*
let c4 = sub2
    .tryMap { value throws -> Double in try isZero(value) }
    .mapError { changeError($0) }
    .catch { toJust($0) }
    .sink{ r4.append($0)}
/// *Your Problem 17.4 stops here*
sub2.send(1)
sub2.send(2)
sub2.send(3)
sub2.send(0)
/*:
 17.5 - In one line only, cause sub2 to complete and verify that result = [1,2,3,3]
*/
/// *Your 17.5 answer goes here*
sub2.send(completion: .finished)
/// *Your Problem 17.5 stops here*
r4 == [1,2,3,3]

/*:
### Problem 18
 Using the techniques demonstrated in class:
 
 1. make z1 and z2 into publishers
 1. make cz be an AnyCancellable of a Zip publisher which:
 
    - zips z1 and z2 together
    - maps the first value to twice its input and the second to uppercase
 
 1. Attach a sink which sets rz to be the most recent value
 
 Your answer may use no more 3 lines
 */

var rz = (0, "")
let z1 = [1, 2, 3, 4, 5]
let z2 = ["a", "b", "c", "d"]

/// *Your problem 18 code replaces the line below*
let cz = z1.publisher.map{$0 * 2}.zip(
    z2.publisher.map{$0.uppercased()})
    .sink { rz = $0 }

/// *Your Problem 18 stops here*
rz == (8, "D")

/*:
### Problem 19
 Using the techniques demonstrated in class, write a timer which:
 
 1. makes the variable `cancellable` its cancellable
 1. publishes every 2 seconds on the main thread in common mode
 1. autoconnects when subscribed
 
 Attach a sink which:
 
 1. increments `timesFired`,
 1. prints the number of times fired and the current time,
 1. cancels the timer after 5 fires, and
 1. prints "Cancelled"  when it cancels.
 
 Your answer may use no more 12 lines
 */
var timesFired = 0
var cancellable: AnyCancellable?
/// *Your Problem 19 starts here*
/// This works when coped to learn-swift playground, but for some reason does not work here
cancellable = Timer
    .publish(every: 2, on: .main, in: .common)
    .autoconnect()
    .output(in: 0 ..< 5)
    .sink { time in
        timesFired += 1
        print("Times Fired: \(timesFired). Time: \(time)")
    }
DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
    print("Cancelled")
    cancellable?.cancel()
    cancellable = .none
}


/// *Your Problem 19 stops here*

/*:
 _The following data types, values and functions are used in Problem 20_
 */
struct Configuration: Codable, Equatable {
    public let title : String
    private let contents: [[Int]]

    public init(title: String, contents: [[Int]]) throws {
        self.title = title
        self.contents = contents
    }
}

let urlString = "https://www.dropbox.com/s/i4gp5ih4tfq3bve/S65g.json?dl=1"
let url = URL(string: urlString)!
let decoder = JSONDecoder()

enum APIError: Error {
    case urlError(URLError)
    case badResponse
    case badResponseStatus(Int)
    case unknownFetchError(Error)
    case corruptData(DecodingError)
    case otherJSONError(Error)
}

extension URL {
    func fetchedAsync() async -> Result<(Data?, URLResponse?), Error> {
        do {
            return .success(try await URLSession.shared.data(from: self))
        } catch {
            return .failure(error)
        }
    }
}

extension Result where Failure == Never {
    var value: Success {
        try! get()
    }
}

extension Result where Success == Data {
    func decode<T: Decodable>(_ type: T.Type, decoder: JSONDecoder) -> Result<T, Error> {
        switch self {
            case let .success(data):
                do {
                    return .success(try decoder.decode(T.self, from: data))
                }
                catch {
                    return .failure(error)
                }

            case let .failure(error):
                return .failure(error)
        }
    }
}

extension Result {
    func replace(with value: Success) -> Result<Success, Never> {
        switch self {
            case let .success(current):
                return .success(current)
            case .failure:
                return .success(value)
        }
    }
}

func dataFromResponse(data: Data?, response: URLResponse?) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.badResponse
    }
    guard httpResponse.statusCode == 200 else {
        throw APIError.badResponseStatus(httpResponse.statusCode)
    }
    return data ?? Data()
}

func resultFromResponse(
    arg: (data: Data?, response: URLResponse?)
) -> Result<Data, Error> {
    Result {
        try dataFromResponse(data: arg.data, response: arg.response)
    }
}

func verifyResponse(_ error: Error) -> APIError {
    guard let apiError = error as? APIError else {
        return APIError.unknownFetchError(error)
    }
    return apiError
}

func verifyJSON(_ error: Error) -> APIError {
    guard let decodingError = error as? DecodingError else {
        return .otherJSONError(error)
    }
    return .corruptData(decodingError)
}

/*:
### Problem 20
 Using the techniques shown in class and the code provided immediately above, inside the task below, asynchronously:

 1. fetch the contents of `url` into a Result object
 1. from the contents of that Result generate another Result using `resultFromResponse` (Hint: you will want to use `flatMap`)
 1. map the error type of that Result to an APIError
 1. if successful, decode that Result to an array of Configuration objects
 1. map any errors from the decode step using `verifyJSON`
 1. if unsuccessful with any of the above replace the failure
    with an empty array of Configuration objects
 1. set concurrencyResult to be the value of the above chain of operations
    using the `value` variable provided above.

 You should use separate variables (points) during development,
 but when you are complete, all operations should part of a single chain.
 All uses of Higher Order Functions should be in point-free form.
 An error anywhere along the chain should fall through to the bottom.

 To be clear, the goal here is to fetch a JSON file from the internet,
 handle any errors that may result from the fetch, if successful,
 decode the fetched value, handle any errors from that and provide
 a specific type generated from the fetched data.

 This is _very_ standard in almost any app that you will write.
 */
var concurrencyResult: [Configuration] = []
let task: Task<Void, Error> = Task.init {
    /// *Your Problem 20 code goes here*

    /// Your Problem 20 code stops here
    DispatchQueue.main.async {
        print(concurrencyResult)
    }
}
