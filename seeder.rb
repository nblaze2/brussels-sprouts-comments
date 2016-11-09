require 'pg'
require 'pry'
require 'faker'

TITLES = ["Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end




TITLES.each do |recipe|
  db_connection do |conn|
    recp_id = ""
    conn.exec_params(
      'INSERT INTO recipes (name) VALUES($1)', [recipe]
    )
    recp_id = conn.exec_params(
      'SELECT id FROM recipes WHERE name=$1', [recipe]
    )

    recipe_id = recp_id[0]["id"]

    n = rand(1..3)
    comments = Faker::Hipster.sentences(n)
    conn.exec_params(
      'INSERT INTO comments (recipe_id, comments, num_of_comments) VALUES($1, $2, $3)', [recipe_id, comments, comments.count]
    )
    end
end

# Answers to Instruction Questions #5, 7-11
  # 5. (Displays table as designed) SELECT cid, name, comments  FROM recipes JOIN comments ON (id=recipe_id);
  # 7. SELECT COUNT(name) FROM recipes;
  # 8. SELECT SUM(num_of_comments) FROM comments;
  # 9. SELECT name, num_of_comments  FROM recipes JOIN comments ON (id=recipe_id);
  #10. SELECT name FROM recipes JOIN comments ON (id=recipe_id) WHERE comments = "<insert comment here>";
  #11. INSERT INTO recipes (name) VALUES('Brussels Sprouts with Goat Cheese');
      # hipster_comments = Faker::Hipster.sentences(2)
      # INSERT INTO comments (comments) VALUES(hipster_comments) WHERE name = 'Brussels Sprouts with Goat Cheese';
