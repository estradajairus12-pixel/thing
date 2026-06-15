-- Quiz System LocalScript
-- Place inside StarterPlayerScripts or run via console

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Bump this every time you change the script so you can tell what's running in-game.
local VERSION = "2.1"
local VERSION_DATE = "2026-06-14"
local VERSION_NOTE = "Starting quiz name notification added!"

-- =============================================
-- QUIZZES
-- =============================================
local Quizzes = {
    {
        name = "Test Quiz",
        questions = {
            { question = "What is the capital of France?",        answers = { "A) London", "B) Paris", "C) Rome", "D) Berlin" },     correct = "B" },
            { question = "What is 2 + 2?",                        answers = { "A) 3", "B) 5", "C) 4", "D) 22" },                    correct = "C" },
            { question = "What color is the sky?",                answers = { "A) Green", "B) Red", "C) Purple", "D) Blue" },        correct = "D" },
        }
    },
    {
        name = "Banana Quiz",
        questions = {
            { question = "What color is a ripe banana?",          answers = { "A) Red", "B) Blue", "C) Yellow", "D) Green" },        correct = "C" },
            { question = "Bananas grow on which type of plant?",   answers = { "A) Tree", "B) Vine", "C) Shrub", "D) Herb" },         correct = "D" },
            { question = "Which country produces the most bananas?", answers = { "A) Brazil", "B) India", "C) Philippines", "D) Ecuador" }, correct = "B" },
            { question = "What is the edible inside of a banana called?", answers = { "A) Pulp", "B) Core", "C) Flesh", "D) Seed" }, correct = "C" },
        }
    },
    {
        name = "Water Quiz",
        questions = {
            { question = "What is the chemical formula for water?",                answers = { "A) HO2", "B) H2O", "C) H3O", "D) OH2" },         correct = "B" },
            { question = "At what Celsius does water boil at sea level?",          answers = { "A) 90", "B) 110", "C) 85", "D) 100" },            correct = "D" },
            { question = "What percent of Earth's surface is covered by water?",   answers = { "A) 51%", "B) 61%", "C) 71%", "D) 81%" },          correct = "C" },
            { question = "Which state of water is the least dense?",               answers = { "A) Liquid", "B) Solid", "C) Gas", "D) Plasma" },   correct = "B" },
        }
    },
    {
        name = "Existence of Life Quiz",
        questions = {
            { question = "How old is life on Earth estimated to be?",              answers = { "A) 1 billion yrs", "B) 2 billion yrs", "C) 3.5 billion yrs", "D) 5 billion yrs" }, correct = "C" },
            { question = "What is the smallest unit of life?",                     answers = { "A) Atom", "B) Cell", "C) Molecule", "D) Organ" },   correct = "B" },
            { question = "Which molecule carries genetic info in living things?",   answers = { "A) ATP", "B) RNA", "C) DNA", "D) ADP" },            correct = "C" },
            { question = "What are life forms that survive extreme conditions?",    answers = { "A) Megaforms", "B) Extremophiles", "C) Parasites", "D) Archeons" }, correct = "B" },
            { question = "Which planet is studied most for signs of past life?",   answers = { "A) Venus", "B) Jupiter", "C) Mars", "D) Europa" },   correct = "C" },
        }
    },
    {
        name = "Block Tales Quiz",
        questions = {
            { question = "What is the main goal in Block Tales?",                    answers = { "A) Build a castle", "B) Retrieve 7 SFOTH swords to save Builderman", "C) Defeat 100 enemies", "D) Find treasure" }, correct = "B" },
            { question = "Which sword do you obtain in Chapter 1?",                  answers = { "A) Venomshank", "B) Firebrand", "C) Ice Dagger", "D) Ghostwalker" }, correct = "C" },
            { question = "Who is the final boss of Chapter 1?",                      answers = { "A) Supreme Ant", "B) Cruel King", "C) Noobador", "D) Sentient Statue" }, correct = "B" },
            { question = "What does HP stand for in Block Tales?",                   answers = { "A) Health Power", "B) Heart Points", "C) Hit Points", "D) Healing Power" }, correct = "B" },
            { question = "Which boss is found in the Prologue?",                     answers = { "A) Red & Blue Noobs", "B) Griefer", "C) Turkey", "D) Finn McCool" }, correct = "A" },
            { question = "What sword is obtained in Chapter 2?",                     answers = { "A) Ice Dagger", "B) Windforce", "C) Venomshank", "D) Firebrand" }, correct = "C" },
            { question = "Who tasks you with retrieving the swords?",                answers = { "A) Builderman", "B) Shedletsky", "C) Tutorial Terry", "D) Matt Dusek" }, correct = "B" },
            { question = "What is the final boss of Chapter 2?",                     answers = { "A) Komodo Dragon", "B) Bigfoot", "C) Bubonic Plant", "D) Supreme Mosquito" }, correct = "C" },
            { question = "Which chapter takes place in a haunted manor?",            answers = { "A) Chapter 1", "B) Chapter 2", "C) Chapter 3", "D) Chapter 4" }, correct = "C" },
            { question = "What sword do you get in Chapter 3?",                      answers = { "A) Ghostwalker", "B) Ice Dagger", "C) Firebrand", "D) Windforce" }, correct = "A" },
            { question = "What does SP stand for?",                                  answers = { "A) Special Power", "B) Speed Points", "C) Special Points", "D) Skill Points" }, correct = "C" },
            { question = "Who is the boss of the Ancient Tomb in Chapter 4?",        answers = { "A) The Ancients", "B) The Great Floccinaucinihilipilification", "C) Captain Trotter", "D) Temple Guardian" }, correct = "B" },
            { question = "What sword is obtained in Chapter 4?",                     answers = { "A) Venomshank", "B) Ghostwalker", "C) Firebrand", "D) Ice Dagger" }, correct = "C" },
            { question = "What is the name of the final boss in Chapter 5?",         answers = { "A) Reginald", "B) Frostmaw", "C) Arg'il", "D) The Trinity" }, correct = "C" },
            { question = "Which sword is obtained in Chapter 5?",                    answers = { "A) Firebrand", "B) Windforce", "C) Ghostwalker", "D) Venomshank" }, correct = "B" },
            { question = "What does BP stand for in the card system?",               answers = { "A) Battle Points", "B) Build Points", "C) Bonus Points", "D) Block Points" }, correct = "B" },
            { question = "What is the name of the Dream World boss representing greed?", answers = { "A) Fear", "B) Hatred", "C) Solitude", "D) Greed" }, correct = "D" },
            { question = "Which enemy type is found in Roblox HQ during the Prologue?", answers = { "A) Nooblet", "B) Zombie", "C) Bandit", "D) Pirate" }, correct = "A" },
            { question = "What currency is used alongside BUX in Block Tales?",      answers = { "A) Gold", "B) TIX", "C) Coins", "D) Cash" }, correct = "B" },
            { question = "Who is the pirate captain in Chapter 4?",                  answers = { "A) Calypso", "B) Captain Trotter", "C) Finn McCool", "D) The Ancients" }, correct = "B" },
        }
    },
    {
        name = "Animation vs Minecraft Quiz",
        questions = {
            { question = "When was Animation vs. Minecraft released?",               answers = { "A) 2014", "B) December 15, 2015", "C) 2016", "D) 2017" }, correct = "B" },
            { question = "Who is the main antagonist in the original AvM?",          answers = { "A) Steve", "B) Herobrine", "C) Notch", "D) Ender Dragon" }, correct = "B" },
            { question = "What does Red build to trap Blue?",                        answers = { "A) A cage", "B) A cobblestone wall", "C) TNT", "D) A pit" }, correct = "B" },
            { question = "What weapon does The Second Coming craft first?",          answers = { "A) Sword", "B) Pickaxe", "C) Bow", "D) Axe" }, correct = "B" },
            { question = "What structure does Green build in the beginning?",        answers = { "A) A house", "B) A windmill", "C) A tower", "D) A farm" }, correct = "B" },
            { question = "What does Herobrine possess to create the MegaStick?",     answers = { "A) Red", "B) Blue", "C) Green", "D) Yellow" }, correct = "A" },
            { question = "What material is the MegaStick made of?",                  answers = { "A) Wood", "B) Stone", "C) Cobblestone", "D) Obsidian" }, correct = "C" },
            { question = "What dimension do they enter without a portal?",           answers = { "A) The End", "B) The Nether", "C) SkyBlock", "D) Aether" }, correct = "B" },
            { question = "What item is used to recycle Minecraft?",                  answers = { "A) Trash Bin", "B) Recycle Bin", "C) Delete Button", "D) Destroy Command" }, correct = "B" },
            { question = "Who is the orange stick figure in Season 3?",              answers = { "A) Purple", "B) King Orange", "C) Gold", "D) Orange" }, correct = "B" },
            { question = "What episode features a building contest?",                answers = { "A) Episode 1", "B) Episode 2", "C) Episode 3", "D) Episode 4" }, correct = "B" },
            { question = "What mob attacks in Episode 9?",                           answers = { "A) Zombies", "B) Skeletons", "C) Villagers", "D) Creepers" }, correct = "C" },
            { question = "What is Episode 10 about?",                                answers = { "A) The Nether", "B) The End", "C) SkyBlock", "D) Villagers" }, correct = "B" },
            { question = "Who is King Orange's deceased son?",                       answers = { "A) Purple", "B) Yellow", "C) Gold", "D) Red" }, correct = "C" },
            { question = "What game do they play in Episode 36?",                    answers = { "A) SkyWars", "B) Bedwars", "C) PvP", "D) Build Battle" }, correct = "B" },
            { question = "What season features Hardcore mode?",                      answers = { "A) Season 3", "B) Season 4", "C) Season 5", "D) Season 1" }, correct = "C" },
            { question = "What creature stalks them in Season 5?",                   answers = { "A) The Warden", "B) The Creature", "C) Herobrine", "D) Ender Dragon" }, correct = "B" },
            { question = "What dimension is featured in Episode 39?",                answers = { "A) The Nether", "B) The End", "C) The Aether", "D) Far Lands" }, correct = "C" },
            { question = "Who are the enemies in Season 5?",                         answers = { "A) Mobs", "B) Armor Stands", "C) Players", "D) Villagers" }, correct = "B" },
            { question = "What is the longest episode in the series?",               answers = { "A) The King", "B) The Warden", "C) Hardcore Manhunt", "D) The Far Lands" }, correct = "A" },
        }
    },
    {
        name = "Test Quiz 2",
        questions = {
            { question = "What is the largest planet in our solar system?",          answers = { "A) Earth", "B) Mars", "C) Jupiter", "D) Saturn" }, correct = "C" },
            { question = "How many continents are there on Earth?",                  answers = { "A) 5", "B) 6", "C) 7", "D) 8" }, correct = "C" },
            { question = "What is the fastest land animal?",                         answers = { "A) Lion", "B) Cheetah", "C) Leopard", "D) Tiger" }, correct = "B" },
            { question = "What year did World War II end?",                          answers = { "A) 1943", "B) 1944", "C) 1945", "D) 1946" }, correct = "C" },
            { question = "What is the hardest natural substance on Earth?",          answers = { "A) Gold", "B) Iron", "C) Diamond", "D) Platinum" }, correct = "C" },
        }
    },
    {
        name = "Space Quiz",
        questions = {
            { question = "What is the closest star to Earth?",                       answers = { "A) Proxima Centauri", "B) The Sun", "C) Sirius", "D) Betelgeuse" }, correct = "B" },
            { question = "How many moons does Mars have?",                           answers = { "A) 0", "B) 1", "C) 2", "D) 3" }, correct = "C" },
            { question = "What is the hottest planet in our solar system?",          answers = { "A) Mercury", "B) Venus", "C) Mars", "D) Jupiter" }, correct = "B" },
            { question = "What galaxy is Earth located in?",                         answers = { "A) Andromeda", "B) Milky Way", "C) Triangulum", "D) Whirlpool" }, correct = "B" },
            { question = "What is the name of NASA's most famous space telescope?",  answers = { "A) James Webb", "B) Hubble", "C) Kepler", "D) Spitzer" }, correct = "B" },
        }
    },
    {
        name = "Geography Quiz",
        questions = {
            { question = "What is the longest river in the world?",                  answers = { "A) Amazon", "B) Nile", "C) Yangtze", "D) Mississippi" }, correct = "B" },
            { question = "Which country has the largest population?",                answers = { "A) India", "B) USA", "C) China", "D) Indonesia" }, correct = "A" },
            { question = "What is the smallest country in the world?",               answers = { "A) Monaco", "B) Vatican City", "C) San Marino", "D) Liechtenstein" }, correct = "B" },
            { question = "Which desert is the largest in the world?",                answers = { "A) Sahara", "B) Arabian", "C) Gobi", "D) Antarctic" }, correct = "D" },
            { question = "Mount Everest is located in which mountain range?",        answers = { "A) Alps", "B) Andes", "C) Himalayas", "D) Rockies" }, correct = "C" },
        }
    },
    {
        name = "Science Quiz",
        questions = {
            { question = "What is the atomic number of Carbon?",                     answers = { "A) 4", "B) 6", "C) 8", "D) 12" }, correct = "B" },
            { question = "What force keeps planets in orbit around the Sun?",        answers = { "A) Magnetism", "B) Gravity", "C) Friction", "D) Inertia" }, correct = "B" },
            { question = "What is the powerhouse of the cell?",                      answers = { "A) Nucleus", "B) Ribosome", "C) Mitochondria", "D) Cytoplasm" }, correct = "C" },
            { question = "What gas do plants absorb from the atmosphere?",           answers = { "A) Oxygen", "B) Nitrogen", "C) Carbon Dioxide", "D) Hydrogen" }, correct = "C" },
            { question = "What is the speed of light approximately?",                answers = { "A) 300,000 km/s", "B) 150,000 km/s", "C) 1,000,000 km/s", "D) 50,000 km/s" }, correct = "A" },
        }
    },
    {
        name = "History Quiz",
        questions = {
            { question = "Who was the first President of the United States?",        answers = { "A) Thomas Jefferson", "B) George Washington", "C) Abraham Lincoln", "D) John Adams" }, correct = "B" },
            { question = "In what year did the Titanic sink?",                       answers = { "A) 1910", "B) 1912", "C) 1914", "D) 1916" }, correct = "B" },
            { question = "Who painted the Mona Lisa?",                               answers = { "A) Michelangelo", "B) Raphael", "C) Leonardo da Vinci", "D) Donatello" }, correct = "C" },
            { question = "What ancient civilization built the pyramids?",            answers = { "A) Romans", "B) Greeks", "C) Egyptians", "D) Mayans" }, correct = "C" },
            { question = "Who discovered America in 1492?",                          answers = { "A) Vasco da Gama", "B) Christopher Columbus", "C) Ferdinand Magellan", "D) Amerigo Vespucci" }, correct = "B" },
        }
    },
    {
        name = "Sports Quiz",
        questions = {
            { question = "How many players are on a soccer team on the field?",      answers = { "A) 9", "B) 10", "C) 11", "D) 12" }, correct = "C" },
            { question = "In which sport would you perform a slam dunk?",            answers = { "A) Volleyball", "B) Basketball", "C) Tennis", "D) Baseball" }, correct = "B" },
            { question = "How long is a marathon?",                                  answers = { "A) 26.2 miles", "B) 20 miles", "C) 30 miles", "D) 13.1 miles" }, correct = "A" },
            { question = "What country won the first FIFA World Cup?",               answers = { "A) Brazil", "B) Argentina", "C) Uruguay", "D) Italy" }, correct = "C" },
            { question = "Which sport uses a shuttlecock?",                          answers = { "A) Tennis", "B) Squash", "C) Badminton", "D) Ping Pong" }, correct = "C" },
        }
    },
    {
        name = "Movies Quiz",
        questions = {
            { question = "Which movie won the first Academy Award for Best Picture?", answers = { "A) Wings", "B) Sunrise", "C) The Jazz Singer", "D) Metropolis" }, correct = "A" },
            { question = "Who directed Jurassic Park?",                              answers = { "A) George Lucas", "B) Steven Spielberg", "C) James Cameron", "D) Ridley Scott" }, correct = "B" },
            { question = "What is the highest-grossing film of all time?",           answers = { "A) Avengers: Endgame", "B) Avatar", "C) Titanic", "D) Star Wars" }, correct = "B" },
            { question = "Who played Iron Man in the MCU?",                          answers = { "A) Chris Evans", "B) Robert Downey Jr.", "C) Chris Hemsworth", "D) Mark Ruffalo" }, correct = "B" },
            { question = "What year was the first Star Wars movie released?",        answers = { "A) 1975", "B) 1977", "C) 1979", "D) 1981" }, correct = "B" },
        }
    },
    {
        name = "Music Quiz",
        questions = {
            { question = "Who is known as the King of Pop?",                         answers = { "A) Elvis Presley", "B) Michael Jackson", "C) Prince", "D) Freddie Mercury" }, correct = "B" },
            { question = "Which band wrote 'Bohemian Rhapsody'?",                    answers = { "A) The Beatles", "B) Led Zeppelin", "C) Queen", "D) Pink Floyd" }, correct = "C" },
            { question = "How many strings does a standard guitar have?",            answers = { "A) 4", "B) 5", "C) 6", "D) 7" }, correct = "C" },
            { question = "Who sang 'Rolling in the Deep'?",                          answers = { "A) Taylor Swift", "B) Beyoncé", "C) Adele", "D) Rihanna" }, correct = "C" },
            { question = "What instrument does Yo-Yo Ma play?",                      answers = { "A) Violin", "B) Piano", "C) Cello", "D) Flute" }, correct = "C" },
        }
    },
    {
        name = "Technology Quiz",
        questions = {
            { question = "Who founded Microsoft?",                                   answers = { "A) Steve Jobs", "B) Bill Gates", "C) Mark Zuckerberg", "D) Jeff Bezos" }, correct = "B" },
            { question = "What does CPU stand for?",                                 answers = { "A) Central Processing Unit", "B) Computer Personal Unit", "C) Central Program Utility", "D) Core Processing Unit" }, correct = "A" },
            { question = "In what year was the iPhone first released?",              answers = { "A) 2005", "B) 2007", "C) 2009", "D) 2011" }, correct = "B" },
            { question = "What does WWW stand for?",                                 answers = { "A) World Wide Web", "B) World Web Wide", "C) Wide World Web", "D) Web World Wide" }, correct = "A" },
            { question = "Which company makes the Galaxy smartphone series?",        answers = { "A) Apple", "B) Google", "C) Samsung", "D) Huawei" }, correct = "C" },
        }
    },
    {
        name = "Animal Quiz",
        questions = {
            { question = "What is the largest mammal in the world?",                 answers = { "A) African Elephant", "B) Blue Whale", "C) Giraffe", "D) Hippopotamus" }, correct = "B" },
            { question = "How many hearts does an octopus have?",                    answers = { "A) 1", "B) 2", "C) 3", "D) 4" }, correct = "C" },
            { question = "What is the only mammal capable of true flight?",          answers = { "A) Flying Squirrel", "B) Bat", "C) Sugar Glider", "D) Colugo" }, correct = "B" },
            { question = "Which animal is known as the 'Ship of the Desert'?",       answers = { "A) Horse", "B) Camel", "C) Elephant", "D) Donkey" }, correct = "B" },
            { question = "What is a group of lions called?",                         answers = { "A) Herd", "B) Pack", "C) Pride", "D) Flock" }, correct = "C" },
        }
    },
    {
        name = "Food Quiz",
        questions = {
            { question = "What is the main ingredient in guacamole?",                answers = { "A) Tomato", "B) Avocado", "C) Onion", "D) Pepper" }, correct = "B" },
            { question = "Which country invented pizza?",                            answers = { "A) France", "B) Greece", "C) Italy", "D) Spain" }, correct = "C" },
            { question = "What type of pastry is a croissant?",                      answers = { "A) Filo", "B) Puff", "C) Choux", "D) Shortcrust" }, correct = "B" },
            { question = "Sushi originated in which country?",                       answers = { "A) China", "B) Korea", "C) Japan", "D) Thailand" }, correct = "C" },
            { question = "What is the main ingredient in hummus?",                   answers = { "A) Lentils", "B) Chickpeas", "C) Black Beans", "D) Peas" }, correct = "B" },
        }
    },
    {
        name = "Art Quiz",
        questions = {
            { question = "Who painted the Mona Lisa?",                answers = { "A) Van Gogh", "B) Picasso", "C) Da Vinci", "D) Michelangelo" }, correct = "C" },
            { question = "What art movement is Salvador Dali known for?", answers = { "A) Impressionism", "B) Surrealism", "C) Cubism", "D) Realism" }, correct = "B" },
            { question = "Which artist cut off his own ear?",          answers = { "A) Monet", "B) Van Gogh", "C) Renoir", "D) Degas" }, correct = "B" },
            { question = "What is the art of beautiful handwriting called?", answers = { "A) Typography", "B) Calligraphy", "C) Lithography", "D) Cartography" }, correct = "B" },
            { question = "Which museum houses the Mona Lisa?",         answers = { "A) The Met", "B) The Louvre", "C) The British Museum", "D) The Vatican" }, correct = "B" },
        }
    },
    {
        name = "Literature Quiz",
        questions = {
            { question = "Who wrote 'Romeo and Juliet'?",              answers = { "A) Charles Dickens", "B) Jane Austen", "C) William Shakespeare", "D) Mark Twain" }, correct = "C" },
            { question = "What is the first book in the Harry Potter series?", answers = { "A) Chamber of Secrets", "B) Prisoner of Azkaban", "C) Philosopher's Stone", "D) Goblet of Fire" }, correct = "C" },
            { question = "Who wrote '1984'?",                          answers = { "A) Aldous Huxley", "B) George Orwell", "C) Ray Bradbury", "D) J.R.R. Tolkien" }, correct = "B" },
            { question = "What is the name of Sherlock Holmes' assistant?", answers = { "A) Dr. Watson", "B) Inspector Lestrade", "C) Mycroft Holmes", "D) Mrs. Hudson" }, correct = "A" },
            { question = "Which novel features Atticus Finch?",        answers = { "A) The Great Gatsby", "B) To Kill a Mockingbird", "C) Catcher in the Rye", "D) Lord of the Flies" }, correct = "B" },
        }
    },
    {
        name = "Mythology Quiz",
        questions = {
            { question = "Who is the king of Greek gods?",             answers = { "A) Poseidon", "B) Hades", "C) Zeus", "D) Apollo" }, correct = "C" },
            { question = "What creature has the body of a lion and head of a human?", answers = { "A) Griffin", "B) Sphinx", "C) Chimera", "D) Manticore" }, correct = "B" },
            { question = "Who flew too close to the sun?",             answers = { "A) Perseus", "B) Hercules", "C) Icarus", "D) Theseus" }, correct = "C" },
            { question = "What is the Norse tree of life called?",     answers = { "A) Yggdrasil", "B) Valhalla", "C) Asgard", "D) Bifrost" }, correct = "A" },
            { question = "Who is the Egyptian god of the dead?",       answers = { "A) Ra", "B) Anubis", "C) Horus", "D) Osiris" }, correct = "D" },
        }
    },
    {
        name = "Computer Science Quiz",
        questions = {
            { question = "What does CPU stand for?",                   answers = { "A) Central Processing Unit", "B) Computer Personal Unit", "C) Central Program Utility", "D) Core Processing Unit" }, correct = "A" },
            { question = "Which language is used for web pages?",      answers = { "A) Python", "B) Java", "C) HTML", "D) C++" }, correct = "C" },
            { question = "What does RAM stand for?",                   answers = { "A) Read Access Memory", "B) Random Access Memory", "C) Rapid Application Memory", "D) Run All Memory" }, correct = "B" },
            { question = "Who founded Microsoft?",                     answers = { "A) Steve Jobs", "B) Bill Gates", "C) Mark Zuckerberg", "D) Elon Musk" }, correct = "B" },
            { question = "What year was the World Wide Web invented?", answers = { "A) 1985", "B) 1989", "C) 1991", "D) 1995" }, correct = "B" },
        }
    },
    {
        name = "Nature Quiz",
        questions = {
            { question = "What is the tallest tree species?",          answers = { "A) Oak", "B) Redwood", "C) Pine", "D) Maple" }, correct = "B" },
            { question = "How many hearts does an octopus have?",      answers = { "A) 1", "B) 2", "C) 3", "D) 4" }, correct = "C" },
            { question = "What is the fastest land animal?",           answers = { "A) Lion", "B) Cheetah", "C) Leopard", "D) Gazelle" }, correct = "B" },
            { question = "Which planet is known as the Red Planet?",   answers = { "A) Venus", "B) Jupiter", "C) Mars", "D) Saturn" }, correct = "C" },
            { question = "What gas do plants absorb from the air?",    answers = { "A) Oxygen", "B) Nitrogen", "C) Carbon Dioxide", "D) Hydrogen" }, correct = "C" },
        }
    },
    {
        name = "Music Theory Quiz",
        questions = {
            { question = "How many lines are on a musical staff?",     answers = { "A) 4", "B) 5", "C) 6", "D) 7" }, correct = "B" },
            { question = "What note is worth 4 beats in 4/4 time?",    answers = { "A) Half Note", "B) Quarter Note", "C) Whole Note", "D) Eighth Note" }, correct = "C" },
            { question = "Which clef is used for higher pitches?",     answers = { "A) Bass Clef", "B) Treble Clef", "C) Alto Clef", "D) Tenor Clef" }, correct = "B" },
            { question = "What is the term for playing notes smoothly?", answers = { "A) Staccato", "B) Legato", "C) Forte", "D) Piano" }, correct = "B" },
            { question = "How many semitones are in an octave?",       answers = { "A) 10", "B) 11", "C) 12", "D) 13" }, correct = "C" },
        }
    },
    {
        name = "World Records Quiz",
        questions = {
            { question = "What is the tallest building in the world?", answers = { "A) Shanghai Tower", "B) Burj Khalifa", "C) One World Trade Center", "D) Taipei 101" }, correct = "B" },
            { question = "Who holds the record for most Olympic gold medals?", answers = { "A) Usain Bolt", "B) Michael Phelps", "C) Carl Lewis", "D) Simone Biles" }, correct = "B" },
            { question = "What is the largest ocean on Earth?",        answers = { "A) Atlantic", "B) Indian", "C) Arctic", "D) Pacific" }, correct = "D" },
            { question = "Which country has the largest population?",  answers = { "A) India", "B) USA", "C) China", "D) Indonesia" }, correct = "A" },
            { question = "What is the longest river in the world?",    answers = { "A) Amazon", "B) Nile", "C) Yangtze", "D) Mississippi" }, correct = "A" },
        }
    },
    {
        name = "Inventions Quiz",
        questions = {
            { question = "Who invented the light bulb?",               answers = { "A) Nikola Tesla", "B) Thomas Edison", "C) Benjamin Franklin", "D) Alexander Bell" }, correct = "B" },
            { question = "What year was the telephone invented?",      answers = { "A) 1865", "B) 1876", "C) 1885", "D) 1890" }, correct = "B" },
            { question = "Who invented the airplane?",                 answers = { "A) Wright Brothers", "B) Leonardo da Vinci", "C) Amelia Earhart", "D) Charles Lindbergh" }, correct = "A" },
            { question = "What did Gutenberg invent?",                 answers = { "A) Compass", "B) Printing Press", "C) Telescope", "D) Microscope" }, correct = "B" },
            { question = "Who invented penicillin?",                   answers = { "A) Marie Curie", "B) Louis Pasteur", "C) Alexander Fleming", "D) Joseph Lister" }, correct = "C" },
        }
    },
    {
        name = "Currency Quiz",
        questions = {
            { question = "What is the currency of Japan?",             answers = { "A) Yuan", "B) Won", "C) Yen", "D) Ringgit" }, correct = "C" },
            { question = "Which country uses the Euro?",               answers = { "A) Switzerland", "B) Sweden", "C) Germany", "D) Norway" }, correct = "C" },
            { question = "What is the currency of the UK?",            answers = { "A) Euro", "B) Dollar", "C) Pound Sterling", "D) Franc" }, correct = "C" },
            { question = "Which currency has the highest value?",      answers = { "A) USD", "B) EUR", "C) GBP", "D) KWD" }, correct = "D" },
            { question = "What is the symbol for Bitcoin?",            answers = { "A) B", "B) ₿", "C) BTC", "D) XBT" }, correct = "B" },
        }
    },
    {
        name = "Roblox Quiz",
        questions = {
            { question = "When was Roblox released?",                  answers = { "A) 2004", "B) 2005", "C) 2006", "D) 2007" }, correct = "C" },
            { question = "What was Roblox originally called?",         answers = { "A) DynaBlocks", "B) BlockWorld", "C) RoboBlocks", "D) BuildZone" }, correct = "A" },
            { question = "What is the premium currency in Roblox?",    answers = { "A) Tix", "B) Robux", "C) Gold", "D) Credits" }, correct = "B" },
            { question = "Who is the CEO of Roblox Corporation?",      answers = { "A) Erik Cassel", "B) David Baszucki", "C) John Shedletsky", "D) Telamon" }, correct = "B" },
            { question = "What scripting language does Roblox use?",   answers = { "A) Python", "B) JavaScript", "C) Lua", "D) C#" }, correct = "C" },
        }
    },
}

