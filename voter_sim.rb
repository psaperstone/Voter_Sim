require "./start.rb"

# Person class
class Person
  attr_accessor :name

  def initialize
    @name = name
  end
end

# Politician class inherited from Person
class Politician < Person
  attr_accessor :party

  def initialize(name, party)
    @party = party
  end
end

# Voter class inherited from Person
class Voter < Person
  attr_accessor :affiliation

  def initialize
    @affiliation = affiliation
  end
end

# World class in which creation of its Instance initiates the Voter_Sim app
class World
  attr_accessor :politicians, :voters

  def initialize
    @politicians = []
    @voters = []
    system "clear"
    start
  end

# want to create a Voter or a Politician ?
  def create_person
    print "Create a new (P)olitician or (V)oter ?: "
    type_of_person_to_create = gets.chomp.capitalize
    if type_of_person_to_create == "P"
      create_politician
    elsif type_of_person_to_create == "V"
      create_voter
    else
      invalid_entry
      create_person
    end
  end

# Create the Politician with associated Party attribute
  def create_politician
    puts "Creating Politician......."
    print "What is the full name of the Politician > "
      name = gets.chomp.split.each{ | word | word.capitalize! }.join(' ')
    print "To which political party do they belong: (D)emocrat or (R)epublican ? > "
      party = gets.chomp.upcase
      case party
        when "D"
          party = "Democrat"
        when "R"
          party = "Republican"
        else
          invalid_entry
          create_politician
      end
      system "clear"
      puts "Please validate the spelling of this Politician and Party selection:"
      puts
      puts "        Name: #{name}"
      puts "       Party: #{party}"
      puts
      print "< press ENTER to accept > "
      input = gets.chomp
      if input.empty?
        @politicians << {:name => name, :party => party}
        start
      else
        system "clear"
        create_politician
      end
  end

# Create the Voter with the associated Affiliation attribute
  def create_voter
    puts "Creating Voter......."
    print "What is the full name of the Voter > "
      name = gets.chomp.split.each{ | word | word.capitalize! }.join(' ')
    puts
    puts "What is the political affiliation of the Voter: "
    print "  (L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral ? > "
      affiliation = gets.chomp.upcase
      case affiliation
        when "L"
          affiliation = "Liberal"
        when "C"
          affiliation = "Conservative"
        when "T"
          affiliation = "Tea Party"
        when "S"
          affiliation = "Socialist"
        when "N"
          affiliation = "Neutral"
        else
          invalid_entry
          create_voter
      end
      system "clear"
      puts "Please validate the spelling of this Voter and Affiliation preference:"
      puts
      puts "         Name: #{name}"
      puts "  Affiliation: #{affiliation}"
      puts
      print "< press ENTER to accept > "
      input = gets.chomp
      if input.empty?
        @voters << {:name => name, :affiliation => affiliation}
      start
      else
        system "clear"
        create_voter
      end
  end

# determine if the Politician exists in the database, if so, determine which of Name or Party change is desired
  def update_politician
    print "What Politician do you want to update? > "
    person = gets.chomp.split.each{ |word| word.capitalize! }.join(' ')
    @politicians.each do |politician|
      if politician[:name] == person
        print "Do you want to change the (N)ame or (P)arty of #{politician[:name]}? > "
        response = gets.chomp.capitalize
        case response
          when "N"
            change_politician_name(person)
          when "P"
            change_party(person)
          else
            invalid_entry
            list
            update_politician
        end
      else
        next
      end
    end
    puts "The person you requested is not in the Database."
    print " (T)ry again, (N)ew action, or (E)xit > "
    response = gets.chomp.capitalize
    case response
      when "T"
        update_politician
      when "N"
        start
      when "E"
        puts "You have chosen to EXIT the Voter App."
        exit
      else
        start
    end
  end

# determine if the Voter exists in the database, if so, determine which of Name or Affiliation change is desired
  def update_voter
    print "What Voter do you want to update? > "
    person = gets.chomp.split.each{ |word| word.capitalize! }.join(' ')
    @voters.each do |voter|
      if voter[:name] == person
        print "Do you want to change the (N)ame or (A)ffiliation of #{voter[:name]}? > "
        response = gets.chomp.capitalize
        case response
          when "N"
            change_voter_name(person)
          when "A"
            change_affiliation(person)
          else
            invalid_entry
            list
            update_voter
        end
      else
        next
      end
    end
    puts "The person you requested is not in the Database."
    print " (T)ry again, (N)ew action, or (E)xit > "
    response = gets.chomp.capitalize
    case response
      when "T"
        update_voter
      when "N"
        start
      when "E"
        puts "You have chosen to EXIT the Voter App."
        exit
      else
        start
    end
  end

