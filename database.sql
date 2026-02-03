-- Crear base de datos
CREATE DATABASE IF NOT EXISTS cine_app;

-- Usar la base de datos
USE cine_app;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de películas
CREATE TABLE IF NOT EXISTS movies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  image_url VARCHAR(500),
  release_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de asientos o reservas (ejemplo)
CREATE TABLE IF NOT EXISTS reservations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  movie_id INT,
  seats VARCHAR(255),
  showtime DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (movie_id) REFERENCES movies(id)
);

-- Inserciones de ejemplo en la tabla movies (posters + descripción)
INSERT INTO movies (title, description, image_url, release_date) VALUES
('Inception',
 'Dom Cobb es un extractor: su trabajo consiste en robar secretos del subconsciente durante el sueño. Le ofrecen una oportunidad para redimirse: implantar una idea en la mente de alguien. Una película de suspense y ciencia ficción dirigida por Christopher Nolan.',
 'https://play-lh.googleusercontent.com/buKf27Hxendp3tLNpNtP3E-amP0o4yYV-SGKyS2u-Y3GdGRTyfNCIT5WAVs2OudOz6so5K1jtYdAUKI9nw8',
 '2010-07-16'),

('El Padrino',
 'La saga de la familia Corleone, una historia sobre poder, lealtades y crimen organizado en Estados Unidos. Considerada una de las mejores películas de la historia.',
 'https://www.extremadura.com/uploads/event/event/poster/5776255f6c6f6306ae000200/normal_cine-el-padrino-en-badajoz.jpg',
 '1972-03-24'),

('El viaje de Chihiro',
 'Una niña llamada Chihiro queda atrapada en un mundo mágico de espíritus y dioses. Para salvar a sus padres y volver a casa debe trabajar en una extraña casa de baños. Animación de Studio Ghibli dirigida por Hayao Miyazaki.',
 'https://m.media-amazon.com/images/M/MV5BMWI1OTdjN2EtOGUxYy00ZDBmLWFlNzAtNmRkZjhiMTIzOTNhXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
 '2001-07-20'),

('Parásitos',
 'Una familia de clase baja se infiltra poco a poco en la vida de una familia adinerada con consecuencias inesperadas. Thriller social surcoreano ganador del Óscar.',
 'https://es.web.img3.acsta.net/pictures/19/09/17/17/13/3740579.jpg',
 '2019-05-30'),

('Interestelar',
 'Un equipo de exploradores viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad. Ciencia ficción épica de Christopher Nolan con fuerte carga emocional.',
 'https://m.media-amazon.com/images/S/pv-target-images/79194981293eabf6620ece96eb5a9c1fffa04d3374ae12986e0748800b37b9cf.jpg',
 '2014-11-07'),

('La La Land',
 'Un músico de jazz y una aspirante a actriz persiguen sus sueños en Los Ángeles, entre romance, música y decisiones difíciles sobre la carrera y el amor.',
 'https://pics.filmaffinity.com/La_ciudad_de_las_estrellas_La_La_Land-133356261-large.jpg',
 '2016-12-09'),

('Toy Story',
 'Las aventuras de los juguetes que cobran vida cuando los humanos no están presentes. Una emotiva y divertida película de animación que revolucionó el cine por ordenador.',
 'https://hips.hearstapps.com/hmg-prod/images/toy-story-4-poster-1543427531.jpg',
 '1995-11-22'),

('Blade Runner 2049',
 'Un joven blade runner desentierra un secreto que podría sumergir lo que queda de la sociedad en el caos. Ciencia ficción visualmente impresionante.',
 'https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_FMjpg_UX1000_.jpg',
 '2017-10-06');

-- Desactivar modo seguro temporalmente
SET SQL_SAFE_UPDATES = 0;

-- Actualizar las URLs
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg' WHERE title LIKE '%Inception%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg' WHERE title LIKE '%Padrino%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg' WHERE title LIKE '%Chihiro%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg' WHERE title LIKE '%Parásitos%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg' WHERE title LIKE '%Interestelar%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg' WHERE title LIKE '%La La Land%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg' WHERE title LIKE '%Blade Runner%';
UPDATE movies SET image_url = 'https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg' WHERE title LIKE '%Toy Story%';

-- Reactivar modo seguro
SET SQL_SAFE_UPDATES = 1;

-- Verificar los cambios
SELECT id, title, image_url FROM movies;

-- Añadir dos películas más a la base de datos
INSERT INTO movies (title, description, image_url, release_date) VALUES
('El Señor de los Anillos: El Retorno del Rey', 'Gandalf y Aragorn lideran el Mundo de los Hombres contra el ejército de Sauron para distraer su mirada de Frodo y Sam mientras se acercan al Monte del Destino con el Anillo Único.', 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', '2003-12-17'),
('Seven', 'Dos detectives, un novato y un veterano, cazan a un asesino en serie que usa los siete pecados capitales como motivo para sus asesinatos.', 'https://image.tmdb.org/t/p/w500/6yoghtyTpznpBik8EngEmJskVUO.jpg', '1995-09-22');

-- Verificar que se agregaron
SELECT id, title, image_url FROM movies ORDER BY id DESC LIMIT 2;