-- =============================================
-- SAY AS PLAYER IN CHAT
-- =============================================
local function sayAsPlayer(text)
    local ok = pcall(function()
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local general = channels:FindFirstChild("RBXGeneral")
            if general then
                general:SendAsync(text)
                return
            end
        end
    end)
    if not ok then
        pcall(function()
            game:GetService("ReplicatedStorage")
                .DefaultChatSystemChatEvents
                .SayMessageRequest:FireServer(text, "All")
        end)
    end
end

-- =============================================
-- TAG DETECTION & RETRY SYSTEM
-- =============================================
local lastSentText = nil
local lastSentTime = 0
local wasLastMessageTagged = false

local function hookChatFilter()
    local function connectChannel(channel)
        if channel then
            channel.MessageReceived:Connect(function(message)
                if lastSentText and (tick() - lastSentTime) < 3 then
                    if message.Text:find("###") and not lastSentText:find("###") then
                        wasLastMessageTagged = true
                    end
                    lastSentText = nil
                end
            end)
        end
    end

    task.spawn(function()
        local channels = TextChatService:WaitForChild("TextChannels", 5)
        if channels then
            local general = channels:FindFirstChild("RBXGeneral")
            if general then
                connectChannel(general)
            else
                channels.ChildAdded:Connect(function(child)
                    if child.Name == "RBXGeneral" then
                        connectChannel(child)
                    end
                end)
            end
        end
    end)
