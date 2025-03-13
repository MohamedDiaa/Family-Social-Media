import { client } from './dbconnect.js';


export async function getPhotos(req, res) {
    try {
      await client.connect();
  
       const db = client.db("SocialMedia");
       const collectionName = db.collection("PhotoInfo")
       
       const result = await collectionName.find().toArray();
       res.json(result);
  
    } finally {
      await client.close();
    }
  }
  
  export async function addPhoto(req, res) {
    try {
      const photoInfo = req.body;
      console.log(photoInfo);
  
      await client.connect();
  
      const db = client.db("SocialMedia");
      const collectionName = db.collection("PhotoInfo")
  
      const result =  await collectionName.insertOne(photoInfo);
      
      console.log(
           `A document was inserted with the _id: ${result.insertedId}`,
      )
      res.json(result);
  
    } finally {
      await client.close();
    }
  }
  