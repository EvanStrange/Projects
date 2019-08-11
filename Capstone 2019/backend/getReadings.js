const AWS = require("aws-sdk")

AWS.config.update({
    region: "us-east-1",
    accessKeyId: "",
    secretAccessKey: ""
})

const getReadings = () => {
    const dynamoDB = new AWS.DynamoDB.DocumentClient()
    let readings
    const params = {
        TableName: 'Flowr'
    }
    
    dynamoDB.scan(params, function(err,data){
        if(err) console.log(err)
        else {
            readings = data
            console.log(data)
        }
    })
    return readings
}

getReadings()