end

local function isTagged(str)
    return str:find("###") ~= nil
end

local function sendWithRetry(text, type)
    local tagCount = 0
    local maxRetries = 3
    
    while tagCount < maxRetries do
        if isStopped then return false end 
        
        wasLastMessageTagged = false
        lastSentText = text
        lastSentTime = tick()
        
        sayAsPlayer(text)
        
        task.wait(2) 
        if isStopped then return false end
        
        local tagged = wasLastMessageTagged or isTagged(text)
        
        if tagged then
            tagCount = tagCount + 1
            if tagCount == 1 then
                sayAsPlayer("[System] (Calm) The " .. type:lower() .. " was tagged. I will repeat it in 5 seconds.")
                task.wait(5)
            elseif tagCount == 2 then
                sayAsPlayer("[System] (Worried) Uh oh, it got tagged again... I'm a tad bit worried. I will repeat it in 5 seconds.")
                task.wait(5)
            elseif tagCount == 3 then
                sayAsPlayer("[System] (Giving up) The " .. type:lower() .. " keeps getting tagged. Skipping this " .. type:lower() .. ".")
                task.wait(4) 
                return false 
            end
        else
            return true 
        end
        if isStopped then return false end
    end
    return false
end

-- =============================================
-- STATE
-- =============================================
local isRunning            = false
local isStopped            = false
local skipLeaderboard      = false
local currentCorrectLetter = nil
local currentCorrectWord   = nil
local correctCount         = 0
local scores               = {}
local wrongAnswers         = {} -- Tracks wrong answers per player
local cooldowns            = {} -- Tracks cooldowns per player
local disqualified         = {} -- Tracks disqualified players per question
local statusLabel          = nil
local questionLabel        = nil
local timerLabel           = nil
local flyEnabled           = false
local flyConn              = nil
local flyBv                = nil
local flyBg                = nil
local FLY_SPEED            = 50