# Politician has been identified and Name change will be executed
  def change_politician_name(person)
    @politicians.each do |politician|
      if politician[:name] == person
        print "You want to change the Politician named \"#{politician[:name]}\" to what other name? > "
        response = gets.chomp.split.each{ |word| word.capitalize! }.join(' ')
        politician[:name] = response
        puts "Politician name has successfully been changed from \"#{person}\" to \"#{response}\"."
        start
      else
        next
      end
    end
  end

# Voter has been identified and Name change will be executed
  def change_voter_name(person)
    @voters.each do |voter|
      if voter[:name] == person
        print "You want to change the Voter named \"#{voter[:name]}\" to what other name? > "
        response = gets.chomp.split.each{ |word| word.capitalize! }.join(' ')
        voter[:name] = response
        puts "Voter name has successfully been changed from \"#{person}\" to \"#{response}\"."
        start
      else
        next
      end
    end
  end

# Voter has been identified and Affiliation change will be executed
  def change_affiliation(person)
    @voters.each do |voter|
      if voter[:name] == person
        puts "You want to change the affiliation of the Voter named \"#{voter[:name]}\" who is currently \"#{voter[:affiliation]}\""
        print "to what other affiliation? (L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral ? > "
        response = gets.chomp.capitalize
        old_affiliation = voter[:affiliation]
        case response
          when "L"
            new_affiliation = "Liberal"
          when "C"
            new_affiliation = "Conservative"
          when "T"
            new_affiliation = "Tea Party"
          when "S"
            new_affiliation = "Socialist"
          when "N"
            new_affiliation = "Neutral"
          else
            invalid_entry
            change_affiliation(person)
        end
        voter[:affiliation] = new_affiliation
        puts "The affiliation of \"#{person}\" has successfully been changed from \"#{old_affiliation}\" to \"#{new_affiliation}\"."
        start
      else
        next
      end
    end
    start
  end

# Politician has been identified and Party change will be executed
  def change_party(person)
    @politicians.each do |politician|
    if politician[:name] == person
      puts "You want to change the party of the Politician named \"#{politician[:name]}\" who is currently a \"#{politician[:party]}\" "
      print "to what party? (D)emocrat or (R)epublican ? > "
      response = gets.chomp.capitalize
      old_party = politician[:party]
      case response
        when "D"
          new_party = "Democrat"
        when "R"
          new_party = "Republican"
        else
          invalid_entry
          change_party(person)
      end
      politician[:party] = new_party
      puts "The Politician named \"#{person}\" has successfully changed their party from \"#{old_party}\" to \"#{new_party}\"."
      start
    else
      next
    end
  end
  start
end

# determine if the Voter exists in the database, if so, delete after the user confirms
  def delete_voter
    print "Who do you want to Delete? > "
    person = gets.chomp.split.each{ |word| word.capitalize! }.join(' ')
    @voters.each do |voter|
      if voter[:name] == person
        print "Are you sure you want to DELETE the Voter named \"#{voter[:name]}\"? (Y)es or (N)o > "
        response = gets.chomp.capitalize
        case response
          when "Y"
            @voters.delete(voter)
            start
          when "N"
            system "clear"
            puts "You have declined to delete #{voter[:name]}"
            puts
            start
          else
            invalid_entry
            delete_voter
        end
      else
        next
      end
    end
    puts "The person you requested is not in the Database.  (T)ry again, (N)ew action, or (E)xit"
    response = gets.chomp.capitalize
    case response
      when "T"
        delete_voter
      when "N"
        start
      when "E"
        puts "You have chosen to EXIT the Voter App."
        exit
      else
        start
    end
  end

# determine if the Politician exists in the database, if so, delete after the user confirms
  def delete_politician
    print "Who do you want to Delete? > "
    person = gets.chomp.split.each{ |word| word.capitalize! }.join(' ')
    @politicians.each do |politician|
      if politician[:name] == person
        print "Are you sure you want to DELETE the Politician named \"#{politician[:name]}\"? (Y)es or (N)o > "
        response = gets.chomp.capitalize
        case response
          when "Y"
            @politicians.delete(politician)
            start
          when "N"
            system "clear"
            puts "You have declined to delete #{politicians[:name]}"
            puts
            start
          else
            invalid_entry
            delete_politician
        end
      else
        next
      end
    end
    puts "The person you requested is not in the Database.  (T)ry again, (N)ew action, or (E)xit"
    response = gets.chomp.capitalize
    case response
      when "T"
        delete_politician
      when "N"
        start
      when "E"
        puts "You have chosen to EXIT the Voter App."
        exit
      else
        start
    end
  end

#close Class World
end

World.new
