import ballerina.io;
import ballerina.mime;
import ballerina.net.http;

@http:configuration {basePath:"/foo"}
service<http> echo {
    @http:resourceConfig {
        methods:["POST"],
        path:"/receivableParts"
    }
    resource echo (http:Connection conn, http:InRequest req) {
        //Extract multiparts from the inbound request
        mime:Entity[] bodyParts = req.getMultiparts();
        int i = 0;

        println("CONTENT TYPE OF TOP LEVEL ENTITY > " + req.getHeader("Content-Type"));
        //Loop through body parts
        while (i < lengthof bodyParts) {
            mime:Entity part = bodyParts[i];
<<<<<<< HEAD
            println("============================PART "+ i +"================================");
            println("---------Content Type-------");
            println(part.contentType.toString());
            println("------------Part Name-------");
            println(part.contentDisposition.name);
            println("------Body Part Content-----");
=======
            io:println("-----------------------------");
            io:print("Content Type : ");
            io:println(part.contentType.toString());
            io:println("-----------------------------");
>>>>>>> Update ballerina-by-examples with builtin changes.
            handleContent(part);
            i = i + 1;
        }
        http:OutResponse res = {};
        res.setStringPayload("Multiparts Received!");
        _ = conn.respond(res);
    }
}

function handleContent (mime:Entity bodyPart) {
    string contentType = bodyPart.contentType.toString();
    if (mime:APPLICATION_XML == contentType || mime:TEXT_XML == contentType) {
<<<<<<< HEAD
        //Extract xml data from body part and print
        println(bodyPart.getXml());
    } else if (mime:APPLICATION_JSON == contentType) {
        //Extract json data from body part and print
        println(bodyPart.getJson());
    } else if (mime:TEXT_PLAIN == contentType){
        //Extract text data from body part and print
        println(bodyPart.getText());
    } else if ("application/vnd.ms-powerpoint" == contentType) {
        //Get a byte channel from body part and write content to a file
        writeToFile(bodyPart.getByteChannel());
        println("Content saved to file");
=======
        //Given a body part get it's xml content and io:print
        io:println(mime:getXml(bodyPart));
    } else if (mime:APPLICATION_JSON == contentType) {
        //Given a body part get it's json content and io:print
        io:println(mime:getJson(bodyPart));
    } else if (mime:TEXT_PLAIN == contentType){
        //Given a body part get it's text content and io:print
        io:println(mime:getText(bodyPart));
    } else if ("application/vnd.ms-powerpoint" == contentType) {
        //Given a body part get it's content as a blob and write it to a file
        writeToFile(mime:getBlob(bodyPart));
        io:println("Content saved to file");
>>>>>>> Update ballerina-by-examples with builtin changes.
    }
}

function writeToFile(io:ByteChannel byteChannel) {
    string dstFilePath = "./files/savedFile.ppt";
    io:ByteChannel destinationChannel = getByteChannel(dstFilePath, "w");
    blob readContent;
    int numberOfBytesRead;
    readContent,numberOfBytesRead = byteChannel.readAllBytes();
    int numberOfBytesWritten = destinationChannel.writeBytes(readContent, 0);
}

function getByteChannel (string filePath, string permission) (io:ByteChannel) {
    io:ByteChannel channel = io:openFile(filePath, permission);
    return channel;
}