local QUESTION_READ_TIME = 4
local ANSWER_TIME        = 10
local WARN_AT            = 2
local POINTS             = { 3, 2, 1 }

-- =============================================
-- RULES AUTO-SAY FUNCTION (Filter-Friendly)
-- =============================================
local function autoSayRules()
    task.spawn(function()
        local rules = {
            "QUIZ RULES",
            "1. Wait for the question and answers in chat.",
            "2. Type the correct letter or the exact word.",
            "3. The first 3 correct answers get points.",
            "SCORING",
            "1st place gets 3 points",
            "2nd place gets 2 points",
            "3rd place gets 1 point",
            "WRONG ANSWERS",
            "Wrong answer means 2 second wait before trying again.",
            "Two wrong answers means you are out for that question.",
            "CHAT FILTER",
            "If something gets tagged it retries 3 times then skips.",
            "Good luck and have fun",
        }
        
        for _, rule in ipairs(rules) do
            if isStopped then break end
            sayAsPlayer(rule)
            task.wait(3) -- 3 second pause between each message
        end
    end)
end

-- =============================================
-- LEADERBOARD
-- =============================================
local function showLeaderboard(leaderboardTab)
    local sorted = {}
    for name, pts in pairs(scores) do
        if name:sub(1, 11) ~= "__answered_" then
            table.insert(sorted, { name = name, points = pts })
        end
    end
    table.sort(sorted, function(a, b) return a.points > b.points end)

    task.wait(2)
    if isStopped then return end
    sayAsPlayer("FINAL LEADERBOARD")
    task.wait(2)

    local medals = { "1st", "2nd", "3rd" }

    if #sorted == 0 then
        sayAsPlayer("Nobody scored any points!")
    else
        for rank, entry in ipairs(sorted) do
            if isStopped then return end
            local place = medals[rank] or "#" .. rank
            local line = place .. " - " .. entry.name .. " - " .. entry.points .. " pts"
            sayAsPlayer(line)
            task.wait(5) 
            pcall(function()
                leaderboardTab:CreateLabel(line)
            end)
        end
    end
