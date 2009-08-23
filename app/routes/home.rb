class Main
  get "/" do
    @sizings = User.by_user_name(:reduce => true, :group => true).first[1]
    erb :home
  end

  get "/populate" do
    srand(1000000000000)

    create_db

    erb :home
  end


  def create_db
    product_names = ['Dunks', 'Chucks', 'Vans Half-Cab', 'Nike Plus', 'Clark\'s Wallabees']
    users = ['TobyJoe', 'RyanTomorrow', 'Mihow', 'Murray', 'Brysonian', 'Agnes', 'Alicia', 'Allen', 'Allison', 'Andrew', 'Anita', 'Audrey', 'Betsy', 'Beulah', 'Bob', 'Camille', 'Carla', 'Carmen', 'Carol', 'Celia', 'Cesar', 'Charley', 'Cleo', 'Connie', 'David', 'Dean', 'Dennis', 'Diana', 'Diane', 'Donna', 'Dora', 'Edna', 'Elena', 'Eloise', 'Fabian', 'Felix', 'Fifi', 'Flora', 'Floyd', 'Fran', 'Frances', 'Frederic', 'Georges', 'Gilbert', 'Gloria', 'Gustav', 'Hattie', 'Hazel', 'Hilda', 'Hortense', 'Hugo', 'Ike', 'Inez', 'Ione', 'Iris', 'Isabel', 'Isidore', 'Ivan', 'Janet', 'Jeanne', 'Joan', 'Juan', 'Katrina', 'Keith', 'Klaus', 'Lenny', 'Lili', 'Luis', 'Marilyn', 'Michelle', 'Mitch', 'Noel', 'Opal', 'Paloma', 'Rita', 'Roxanne', 'Stan', 'Wilma']
    
    sizes = [7,8,9,10,11]
    range = 0.5

    for user_name in users
      reference_size = sizes[rand(sizes.size)]
      u = User.new(:user_name => user_name)
      for product_name in product_names
        # maybe skip.
        next if (rand(10) % 2 == 1)
        random_size_in_range = reference_size + ((rand(2) == 1) ? range : 0)
        s = Sizing.new(:size => random_size_in_range, :product_name => product_name)
        u.add_sizing(s)
        puts "Saved sizing: #{s.inspect}\n"
      end
      u.save!
    end
  end


end
