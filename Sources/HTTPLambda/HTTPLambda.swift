import AWSLambdaEvents
import AWSLambdaRuntime
import NIO

public struct HTTPLambda: EventLoopLambdaHandler {
    public typealias In = APIGateway.V2.Request
    public typealias Out = APIGateway.V2.Response

    public func handle(context: Lambda.Context, event: In) -> EventLoopFuture<Out> {
        execute(context, event)
    }

    public let execute: (_ context: Lambda.Context, _ event: In) -> EventLoopFuture<Out>
}

public extension HTTPLambda {
    init(
        _ callback: @escaping (_ context: Lambda.Context, _ event: In) -> EventLoopFuture<Out>
    ) {
        execute = callback
    }

    init(
        _ callback: @escaping (_ context: Lambda.Context, _ event: In) -> Out
    ) {
        self.init(execute: { context, event in
            let result = callback(context, event)
            return context.eventLoop.makeSucceededFuture(result)
        })
    }
}
