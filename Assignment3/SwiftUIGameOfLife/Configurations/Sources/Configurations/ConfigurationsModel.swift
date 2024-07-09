//
//  Configuration.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import Foundation
import ComposableArchitecture
import Combine
import Dispatch
import GameOfLife
import Configuration

// MARK: API Support
private let configURL = URL(string: "https://www.dropbox.com/s/i4gp5ih4tfq3bve/S65g.json?dl=1")!

enum APIError: Error {
    case urlError(URL, URLError)
    case badResponse(URL, URLResponse)
    case badResponseStatus(URL, HTTPURLResponse)
    case jsonDecodingError(URL, Error, String)
}

class DefaultHandlingSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        completionHandler(.performDefaultHandling, .none)
    }
}

// MARK: ConfigurationsState
public struct ConfigurationsState {
    public var configs: IdentifiedArrayOf<ConfigurationState> = []
    public var isFetching = false

    public init(
        configs: IdentifiedArrayOf<ConfigurationState> = [],
        fetchCancellable: AnyCancellable? = nil
    ) {
        self.configs = configs
    }

    static var session: URLSession {
        URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: DefaultHandlingSessionDelegate(),
            delegateQueue: .none
        )
    }

    static func validateHttpResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badResponse(configURL, response)
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.badResponseStatus(configURL, httpResponse)
        }
        return data
    }
}

extension ConfigurationsState: Equatable { }
extension ConfigurationsState: Codable { }

public extension ConfigurationsState {
    enum Action {
        case setConfigs(IdentifiedArrayOf<ConfigurationState>)
        case configuration(id: UUID, action: ConfigurationState.Action)
        case fetch
        case cancelFetch
        case clear
    }
    
    enum Identifiers: Hashable {
        case fetchCancellable
    }
}

public struct ConfigurationsEnvironment {
    public private(set) var configurationEnvironment = ConfigurationEnvironment()

    public init(configurationEnvironment: ConfigurationEnvironment = ConfigurationEnvironment()) {
        self.configurationEnvironment = configurationEnvironment
    }
}

public let configurationsReducer = Reducer<ConfigurationsState, ConfigurationsState.Action, ConfigurationsEnvironment>.combine(
    configurationReducer.forEach(
        state: \ConfigurationsState.configs,
        action: /ConfigurationsState.Action.configuration(id:action:),
        environment: \.configurationEnvironment
    ),
    Reducer<ConfigurationsState, ConfigurationsState.Action, ConfigurationsEnvironment> { state, action, env in
        switch action {
        case .setConfigs(let configs):
            state.configs = configs
            return .none
        case .configuration(id: let index, action: let action):
            return .none
        case .fetch:
            state.isFetching = true
            state.configs = []
            return ConfigurationsState.session
                .dataTaskPublisher(for: configURL)
                .mapError { (error: URLError) -> APIError in
                        return APIError.urlError(configURL, error)
                    }
                .tryMap(ConfigurationsState.validateHttpResponse)
                .decode(type: [Grid.Configuration].self, decoder: JSONDecoder())
                .replaceError(with: [Grid.Configuration]())
                .map{ConfigurationsState.Action.setConfigs(.init(uniqueElements:  $0.map(ConfigurationState.init)))}
                .receive(on: DispatchQueue.main)
                .eraseToEffect()
                .cancellable(id: ConfigurationsState.Identifiers.fetchCancellable)
        case .cancelFetch:
            state.isFetching = false
            return Effect.cancel(id: ConfigurationsState.Identifiers.fetchCancellable)
        case .clear:
            state.isFetching = false
            state.configs = []
            return Effect.cancel(id: ConfigurationsState.Identifiers.fetchCancellable)
        }
    }
)