end

-- =============================================
-- CHAT HOOK WITH WRONG ANSWER SYSTEM (BOT EXCLUDED)
-- =============================================
local function normalizeAnswer(msg)
	-- Remove only trailing punctuation, keep internal structure for validation
	return msg:lower():gsub("[%.%!%?]+$", "")
end

local function isValidAnswerAttempt(msg)
	-- Trim whitespace first
	local trimmed = msg:match("^%s*(.-)%s*$") or msg
	
	-- If it contains spaces, it's a sentence, not an answer
	if trimmed:find("%s") then
		return false
	end
	
	-- Check if it's a single letter (a, b, c, d) with optional trailing punctuation
	-- Examples: "A", "b", "C.", "d?!", "A.."
	if trimmed:lower():match("^[abcd][%.%!%?]*$") then
		return true
	end
	
	-- Check if it's a pure alphabetic word with optional trailing punctuation
	-- Examples: "apple", "Paris", "yellow?!", "Apple."
	-- Must NOT contain numbers or other symbols
	if trimmed:match("^[a-zA-Z]+[%.%!%?]*$") then
		return true
	end
	
	-- Anything else (numbers, mixed symbols, etc.) is invalid
	return false
end

local function handleAnswer(msg, playerName, displayName)
	if not isRunning then return end
	if currentCorrectLetter == nil then return end
	if correctCount >= 3 then return end
	if scores[playerName] == nil then scores[playerName] = 0 end
	if scores["__answered_" .. playerName .. "_q"] then return end
	
	-- Check if player is disqualified
	if disqualified[playerName] then return end
	
	-- Check if player is on cooldown
	if cooldowns[playerName] and tick() < cooldowns[playerName] then return end
	
	-- STRICT VALIDATION: Only process if it looks like a valid answer attempt
	if not isValidAnswerAttempt(msg) then
		return -- Ignore completely (e.g., "I hate apples!", "123", "A B")
	end
	
	-- Normalize: lowercase and remove trailing punctuation
	local cleaned = normalizeAnswer(msg)
	
	-- Determine if it's a letter or word attempt
	local isLetterAttempt = cleaned:match("^[abcd]$")
	local isWordAttempt = cleaned:match("^[a-z]+$")
	
	-- Double-check validity after normalization
	if not isLetterAttempt and not isWordAttempt then
		return
	end
	
	-- Check if the answer is correct
	if cleaned == currentCorrectLetter or cleaned == currentCorrectWord then
		correctCount += 1
		local pts = POINTS[correctCount] or 0
		scores[playerName] = scores[playerName] + pts
		scores["__answered_" .. playerName .. "_q"] = true

		local place = { "1st", "2nd", "3rd" }
		sayAsPlayer("Correct! " .. displayName .. " got it " .. (place[correctCount] or "") .. "! (+ " .. pts .. " pts)")

		if statusLabel then
			statusLabel:Set(displayName .. " answered " .. (place[correctCount] or "") .. " (+ " .. pts .. " pts)")
		end
	else
		-- EXCLUDE THE BOT (LOCAL PLAYER) FROM WRONG ANSWER PENALTIES
		if playerName == Players.LocalPlayer.Name then
			return -- Bot is the quiz master, don't penalize it
		end
		
		-- Wrong answer handling for other players
		if wrongAnswers[playerName] == nil then
			wrongAnswers[playerName] = 0
		end
		
		wrongAnswers[playerName] = wrongAnswers[playerName] + 1
		
		if wrongAnswers[playerName] == 1 then
			-- First wrong answer - 2 second cooldown
			sayAsPlayer(displayName .. " got it wrong! Wait 2 seconds to answer again.")
			cooldowns[playerName] = tick() + 2
		elseif wrongAnswers[playerName] >= 2 then
			-- Second wrong answer - disqualified for this question
			sayAsPlayer(displayName .. " got it wrong twice! You are out for this question.")
			disqualified[playerName] = true
		end
	end
