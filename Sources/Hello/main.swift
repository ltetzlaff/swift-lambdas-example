import AWSLambdaRuntime
import HTTPLambda

Lambda.run(HTTPLambda { _,_ in
    .init(statusCode: .ok, body: "👋")
})
