import ballerina.net.http;

service<http> sample {

    @http:resourceConfig {
        methods:["GET"],
        path:"/path/{foo}"
    }
    @Description {value:"PathParam and QueryParam extract values from the request URI."}
    resource params (http:Connection conn, http:InRequest req, string foo) {
        // Get QueryParam.
        map params = req.getQueryParams();
        var bar, _ = (string)params.bar;

        // Get Matrix params
        map pathMParams = req.getMatrixParams("/sample/path");
        var a, _ = (string)pathMParams.a;
        var b, _ = (string)pathMParams.b;
        string pathMatrixStr = string `a={{a}}, b={{b}}`;
        map fooMParams = req.getMatrixParams("/sample/path/" + foo);
        var x, _ = (string)fooMParams.x;
        var y, _ = (string)fooMParams.y;
        string fooMatrixStr = string `x={{x}}, y={{y}}`;
        json matrixJson = {"path":pathMatrixStr, "foo":fooMatrixStr};

        // Create json payload with the extracted values.
        json responseJson = {"pathParam":foo, "queryParam":bar, "matrix":matrixJson};
        http:OutResponse res = {};
        // A util method to set the json payload to the response message.
        res.setJsonPayload(responseJson);
        // Send a response to the client.
        _ = conn.respond(res);
    }
}