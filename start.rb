# main menu options
def start
  print "What do you want to do?: (C)reate, (L)ist, (U)pdate, (D)elete, or (E)xit > "
  action = gets.chomp.capitalize
  determine_action(action)
end

# direct user to method based on main menu selection
def determine_action(action)
  case action
    when "C"
      create_person
    when "L"
      list
    when "U"
      method = "Update"
      find_person_requested(method)
    when "D"
      method = "Delete"
      find_person_requested(method)
    when "E"
      exit
    else
      invalid_entry
      start
    end
end

# for actions requiring Person identification (Update or Delete) direct the control flow to the correct method
def find_person_requested(method)
  print "Do you want to #{method} a (P)olitician or (V)oter?: > "
  response = gets.chomp.capitalize
  if response == "P" && method == "Update"
    update_politician
  elsif response == "V" && method == "Update"
    update_voter
  elsif response == "P" && method == "Delete"
    delete_politician
  elsif response == "V" && method == "Delete"
    delete_voter
  else
    invalid_entry
    find_person_requested(method)
  end
end

# list all Voters & Politicians with their personal attributes
def list
  system "clear"
  puts "*" * 60
  puts "The registered political candidates are:"
  @politicians.each do |politician|
    puts "  * Politician, #{politician[:name]}, #{politician[:party]}"
  end
  puts "*" * 60
   puts "The registered voters are:"
  @voters.each do |voter|
    puts "  * Voter, #{voter[:name]}, #{voter[:affiliation]}"
  end
  puts "*" * 60
  start
end

# return User Message of "invalid entry"
def invalid_entry
  system "clear"
  puts "*** Invalid Entry -- please respond with a valid input ***"
  puts
end
