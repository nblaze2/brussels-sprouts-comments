DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS recipes;

CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
  -- ingredients VARCHAR(255)?
);

CREATE TABLE comments (
  cid SERIAL PRIMARY KEY,
  recipe_id INT REFERENCES recipes(id),
  comments VARCHAR(255),
  num_of_comments INT
);