end

local hookedChatPlayers = {}
local hookedTextChannels = {}
local recentAnswerKeys = {}
local ANSWER_DEDUP_WINDOW = 1

local function trimMessage(msg)
	return msg:match("^%s*(.-)%s*$") or msg
end

local function tryHandleAnswer(msg, playerName, displayName)
	local key = playerName .. "\0" .. trimMessage(msg):lower()
	local now = tick()
	local lastSeen = recentAnswerKeys[key]
	if lastSeen and (now - lastSeen) < ANSWER_DEDUP_WINDOW then
		return
	end
	recentAnswerKeys[key] = now
	for existingKey, seenAt in pairs(recentAnswerKeys) do
		if (now - seenAt) >= ANSWER_DEDUP_WINDOW then
			recentAnswerKeys[existingKey] = nil
		end
	end
	handleAnswer(msg, playerName, displayName)
end

local function getSenderFromMessage(message)
	if message.TextSource and message.TextSource.UserId and message.TextSource.UserId > 0 then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		local displayName = message.TextSource.Name or (player and player.DisplayName) or "Player"
		local playerName = player and player.Name or displayName
		return playerName, displayName
	end
	if message.User and message.User.Id and message.User.Id > 0 then
		local player = Players:GetPlayerByUserId(message.User.Id)
		local displayName = message.User.DisplayName or (player and player.DisplayName) or "Player"
		local playerName = player and player.Name or displayName
		return playerName, displayName
	end
	return nil
end

local function hookTextChannel(channel)
	if hookedTextChannels[channel] then return end
	hookedTextChannels[channel] = true
	channel.MessageReceived:Connect(function(message)
		local playerName, displayName = getSenderFromMessage(message)
		if not playerName then return end
		tryHandleAnswer(message.Text, playerName, displayName)
	end)
end

local function hookPlayerChat(player)
	if hookedChatPlayers[player] then return end
	hookedChatPlayers[player] = true
	player.Chatted:Connect(function(msg)
		tryHandleAnswer(msg, player.Name, player.DisplayName)
	end)
end

local function hookChat()
	local function hookAllChannels(channels)
		for _, channel in ipairs(channels:GetChildren()) do
			if channel:IsA("TextChannel") then
				hookTextChannel(channel)
			end
		end
		channels.ChildAdded:Connect(function(child)
			if child:IsA("TextChannel") then
				hookTextChannel(child)
			end
		end)
	end

	local function hookLegacyChat()
		for _, player in ipairs(Players:GetPlayers()) do
			hookPlayerChat(player)
		end
		Players.PlayerAdded:Connect(hookPlayerChat)
	end

	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		task.spawn(function()
			local channels = TextChatService:WaitForChild("TextChannels", 15)
			if channels then
				hookAllChannels(channels)
			end

			TextChatService.ChildAdded:Connect(function(child)
				if child.Name == "TextChannels" then
					hookAllChannels(child)
				end
			end)
		end)
	else
		hookLegacyChat()
	end
