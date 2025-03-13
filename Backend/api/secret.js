
const userName = `mdUser`;
const userPassword = `mdUserPassword`;

//"mongodb+srv://mdUser:<db_password>@cluster0.o5927.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

 const connectString = `mongodb+srv://${userName}:${userPassword}@cluster0.o5927.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`

 export const uri = connectString;