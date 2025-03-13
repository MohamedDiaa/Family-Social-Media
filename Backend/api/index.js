import express from 'express';
import { addPhoto, getPhotos} from './src/photos.js';

const app = express();

const PORT = 3333;

app.use(express.json());

app.get('/photos', getPhotos);

app.post('/photo', addPhoto);

app.listen(PORT, ()=> {

    console.log(`Server is running on port ${PORT}`);
});