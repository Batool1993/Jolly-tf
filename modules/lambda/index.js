const AWS = require("aws-sdk")
const dynamo= new AWS.DynamoDB.DocumentClient()
const cognitoId = event.requestContext.authorizer.claims['cognito:username'];
console.log("claims:", event.requestContext.authorizer.claims['cognito:username']);


exports.handler = async(event,context) => {
    console.log('event' + JSON.stringify(event));

    let body;
    let statusCode=200;
    const headers = {
        "Content-Type": "application/json",
         "Access-Control-Allow-Origin": "*"
        
      };
      try {
        let route = event.httpMethod + " " + event.resource;
        let requestJSON;
        console.log("route : " + route)
        switch (route) {
          
          
          
          
                case "GET /doctors/{doctorid}":
           
            body = await dynamo.get({
                TableName: "jolly-doctors",
                Key:{
              id : event.pathParameters.doctorid
            },
              })
              .promise();
            break;
        
    
            
                case "GET /doctors":
            
              //console.log(event.pathParameters.id, "in get")
               body = await dynamo.scan({
                TableName: "jolly-doctors",
                FilterExpression: "#userId = :cognitoId",
                ExpressionAttributeNames:{
                   "#userId": "userId"
                 },
                ExpressionAttributeValues: {
                   ":cognitoId": cognitoId
                }
               
              })
              .promise();
              
              break;
    
                 case "POST /doctors" :
              requestJSON = JSON.parse(event.body);
              console.log("requestJSON" + JSON.stringify(requestJSON));
              requestJSON.id =  context.awsRequestId;
              //requestJSON.id =  event.pathParameters.doctorid;
              console.log(JSON.stringify(event))
              await dynamo
                .put({
                  TableName: "jolly-doctors",
                  Item: {
                    id: requestJSON.id,
                    name: requestJSON.name}
                })
                .promise();
              body = `created doctor `;
              break;
              
                    case "PUT /doctors/{doctorid}":
              requestJSON = JSON.parse(event.body);
              console.log("requestJSON" + JSON.stringify(requestJSON));
              
              await dynamo
                .update({
                  TableName: "jolly-doctors",
                   Key:{
              id : event.pathParameters.doctorid
            },
              UpdateExpression: "set #name=:w",
              
              ExpressionAttributeValues: {
                  ":w": requestJSON.name,
               
                
                
              },
          
              ExpressionAttributeNames: {"#name": "name"}
                 })
                .promise();
              body = `updated  doctor`;
              break;
              
               case "DELETE /doctors/{doctorid}":
            await dynamo
              .delete({
                TableName: "jolly-doctors",
                Key: {
                  id: event.pathParameters.doctorid
                }
              })
              .promise();
            body = `Deleted  doctor`;
            break;

            case "GET /patients/{patientId}":
           
              body = await dynamo.get({
                  TableName: "jolly-patients",
                  Key:{
                id : event.pathParameters.patientId
              },
                })
                .promise();
              break;
          
      
              
                  case "GET /patients":
              
                //console.log(event.pathParameters.id, "in get")
                 body = await dynamo.scan({
                  TableName: "jolly-patients",
                  FilterExpression: "#userId = :cognitoId",
                  ExpressionAttributeNames:{
                     "#userId": "userId"
                   },
                  ExpressionAttributeValues: {
                     ":cognitoId": cognitoId
                  }
                 
                })
                .promise();
                
                break;
      
                   case "POST /patients" :
                requestJSON = JSON.parse(event.body);
                console.log("requestJSON" + JSON.stringify(requestJSON));
                requestJSON.id =  context.awsRequestId;
                //requestJSON.id =  event.pathParameters.doctorid;
                console.log(JSON.stringify(event))
                await dynamo
                  .put({
                    TableName: "jolly-patients",
                    Item: {
                      id: requestJSON.id,
                      name: requestJSON.name}
                  })
                  .promise();
                body = `created patient `;
                break;
                
                      case "PUT /patients/{patientId}":
                requestJSON = JSON.parse(event.body);
                console.log("requestJSON" + JSON.stringify(requestJSON));
                
                await dynamo
                  .update({
                    TableName: "jolly-patients",
                     Key:{
                id : event.pathParameters.patientId
              },
                UpdateExpression: "set #name=:w",
                
                ExpressionAttributeValues: {
                    ":w": requestJSON.name,
                 
                  
                  
                },
            
                ExpressionAttributeNames: {"#name": "name"}
                   })
                  .promise();
                body = `updated  patient`;
                break;
                
                 case "DELETE /patients/{patientId}":
              await dynamo
                .delete({
                  TableName: "jolly-patients",
                  Key: {
                    id: event.pathParameters.patientId
                  }
                })
                .promise();
              body = `Deleted  patient`;
              break;

              case "GET /appointments/{appointmentId}":
           
                body = await dynamo.get({
                    TableName: "jolly-appointments",
                    Key:{
                  id : event.pathParameters.appointmentId
                },
                  })
                  .promise();
                break;
            
        
                
                    case "GET /appointments":
                
                  //console.log(event.pathParameters.id, "in get")
                   body = await dynamo.scan({
                    TableName: "jolly-appointments",
                    FilterExpression: "#userId = :cognitoId",
                    ExpressionAttributeNames:{
                       "#userId": "userId"
                     },
                    ExpressionAttributeValues: {
                       ":cognitoId": cognitoId
                    }
                   
                   
                  })
                  .promise();
                  
                  break;
        
                     case "POST /appointments" :
                  requestJSON = JSON.parse(event.body);
                  console.log("requestJSON" + JSON.stringify(requestJSON));
                  requestJSON.id =  context.awsRequestId;
                  //requestJSON.id =  event.pathParameters.doctorid;
                  console.log(JSON.stringify(event))
                  await dynamo
                    .put({
                      TableName: "jolly-appointments",
                      Item: {
                        id: requestJSON.id,
                        doctorName: requestJSON.doctorName,
                        patientName: requestJSON.patientName
                        
                      }
                    })
                    .promise();
                  body = `created appointment `;
                  break;
                  
                        case "PUT /appointments/{appointmentId}":
                  requestJSON = JSON.parse(event.body);
                  console.log("requestJSON" + JSON.stringify(requestJSON));
                  
                  await dynamo
                    .update({
                      TableName: "jolly-appointments",
                       Key:{
                  id : event.pathParameters.appointmentId
                },
                  UpdateExpression: "set doctorName=:w, patientName=:a",
                  
                  ExpressionAttributeValues: {
                      ":w": requestJSON.doctorName,
                      ":a": requestJSON.patientName,
                   
                    
                    
                  },
              
                  //ExpressionAttributeNames: {"#patientName": "patientName"}
                     })
                    .promise();
                  body = `updated  patient`;
                  break;
                  
                   case "DELETE /appointments/{appointmentId}":
                await dynamo
                  .delete({
                    TableName: "jolly-appointments",
                    Key: {
                      id: event.pathParameters.appointmentId
                    }
                  })
                  .promise();
                body = `Deleted  appointment`;
                break;
            
          default:
            throw new Error(`Unsupported route: "${event.routeKey}"`);
        }
      } catch (err) {
        console.log(err);
        statusCode = 500;
        body = err.message;
      } finally {
        body = JSON.stringify(body);
      }
    
      return {
        statusCode,
        body,
        headers
        
      };
    };