end

-- =============================================
-- QUIZ RUNNER
-- =============================================
local function runQuiz(quiz, leaderboardTab)
    if isRunning then return end
    isRunning = true
    isStopped = false
    scores = {}

    task.spawn(function()
        for i, q in ipairs(quiz.questions) do
            if isStopped then break end
            
            currentCorrectLetter = q.correct:lower()
            currentCorrectWord   = currentCorrectLetter 

            local fullAnswerText = q.correct
            
            for _, ans in ipairs(q.answers) do
                if ans:sub(1, 1):upper() == q.correct:upper() then
                    fullAnswerText = ans
                    local word = ans:match("%)%s*(.+)")
                    if word then
                        currentCorrectWord = normalizeAnswer(word)
                    end
                    break
                end
            end
            
            correctCount = 0
            
            -- Reset wrong answer tracking for new question
            wrongAnswers = {}
            cooldowns = {}
            disqualified = {}

            for k in pairs(scores) do
                if k:sub(1, 11) == "__answered_" then
                    scores[k] = nil
                end
            end

            -- QUESTION PHASE
            if isStopped then break end
            task.wait(1) 
            
            local qText = "Q" .. i .. "/" .. #quiz.questions .. ": " .. q.question
            local qSent = sendWithRetry(qText, "Question")
            if isStopped then break end
            if not qSent then
                currentCorrectLetter = nil
                currentCorrectWord   = nil
                continue 
            end
            
            if statusLabel then statusLabel:Set("Q" .. i .. ": " .. q.question) end
            if questionLabel then questionLabel:Set("Reading question...") end

            for t = QUESTION_READ_TIME, 1, -1 do
                if isStopped then break end
                if timerLabel then timerLabel:Set("Answers in: " .. t .. "s") end
                task.wait(1)
            end
            if isStopped then break end

            -- ANSWER PHASE
            local aText = table.concat(q.answers, "   ")
            local aSent = sendWithRetry(aText, "Answer")
            if isStopped then break end
            if not aSent then
                currentCorrectLetter = nil
                currentCorrectWord   = nil
                continue 
            end
            
            if questionLabel then questionLabel:Set("Waiting for answers...") end

            local timeLeft = ANSWER_TIME
            local warned   = false

            while timeLeft > 0 do
                if isStopped then break end
                if correctCount >= 3 then break end

                if timeLeft == WARN_AT and not warned then
                    warned = true
                    sayAsPlayer(WARN_AT .. " seconds left!")
                end

                if timerLabel then timerLabel:Set("Time left: " .. timeLeft .. "s") end
                task.wait(1)
                timeLeft -= 1
            end
            
            if isStopped then break end

            if correctCount == 0 then
                sayAsPlayer("Nobody got it! Answer was: " .. fullAnswerText)
                if statusLabel then statusLabel:Set("No one answered. Was: " .. fullAnswerText) end
            end

            currentCorrectLetter = nil
            currentCorrectWord   = nil
            task.wait(2)
        end

        -- QUIZ OVER
        if isStopped then
            isStopped = false
            if statusLabel then statusLabel:Set("Status: Stopped") end
            if questionLabel then questionLabel:Set("—") end
            if timerLabel then timerLabel:Set("—") end
            isRunning = false
            return
        end

        sayAsPlayer("Quiz over! Calculating scores...")
        task.wait(1)
        
        if skipLeaderboard then
            skipLeaderboard = false
            sayAsPlayer("[System] Leaderboard display skipped as requested.")
            if statusLabel then statusLabel:Set("Done! Leaderboard skipped.") end
        else
            showLeaderboard(leaderboardTab)
            if statusLabel then statusLabel:Set("Done! Check Leaderboard tab.") end
        end

        if questionLabel then questionLabel:Set("—") end
        if timerLabel then timerLabel:Set("—") end
        isRunning = false
    end)
end

-- =============================================
-- LOAD RAYFIELD
-- =============================================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Quiz System",
    LoadingTitle = "Quiz System",
    LoadingSubtitle = "v" .. VERSION,
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = { Enabled = false },
})

-- =============================================
-- TAB: Quizzes
-- =============================================
local QuizTab = Window:CreateTab("Quizzes", 4483362458)
QuizTab:CreateSection("Status")

statusLabel   = QuizTab:CreateLabel("Status: Ready")
questionLabel = QuizTab:CreateLabel("Question: —")
timerLabel    = QuizTab:CreateLabel("Timer: —")

QuizTab:CreateSection("Controls")
QuizTab:CreateButton({
    Name = "Stop Current Quiz",
    Callback = function()
        if not isRunning then
            Rayfield:Notify({ Title = "No Quiz Running", Content = "There is no active quiz to stop.", Duration = 3 })
            return
        end
        isStopped = true
        Rayfield:Notify({ Title = "Quiz Stopped", Content = "The current quiz is stopping...", Duration = 3 })
        sayAsPlayer("[System] Quiz has been manually stopped by the host.")
    end
})

QuizTab:CreateSection("Start a Quiz")
for _, quiz in ipairs(Quizzes) do
    local q = quiz
    QuizTab:CreateButton({
        Name = q.name,
        Callback = function()
            if isRunning then
                Rayfield:Notify({ Title = "Already Running!", Content = "Wait for the current quiz to finish.", Duration = 3 })
                return
            end
            Rayfield:Notify({ Title = "Starting " .. q.name .. "!", Content = "Get ready...", Duration = 3 })
            runQuiz(q, LeaderboardTab)
        end
    })
end

-- =============================================
-- TAB: Leaderboard
-- =============================================
local LeaderboardTab = Window:CreateTab("Leaderboard", 4483362458)
LeaderboardTab:CreateSection("Results")
LeaderboardTab:CreateLabel("Leaderboard appears here after a quiz ends.")

-- =============================================
-- TAB: Quiz List
-- =============================================
local QuizListTab = Window:CreateTab("Quiz List", 4483362458)
QuizListTab:CreateSection("All Available Quizzes")

-- Add a label showing all quiz names
local quizListText = "Quiz List\n"
for i, quiz in ipairs(Quizzes) do
    quizListText = quizListText .. "(" .. quiz.name .. ")\n"
end
quizListText = quizListText .. "1/" .. #Quizzes

local quizListLabel = QuizListTab:CreateLabel(quizListText)

QuizListTab:CreateSection("Actions")
QuizListTab:CreateButton({
    Name = "List Quiz to People",
    Callback = function()
        if isRunning then
            Rayfield:Notify({ Title = "Quiz Running!", Content = "Wait for the current quiz to finish.", Duration = 3 })
            return
        end
        Rayfield:Notify({
            Title = "Listing Quizzes",
            Content = "Announcing all quizzes in chat (10 per message) with 6 second pauses...",
            Duration = 3,
        })
        task.spawn(function()
            local quizNames = {}
            for _, quiz in ipairs(Quizzes) do
                table.insert(quizNames, quiz.name)
            end
            table.sort(quizNames)
            
            local totalQuizzes = #quizNames
            local batchSize = 10
            local currentIndex = 1
            
            while currentIndex <= totalQuizzes and not isStopped do
                local endIndex = math.min(currentIndex + batchSize - 1, totalQuizzes)
                local messageParts = {"Quiz List"}
                
                for i = currentIndex, endIndex do
                    table.insert(messageParts, "(" .. quizNames[i] .. ")")
                end
                
                table.insert(messageParts, currentIndex .. "/" .. totalQuizzes)
                
                local fullMessage = table.concat(messageParts, "\n")
                sayAsPlayer(fullMessage)
                
                currentIndex = endIndex + 1
                
                if currentIndex <= totalQuizzes and not isStopped then
                    task.wait(6)
                end
            end
        end)
    end
})

-- =============================================
-- TAB: Rules
-- =============================================
local RulesTab = Window:CreateTab("Rules", 4483362458)
RulesTab:CreateSection("How to Play")
RulesTab:CreateLabel("Quiz Rules and Information")
RulesTab:CreateLabel("Click the button below to have the rules automatically said in chat!")

RulesTab:CreateButton({
    Name = "Auto-Say Rules in Chat",
    Callback = function()
        Rayfield:Notify({
            Title = "Auto-Saying Rules",
            Content = "The rules will be announced in chat with pauses.",
            Duration = 3,
        })
        autoSayRules()
    end
})

RulesTab:CreateSection("Quick Reference")
RulesTab:CreateLabel("Answer with Letter (A, B, C, D) or Word")
RulesTab:CreateLabel("Top 3 correct answers get points")
RulesTab:CreateLabel("1st = 3pts | 2nd = 2pts | 3rd = 1pt")
RulesTab:CreateLabel("Wrong answer = 2 second wait")
RulesTab:CreateLabel("Two wrong answers = disqualified for that question")
RulesTab:CreateLabel("Tagged questions are retried up to 3 times")

-- =============================================
-- FLY
-- =============================================
local function stopFly()
    flyEnabled = false
    if flyConn then
        flyConn:Disconnect()
        flyConn = nil
    end
    if flyBv then
        flyBv:Destroy()
        flyBv = nil
    end
    if flyBg then
        flyBg:Destroy()
        flyBg = nil
    end
    local character = Players.LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

local function startFly()
    local character = Players.LocalPlayer.Character
    if not character then return false end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return false end

    stopFly()
    flyEnabled = true
    humanoid.PlatformStand = true

    flyBv = Instance.new("BodyVelocity")
    flyBv.Name = "QuizFlyVelocity"
    flyBv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    flyBv.Velocity = Vector3.zero
    flyBv.Parent = root

    flyBg = Instance.new("BodyGyro")
    flyBg.Name = "QuizFlyGyro"
    flyBg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    flyBg.P = 1000
    flyBg.D = 100
    flyBg.CFrame = root.CFrame
    flyBg.Parent = root

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyEnabled or not root.Parent then
            stopFly()
            return
        end

        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end

        if dir.Magnitude > 0 then
            flyBv.Velocity = dir.Unit * FLY_SPEED
        else
            flyBv.Velocity = Vector3.zero
        end
        flyBg.CFrame = cam.CFrame
    end)

    return true
end

-- =============================================
-- TAB: Secret
-- =============================================
local SecretTab = Window:CreateTab("Secret", 4483362458)
SecretTab:CreateSection("Special")

SecretTab:CreateButton({
    Name = "Fly",
    Callback = function()
        if flyEnabled then
            stopFly()
            Rayfield:Notify({
                Title = "Flight Toggled",
                Content = "Flying disabled.",
                Duration = 3,
            })
            return
        end

        if startFly() then
            Rayfield:Notify({
                Title = "Flight Toggled",
                Content = "Flying enabled. Use WASD, Space, and Ctrl.",
                Duration = 3,
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not start flight. Make sure your character is loaded.",
                Duration = 3,
            })
        end
    end
})

-- =============================================
-- TAB: Settings
-- =============================================
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateSection("Timing")

SettingsTab:CreateSlider({
    Name = "Question Read Time (s)",
    Range = {2, 10},
    Increment = 1,
    Suffix = "s",
    CurrentValue = QUESTION_READ_TIME,
    Flag = "QuestionTime",
    Callback = function(val) QUESTION_READ_TIME = val end
})

SettingsTab:CreateSlider({
    Name = "Answer Time (s)",
    Range = {5, 30},
    Increment = 1,
    Suffix = "s",
    CurrentValue = ANSWER_TIME,
    Flag = "AnswerTime",
    Callback = function(val) ANSWER_TIME = val end
})

SettingsTab:CreateSlider({
    Name = "Warn When X Seconds Left",
    Range = {1, 5},
    Increment = 1,
    Suffix = "s",
    CurrentValue = WARN_AT,
    Flag = "WarnAt",
    Callback = function(val) WARN_AT = val end
})

SettingsTab:CreateSection("Quiz Controls")
SettingsTab:CreateButton({
    Name = "Skip Leaderboard (Next Quiz)",
    Callback = function()
        skipLeaderboard = true
        Rayfield:Notify({
            Title = "Leaderboard Skipped",
            Content = "The leaderboard will be skipped for the next quiz.",
            Duration = 3,
        })
    end
})

SettingsTab:CreateSection("Danger Zone")
SettingsTab:CreateButton({
    Name = "Exit Rayfield",
    Callback = function()
        stopFly()
        Rayfield:Destroy()
    end
})

-- =============================================
-- TAB: Version
-- =============================================
local VersionTab = Window:CreateTab("Version", 4483362458)
VersionTab:CreateSection("Build Info")
VersionTab:CreateLabel("Quiz System v" .. VERSION)
VersionTab:CreateLabel("Updated: " .. VERSION_DATE)
VersionTab:CreateLabel("Latest: " .. VERSION_NOTE)
VersionTab:CreateSection("About")
VersionTab:CreateLabel("Created for Roblox")
VersionTab:CreateLabel("If this version does not match your repo, re-run the script.")
VersionTab:CreateSection("Features")
VersionTab:CreateLabel("- Multiple quizzes available")
VersionTab:CreateLabel("- Auto-say quiz list in chat")
VersionTab:CreateLabel("- Leaderboard tracking")
VersionTab:CreateLabel("- Wrong answer penalty system")
VersionTab:CreateLabel("- Customizable timing settings")
VersionTab:CreateLabel("- Secret fly feature")

-- =============================================
-- INIT
-- =============================================
print("[Quiz System] Loaded v" .. VERSION .. " - " .. VERSION_NOTE)

hookChat()
hookChatFilter() 

Rayfield:Notify({
    Title = "Quiz System v" .. VERSION,
    Content = "If this is not v1.1.4, paste the latest script and run again.",
    Duration = 5,
})
